create or alter trigger dbo.TR_Basket_insert_update
on dbo.Basket
after insert, update
as
update b
set b.DiscountValue = iif(i.SKUCount > 1, b.Value * 0.05, 0)
from dbo.Basket as b
	left join (
		select count(i.ID_SKU) as SKUCount, i.ID_SKU
		from inserted as i
		group by i.ID_SKU
	) as i on i.ID_SKU = b.ID_SKU
	