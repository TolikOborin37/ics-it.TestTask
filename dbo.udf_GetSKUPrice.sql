create function dbo.GetSKUPrice(@ID_SKU AS int)
Returns decimal(18,1)
Begin
Declare @Summ decimal(18,2)
Select @Summ = CAST(SUM(Value) AS decimal(18,2))/CAST(SUM(Quantity) AS decimal(18,2))
from dbo.Basket
Where @ID_SKU = ID_SKU
Return @Summ
end