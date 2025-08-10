CREATE DATABASE [SalesSystemDataBase];

GO

USE [SalesSystemDataBase]

GO

-- Common

CREATE TABLE [dbo].[User]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Email] NVARCHAR(100) NOT NULL,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[CellPhone] VARCHAR(20) NOT NULL,
	[Phone] VARCHAR(20) NULL,
	[Password] NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_User_Email PRIMARY KEY (Email)
)

GO

CREATE TABLE [dbo].[Role]
(
	[Id] INT UNIQUE,
	[RoleName] NVARCHAR(100) NOT NULL UNIQUE,
	[Description] NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Role_Id_RoleName PRIMARY KEY (Id, RoleName)
)

GO

CREATE TABLE [dbo].[UserLogin]
(
	[UserId] INT NOT NULL,
	[LoginDate] DateTime DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT FK_UserLogin_UserId_User_Id FOREIGN KEY (UserId) REFERENCES [User]([Id])
)

GO

CREATE TABLE [dbo].[User2Role]
(
	[UserId] INT NOT NULL,
	[RoleId] INT NOT NULL
	CONSTRAINT PK_User2Role_UserId_RoleId PRIMARY KEY (UserId, RoleId),
	CONSTRAINT FK_User2Role_UserId_User_Id FOREIGN KEY (UserId) REFERENCES [User](Id),
	CONSTRAINT FK_User2Role_RoleId_Role_Id FOREIGN KEY (RoleId) REFERENCES [Role](Id)
)

GO

CREATE PROCEDURE [dbo].[User_Authenticate]
	@email NVARCHAR(100),
	@password NVARCHAR(20)
AS
BEGIN
	SELECT TOP 1 u.[Id], [Email], [FirstName], [LastName], [CellPhone], [Phone], [LoginDate], r.[Id] AS [RoleId], [RoleName], [Description] AS [RoleDescription]
	FROM [dbo].[User] AS u
	LEFT JOIN [dbo].[UserLogin] AS ul ON u.[Id] = ul.[UserId]
	LEFT JOIN [dbo].[User2Role] AS u2r ON u.[Id] = u2r.[UserId]
	LEFT JOIN [dbo].[Role] AS r ON u2r.[RoleId] = r.[Id]
	WHERE [Email] = @email
	AND [Password] = @password
	ORDER BY [LoginDate] DESC

	IF (@@ROWCOUNT > 0)
	BEGIN
		INSERT INTO [dbo].[UserLogin] (UserId)
		SELECT [Id] FROM [dbo].[User] WHERE [Email] = @email
	END
END

GO

-- Customer

CREATE TABLE [dbo].[City]
(
	[Name] NVARCHAR(100) NOT NULL,
	[Code] INT,
	CONSTRAINT PK_City_Code PRIMARY KEY (Code)
)

GO

CREATE TABLE [dbo].[Contact]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[FirstName] NVARCHAR(50) NOT NULL,
	[LastName] NVARCHAR(50) NOT NULL,
	[Job] NVARCHAR(100) NOT NULL,
	[OfficePhone] VARCHAR(20) NOT NULL,
	[CellPhone] VARCHAR(20) NOT NULL,
	[Email] NVARCHAR(100) NOT NULL,	
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_Contact_CellPhone_Email PRIMARY KEY (CellPhone, Email)
)

GO

CREATE TABLE [dbo].[Customer]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Name] NVARCHAR(100) NOT NULL,
	[DealerId] INT NOT NULL,
	[Status] INT NOT NULL DEFAULT (0),
	[CityCode] INT NOT NULL,
	[Street] NVARCHAR(100) NOT NULL,
	[Zip] NCHAR(10) NOT NULL,
	[Contact1] INT NOT NULL,
	[Contact2] INT NULL,
	[Bank] VARCHAR(30) NOT NULL,
	[Branch] VARCHAR(5) NOT NULL,
	[Account] VARCHAR(10) NOT NULL,
	[Credit] INT NOT NULL,	
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_Customer_Name PRIMARY KEY (Name),
	CONSTRAINT FK_Customer_CityCode_City_Code FOREIGN KEY (CityCode) REFERENCES [City](Code),
	CONSTRAINT FK_Customer_CityCode_Contact_Contact1 FOREIGN KEY (Contact1) REFERENCES [Contact](Id),
	CONSTRAINT FK_Customer_CityCode_Contact_Contact2 FOREIGN KEY (Contact2) REFERENCES [Contact](Id)
)

