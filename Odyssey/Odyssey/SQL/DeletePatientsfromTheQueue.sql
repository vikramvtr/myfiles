DECLARE @DomainId uniqueidentifier
DECLARE @ClosedStatus uniqueidentifier

SET @DomainId = (select id from dbo.Domain where Description = 'EnglishStandaloneENAU')
SET @ClosedStatus = (SELECT id FROM Status where Description = 'Closed')

(SELECT * FROM Session 
INNER JOIN SessionStatus on Session.Id = SessionStatus.SessionId 
WHERE Session.DomainId = @DomainId 
AND StatusId in (SELECT id FROM Status where Description IN ('Open', 'Interrupted', 'Suspended', 'Waiting', 'Reception','Paused')))

UPDATE SessionStatus SET StatusId = @ClosedStatus WHERE SessionStatus.SessionId in 
(SELECT id FROM Session 
INNER JOIN SessionStatus on Session.Id = SessionStatus.SessionId 
WHERE Session.DomainId = @DomainId 
AND StatusId in (SELECT id FROM Status where Description IN ('Open', 'Interrupted', 'Suspended', 'Waiting', 'Reception','Paused')))