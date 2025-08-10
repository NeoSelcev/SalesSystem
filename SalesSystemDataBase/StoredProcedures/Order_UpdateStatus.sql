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