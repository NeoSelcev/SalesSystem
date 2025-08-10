CREATE PROCEDURE [dbo].[Customer_FindByIdOrName]
	@id INT = NULL,
	@name NVARCHAR(100) = NULL
AS
BEGIN
	SELECT [Id], [Name], [Status]
	FROM [dbo].[Customer]
	WHERE [Id] = @id
	OR [Name] LIKE '%' + @name + '%'
END