GO

CREATE PROCEDURE [dbo].[Customer_Upsert]
	@id INT = NULL,
	@name NVARCHAR(100),
	@dealerId NVARCHAR(100),
	@status INT = NULL,

	@cityCode INT,
	@street NVARCHAR(100),
	@zip NCHAR(10),

	@contact1Id INT = NULL,
	@contact1FirstName NVARCHAR(50),
	@contact1LastName NVARCHAR(50),
	@contact1Job NVARCHAR(100),
	@contact1OfficePhone VARCHAR(20),
	@contact1CellPhone VARCHAR(20),
	@contact1Email NVARCHAR(100),

	@contact2Id INT = NULL,
	@contact2FirstName NVARCHAR(50),
	@contact2LastName NVARCHAR(50),
	@contact2Job NVARCHAR(100),
	@contact2OfficePhone VARCHAR(20),
	@contact2CellPhone VARCHAR(20),
	@contact2Email NVARCHAR(100),

	@bank NVARCHAR(30),
	@branch VARCHAR(5),
	@account VARCHAR(10),

	@credit NCHAR(20)
AS
BEGIN
	IF(@id IS NOT NULL)
	BEGIN
		-- update contact 1
		UPDATE [dbo].[Contact]
		SET [FirstName] = @contact1FirstName, [LastName] = @contact1LastName, [Job] = @contact1Job, 
			[OfficePhone] = @contact1OfficePhone, [CellPhone] = @contact1CellPhone, [Email] = @contact1Email,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Id] = @contact1Id

		IF(@contact2Id IS NOT NULL) -- update contact 2
		BEGIN			
			UPDATE [dbo].[Contact]
			SET [FirstName] = @contact2FirstName, [LastName] = @contact2LastName, [Job] = @contact2Job, 
				[OfficePhone] = @contact2OfficePhone, [CellPhone] = @contact2CellPhone, [Email] = @contact2Email,
				[LastUpdated] = CURRENT_TIMESTAMP
			WHERE [Id] = @contact2Id
		END
		ELSE
		BEGIN
			IF(@contact2FirstName IS NOT NULL) -- insert contact 2
			BEGIN
				DECLARE @InsertedWithinUpdateContact2 TABLE ([Id] INT)

				INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
				OUTPUT INSERTED.[Id] INTO @InsertedWithinUpdateContact2
				VALUES (@contact2FirstName, @contact2LastName, @contact2Job, @contact2OfficePhone, @contact2CellPhone, @contact2Email)
				
				SELECT @contact2Id = [Id] FROM @InsertedWithinUpdateContact2
			END
		END

		-- update customer
		UPDATE [dbo].[Customer]
		SET [Name] = @name, [DealerId] = @dealerId, [Status] = @status, [CityCode] = @cityCode, [Street] = @street, [Zip] = @zip, 
			[Contact1] = @contact1Id, [Contact2] = @contact2Id,  [Bank] = @bank, [Branch] = @branch, [Account] = @account, [Credit] = @credit,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Id] = @id

		SELECT @id AS [Id]
	END
	ELSE
	BEGIN
		-- insert contact 2
		IF(@contact2FirstName IS NOT NULL AND @contact2FirstName != '' AND @contact2FirstName != N'') 
		BEGIN
			DECLARE @InsertedContact2 TABLE ([Id] INT)

			INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
			OUTPUT INSERTED.[Id] INTO @InsertedContact2
			VALUES (@contact2FirstName, @contact2LastName, @contact2Job, @contact2OfficePhone, @contact2CellPhone, @contact2Email)
				
			SELECT @contact2Id = [Id] FROM @InsertedContact2
		END

		-- insert contact 1
		DECLARE @InsertedContact1 TABLE ([Id] INT)

		INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
		OUTPUT INSERTED.[Id] INTO @InsertedContact1
		VALUES (@contact1FirstName, @contact1LastName, @contact1Job, @contact1OfficePhone, @contact1CellPhone, @contact1Email)
				
		SELECT @contact1Id = [Id] FROM @InsertedContact1

		-- update customer
		DECLARE @InsertedCustomer TABLE ([Id] INT)

		INSERT INTO [dbo].[Customer] ([Name], [DealerId], [CityCode], [Street], [Zip], [Contact1], [Contact2], [Bank], [Branch], [Account], [Credit])
		OUTPUT INSERTED.[Id] INTO @InsertedCustomer
		VALUES (@name, @dealerId, @cityCode, @street, @zip, @contact1Id, @contact2Id, @bank, @branch, @account, @credit)

		SELECT [Id] FROM @InsertedCustomer 
	END	
