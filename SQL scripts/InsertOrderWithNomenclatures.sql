use FACTORY;

/*
create type dbo.NomenclatureListType as table (
	NomenclatureName nvarchar(255)
	,NomenclatureCount int
);
*/

drop procedure dbo.usp_InsertOrderWithNomenclatures;

go


create procedure dbo.usp_InsertOrderWithNomenclatures
    @endDate datetime
    ,@InsertNomenclature dbo.NomenclatureListType readonly
as
begin
    set NOCOUNT on;

	if (@endDate<=CURRENT_TIMESTAMP) or (@endDate is null)
	begin
	    raiserror('End date is wrong', 16, 1);
        return;
    end;

    -- Проверка наличия номенклатур в списке
    if not exists (select * from @InsertNomenclature)
    begin
        raiserror('Nomenclature list is empty', 16, 1);
        return;
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
        return;
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
        return;
    end;

	declare @OrderID INT;

	set @OrderID=
		case 
			when (select count(*) from dbo.Orders)=0 
				then 1
			else ident_current('dbo.Orders') +1
		end;

	declare @OrderNumber nvarchar(255);
	set @OrderNumber= 'ord'+ CAST(@OrderID as nvarchar(50));
    -- Вставка заказа
    insert into dbo.Orders (Number, endDate)
    values (@OrderNumber, @endDate);

    set @OrderID=scope_identity();

    -- Вставка номенклатур заказа
    insert into dbo.Orders_Nomenclatures (ID_Order, ID_Nomenclature, Count)
    select @OrderID, N.ID, NL.NomenclatureCount
    from @InsertNomenclature NL
    inner join Nomenclatures N on NL.NomenclatureName = N.Name;

    print 'Order inserted successfully';
end;
