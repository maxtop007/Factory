use FACTORY;

-- Заполнение таблицы dbo.Parts
INSERT INTO dbo.Parts (Name)
VALUES 
('Engine'), 
('Chassis'), 
('Transmission'), 
('Brakes'), 
('Suspension'), 
('Electronics'), 
('Interior'), 
('Exterior'), 
('Wheels'), 
('Lights'), 
('Seats'), 
('Steering Wheel'), 
('Air Conditioning'), 
('Exhaust System'), 
('Fuel System'), 
('Body Panels'), 
('Windows'), 
('Mirrors'), 
('Roof'), 
('Bumpers');

-- Заполнение таблицы dbo.Nomenclatures
INSERT INTO dbo.Nomenclatures (Name, BuildPeriod)
VALUES 
('Car', 30.5), 
('Truck', 45.2), 
('Motorcycle', 15.8), 
('SUV', 35.9), 
('Van', 40.2), 
('Bus', 50.7), 
('Electric Vehicle', 28.3), 
('Hybrid Vehicle', 32.6), 
('Convertible', 25.4), 
('Sedan', 37.8);

-- Заполнение таблицы dbo.BuildAreas
INSERT INTO dbo.BuildAreas (Name)
VALUES 
('Assembly Workshop'), 
('Paint Shop'), 
('Quality Control Area'), 
('Testing Track'), 
('Storage Area');

-- Вставка данных вручную для таблицы BuildAreas_Nomenclatures

-- Номенклатура Car производится на сборочных площадях 1, 2 и 3
INSERT INTO dbo.BuildAreas_Nomenclatures (ID_Nomenclature, ID_BuildArea)
VALUES 
(1, 1), (1, 2), (1, 3),
-- Номенклатура Truck производится на сборочных площадях 2 и 3
(2, 2), (2, 3),
-- Номенклатура Motorcycle производится на сборочных площадях 1 и 3
(3, 1), (3, 3),
-- Номенклатура SUV производится на сборочных площадях 1 и 2
(4, 1), (4, 2),
-- Номенклатура Van производится только на сборочной площадке 1
(5, 1),
-- Номенклатура Bus производится только на сборочной площадке 2
(6, 2),
-- Номенклатура Electric Vehicle производится только на сборочной площадке 3
(7, 3),
-- Номенклатура Hybrid Vehicle производится на сборочных площадях 1 и 2
(8, 1), (8, 2),
-- Номенклатура Convertible производится на сборочных площадях 2 и 3
(9, 2), (9, 3),
-- Номенклатура Sedan производится на сборочных площадях 1, 2 и 3
(10, 1), (10, 2), (10, 3);

INSERT INTO dbo.Nomenclatures_Parts (ID_Part, ID_Nomenclature)
VALUES 
(1, 1),                     -- Номенклатура Car состоит только из запчасти Engine
(2, 2), (3, 2), (4, 2),     -- Номенклатура Truck состоит из запчастей Transmission, Brakes и Suspension
(5, 3), (6, 3), (7, 3),     -- Номенклатура Motorcycle состоит из запчастей Electronics, Interior и Exterior
(8, 4), (9, 4),             -- Номенклатура SUV состоит из запчастей Wheels и Lights
(10, 5), (11, 5), (12, 5),  -- Номенклатура Van состоит из запчастей Seats, Steering Wheel и Air Conditioning
(13, 6), (14, 6), (15, 6),  -- Номенклатура Bus состоит из запчастей Exhaust System, Fuel System и Body Panels
(16, 7), (17, 7),           -- Номенклатура Electric Vehicle состоит из запчастей Windows и Mirrors
(18, 8), (19, 8),           -- Номенклатура Hybrid Vehicle состоит из запчастей Roof и Bumpers
(20, 9), (1, 9), (2, 9),    -- Номенклатура Convertible состоит из запчастей Engine, Chassis и Transmission
(3, 10), (10, 10);          -- Номенклатура Sedan состоит из запчастей Electronics и Seats



INSERT INTO dbo.RemainingNomenclature (ID_Nomenclature, ID_BuildArea, Count)
VALUES 
(1, 1, 20),     -- Номенклатура Car находится в сборочном цехе и имеет остаток 20
(2, 2, 15),     -- Номенклатура Truck находится в цехе покраски и имеет остаток 15
(3, 3, 30),     -- Номенклатура Motorcycle находится в зоне контроля качества и имеет остаток 30
(4, 4, 25),     -- Номенклатура SUV находится на испытательной трассе и имеет остаток 25
(5, 5, 18);     -- Номенклатура Van находится на складе и имеет остаток 18