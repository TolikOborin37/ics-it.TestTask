create procedure dbo.usp_MakeFamilyPurchase
@FamilySurName as varchar(255)
AS
DECLARE @ID_SurName int
DECLARE @SumBasketValueID int
SET @ID_SurName = (select id from dbo.Family Where @FamilySurName = Family.SurName)
IF (@ID_SurName IS NOT NULL)
begin
SET @SumBasketValueID = (select sum(value) from dbo.Basket where ID_Family = @ID_SurName)
update dbo.Family SET BodgerValue = dbo.Family.BodgerValue - @SumBasketValueID	WHERE @FamilySurName = SurName
end
ELSE
PRINT 'Такой семьи нет'
