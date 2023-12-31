/* ------------------------------------------------------------

   DESCRIPTION:  Synchronization Script for Object(s) 
     Tables:
        [dbo].[Address],
        [dbo].[ContactInfo],
        [dbo].[Person],
        [dbo].[PersonAddress],
        [dbo].[PersonContact],
        [dbo].[PersonDetail],
        [dbo].[PersonGP]


     Add Patient test data to Odyssey v3.10

   DATE:	20/04/2017 
   
   SET DOMAIN ID BELOW
   SET target database if required

   ------------------------------------------------------------ */

SET NOEXEC OFF
SET ANSI_WARNINGS ON
SET XACT_ABORT ON
SET IMPLICIT_TRANSACTIONS OFF
SET ARITHABORT ON
SET NOCOUNT ON
SET QUOTED_IDENTIFIER ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
GO

--USE [OdysseyStandalone3.10ENGB]
--GO
DECLARE @DomainId uniqueidentifier
SET @DomainId = '26eb400a-516a-4215-9aa1-961478ac35ef' 
--SET @DomainId =(select id from dbo.Domain)


BEGIN TRAN

-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[PersonGP]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[PersonGP]'

ALTER TABLE [dbo].[PersonGP] NOCHECK CONSTRAINT [FK_PersonGP_GP]
ALTER TABLE [dbo].[PersonGP] NOCHECK CONSTRAINT [FK_PersonGP_Person]
-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[PersonDetail]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[PersonDetail]'

ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Ethnicity]
ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Gender]
ALTER TABLE [dbo].[PersonDetail] NOCHECK CONSTRAINT [FK_PersonDetail_Person]
-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[PersonContact]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[PersonContact]'

ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_ContactInfo]
ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_ContactType]
ALTER TABLE [dbo].[PersonContact] NOCHECK CONSTRAINT [FK_PersonContact_Person]
-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[PersonAddress]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[PersonAddress]'

ALTER TABLE [dbo].[PersonAddress] NOCHECK CONSTRAINT [FK_PersonAddress_Address]
ALTER TABLE [dbo].[PersonAddress] NOCHECK CONSTRAINT [FK_PersonAddress_Person]
-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[Person]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[Person]'

ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Ethnicity]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_GPStatus]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Prefix]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Suffix]
ALTER TABLE [dbo].[Person] NOCHECK CONSTRAINT [FK_Person_Title]
-- =======================================================
-- Foreign Key Constraint Nochecks's for Table: [dbo].[Address]
-- =======================================================
Print 'Foreign Key Constraint Nochecks''s for Table: [dbo].[Address]'

ALTER TABLE [dbo].[Address] NOCHECK CONSTRAINT [FK_Address_AddressType]

-- =======================================================
-- Synchronization Script for Table: [dbo].[ContactInfo]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[ContactInfo]'

DECLARE @ContactId int
INSERT INTO [dbo].[ContactInfo] ([Contact]) VALUES (N'123456789')
SET @ContactId = @@IDENTITY

-- =======================================================
-- Synchronization Script for Table: [dbo].[Address]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[Address]'

DECLARE @AddressId int
INSERT INTO [dbo].[Address] ([Name], [Address1], [Address2], [Address3], [Town], [County], [Postcode], [Country], [AddressTypeId]) 
VALUES (NULL, N'123 Narrow St', NULL, NULL, N'Beaminster', N'Dorset', N'DT83BA', NULL, 1)
SET @AddressId = @@IDENTITY

-- =======================================================
-- Synchronization Script for Table: [dbo].[Person]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[Person]'

DECLARE @PersonId int
INSERT INTO [dbo].[Person] ([SuffixId], [PrefixId], [TitleId], [Identifier], [Locked], [GPStatusId], [DomainId], [InstitutionName], [ThirdPartyIdentifier], [EthnicityId]) 
VALUES (NULL, NULL, NULL, NULL, 0, 2, @DomainId, NULL, N'', NULL)
SET @PersonId = @@IDENTITY

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonAddress]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonAddress]'

INSERT INTO [dbo].[PersonAddress] ([PersonId], [AddressId], [Description], [IsDefault], [IsPrevious], [From], [To]) 
VALUES (@PersonId, @AddressId, N'', 1, 0, GETDATE(), NULL)

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonContact]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonContact]'

INSERT INTO [dbo].[PersonContact] ([PersonId], [ContactId], [Description], [Notes], [IsPrevious], [ContactType], [From], [To]) 
VALUES (@PersonId, @ContactId, NULL, NULL, 0, 1, GETDATE(), NULL)

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonDetail]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonDetail]'

INSERT INTO [dbo].[PersonDetail] ([PersonDetailId], [PersonId], [From], [To], [Surname], [Forename], [Middlename], [DoB], [ApproxAge], [AgeMeasuredInWeeks], [IsAnonymous], [GenderId], [Identifier], [EthnicityId]) 
VALUES ('30f79654-2b2f-420d-9c1d-37b62b1fdcc6', @PersonId, GETDATE(), NULL, N'Automation', N'Test', NULL, NULL, 2295, 0, 0, 1, N'', NULL)

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonGP]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonGP]'

INSERT INTO [dbo].[PersonGP] ([Id], [PersonId], [GPId], [GPStatusId], [ValidFrom], [ValidTo]) 
VALUES ('e90f3cfc-8ca4-4422-a0e8-c3999802a932', @PersonId, NULL, 2, NULL, NULL)

-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[Address]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[Address]'

ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_AddressType]
-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[Person]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[Person]'

ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Ethnicity]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_GPStatus]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Prefix]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Suffix]
ALTER TABLE [dbo].[Person] CHECK CONSTRAINT [FK_Person_Title]
-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[PersonAddress]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[PersonAddress]'

ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Address]
ALTER TABLE [dbo].[PersonAddress] CHECK CONSTRAINT [FK_PersonAddress_Person]
-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[PersonContact]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[PersonContact]'

ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_ContactInfo]
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_ContactType]
ALTER TABLE [dbo].[PersonContact] CHECK CONSTRAINT [FK_PersonContact_Person]
-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[PersonDetail]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[PersonDetail]'

ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Ethnicity]
ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Gender]
ALTER TABLE [dbo].[PersonDetail] CHECK CONSTRAINT [FK_PersonDetail_Person]
-- =======================================================
-- Foreign Key Constraint Check's for Table: [dbo].[PersonGP]
-- =======================================================
Print 'Foreign Key Constraint Check''s for Table: [dbo].[PersonGP]'

ALTER TABLE [dbo].[PersonGP] CHECK CONSTRAINT [FK_PersonGP_GP]
ALTER TABLE [dbo].[PersonGP] CHECK CONSTRAINT [FK_PersonGP_Person]
COMMIT

SET NOEXEC OFF
GO
