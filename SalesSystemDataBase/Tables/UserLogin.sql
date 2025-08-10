CREATE TABLE [dbo].[UserLogin]
(
	[UserId] INT NOT NULL,
	[LoginDate] DateTime DEFAULT (CURRENT_TIMESTAMP),
	CONSTRAINT FK_UserLogin_UserId_User_Id FOREIGN KEY (UserId) REFERENCES [User](Id)
)
