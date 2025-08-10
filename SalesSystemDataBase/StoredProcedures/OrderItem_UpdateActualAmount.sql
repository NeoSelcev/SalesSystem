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