END

GO

CREATE PROCEDURE [dbo].[Customer_FindById]
	@id INT
AS
BEGIN
	SELECT TOP 1 cu.[Id], cu.[Name], [DealerId], u.[FirstName] + ' ' + u.[LastName] AS [DealerName], [Status], [CityCode], c.[Name] AS [CityName], [Street], [Zip],
	co1.[Id] AS [Contact1Id], co1.[FirstName] AS [Contact1FirstName], co1.[LastName] AS [Contact1LastName], co1.[Job] AS [Contact1Job], co1.[OfficePhone] AS [Contact1OfficePhone], co1.[CellPhone] AS [Contact1CellPhone], co1.[Email] AS [Contact1Email],
	co2.[Id] AS [Contact2Id], co2.[FirstName] AS [Contact2FirstName], co2.[LastName] AS [Contact2LastName], co2.[Job] AS [Contact2Job], co2.[OfficePhone] AS [Contact2OfficePhone], co2.[CellPhone] AS [Contact2CellPhone], co2.[Email] AS [Contact2Email],
	[Bank], [Branch], [Account], [Credit], [Credit] as [CreditLeft]
	FROM [dbo].[Customer] cu
	LEFT JOIN [dbo].[City] AS c ON cu.[CityCode] = c.[Code]
	LEFT JOIN [dbo].[Contact] AS co1 ON cu.[Contact1] = co1.[Id]
	LEFT JOIN [dbo].[Contact] AS co2 ON cu.[Contact2] = co2.[Id]
	LEFT JOIN [dbo].[User] AS u ON u.[Id] = [DealerId]
	WHERE cu.[Id] = @id
END

GO

CREATE PROCEDURE [dbo].[Customer_FindByIdOrName]
	@id INT = NULL,
	@name NVARCHAR(100) = NULL
AS
BEGIN
	SELECT [Id], [Name], [Status]
	FROM [dbo].[Customer]
	WHERE [Id] = @id
	OR [Name] LIKE '%' + @name + '%'
END

GO

CREATE PROCEDURE [dbo].[Customer_GetCities]
AS
BEGIN
	SELECT [Name], [Code]
	FROM [dbo].[City]
END

GO

-- Item

CREATE TABLE [dbo].[Category]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Name] NVARCHAR(30) NOT NULL,
	[Description] NVARCHAR(500) NOT NULL,	
	CONSTRAINT PK_Category_Name PRIMARY KEY (Name)
)

GO

CREATE TABLE [dbo].[Color]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Name] NVARCHAR(30) NOT NULL,	
	CONSTRAINT PK_Color_Name PRIMARY KEY (Name)
)

GO

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

GO

CREATE PROCEDURE [dbo].[Item_GetColors]
AS
BEGIN
	SELECT [Id], [Name]
	FROM [dbo].[Color]
END

GO

CREATE PROCEDURE [dbo].[Item_GetCategoies]
AS
BEGIN
	SELECT [Id], [Name], [Description]
	FROM [dbo].[Category]
END

GO

CREATE PROCEDURE [dbo].[Item_FindBySku]
	@sku INT
AS
BEGIN
	SELECT TOP 1 [Sku], [CategoryId], ca.[Name] AS [CategoryName], i.[Name], i.[Description], [Price], [ColorId], co.[Name] as [ColorName], [Height], [Width], [Length], [Weight], [Available], [WarehousePlace], [ImageUrl]
	FROM [dbo].[Item] AS i
	LEFT JOIN [dbo].[Category] AS ca ON i.[CategoryId] = ca.[Id]
	LEFT JOIN [dbo].[Color] AS co ON i.[ColorId] = co.[Id]
	WHERE [Sku] = @sku
