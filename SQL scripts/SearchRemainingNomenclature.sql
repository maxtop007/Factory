use FACTORY;

go

drop procedure dbo.usp_SearchRemainingNomenclature;

go

create procedure dbo.usp_SearchRemainingNomenclature
    @OrderNomenclature dbo.NomenclatureListType readonly
	,@ID_order int
	,@FlagOrder bit
as
begin
    set nocount on;
	declare @tmpOrderNomenclature dbo.NomenclatureListType;
    declare @NomenclatureName nvarchar(255);
    declare @NomenclatureCount int;

	insert into @tmpOrderNomenclature
		select *
		from @OrderNomenclature;

    -- ќбрабатываем каждую номенклатуру из входного списка
    declare nomenclature_cursor CURSOR STATIC FOR
        select NomenclatureName, NomenclatureCount
        from @tmpOrderNomenclature;

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
				declare @FreeCount int;
				select 
					@FreeCount = sum(Count)
				from dbo.RemainingNomenclature
				where ID_Nomenclature = @ID_Nomenclature;

				if @FreeCount is not null
				begin

					if @FreeCount >= @NomenclatureCount
					begin
						delete from @tmpOrderNomenclature
						where NomenclatureName = @NomenclatureName;

					end
					else
					begin
           
						   -- ¬ычитаем количество номенклатур из свободного остатка
						update @tmpOrderNomenclature
						set NomenclatureCount = NomenclatureCount - @FreeCount
						where NomenclatureName = @NomenclatureName;

					   -- ”дал€ем из входного списка номенклатуру, если ее не хватает в свободных остатках
    
					end

					if @FlagOrder= 1 
					begin
						if not exists (
							select *
							from dbo.Orders as O
							where O.ID=@ID_order
						)
							begin
								raiserror('Order ID is incorrect!', 16, 1);
								return;
							end;
						exec dbo.usp_DeleteFromRemainingNomenclature_InsertProducedNomenclature
							@ID_Nomenclature=@ID_Nomenclature
							,@NomenclatureCount=@NomenclatureCount
							,@ID_order=@ID_order;
					end

				  end
				end
				fetch next from nomenclature_cursor INTO @NomenclatureName, @NomenclatureCount;
			end

			close nomenclature_cursor;
			deallocate nomenclature_cursor;

			
			select *
			from @tmpOrderNomenclature;
	
end