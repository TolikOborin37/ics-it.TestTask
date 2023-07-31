--создание таблицы dbo.SKU
create table dbo.SKU
(ID int not null identity(1,1),
Code as CONCAT(N's',ID),
Name nvarchar(50) not null
);
GO
--ограничение для таблицы dbo.SKU
alter table dbo.Sku
add constraint PK_SKU Primary key(ID),
constraint Unique_Code_SKU Unique(Code)
GO
create table dbo.Family
(
ID int not null identity(1,1),
SurName nvarchar(50) not null,
BodgerValue int not null,
);
GO
--ограничение на таблицу Family
alter table dbo.Family
add constraint PK_Family Primary key(ID)
GO
create table dbo.Basket
(
ID int not null identity(1,1),
ID_SKU int not null,
ID_Family int not null,
Quantity int not null,
Value int not null,
PurchaseDate datetime not null,
DiscountValue int not null
);
GO
--ограничения таблицы dbo.Basket на поле Quantity, Value и PurchaseDate
alter table dbo.Basket
add constraint CHK_Bakset_Quantity CHECK(Quantity>0),
constraint CHK_Basket_Value CHECK(Value>0),
constraint DFT_Basket_PurchaseDate DEFAULT(SYSDATETIME()) FOR PurchaseDate,
--внешние ключи на таблицы SKU и Family
constraint FK_Basket_SKU foreign key(ID_SKU) REFERENCES dbo.SKU(ID),
constraint FK_Basket_Family foreign key(ID_Family) REFERENCES dbo.Family(ID)
GO