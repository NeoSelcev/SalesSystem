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