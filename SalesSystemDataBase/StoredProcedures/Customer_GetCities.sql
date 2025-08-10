CREATE PROCEDURE [dbo].[Customer_GetCities]
AS
BEGIN
	SELECT [Name], [Code]
	FROM [dbo].[City]
END