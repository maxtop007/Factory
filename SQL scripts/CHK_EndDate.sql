use FACTORY;

go

drop procedure dbo.usp_CHK_EndDate;

go

create procedure dbo.usp_CHK_EndDate
	@InsertNomenclature dbo.NomenclatureListType readonly
	,@EndDate datetime 
as
begin
	set nocount on;

	declare @result bit;
	set @result=0;
	
	

	if (@EndDate<=CURRENT_TIMESTAMP) or (@endDate is null)
	begin
	    raiserror('End date is wrong', 16, 1);
        return @result;
    end;

    -- Проверка наличия номенклатур в списке
    if not exists (select * from @InsertNomenclature)
    begin
        raiserror('Nomenclature list is empty', 16, 1);
        return @result;
    end;

    -- Проверка сопоставления номенклатур
    if  exists (
        select 1
        from @InsertNomenclature as NL
        left join Nomenclatures as N on NL.NomenclatureName = N.Name
        where N.ID is null
    )
    begin
        -- Вызов ошибки, если есть неправильные номенклатуры
        raiserror('one or more nomenclatures do not match existing records', 16, 1);
        return @result;
    end;

	 -- Проверка верного числа номенклатур
    if  exists (
        select 1
        from @InsertNomenclature as NL
        where (NL.NomenclatureCount<=0)  or  (NL.NomenclatureCount is null) 
    )
    begin
        -- Вызов ошибки, если есть неправильные номенклатуры
        raiserror('Wrong amount of nomenclatures', 16, 1);
        return @result;
    end;


	declare @ResultOrderNomenclature dbo.NomenclatureListType;

	insert into @ResultOrderNomenclature 
	exec dbo.usp_SearchRemainingNomenclature 
		@OrderNomenclature = @InsertNomenclature
		,@ID_order = 123  
		,@FlagOrder = 0;

	declare @tmpBuildQueue dbo.BuildQueueType;
	
	insert into @tmpBuildQueue
	select 
		ID_Nomenclature
		,ID_BuildArea
		,StartDate
		,EndDate
	from dbo.BuildQueue;

	declare @NomenclatureName nvarchar(255);
    declare @NomenclatureCount int;

	declare @MaxMinDate datetime;

	declare nomenclature_cursor cursor for
    select NomenclatureName, NomenclatureCount
    from @ResultOrderNomenclature;

    open nomenclature_cursor;
    fetch next from nomenclature_cursor INTO @NomenclatureName, @NomenclatureCount;

    while @@FETCH_STATUS = 0
    begin
		       
        
			declare @ID_Nomenclature int;
			select top 1
				@ID_Nomenclature=N.ID
			from dbo.Nomenclatures as N
			where N.Name=@NomenclatureName;
			


		
			if @ID_Nomenclature is not null
			begin
				
				declare @NomenclatureCounter int;
				set @NomenclatureCounter =0;

				while @NomenclatureCounter< @NomenclatureCount
				begin
					
					declare @ID_BuildArea int;
					declare @MinEndDate datetime;

					select top 1
						@ID_BuildArea=ID_BuildArea
						,@MinEndDate=BuildAreaEndDate
					from dbo.udf_GetMinDateNomenclature_withTempBuildQueue(@ID_Nomenclature,@tmpBuildQueue)
					where BuildAreaEndDate=(
						select 
							min(BuildAreaEndDate)
						from dbo.udf_GetMinDateNomenclature_withTempBuildQueue(@ID_Nomenclature,@tmpBuildQueue));



					insert into @tmpBuildQueue (ID_Nomenclature,ID_BuildArea,StartDate,EndDate)
					values
						(@ID_Nomenclature, @ID_BuildArea,CURRENT_TIMESTAMP,@MinEndDate);


					set	@NomenclatureCounter=@NomenclatureCounter+1;

					if (@MaxMinDate is null) or (@MaxMinDate<@MinEndDate)
					begin
						set @MaxMinDate=@MinEndDate;
					end

					


				end
				
			end
				fetch next from nomenclature_cursor INTO @NomenclatureName, @NomenclatureCount;
	end

			close nomenclature_cursor;
			deallocate nomenclature_cursor;

	if (@MaxMinDate<=@EndDate) or (@MaxMinDate is null)
		set @result=1;



	return @result;
end