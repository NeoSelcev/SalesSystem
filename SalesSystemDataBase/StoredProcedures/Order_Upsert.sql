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