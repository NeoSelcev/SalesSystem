CREATE PROCEDURE [dbo].[Order_FindById]
	@id INT
AS
BEGIN
	SELECT o.[Id], [CustomerId], [Name] AS [CustomerName], o.[Status], [Discount]
	FROM [dbo].[Order] AS o
	LEFT JOIN [dbo].[Customer] AS c ON o.[CustomerId] = c.[Id]
	where o.[Id] = @id
END