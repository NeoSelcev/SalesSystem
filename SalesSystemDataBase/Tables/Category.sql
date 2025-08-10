CREATE TABLE [dbo].[Category]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Name] NVARCHAR(30) NOT NULL,
	[Description] NVARCHAR(500) NOT NULL,	
	CONSTRAINT PK_Category_Name PRIMARY KEY (Name)
)
