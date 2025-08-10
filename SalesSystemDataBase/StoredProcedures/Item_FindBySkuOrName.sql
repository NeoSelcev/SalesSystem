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