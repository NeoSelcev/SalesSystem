CREATE PROCEDURE [dbo].[Customer_Upsert]
	@id INT = NULL,
	@name NVARCHAR(100),
	@dealerId NVARCHAR(100),
	@status INT = NULL,

	@cityCode INT,
	@street NVARCHAR(100),
	@zip NCHAR(10),

	@contact1Id INT = NULL,
	@contact1FirstName NVARCHAR(50),
	@contact1LastName NVARCHAR(50),
	@contact1Job NVARCHAR(100),
	@contact1OfficePhone VARCHAR(20),
	@contact1CellPhone VARCHAR(20),
	@contact1Email NVARCHAR(100),

	@contact2Id INT = NULL,
	@contact2FirstName NVARCHAR(50),
	@contact2LastName NVARCHAR(50),
	@contact2Job NVARCHAR(100),
	@contact2OfficePhone VARCHAR(20),
	@contact2CellPhone VARCHAR(20),
	@contact2Email NVARCHAR(100),

	@bank NVARCHAR(30),
	@branch VARCHAR(5),
	@account VARCHAR(10),

	@credit NCHAR(20)
AS
BEGIN
	IF(@id IS NOT NULL)
	BEGIN
		-- update contact 1
		UPDATE [dbo].[Contact]
		SET [FirstName] = @contact1FirstName, [LastName] = @contact1LastName, [Job] = @contact1Job, 
			[OfficePhone] = @contact1OfficePhone, [CellPhone] = @contact1CellPhone, [Email] = @contact1Email,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Id] = @contact1Id

		IF(@contact2Id IS NOT NULL) -- update contact 2
		BEGIN			
			UPDATE [dbo].[Contact]
			SET [FirstName] = @contact2FirstName, [LastName] = @contact2LastName, [Job] = @contact2Job, 
				[OfficePhone] = @contact2OfficePhone, [CellPhone] = @contact2CellPhone, [Email] = @contact2Email,
				[LastUpdated] = CURRENT_TIMESTAMP
			WHERE [Id] = @contact2Id
		END
		ELSE
		BEGIN
			IF(@contact2FirstName IS NOT NULL) -- insert contact 2
			BEGIN
				DECLARE @InsertedWithinUpdateContact2 TABLE ([Id] INT)

				INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
				OUTPUT INSERTED.[Id] INTO @InsertedWithinUpdateContact2
				VALUES (@contact2FirstName, @contact2LastName, @contact2Job, @contact2OfficePhone, @contact2CellPhone, @contact2Email)
				
				SELECT @contact2Id = [Id] FROM @InsertedWithinUpdateContact2
			END
		END

		-- update customer
		UPDATE [dbo].[Customer]
		SET [Name] = @name, [DealerId] = @dealerId, [Status] = @status, [CityCode] = @cityCode, [Street] = @street, [Zip] = @zip, 
			[Contact1] = @contact1Id, [Contact2] = @contact2Id,  [Bank] = @bank, [Branch] = @branch, [Account] = @account, [Credit] = @credit,
			[LastUpdated] = CURRENT_TIMESTAMP
		WHERE [Id] = @id

		SELECT @id AS [Id]
	END
	ELSE
	BEGIN
		-- insert contact 2
		IF(@contact2FirstName IS NOT NULL AND @contact2FirstName != '' AND @contact2FirstName != N'') 
		BEGIN
			DECLARE @InsertedContact2 TABLE ([Id] INT)

			INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
			OUTPUT INSERTED.[Id] INTO @InsertedContact2
			VALUES (@contact2FirstName, @contact2LastName, @contact2Job, @contact2OfficePhone, @contact2CellPhone, @contact2Email)
				
			SELECT @contact2Id = [Id] FROM @InsertedContact2
		END

		-- insert contact 1
		DECLARE @InsertedContact1 TABLE ([Id] INT)

		INSERT INTO [dbo].[Contact] ([FirstName], [LastName], [Job], [OfficePhone], [CellPhone], [Email])
		OUTPUT INSERTED.[Id] INTO @InsertedContact1
		VALUES (@contact1FirstName, @contact1LastName, @contact1Job, @contact1OfficePhone, @contact1CellPhone, @contact1Email)
				
		SELECT @contact1Id = [Id] FROM @InsertedContact1

		-- update customer
		DECLARE @InsertedCustomer TABLE ([Id] INT)

		INSERT INTO [dbo].[Customer] ([Name], [DealerId], [CityCode], [Street], [Zip], [Contact1], [Contact2], [Bank], [Branch], [Account], [Credit])
		OUTPUT INSERTED.[Id] INTO @InsertedCustomer
		VALUES (@name, @dealerId, @cityCode, @street, @zip, @contact1Id, @contact2Id, @bank, @branch, @account, @credit)

		SELECT [Id] FROM @InsertedCustomer 
	END	
END