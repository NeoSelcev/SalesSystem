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