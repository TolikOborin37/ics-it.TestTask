CREATE TRIGGER dbo.TR_Basket_insert_update
ON dbo.Basket
instead of insert
AS
SET NOCOUNT ON;
DECLARE
@id_sku int,
@countId int;
DECLARE ff_Basket_cursor CURSOR FAST_FORWARD FOR
select 
	ID_SKU, 
	COUNT(ID_SKU) 
from inserted
group by ID_SKU;
OPEN ff_Basket_cursor;
FETCH FROM ff_Basket_cursor INTO @id_sku, @countId;
WHILE @@FETCH_STATUS = 0
if(@countId>=2)
begin
insert into dbo.Basket(ID_SKU, ID_Family, Quantity,Value, DiscountValue)
select ID_SKU, ID_Family, Quantity,Value, DiscountValue=value*0.05
from inserted
WHERE @id_sku = ID_SKU;
FETCH NEXT FROM ff_Basket_cursor INTO @id_sku, @countId;
end
else
begin
insert into dbo.Basket(ID_SKU, ID_Family, Quantity,Value, DiscountValue)
select ID_SKU, ID_Family, Quantity,Value, DiscountValue=0
from inserted
WHERE @id_sku = ID_SKU;
FETCH NEXT FROM ff_Basket_cursor INTO @id_sku, @countId;
end

close ff_Basket_cursor;
DEALLOCATE ff_Basket_cursor;

 

