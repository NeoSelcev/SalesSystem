CREATE PROCEDURE [dbo].[User_Authenticate]
	@email NVARCHAR(100),
	@password NVARCHAR(20)
AS
BEGIN
	SELECT TOP 1 u.[Id], [Email], [FirstName], [LastName], [CellPhone], [Phone], [LoginDate], r.[Id] AS [RoleId], [RoleName], [Description] AS [RoleDescription]
	FROM [dbo].[User] AS u
	LEFT JOIN [dbo].[UserLogin] AS ul ON u.[Id] = ul.[UserId]
	LEFT JOIN [dbo].[User2Role] AS u2r ON u.[Id] = u2r.[UserId]
	LEFT JOIN [dbo].[Role] AS r ON u2r.[RoleId] = r.[Id]
	WHERE [Email] = @email
	AND [Password] = @password
	ORDER BY [LoginDate] DESC

	IF (@@ROWCOUNT > 0)
	BEGIN
		INSERT INTO [dbo].[UserLogin] (UserId)
		SELECT [Id] FROM [dbo].[User] WHERE [Email] = @email
	END
END