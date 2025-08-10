CREATE TABLE [dbo].[Item]
(
	[Sku] INT IDENTITY (1, 1) UNIQUE,
	[CategoryId] INT NOT NULL,
	[Name] NVARCHAR(30) NOT NULL,
	[Description] NVARCHAR(500) NOT NULL,	
	[Price] INT NOT NULL,
	[ColorId] INT NOT NULL,
	[Height] NCHAR(10) NOT NULL,
	[Width] NCHAR(10) NOT NULL,
	[Length] NCHAR(10) NOT NULL,
	[Weight] NCHAR(10) NOT NULL,
	[Available] INT NOT NULL,
	[WarehousePlace] NVARCHAR(500) NOT NULL,	
	[ImageUrl] NVARCHAR(1000) NOT NULL,	
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_Item_Name PRIMARY KEY (Name),
	CONSTRAINT FK_Item_CategoryId_Category_Id FOREIGN KEY (CategoryId) REFERENCES [Category](Id),
	CONSTRAINT FK_Item_ColorId_Color_Id FOREIGN KEY (ColorId) REFERENCES [Color](Id)
)
