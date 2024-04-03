use FACTORY;

-- Шаг 1: Подготовка данных
-- Создание временной таблицы @OrderNomenclature с тестовыми данными
DECLARE @OrderNomenclature dbo.NomenclatureListType;
DECLARE @ResultOrderNomenclature dbo.NomenclatureListType;
INSERT INTO @OrderNomenclature (NomenclatureName, NomenclatureCount)
VALUES 
    ('Car', 30),    -- Запрашиваем 30 штук, хотя в RemainingNomenclature только 20
    ('Truck', 50),  -- Запрашиваем 50 штук, хотя в RemainingNomenclature только 15
    ('SUV', 5),    -- Запрашиваем 5 штук, хотя в RemainingNomenclature только 25
    ('Bus', 2),     -- Номенклатура Bus есть в Nomenclatures, но нет в RemainingNomenclature
    ('Convertible', 3);  -- Номенклатура Convertible есть в Nomenclatures, но нет в RemainingNomenclature


select *
from @OrderNomenclature;

-- Шаг 2: Выполнение процедуры
-- Вызов процедуры с использованием подготовленных данных
insert into @ResultOrderNomenclature 
	EXEC dbo.usp_SearchRemainingNomenclature 
		@OrderNomenclature = @OrderNomenclature,
		@ID_order = 123,  -- Указать существующий ID заказа для теста
		@FlagOrder = 0;   -- Установить флаг на ноль для теста без условия @FlagOrder=1


select * from @ResultOrderNomenclature;

select top 1
	ID_BuildArea
	,BuildAreaEndDate
from dbo.udf_GetMinDateNomenclature(2)
where BuildAreaEndDate=(
	select 
		min(BuildAreaEndDate)
	from dbo.udf_GetMinDateNomenclature(2));