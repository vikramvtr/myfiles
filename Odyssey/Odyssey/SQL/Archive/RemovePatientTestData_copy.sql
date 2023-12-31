
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

Declare @PersonDetId uniqueidentifier
select @PersonDetId = PersonDetailId from [dbo].[PersonDetail] where Surname = 'Automation' and Forename='Test';

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
-- Synchronization Script for Table: [dbo].[PersonDetail]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonDetail]'

DECLARE @PersonId int
SELECT @PersonId = PersonId FROM [dbo].[PersonDetail] WHERE [PersonDetailId]= @PersonDetId
DELETE FROM [dbo].[PersonDetail] WHERE [PersonDetailId]= @PersonDetId

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonGP]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonGP]'

DELETE FROM [dbo].[PersonGP] WHERE PersonId = @PersonId

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonContact]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonContact]'

DECLARE @ContactId int
SELECT @ContactId = ContactId FROM [dbo].[PersonContact] WHERE PersonId = @PersonId
DELETE FROM [dbo].[PersonContact] WHERE PersonId = @PersonId

-- =======================================================
-- Synchronization Script for Table: [dbo].[PersonAddress]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[PersonAddress]'

DECLARE @AddressId int
SELECT @AddressId = AddressId FROM [dbo].[PersonAddress] WHERE PersonId = @PersonId
DELETE FROM [dbo].[PersonAddress] WHERE PersonId = @PersonId

-- =======================================================
-- Synchronization Script for Table: [dbo].[Person]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[Person]'

DELETE FROM [dbo].[Person] WHERE Id = @PersonId

-- =======================================================
-- Synchronization Script for Table: [dbo].[Address]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[Address]'

DELETE FROM [dbo].[Address] WHERE Id = @AddressId

-- =======================================================
-- Synchronization Script for Table: [dbo].[ContactInfo]
-- =======================================================
Print 'Synchronization Script for Table: [dbo].[ContactInfo]'

DELETE FROM [dbo].[ContactInfo] WHERE Id = @ContactId

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
