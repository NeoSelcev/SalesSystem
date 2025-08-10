CREATE PROCEDURE [dbo].[OrderItem_Insert]
	@orderId INT,
	@sku INT,
	@amount INT
AS
BEGIN
	INSERT INTO [dbo].[OrderItem] ([OrderId], [Sku], [Amount])
	VALUES (@orderId, @sku, @amount)
END