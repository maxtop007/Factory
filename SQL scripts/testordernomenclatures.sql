select 
	O.Number
	,N.Name
	,OrdN.Count
from dbo.Orders as O
	inner join dbo.Orders_Nomenclatures as OrdN on OrdN.ID_Order=O.ID
	inner join dbo.Nomenclatures as N on N.ID=OrdN.ID_Nomenclature
order by OrdN.Count desc;