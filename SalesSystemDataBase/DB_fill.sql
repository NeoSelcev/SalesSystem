USE [SalesSystemDataBase];

DECLARE @InsertedDealer TABLE ([Id] INT)
INSERT INTO [User] ([Email], [FirstName], [LastName], [CellPhone], [Phone], [Password])
OUTPUT INSERTED.[Id] INTO @InsertedDealer
VALUES ('dealer@gmail.com', N'משה', N'דילר', '0545054054', NULL, 'd123456')

DECLARE @InsertedManager TABLE ([Id] INT)
INSERT INTO [User] ([Email], [FirstName], [LastName], [CellPhone], [Phone], [Password])
OUTPUT INSERTED.[Id] INTO @InsertedManager
VALUES ('manager@gmail.com', N'אבי', N'מנגר', '0545054054', NULL, 'm123456')

INSERT INTO [Role] ([Id], [RoleName], [Description])
VALUES (0, 'dealer', N'סוכן')

INSERT INTO [Role] ([Id], [RoleName], [Description])
VALUES (1, 'manager', N'מנהל מחסן')

INSERT INTO [User2Role] ([UserId], [RoleId])
VALUES ((SELECT TOP 1 [Id] FROM @InsertedDealer), 0)

insert into [User2Role] ([UserId], [RoleId])
VALUES ((SELECT TOP 1 [Id] FROM @InsertedManager), 1)

INSERT INTO [dbo].[City] ([Name], [Code]) VALUES (N'חיפה', 100)
INSERT INTO [dbo].[City] ([Name], [Code]) VALUES (N'תל אביב', 200)
INSERT INTO [dbo].[City] ([Name], [Code]) VALUES (N'באר שבע', 300)

INSERT INTO [dbo].[Color] ([Name]) VALUES (N'לבן')
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'ניקל')
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'זהב')
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'שחור')
INSERT INTO [dbo].[Color] ([Name]) VALUES (N'אפור')

INSERT INTO [dbo].[Category] ([Name], [Description]) VALUES (N'פרזול', N'תיאור קטגוריית פרזול')
INSERT INTO [dbo].[Category] ([Name], [Description]) VALUES (N'מטחות', N'תיאור קטגוריית מטחות ')
INSERT INTO [dbo].[Category] ([Name], [Description]) VALUES (N'קנטים', N'תיאור קטגורייתקנטים ')
