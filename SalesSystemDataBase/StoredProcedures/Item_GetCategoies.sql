CREATE PROCEDURE [dbo].[Item_GetCategoies]
AS
BEGIN
	SELECT [Id], [Name], [Description]
	FROM [dbo].[Category]
END