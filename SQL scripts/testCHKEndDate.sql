use FACTORY;

go

DECLARE @TestNomenclatureList dbo.NomenclatureListType;

-- Номенклатуры и их количество для заказа
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

-- Тест 1: Проверка корректности проверки даты окончания заказа
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
-- Тест 2: Проверка пустого списка номенклатур
DECLARE @Result2 BIT;
EXEC @Result2 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = NULL, -- Пустой список номенклатур
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- Ожидаемый результат: @Result2 = 0 (должна вернуть ошибку "Nomenclature list is empty")
SELECT 'Тест 2:', @Result2 AS 'Результат';

-- Тест 3: Проверка сопоставления номенклатур
DECLARE @Result3 BIT;
EXEC @Result3 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('InvalidNomenclature', 1)), -- Список с некорректной номенклатурой
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- Ожидаемый результат: @Result3 = 0 (должна вернуть ошибку "one or more nomenclatures do not match existing records")
SELECT 'Тест 3:', @Result3 AS 'Результат';

-- Тест 4: Проверка правильного количества номенклатур
DECLARE @Result4 BIT;
EXEC @Result4 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('Car', -1)), -- Список с неправильным количеством номенклатур
    @EndDate = DATEADD(DAY, 7, GETDATE());

-- Ожидаемый результат: @Result4 = 0 (должна вернуть ошибку "Wrong amount of nomenclatures")
SELECT 'Тест 4:', @Result4 AS 'Результат';

-- Тест 5: Проверка допустимой даты окончания заказа
DECLARE @Result5 BIT;
EXEC @Result5 = dbo.usp_CHK_EndDate 
    @InsertNomenclature = (VALUES ('Car', 2), ('Truck', 3)), -- Список номенклатур с корректными данными
    @EndDate = DATEADD(DAY, 1, GETDATE()); -- Устанавливаем дату окончания заказа на завтра

-- Ожидаемый результат: @Result5 = 0 (должна вернуть ошибку "End date is wrong")
SELECT 'Тест 5:', @Result5 AS 'Результат';
*/

