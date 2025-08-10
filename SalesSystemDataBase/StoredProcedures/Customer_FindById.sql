CREATE PROCEDURE [dbo].[Customer_FindById]
	@id INT
AS
BEGIN
	SELECT TOP 1 cu.[Id], cu.[Name], [DealerId], u.[FirstName] + ' ' + u.[LastName] AS [DealerName], [Status], [CityCode], c.[Name] AS [CityName], [Street], [Zip],
	co1.[Id] AS [Contact1Id], co1.[FirstName] AS [Contact1FirstName], co1.[LastName] AS [Contact1LastName], co1.[Job] AS [Contact1Job], co1.[OfficePhone] AS [Contact1OfficePhone], co1.[CellPhone] AS [Contact1CellPhone], co1.[Email] AS [Contact1Email],
	co2.[Id] AS [Contact2Id], co2.[FirstName] AS [Contact2FirstName], co2.[LastName] AS [Contact2LastName], co2.[Job] AS [Contact2Job], co2.[OfficePhone] AS [Contact2OfficePhone], co2.[CellPhone] AS [Contact2CellPhone], co2.[Email] AS [Contact2Email],
	[Bank], [Branch], [Account], [Credit], [Credit] as [CreditLeft]
	FROM [dbo].[Customer] cu
	LEFT JOIN [dbo].[City] AS c ON cu.[CityCode] = c.[Code]
	LEFT JOIN [dbo].[Contact] AS co1 ON cu.[Contact1] = co1.[Id]
	LEFT JOIN [dbo].[Contact] AS co2 ON cu.[Contact2] = co2.[Id]
	LEFT JOIN [dbo].[User] AS u ON u.[Id] = [DealerId]
	WHERE cu.[Id] = @id
END