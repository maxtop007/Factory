use FACTORY;

go

drop trigger dbo.tr_OrderNomenclature_Insert ;

go
create trigger dbo.tr_OrderNomenclature_Insert
on dbo.Orders_Nomenclatures
after insert
as
begin
/*
	declare @InsertedData nvarchar(max);

	select @InsertedData=STRING_AGG(convert(nvarchar(max),ID_Nomenclature) +', '+convert(nvarchar(max),ID_Order),', ')
	from inserted;
*/
	set nocount on;
	declare @InsertNomenclature dbo.NomenclatureListType;

	insert into @InsertNomenclature
	select
		N.Name
		,i.Count
	from inserted as i
		inner join dbo.Nomenclatures as N on i.ID_Nomenclature=N.ID;

	declare @ID_Order int;

	select top 1
		@ID_Order=I.ID_Order
	from inserted as I;



	declare @ResultOrderNomenclature dbo.NomenclatureListType;

	insert into @ResultOrderNomenclature 
	exec dbo.usp_SearchRemainingNomenclature 
		@OrderNomenclature = @InsertNomenclature
		,@ID_order = @ID_Order  
		,@FlagOrder = 1;


	
	declare @NomenclatureName nvarchar(255);
    declare @NomenclatureCount int;

	declare nomenclature_cursor cursor  for
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
					declare @EndDate datetime;

					select top 1
						@ID_BuildArea=ID_BuildArea
						,@EndDate=BuildAreaEndDate
					from dbo.udf_GetMinDateNomenclature(@ID_Nomenclature)
					where BuildAreaEndDate=(
						select 
							min(BuildAreaEndDate)
						from dbo.udf_GetMinDateNomenclature(@ID_Nomenclature));



					insert into dbo.BuildQueue (ID_Order,ID_Nomenclature,ID_BuildArea,StartDate,EndDate)
					values
						(@ID_Order,@ID_Nomenclature, @ID_BuildArea,CURRENT_TIMESTAMP,@EndDate);

					set	@NomenclatureCounter=@NomenclatureCounter+1;
				end
				
			end
				fetch next from nomenclature_cursor INTO @NomenclatureName, @NomenclatureCount;
		end

			close nomenclature_cursor;
			deallocate nomenclature_cursor;

	
end;