--USE [OdysseyStandalone3.10ENGB]

BEGIN TRAN
BEGIN TRY 

/* Disable Constraints whilst importing */
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"


DELETE FROM GP
DBCC CHECKIDENT(GP, RESEED, 0)
DELETE FROM Practice
DBCC CHECKIDENT(Practice, RESEED, 0)


-- Add Practices 
INSERT INTO Practice (Name, Line1, Line2, Line3, Line4, Postcode, Telephone, PracticCode, [Visible])
VALUES ('THE DENSHAM SURGERY',	'THE HEALTH CENTRE',	'LAWSON STREET',	'STOCKTON',	'CLEVELAND',	'TS18 1HU', '01642 672351',	'A81001', 1)	   
INSERT INTO Practice (Name, Line1, Line2, Line3, Line4, Postcode, Telephone, PracticCode, [Visible])
VALUES ('WOODLANDS ROAD SURGERY',	'6 WOODLANDS ROAD',	NULL, 'MIDDLESBROUGH',	'CLEVELAND',	'TS1 3BE', 	'01642 247982', 'A81004',	1)


-- Add GPs 
DECLARE @PracticeId int
SELECT @PracticeId = Id FROM dbo.Practice WHERE PracticCode = 'A81001'
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('OLIVER G',	@PracticeId, 'A81001', 	1)
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('WILLIAMS SR', @PracticeId, 'A81001', 	1)

SELECT @PracticeId = Id FROM dbo.Practice WHERE PracticCode = 'A81004'
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('HENDRIE P', @PracticeId, 'A81004', 	1)
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('ALAGARSAMY M',	@PracticeId, 'A81004', 	1)
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('MURPHY RS', @PracticeId, 'A81004', 	1)
INSERT INTO GP (Surname, PracticeId, PracticeCode, [visible])
VALUES ('SCOTT WG',	@PracticeId, 'A81004', 	1)



/* Enable Constraints */
exec sp_msforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"


COMMIT TRAN
END TRY
BEGIN CATCH
	SELECT
        ERROR_MESSAGE(),
		ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        ERROR_LINE(),
        ERROR_PROCEDURE()
    ROLLBACK TRAN
END CATCH


