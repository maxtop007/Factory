USE FACTORY;


create table dbo.Nomenclatures(
	
	ID int not null identity
	,Name nvarchar(255)
	,BuildPeriod decimal(18,2)
	,constraint PK_Nomenclatures primary key (ID)
	,constraint CHK_Nomenclatures_BuildPeriod check(BuildPeriod >=0)
);

create table dbo.Parts (
    ID int not null identity
    ,Name nvarchar(255)
	,constraint PK_Parts primary key (ID)
);


create table dbo.BuildAreas (
    ID int not null identity 
    ,Name nvarchar(255)
	,constraint PK_BuildAreas primary key (ID)
);


create table dbo.Orders(
	
	ID int not null identity
	,Number nvarchar(255)
	,EndDate datetime
	,constraint PK_Orders primary key (ID)
	,constraint CHK_Orders_EndDate check(EndDate >= CURRENT_TIMESTAMP)
);


go

create table dbo.Nomenclatures_Parts (
    ID int not null identity
    ,ID_Part int not null
    ,ID_Nomenclature int not null
	,constraint PK_Nomenclatures_Parts primary key (ID)
	,constraint FK_Nomenclatures_Parts_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_Nomenclatures_Parts_ID_Part_Parts foreign key (ID_Part)
		references Parts(ID)
);

create table dbo.BuildAreas_Nomenclatures (
    ID int not null identity
    ,ID_Nomenclature int not null
    ,ID_BuildArea int not null
	,constraint PK_BuildAreas_Nomenclatures primary key (ID)
	,constraint FK_BuildAreas_Nomenclatures_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_BuildAreas_Nomenclatures_ID_BuildArea_BuildAreas foreign key (ID_BuildArea)
		references BuildAreas(ID)
);


create table dbo.Orders_Nomenclatures (
    ID int not null identity
    ,ID_Order int not null
    ,ID_Nomenclature int not null
    ,Count int
	,constraint PK_Orders_Nomenclatures primary key (ID)
	,constraint FK_Orders_Nomenclatures_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_Orders_Nomenclatures_ID_Order_Orders foreign key (ID_Order)
		references Orders(ID)
	,constraint CHK_Orders_Nomenclatures_Count check(Count >=0)
);


create table dbo.BuildQueue (
    ID int not null identity
    ,ID_Order int not null
    ,ID_Nomenclature int not null
    ,ID_BuildArea int not null
    ,StartDate DATETIME
    ,EndDate DATETIME
	,constraint PK_BuildQueue primary key (ID)
	,constraint FK_BuildQueue_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_BuildQueue_ID_Order_Orders foreign key (ID_Order)
		references Orders(ID)
	,constraint FK_BuildQueue_ID_BuildArea_BuildAreas foreign key (ID_BuildArea)
		references BuildAreas(ID)
	,constraint CHK_BuildQueue_EndDate check(EndDate >= CURRENT_TIMESTAMP)
);


create table dbo.ProducedNomenclature (

    ID int not null identity
    ,ID_Order int not null
    ,ID_Nomenclature int not null
    ,ID_BuildArea int not null
    ,Count int
	,constraint CHK_ProducedNomenclature_Count check(Count >=0)
	,constraint PK_ProducedNomenclature primary key (ID)
	,constraint FK_ProducedNomenclature_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_ProducedNomenclature_ID_Order_Orders foreign key (ID_Order)
		references Orders(ID)
	,constraint FK_ProducedNomenclature_ID_BuildArea_BuildAreas foreign key (ID_BuildArea)
		references BuildAreas(ID)
);

create table dbo.RemainingNomenclature (
    ID int not null identity
    ,ID_Nomenclature int not null
    ,ID_BuildArea int not null
    ,Count int
	,constraint CHK_RemainingNomenclature_Count check(Count >=0)
	,constraint PK_RemainingNomenclature primary key (ID)
	,constraint FK_RemainingNomenclature_ID_Nomenclature_Nomenclatures foreign key (ID_Nomenclature)
		references Nomenclatures(ID)
	,constraint FK_RemainingNomenclature_ID_BuildArea_BuildAreas foreign key (ID_BuildArea)
		references BuildAreas(ID)
);