END

GO

CREATE PROCEDURE [dbo].[Item_FindBySkuOrName]
	@sku INT = NULL,
	@name NVARCHAR(100) = NULL
AS
BEGIN
	SELECT [Sku], [Name], [ImageUrl], [Available], [Price]
	FROM [dbo].[Item]
	WHERE [Sku] = @sku
	OR [Name] LIKE '%' + @name + '%'
END

GO

CREATE PROCEDURE [dbo].[Item_Upsert]
	@sku INT = NULL,
	@categoryId INT,
	@name NVARCHAR(30),
	@description NVARCHAR(500),	
	@price INT,
	@colorId INT,
	@height NCHAR(10),
	@width NCHAR(10),
	@length NCHAR(10),
	@weight NCHAR(10),
	@available INT,
	@warehousePlace NVARCHAR(500),	
	@imageUrl NVARCHAR(1000)
AS
BEGIN
	IF(@sku IS NOT NULL)
	BEGIN
		-- update item
		UPDATE [dbo].[Item]
		SET [CategoryId] = @categoryId,  [Name] = @name,  [Description] = @description,  [Price] = @price,  [ColorId] = @colorId,  
			[Height] = @height,  [Width] = @width,  [Length] = @length,  [Weight] = @weight, 
			[Available] = @available,  [WarehousePlace] = @warehousePlace,  [ImageUrl] = @imageUrl,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Sku] = @sku

		SELECT @sku AS [Sku]
	END
	ELSE
	BEGIN
		-- update customer
		DECLARE @InsertedItem TABLE ([Sku] INT)

		INSERT INTO [dbo].[Item] ([CategoryId], [Name], [Description], [Price], [ColorId], [Height], [Width], [Length], [Weight], [Available], [WarehousePlace], [ImageUrl])
		OUTPUT INSERTED.[Sku] INTO @InsertedItem
		VALUES (@categoryId, @name, @description, @price, @colorId, @height, @width, @length, @weight, @available, @warehousePlace, @imageUrl)

		SELECT [Sku] FROM @InsertedItem 
	END	
END

GO

CREATE TABLE [dbo].[Order]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[CustomerId] INT NOT NULL,
	[Status] INT  NOT NULL,
	[Discount] INT  NOT NULL,
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_Order_Id PRIMARY KEY (Id),
	CONSTRAINT FK_Order_CustomerId_Customer_Id FOREIGN KEY (CustomerId) REFERENCES [Customer](Id)
)

GO

CREATE TABLE [dbo].[OrderItem]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[OrderId] INT NOT NULL,
	[Sku] INT NOT NULL,
	[Amount] INT NOT NULL,
	[ActualAmount] INT NULL,
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_OrderItem_Id PRIMARY KEY (Id),
	CONSTRAINT FK_OrderItem_OrderId_Order_Id FOREIGN KEY (OrderId) REFERENCES [Order](Id),
	CONSTRAINT FK_OrderItem_Sku_Item_Sku FOREIGN KEY (Sku) REFERENCES [Item](Sku)
)

GO

CREATE PROCEDURE [dbo].[OrderItem_RemoveByOrderId]
	@orderId INT
AS
BEGIN
	DELETE FROM [dbo].[OrderItem]
	WHERE [OrderId] = @orderId
END

GO

CREATE PROCEDURE [dbo].[OrderItem_Insert]
	@orderId INT,
	@sku INT,
	@amount INT
AS
BEGIN
	INSERT INTO [dbo].[OrderItem] ([OrderId], [Sku], [Amount])
	VALUES (@orderId, @sku, @amount)
END

GO

CREATE PROCEDURE [dbo].[OrderItem_FindByOrderId]
	@orderId INT
AS
BEGIN
	SELECT oi.[Id], oi.[Sku], i.[Name], i.[ImageUrl], i.[Available], oi.[Amount], oi.[ActualAmount], i.[Price], i.[WarehousePlace]
	FROM [dbo].[OrderItem] AS oi
	LEFT JOIN [dbo].[Item] AS i ON oi.[Sku] = i.[Sku]
	where [OrderId] = @orderId
END

GO

