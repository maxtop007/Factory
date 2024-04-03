use FACTORY;

DECLARE @TestNomenclatureList dbo.NomenclatureListType;

-- Ќоменклатуры и их количество дл€ заказа
INSERT INTO @TestNomenclatureList (NomenclatureName, NomenclatureCount)
VALUES 
    ('Car', 2),
    ('Truck', 3),
    ('Motorcycle', 1),
    ('SUV', 1),
    ('Bus', 2),
    ('Van', 1);

DECLARE @EndDate datetime = DATEADD(DAY, 7, GETDATE());

EXEC dbo.usp_InsertOrderWithNomenclatures @endDate = @EndDate, @NomenclatureList = @TestNomenclatureList;

/*DECLARE @InvalidEndDate datetime = GETDATE() - 1;
EXEC dbo.usp_InsertOrderWithNomenclatures @endDate = @InvalidEndDate, @NomenclatureList = @TestNomenclatureList;
*/