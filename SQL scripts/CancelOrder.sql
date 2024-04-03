use FACTORY;

go
drop procedure dbo.usp_CancelOrder;
go

create procedure dbo.usp_CancelOrder
	@Ordernumber varchar(255)
as
begin
	set nocount on;

	declare @ID_Order int;
	select top 1
			@ID_Order=O.ID
	from dbo.Orders as O
	where O.Number=@Ordernumber;

	if (@ID_Order is null)
	begin
		raiserror('Order number is wrong', 16, 1);
		return;
	end

	delete from dbo.BuildQueue 
		where dbo.BuildQueue.ID_Order=@ID_Order;
	
		-- Check if nomenclature from the order exists in the remaining nomenclature
	if exists(
		select *
		from dbo.ProducedNomenclature as PN
		where PN.ID_Order=@ID_Order
	)
	begin
		-- Update existing records in the remaining nomenclature or insert new records
		insert into dbo.RemainingNomenclature (ID_Nomenclature, ID_BuildArea, Count)
		select 
			PN.ID_Nomenclature,
			PN.ID_BuildArea,
			PN.Count
		from dbo.ProducedNomenclature as PN
		where PN.ID_Order=@ID_Order
		and not exists (
			select 1
			from dbo.RemainingNomenclature as RN
			where RN.ID_Nomenclature = PN.ID_Nomenclature
				and RN.ID_BuildArea=PN.ID_BuildArea
		);
		
		-- Update count for existing records in the remaining nomenclature
		update RN
		set RN.Count = RN.Count + PN.Count
		from dbo.RemainingNomenclature as RN
		join dbo.ProducedNomenclature as PN on RN.ID_Nomenclature = PN.ID_Nomenclature
		where PN.ID_Order = @ID_Order
			and RN.ID_Nomenclature = PN.ID_Nomenclature
			and RN.ID_BuildArea=PN.ID_BuildArea;
	end
	else
	begin
		insert into dbo.RemainingNomenclature (ID_Nomenclature, ID_BuildArea, Count)
		select 
			PN.ID_Nomenclature,
			PN.ID_BuildArea,
			PN.Count
		from dbo.ProducedNomenclature as PN
		where PN.ID_Order=@ID_Order;
	end

	delete from dbo.ProducedNomenclature
		where dbo.ProducedNomenclature.ID_Order=@ID_Order;

	delete from dbo.Orders_Nomenclatures
		where dbo.Orders_Nomenclatures.ID_Order=@ID_Order;

	delete from dbo.Orders
		where dbo.Orders.ID=@ID_Order;

	print ('Order canceled successfully');



end