CREATE PROCEDURE [dbo].[Order_Upsert]
    @id INT = NULL,
    @customerId INT,
    @status INT,
    @discount INT
AS
BEGIN
	IF(@id IS NOT NULL)
	BEGIN
		-- update order
		UPDATE [dbo].[Order]
		SET [Status] = @status, [Discount] = @discount,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Id] = @id

		SELECT @id AS [Id]
	END
	ELSE
	BEGIN
		-- update customer
		DECLARE @InsertedOrder TABLE ([Id] INT)

		INSERT INTO [dbo].[Order] ([CustomerId], [Status], [Discount])
		OUTPUT INSERTED.[Id] INTO @InsertedOrder
		VALUES (@customerId, @status, @discount)

		SELECT [Id] FROM @InsertedOrder 
	END	
END

GO

CREATE PROCEDURE [dbo].[Order_FindById]
	@id INT
AS
BEGIN
	SELECT o.[Id], [CustomerId], [Name] AS [CustomerName], o.[Status], [Discount]
	FROM [dbo].[Order] AS o
	LEFT JOIN [dbo].[Customer] AS c ON o.[CustomerId] = c.[Id]
	where o.[Id] = @id
END

GO

CREATE PROCEDURE [dbo].[Order_FindByIdOrDateOrStatus]
	@id INT = NULL,
	@date DateTime = NULL,
	@status INT = NULL
AS
BEGIN
	DECLARE @OrdersTotalPrice TABLE ([OrderId] INT, [TotalPrice] INT)

	INSERT INTO @OrdersTotalPrice
	SELECT o.[Id] AS [OrderId], SUM ([Price] * [Amount]) AS [TotalPrice]
	FROM [dbo].[OrderItem] AS oi
	LEFT JOIN [dbo].[Item] AS i ON oi.[Sku] = i.[Sku]
	LEFT JOIN [dbo].[Order] AS o ON o.[Id] = oi.[OrderId]
	WHERE o.[Id] = @id
	OR CONVERT(date, o.[DateCreated]) = CONVERT(date, @date)
	OR [Status] = @status
	GROUP BY o.[Id]


	SELECT [Id], [DateCreated], [LastUpdated] AS [ShipmentDate], [Status], [TotalPrice]
	FROM [dbo].[Order] AS o
	LEFT JOIN @OrdersTotalPrice AS otp ON o.[Id] = [OrderId]
	WHERE [Id] = @id
	OR CONVERT(date, [DateCreated]) = CONVERT(date, @date)
	OR [Status] = @status
END

GO

CREATE PROCEDURE [dbo].[Order_FindByCustomerId]
	@customerId INT
AS
BEGIN
	DECLARE @OrdersTotalPrice TABLE ([OrderId] INT, [TotalPrice] INT)

	INSERT INTO @OrdersTotalPrice
	SELECT o.[Id] AS [OrderId], SUM ([Price] * [Amount]) AS [TotalPrice]
	FROM [dbo].[OrderItem] AS oi
	LEFT JOIN [dbo].[Item] AS i ON oi.[Sku] = i.[Sku]
	LEFT JOIN [dbo].[Order] AS o ON o.[Id] = oi.[OrderId]
	WHERE o.[CustomerId] = @customerId
	GROUP BY o.[Id]

	SELECT o.[Id], [DateCreated], [LastUpdated] AS [ShipmentDate], [Status], [TotalPrice]
	FROM [dbo].[Order] AS o
	LEFT JOIN @OrdersTotalPrice AS otp ON o.[Id] = [OrderId]
	WHERE [CustomerId] = @customerId	
END

GO

CREATE PROCEDURE [dbo].[Order_UpdateStatus]
    @id INT,
    @status INT
AS
BEGIN
	UPDATE [dbo].[Order]
	SET [Status] = @status,
		[LastUpdated] = CURRENT_TIMESTAMP
	WHERE [Id] = @id
END

GO

CREATE PROCEDURE [dbo].[OrderItem_UpdateActualAmount]
    @id INT,
    @actualAmount INT
AS
BEGIN
	UPDATE [dbo].[OrderItem]
	SET [ActualAmount] = @actualAmount,
		[LastUpdated] = CURRENT_TIMESTAMP
	WHERE [Id] = @id
END