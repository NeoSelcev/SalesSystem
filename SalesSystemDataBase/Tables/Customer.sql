CREATE TABLE [dbo].[Customer]
(
	[Id] INT IDENTITY (1, 1) UNIQUE,
	[Name] NVARCHAR(100) NOT NULL,
	[DealerId] INT NOT NULL,
	[Status] INT NOT NULL DEFAULT (0),

	[CityCode] INT NOT NULL,
	[Street] NVARCHAR(100) NOT NULL,
	[Zip] NCHAR(10) NOT NULL,
	[Contact1] INT NOT NULL,
	[Contact2] INT NULL,

	[Bank] NVARCHAR(30) NOT NULL,
	[Branch] VARCHAR(5) NOT NULL,
	[Account] VARCHAR(10) NOT NULL,

	[Credit] INT NOT NULL,
	
	[DateCreated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	[LastUpdated] DATETIME NOT NULL DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT PK_Customer_Name PRIMARY KEY (Name),
	CONSTRAINT FK_Customer_CityCode_City_Code FOREIGN KEY (CityCode) REFERENCES [City](Code),
	CONSTRAINT FK_Customer_CityCode_Contact_Contact1 FOREIGN KEY (Contact1) REFERENCES [Contact](Id),
	CONSTRAINT FK_Customer_CityCode_Contact_Contact2 FOREIGN KEY (Contact2) REFERENCES [Contact](Id)
)
