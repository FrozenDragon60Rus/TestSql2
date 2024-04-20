create or alter view dbo.vw_SKUPrice
as
select 
	s.[ID identity] 
	,s.Code 
	,s.Name
	,dbo.udf_GetSKUPrice(s.[ID identity]) as SKUPrice
from dbo.SKU as s