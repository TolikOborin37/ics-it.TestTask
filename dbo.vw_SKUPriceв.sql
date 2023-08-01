Create VIEW dbo.vw_SKUPrice
AS
Select ID, Code, Name, dbo.GetSKUPrice(ID) as GetSKUPrice from dbo.SKU
GO