CREATE TABLE [dbo].[Role]
(
	[Id] INT UNIQUE,
	[RoleName] NVARCHAR(100) NOT NULL UNIQUE,
	[Description] NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_Role_Id_RoleName PRIMARY KEY (Id, RoleName)
)
