use FACTORY;

select 
	Nom_Parts.ID
	,Parts.Name as Part
	,Nom.Name as Nomenclature
from dbo.Nomenclatures_Parts as Nom_Parts
	inner join dbo.Parts as Parts on Nom_Parts.ID_Part=Parts.ID
	inner join dbo.Nomenclatures as Nom on Nom_Parts.ID_Nomenclature=Nom.ID
order by   Nom.Name ;