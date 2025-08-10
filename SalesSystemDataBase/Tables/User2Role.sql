CREATE TABLE [dbo].[User2Role]
(
	[UserId] INT NOT NULL,
	[RoleId] INT NOT NULL
	CONSTRAINT PK_User2Role_UserId_RoleId PRIMARY KEY (UserId, RoleId),
	CONSTRAINT FK_User2Role_UserId_User_Id FOREIGN KEY (UserId) REFERENCES [User](Id),
	CONSTRAINT FK_User2Role_RoleId_Role_Id FOREIGN KEY (RoleId) REFERENCES [Role](Id)
)
