use FACTORY;

SELECT 
	BA.Name as BuildAreaName,
	N.Name as NomenclatureName,
	--SUM(CASE WHEN PN.ID_Order IS NULL THEN RN.Count ELSE 0 END) as RemainingNomenclatureCount,
	--RN.Count as RemainingNomenclatureCount,
	COALESCE(RN.Count, 0)  as RemainingNomenclatureCount,
	SUM(PN.Count) as OrderNomenclatureCount,
	COALESCE(RN.Count, 0) + SUM( PN.Count) as AllCount
FROM dbo.ProducedNomenclature as PN
	INNER JOIN dbo.BuildAreas as BA ON PN.ID_BuildArea = BA.ID
	INNER JOIN dbo.Nomenclatures as N ON PN.ID_Nomenclature = N.ID
	LEFT JOIN dbo.RemainingNomenclature as RN ON PN.ID_BuildArea = RN.ID_BuildArea AND PN.ID_Nomenclature = RN.ID_Nomenclature
GROUP BY BA.Name, N.Name,COALESCE(RN.Count, 0) 

UNION

SELECT 
	BA.Name as BuildAreaName,
	N.Name as NomenclatureName,
	RN.Count as RemainingNomenclatureCount,
	0 as OrderNomenclatureCount,
	RN.Count as AllCount
FROM dbo.RemainingNomenclature as RN
	INNER JOIN dbo.BuildAreas as BA ON RN.ID_BuildArea = BA.ID
	INNER JOIN dbo.Nomenclatures as N ON RN.ID_Nomenclature = N.ID
WHERE NOT EXISTS (
	SELECT 1
	FROM dbo.ProducedNomenclature as PN
	WHERE PN.ID_BuildArea = RN.ID_BuildArea AND PN.ID_Nomenclature = RN.ID_Nomenclature
)


select 
	N.Name
	,sum(RN.Count) as RemainingCount
from dbo.RemainingNomenclature as RN
	inner join dbo.Nomenclatures as N on RN.ID_Nomenclature=N.ID
group by N.Name
order by sum(RN.Count);

select
	sum(RN.Count) as AllRemainingCount
from dbo.RemainingNomenclature as RN;

select
	BA.Name as BuildAreaName
	,O.Number as OrderNumber
	,N.Name as NomenclatureName
	,BQ.StartDate
	,BQ.EndDate
from dbo.BuildQueue as BQ
	inner join dbo.Orders as O on O.ID=BQ.ID_Order
	inner join dbo.Nomenclatures as N on N.ID=BQ.ID_Nomenclature
	inner join dbo.BuildAreas as BA on BA.ID=BQ.ID_BuildArea
order by BA.Name;