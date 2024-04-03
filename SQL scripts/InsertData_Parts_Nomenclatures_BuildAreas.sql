use FACTORY;

-- ���������� ������� dbo.Parts
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

-- ���������� ������� dbo.Nomenclatures
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

-- ���������� ������� dbo.BuildAreas
INSERT INTO dbo.BuildAreas (Name)
VALUES 
('Assembly Workshop'), 
('Paint Shop'), 
('Quality Control Area'), 
('Testing Track'), 
('Storage Area');

-- ������� ������ ������� ��� ������� BuildAreas_Nomenclatures

-- ������������ Car ������������ �� ��������� �������� 1, 2 � 3
INSERT INTO dbo.BuildAreas_Nomenclatures (ID_Nomenclature, ID_BuildArea)
VALUES 
(1, 1), (1, 2), (1, 3),
-- ������������ Truck ������������ �� ��������� �������� 2 � 3
(2, 2), (2, 3),
-- ������������ Motorcycle ������������ �� ��������� �������� 1 � 3
(3, 1), (3, 3),
-- ������������ SUV ������������ �� ��������� �������� 1 � 2
(4, 1), (4, 2),
-- ������������ Van ������������ ������ �� ��������� �������� 1
(5, 1),
-- ������������ Bus ������������ ������ �� ��������� �������� 2
(6, 2),
-- ������������ Electric Vehicle ������������ ������ �� ��������� �������� 3
(7, 3),
-- ������������ Hybrid Vehicle ������������ �� ��������� �������� 1 � 2
(8, 1), (8, 2),
-- ������������ Convertible ������������ �� ��������� �������� 2 � 3
(9, 2), (9, 3),
-- ������������ Sedan ������������ �� ��������� �������� 1, 2 � 3
(10, 1), (10, 2), (10, 3);

INSERT INTO dbo.Nomenclatures_Parts (ID_Part, ID_Nomenclature)
VALUES 
(1, 1),                     -- ������������ Car ������� ������ �� �������� Engine
(2, 2), (3, 2), (4, 2),     -- ������������ Truck ������� �� ��������� Transmission, Brakes � Suspension
(5, 3), (6, 3), (7, 3),     -- ������������ Motorcycle ������� �� ��������� Electronics, Interior � Exterior
(8, 4), (9, 4),             -- ������������ SUV ������� �� ��������� Wheels � Lights
(10, 5), (11, 5), (12, 5),  -- ������������ Van ������� �� ��������� Seats, Steering Wheel � Air Conditioning
(13, 6), (14, 6), (15, 6),  -- ������������ Bus ������� �� ��������� Exhaust System, Fuel System � Body Panels
(16, 7), (17, 7),           -- ������������ Electric Vehicle ������� �� ��������� Windows � Mirrors
(18, 8), (19, 8),           -- ������������ Hybrid Vehicle ������� �� ��������� Roof � Bumpers
(20, 9), (1, 9), (2, 9),    -- ������������ Convertible ������� �� ��������� Engine, Chassis � Transmission
(3, 10), (10, 10);          -- ������������ Sedan ������� �� ��������� Electronics � Seats



INSERT INTO dbo.RemainingNomenclature (ID_Nomenclature, ID_BuildArea, Count)
VALUES 
(1, 1, 20),     -- ������������ Car ��������� � ��������� ���� � ����� ������� 20
(2, 2, 15),     -- ������������ Truck ��������� � ���� �������� � ����� ������� 15
(3, 3, 30),     -- ������������ Motorcycle ��������� � ���� �������� �������� � ����� ������� 30
(4, 4, 25),     -- ������������ SUV ��������� �� ������������� ������ � ����� ������� 25
(5, 5, 18);     -- ������������ Van ��������� �� ������ � ����� ������� 18