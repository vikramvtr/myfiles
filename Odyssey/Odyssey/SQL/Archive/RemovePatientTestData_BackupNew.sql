Declare @PersonDetId uniqueidentifier
select @PersonDetId = PersonDetailId from [dbo].[PersonDetail] where (Surname LIKE '%Auto%') OR (Forename LIKE '%Test%');
BEGIN TRAN

ALTER TABLE [dbo].[PersonGP] NOCHECK CONSTRAINT [FK_PersonGP_GP]
ALTER TABLE [dbo].[PersonGP] NOCHECK CONSTRAINT [FK_PersonGP_Person]
ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Ethnicity]
ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Gender]
ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Person]
ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_ContactInfo]
ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_ContactType]
ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_Person]
ALTER TABLE [dbo].[PersonAddress] NOCHECK CONSTRAINT [FK_PersonAddress_Address]
ALTER TABLE [dbo].[PersonAddress] NOCHECK CONSTRAINT [FK_PersonAddress_Person]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Ethnicity]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_GPStatus]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Prefix]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Suffix]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Title]
ALTER TABLE [dbo].[Address] NOCHECK CONSTRAINT [FK_Address_AddressType]


DECLARE @PersonId int
SELECT @PersonId = PersonId FROM [dbo].[PersonDetail] WHERE [PersonDetailId]=@PersonDetId
DELETE FROM [dbo].[PersonDetail] WHERE [PersonDetailId]=@PersonDetId

DELETE FROM [dbo].[PersonSession] WHERE PersonId = @PersonId

DELETE FROM [dbo].[PersonGP] WHERE PersonId = @PersonId


DECLARE @ContactId int
SELECT @ContactId = ContactId FROM [dbo].[PersonContact] WHERE PersonId = @PersonId
DELETE FROM [dbo].[PersonContact] WHERE PersonId = @PersonId

DECLARE @AddressId int
SELECT @AddressId = AddressId FROM [dbo].[PersonAddress] WHERE PersonId = @PersonId
DELETE FROM [dbo].[PersonAddress] WHERE PersonId = @PersonId

DELETE FROM [dbo].[Person] WHERE Id = @PersonId

DELETE FROM [dbo].[Address] WHERE Id = @AddressId

DELETE FROM [dbo].[ContactInfo] WHERE Id = @ContactId

ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_AddressType]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Ethnicity]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_GPStatus]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Prefix]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Suffix]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Title]
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Address]
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Person]
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_ContactInfo]
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_ContactType]
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_Person]
ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Ethnicity]
ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Gender]
ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Person]
ALTER TABLE [dbo].[PersonGP] CHECK CONSTRAINT [FK_PersonGP_GP]
ALTER TABLE [dbo].[PersonGP] CHECK CONSTRAINT [FK_PersonGP_Person]
COMMIT