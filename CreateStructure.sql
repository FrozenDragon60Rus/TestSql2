begin
	if object_id('dbo.SKU') is null
		create table dbo.SKU(
			[ID identity] int not null,
			Code as concat('s',[ID identity]),
			Name varchar(50) not null,
			constraint PK_SKU primary key([ID identity]),
			constraint UK_SKU_Code unique(Code)
		)
end

begin
	if object_id('dbo.Family') is null
		create table dbo.Family(
			[ID identity] int not null,
			SurName varchar(20) not null,
			BudgetValue money not null,
			constraint PK_Family primary key([ID identity])
		)
end

begin
	if object_id('dbo.Basket') is null
		create table dbo.Basket(
			[ID identity] int not null primary key,
			ID_SKU int not null,
			ID_Family int not null,
			Quantity int check(Quantity >= 0) not null,
			Value dec(18,2) check(Value >= 0) not null,
			PurchaseDate date default(getdate()),
			DiscountValue dec(4,2),
			constraint FK_Basket_ID_identity_SKU foreign key (ID_SKU) references dbo.SKU([ID identity]) on delete cascade,
			constraint FK_Basket_ID_identity_Family foreign key (ID_Family) references dbo.Family([ID identity]) on delete cascade
		)
end