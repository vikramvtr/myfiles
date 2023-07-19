-- Remove users and passwords
DECLARE @surname nvarchar(100)
DECLARE @forename nvarchar(100)

SET @forename = 'Automation'
SET @surname = 'Test'


DECLARE @pwdId uniqueidentifier
SELECT @pwdId = PasswordId  FROM [user] WHERE [Forename] = @forename and [Surname] = @surname

DELETE FROM [UserLinkClaim] WHERE [UserID] in (SELECT [Id] FROM [User] WHERE [Forename] = @forename and [Surname] = @surname)
DELETE FROM [UserLinkClinicalContentType] WHERE [UserID] in (SELECT [Id] FROM [User] WHERE [Forename] = @forename and [Surname] = @surname)
DELETE FROM [UserLocationCulture] WHERE [UserID] in (SELECT [Id] FROM [User] WHERE [Forename] = @forename and [Surname] = @surname)

DELETE FROM [user] WHERE [Forename] = @forename and [Surname] = @surname

DELETE FROM [Password] WHERE [Id] = @pwdId
