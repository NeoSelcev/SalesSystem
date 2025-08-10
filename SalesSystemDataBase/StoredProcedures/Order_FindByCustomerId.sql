CREATE PROCEDURE [dbo].[Order_FindByCustomerId]
	@customerId INT
AS
BEGIN
	DECLARE @OrdersTotalPrice TABLE ([OrderId] INT, [TotalPrice] INT)

	INSERT INTO @OrdersTotalPrice
	SELECT o.[Id] AS [OrderId], SUM ([Price] * [Amount]) AS [TotalPrice]
	FROM [dbo].[OrderItem] AS oi
	LEFT JOIN [dbo].[Item] AS i ON oi.[Sku] = i.[Sku]
	LEFT JOIN [dbo].[Order] AS o ON o.[Id] = oi.[OrderId]
	WHERE o.[CustomerId] = @customerId
	GROUP BY o.[Id]

	SELECT o.[Id], [DateCreated], [LastUpdated] AS [ShipmentDate], [Status], [TotalPrice]
	FROM [dbo].[Order] AS o
	LEFT JOIN @OrdersTotalPrice AS otp ON o.[Id] = [OrderId]
	WHERE [CustomerId] = @customerId	
END