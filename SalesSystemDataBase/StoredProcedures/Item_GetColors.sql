CREATE PROCEDURE [dbo].[Item_GetColors]
AS
BEGIN
	SELECT [Id], [Name]
	FROM [dbo].[Color]
END