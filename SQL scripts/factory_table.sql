USE FACTORY;
GO
create table dbo.Nomenclature(
	
	ID int
	,Name nvarchar(255)
	,AssemblyPeriod datetime
	,constraint PK_Nomenclature primary key (ID)
);

