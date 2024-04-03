use FACTORY;

-- ��� 1: ���������� ������
-- �������� ��������� ������� @OrderNomenclature � ��������� �������
DECLARE @OrderNomenclature dbo.NomenclatureListType;
DECLARE @ResultOrderNomenclature dbo.NomenclatureListType;
INSERT INTO @OrderNomenclature (NomenclatureName, NomenclatureCount)
VALUES 
    ('Car', 30),    -- ����������� 30 ����, ���� � RemainingNomenclature ������ 20
    ('Truck', 50),  -- ����������� 50 ����, ���� � RemainingNomenclature ������ 15
    ('SUV', 5),    -- ����������� 5 ����, ���� � RemainingNomenclature ������ 25
    ('Bus', 2),     -- ������������ Bus ���� � Nomenclatures, �� ��� � RemainingNomenclature
    ('Convertible', 3);  -- ������������ Convertible ���� � Nomenclatures, �� ��� � RemainingNomenclature


select *
from @OrderNomenclature;

-- ��� 2: ���������� ���������
-- ����� ��������� � �������������� �������������� ������
insert into @ResultOrderNomenclature 
	EXEC dbo.usp_SearchRemainingNomenclature 
		@OrderNomenclature = @OrderNomenclature,
		@ID_order = 123,  -- ������� ������������ ID ������ ��� �����
		@FlagOrder = 0;   -- ���������� ���� �� ���� ��� ����� ��� ������� @FlagOrder=1


select * from @ResultOrderNomenclature;

select top 1
	ID_BuildArea
	,BuildAreaEndDate
from dbo.udf_GetMinDateNomenclature(2)
where BuildAreaEndDate=(
	select 
		min(BuildAreaEndDate)
	from dbo.udf_GetMinDateNomenclature(2));