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