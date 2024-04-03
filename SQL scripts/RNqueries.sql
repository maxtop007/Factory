use FACTORY;

select 
	RN.ID
	,N.Name as Nomenclature
	,BA.Name as BuildArea
	,RN.Count
from dbo.RemainingNomenclature as RN
	inner join dbo.Nomenclatures as N on N.ID=RN.ID
	inner join dbo.BuildAreas as BA on BA.ID=RN.ID
order by RN.Count;

select 
	sum(RN.Count) as SumNomenclatures
from dbo.RemainingNomenclature as RN;


