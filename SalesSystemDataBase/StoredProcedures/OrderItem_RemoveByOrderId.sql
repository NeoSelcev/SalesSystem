CREATE PROCEDURE [dbo].[OrderItem_RemoveByOrderId]
	@orderId INT
AS
BEGIN
	DELETE FROM [dbo].[OrderItem]
	WHERE [OrderId] = @orderId
END