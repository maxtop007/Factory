use FACTORY;

go

DECLARE @TestNomenclatureList dbo.NomenclatureListType;

-- ������������ � �� ���������� ��� ������
INSERT INTO @TestNomenclatureList (NomenclatureName, NomenclatureCount)
VALUES 
    ('Car', 20)
	/*
    ,('Truck', 3),
    ('Motorcycle', 1),
    ('SUV', 1),
    ('Bus', 2),
    ('Van', 1);
	*/

--DECLARE @EndDate datetime = DATEADD(DAY, 1, GETDATE());

declare @EndDate datetime='2024-03-29 07:51:26.473';

-- ���� 1: �������� ������������ �������� ���� ��������� ������
DECLARE @Result1 BIT;
EXEC @Result1 = dbo.usp_CHK_EndDate 
    @InsertNomenclature =@TestNomenclatureList, 
    @EndDate = @EndDate;

if @Result1 =1
	/*
	EXEC dbo.usp_InsertOrderWithNomenclatures 
		@endDate = @EndDate, 
		@NomenclatureList = @TestNomenclatureList;
	*/
	print ('Correct data')
else

print ('Wrong data');
	/*
-- ���� 2: �������� ������� ������ �����������
DECLARE @Result2 BIT;
EXEC @Result2 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = NULL, -- ������ ������ �����������
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- ��������� ���������: @Result2 = 0 (������ ������� ������ "Nomenclature list is empty")
SELECT '���� 2:', @Result2 AS '���������';

-- ���� 3: �������� ������������� �����������
DECLARE @Result3 BIT;
EXEC @Result3 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('InvalidNomenclature', 1)), -- ������ � ������������ �������������
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- ��������� ���������: @Result3 = 0 (������ ������� ������ "one or more nomenclatures do not match existing records")
SELECT '���� 3:', @Result3 AS '���������';

-- ���� 4: �������� ����������� ���������� �����������
DECLARE @Result4 BIT;
EXEC @Result4 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('Car', -1)), -- ������ � ������������ ����������� �����������
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- ��������� ���������: @Result4 = 0 (������ ������� ������ "Wrong amount of nomenclatures")
SELECT '���� 4:', @Result4 AS '���������';

-- ���� 5: �������� ���������� ���� ��������� ������
DECLARE @Result5 BIT;
EXEC @Result5 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('Car', 2), ('Truck', 3)), -- ������ ����������� � ����������� �������
    @EndDate = DATEADD(DAY, 1, GETDATE()); -- ������������� ���� ��������� ������ �� ������

-- ��������� ���������: @Result5 = 0 (������ ������� ������ "End date is wrong")
SELECT '���� 5:', @Result5 AS '���������';
*/

