CREATE PROCEDURE [dbo].[OrderItem_FindByOrderId]
	@orderId INT
AS
BEGIN
	SELECT oi.[Id], oi.[Sku], i.[Name], i.[ImageUrl], i.[Available], oi.[Amount], oi.[ActualAmount], i.[Price], i.[WarehousePlace]
	FROM [dbo].[OrderItem] AS oi
	LEFT JOIN [dbo].[Item] AS i ON oi.[Sku] = i.[Sku]
	where [OrderId] = @orderId
END