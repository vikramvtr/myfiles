//USEUNIT PageObjects
//USEUNIT CommonFunctions
/*===============================================================================
Description: Function to establish a database connection
Parameters:
	DBName:DB object which is created in page locator	
Return Value: N/A
Note: Connection is DB is done by passing the  DB Obect which is created in pagelocators
===============================================================================*/
function setDBConnection() 
{
     var connectionString;
     dbProvider = "SQLOLEDB";
     var dbserver=Project.Variables.DBServer
     var dbName = Project.Variables.dbName
     var dbUsername = Project.Variables.dbUsername
     var dbPassword = Project.Variables.dbPassword
     
     connectionString = "Provider=" + dbProvider + ";Server=" + dbserver + ";Database=" + dbName + ";Uid=" + dbUsername + ";Pwd=" + dbPassword + ";";

    cmd = ADO.CreateADOCommand();
    cmd.ConnectionString = connectionString;
}

/*===========================================================================================
Description: Function to execute th SQL query file
Parameters: 
    fileNameWithLoc - Location of the file with the name of the file
Return Value: 
Author: Sachin
Date: 31/12/2015
============================================================================================*/
function ExecSQLQueryFile(FileNameWithPath)
{
  var fileNameWithLoc = FileNameWithPath 
     try
     { 
         setDBConnection("Standalone")
         if(fileNameWithLoc=="DeletePatientsfromTheQueue" || fileNameWithLoc=="DeleteGPDetails" || fileNameWithLoc == "Add_GP_DATA_OTA" || fileNameWithLoc == "DeleteUsersFromAdmin" || fileNameWithLoc == "DeleteContactType" || fileNameWithLoc == "DeleteAddressType" || fileNameWithLoc == "DeleteContactTypeForInitialSetup" || fileNameWithLoc == "DeleteAddressTypeForInitialSetup" || fileNameWithLoc == "Delete111Messages" || fileNameWithLoc == "DeleteRelationTypeForInitialSetup")
         {
             var queryString = aqFile.ReadWholeTextFile(Project.Variables.solutionPath+"\\SQL\\"+fileNameWithLoc+".sql",aqFile.ctANSI)
         } 
         else
         { 
             var queryString = aqFile.ReadWholeTextFile(Project.Variables.solutionPath+"\\SQL\\"+fileNameWithLoc+".sql",aqFile.ctUnicode)
         }
         Log.Message(queryString)
         cmd.CommandText = queryString;
         cmd.CommandType = cmdText;
         cmd.Execute();
         
     }
     catch (e)
     {
         Log.Error("Error executing Query file " + aqConvert.VarToStr(fileNameWithLoc) + ": " + e.description)
         return -1   
     }
}
 
/*===============================================================================
Description: This function to execute SQL query 
Parameters: 
            queryString: sql query to execute
Return Value: 
=================================================================================*/
function ExecSQLQuery(queryString)
{
    setDBConnection()
    var rs, rsCnt; cmd
    cmd.CommandText = queryString;
    cmd.CommandType = cmdText;
    rs = cmd.Execute();
}

/*===============================================================================
Description: This function to execute SQL query to return value
Parameters: 
            queryString: sql query to execute
Return Value: 
=================================================================================*/
function ExecSQLQueryToReturnVal(queryString)
{
    setDBConnection()
    var rs, rsCnt; cmd
    var myArray = [0]; //newly added line
    cmd.CommandText = queryString;
    cmd.CommandType = cmdText;
    rs = cmd.Execute();
    rsCnt = 0
    rs.MoveFirst();
    while (!rs.EOF) {
        if (!myArray[rsCnt]) {
            myArray[rsCnt] = {}
        }
        for (col = 0; col < rs.Fields.Count; col++) {
            myArray[rsCnt][col] = rs.Fields(col).Value;
        }
        rsCnt = rsCnt + 1;
        rs.MoveNext();
    }
    return (myArray);  
}

//Functions specific to Test cases

/*===============================================================================
Description: This function to fetch data from DB
Parameters: 
            Item : data to be fetched
Return Value: 
=================================================================================*/
function getDatafromDB(Item)
{
    switch (Item)
    {
        case "DomainDesc":
        var res = ExecSQLQueryToReturnVal("SELECT [Description] FROM [Domain] ")
        Log.Message(res[0][0])
        return res[0][0]
        break;
    }
}
 
/*===============================================================================
Description: This function to delete patient details from DB
Parameters: 
Return Value: 
=================================================================================*/
function DeletePatientsFromTheQueue()
{
    ExecSQLQueryFile("DeletePatientsfromTheQueue")
}

/*===============================================================================
Description: This function to delete person details from DB
Parameters: 
Return Value: 
=================================================================================*/

function DeletePersonDetailFromDB()
{
  ExecSQLQueryFile("RemovePatientTestData")
}

/*===============================================================================
Description: This function to delete GP details
Parameters: 
Return Value: 
=================================================================================*/

function DeleteGPDetailFromDB()
{
  ExecSQLQueryFile("DeleteGPDetails")
}

/*===============================================================================
Description: This function to add patient details to DB
Parameters: 
Return Value: 
=================================================================================*/
function AddGPDetailFromDB()
{
  ExecSQLQueryFile("Add_GP_DATA_OTA")
}

/*===============================================================================
Description: This function to delete users from admin
Parameters: 
Return Value: 
=================================================================================*/
function DeleteUsersFromAdmin()
{
  ExecSQLQueryFile("DeleteUsersFromAdmin")
} 

/*===============================================================================
Description: This function to delete Contact Type added
Parameters: 
Return Value: 
=================================================================================*/
function DeleteContactTypeAddedfromAdmin()
{
  var queryString1 = "Delete from [ContactTypeText] where ContactTypeId = (Select Id from [ContactType] where ContactType='TestAutomation')"
  var queryString2 = "Delete from [PersonContact] where [ContactId] = (Select Id from [ContactType] where ContactType='TestAutomation')"
  var queryString3 = "Delete from [ContactInfo] where Id = (Select Id from [ContactType] where ContactType='TestAutomation')"
  var queryString4 = "Delete from [ContactType] where ContactType='TestAutomation'"

  ExecSQLQuery(queryString1) 
  ExecSQLQuery(queryString2)
  ExecSQLQuery(queryString3) 
  ExecSQLQuery(queryString4)
} 

/*===============================================================================
Description: This function to delete Address Type added
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAddressTypeAddedfromAdmin()
{
  var queryString1 = "Delete from [AddressTypeText] where Type = 'TestAutomation'"
  var queryString2 = "Delete from [AddressType] where Type = 'TestAutomation'"
  ExecSQLQuery(queryString1) 
  ExecSQLQuery(queryString2) 
}

/*===============================================================================
Description: This function to delete Ethnicity 
Parameters: 
Return Value: 
=================================================================================*/
function DeleteEthnicityAddedfromAdmin()
{
  var queryString = "Delete from [Ethnicity] where Description = 'TestAutomation' and DomainId=(Select Id from Domain where Description='"+Project.Variables.Domain+"')"
  ExecSQLQuery(queryString) 
} 

/*===============================================================================
Description: This function to delete Allergies 
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAllegiesAddedfromAdmin()
{
  var queryString1 = "Delete FROM [AllergyText] where Text = 'TestAutomation'"
  ExecSQLQuery(queryString1) 
  
  var queryString2 = "Delete from [PersonLinkAllergy] where AllergyId = (Select Id from [Allergy] where Name = 'TestAutomation')"
  ExecSQLQuery(queryString2) 
  
  var queryString3 = "Delete FROM [Allergy] where Name = 'TestAutomation'"
  ExecSQLQuery(queryString3) 
} 

/*===============================================================================
Description: This function to delete SessionType 
Parameters: 
Return Value: 
=================================================================================*/
function DeleteSessionTypefromAdmin()
{
  var queryString1 = "delete from [SessionTypeText] where SessionTypeId = (select Id FROM SessionType where SessionType = 'TestAutomation')"
  var queryString2 = "delete from [SessionType] where SessionType = 'TestAutomation'"
  ExecSQLQuery(queryString1) 
  ExecSQLQuery(queryString2)
}

/*===============================================================================
Description: This function to delete QuestionSetClosure reason
Parameters: 
Return Value: 
=================================================================================*/
function DeleteQuesSetClosureReasonAddedfromAdmin()
{
  var queryString1 = "Delete FROM [ExclusionReasonText] where Description = 'TestAutomation'"
//  var queryString2 = "delete FROM [ExclusionReason] where Id = (select ExclusionReasonId FROM [ExclusionReasonText] where Description = 'TestAutomation')"
  ExecSQLQuery(queryString1) 
//  ExecSQLQuery(queryString2)
}

/*===============================================================================
Description: This function to delete Close Assessment Reason
Parameters: 
Return Value: 
=================================================================================*/
function DeleteCloseAssessmentReasonAddedfromAdmin()
{
  var queryString1 = "Delete FROM [ClosureReasonText] where Text = 'TestAutomation'"
  var queryString2 = "Delete FROM [ClosureReason] where Description = 'TestAutomation'"
  ExecSQLQuery(queryString1) 
  ExecSQLQuery(queryString2)
}

/*===============================================================================
Description: This function to delete contact types from admin
Parameters: 
Return Value: 
=================================================================================*/
function DeleteContactTypeForInitialSetup()
{
  ExecSQLQueryFile("DeleteContactTypeForInitialSetup")
} 

/*===============================================================================
Description: This function to delete address types from admin
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAddressTypeForInitialSetup()
{
  ExecSQLQueryFile("DeleteAddressTypeForInitialSetup")
} 
/*===============================================================================
Description: This function to change the SessionTimeOutInMinutes value in ConfigSetting table
Parameters: 
            min: number of minutes 1 or 10 or ...
Return Value: 
=================================================================================*/
function setSessionTimeoutInMinutes(min)
{
  var queryString = "Update [dbo].[ConfigSetting] set ConfigValue = '"+min+"' Where ConfigKey = 'SessionTimeoutInMinutes'"
  ExecSQLQuery(queryString) 
}
/*===============================================================================
Description: This function to delete 111 messages from admin
Parameters: 
Return Value: 
=================================================================================*/
function Delete111Messages()
{
  ExecSQLQueryFile("Delete111Messages")
}

/*===============================================================================
Description: This function to delete contact types from admin
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAllContactTypeFromAdmin()
{
  ExecSQLQueryFile("DeleteContactTypeFromAdmin")
} 

/*===============================================================================
Description: This function to delete Contact Type added
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAllAddressTypefromAdmin()
{
  ExecSQLQueryFile("DeleteAddressTypeFromAdmin")
}

/*===============================================================================
Description: This function to get the last entry in session history table ---- Need to be updated
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastEntryFromSessionHistory()
{
  var queryString1 =  "SELECT TOP (1) [Id],[CreatedDate] FROM [Session] Where DomainId=(Select Id from Domain where Description='"+Project.Variables.Domain+"') order by [CreatedDate] desc"
  var lastSessionEntry = ExecSQLQueryToReturnVal(queryString1)
  
  var queryString = "SELECT TOP (1) [Id],[Username],[Role],[Timestamp],[Status],[SessionId] FROM [SessionHistory] where [SessionId]='"+lastSessionEntry[0][0]+"' order by [Timestamp] desc"
  var lastEntry = ExecSQLQueryToReturnVal(queryString)
  return lastEntry
}

/*===============================================================================
Description: This function to get the last entry in session history table
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastEntryFromSession()
{
  var queryString = "SELECT TOP (1) [Id],[CreatedDate],[IterationType],[IterationVersion],[SessionType],[PriorityNurse],[CallHandlerSelectedUrgency],[ROSelectedUrgency],[ExamRecommendedUrgency],[AppVersion] FROM [Session] Where DomainId=(Select Id from Domain where Description='"+Project.Variables.Domain+"') order by [CreatedDate] desc"
  
  var lastSession = ExecSQLQueryToReturnVal(queryString)
  sessionId = lastSession[0][0]
  return lastSession
}
/*===============================================================================
Description: This function to get the last entry in audit table for a session
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastEntryFromAudit(sessionId)
{
  var queryString = "SELECT TOP (1) [Id],[Category],[Summary],[Description],[Identity],[Date],[SessionId] FROM [Audit] where SessionId='"+sessionId+"' order by [Date] desc"  
  var lastAudit = ExecSQLQueryToReturnVal(queryString)
  return lastAudit
}
/*===============================================================================
Description: This function to get the last entry in audit table
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastAuditEntryWithoutSession()
{
  var queryString = "SELECT TOP (1) [Id],[Category],[Summary],[Description],[Identity],[Date],[SessionId] FROM [Audit] where DomainId=(select Id from Domain where Description='"+Project.Variables.Domain+"') order by [Date] desc;"  
  var lastAudit = ExecSQLQueryToReturnVal(queryString)
  return lastAudit
}
/*===============================================================================
Description: This function to get the clinical key in response table
Parameters: 
          sessionID: Session ID
Return Value:dbRecord[][]
=================================================================================*/
function GetClinicalKeyFromResponse(sessionID)
{
  var queryString = "SELECT [Id] ,[SessionId],[ClinicalKey], [ResponseText] FROM [Response] where SessionId='"+sessionID+"'"
  var clinicalKey=ExecSQLQueryToReturnVal(queryString)
  return clinicalKey
}
/*===============================================================================
Description: This function to get the note from db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastNote()
{
  var queryString = "SELECT TOP (1) * FROM [Note] order by [Time] desc"
  var lastNote = ExecSQLQueryToReturnVal(queryString)
  return lastNote
}

/*===============================================================================
Description: This function to get all the notes of any session from db
Parameters: 
          sessionID: Session ID
Return Value:dbRecord[][]
=================================================================================*/
function GetAllNotesofSession(sessionID)
{
  var queryString = "SELECT Text, Username, SessionId FROM [Note] where SessionId='"+sessionID+"'"
  var allNotes = ExecSQLQueryToReturnVal(queryString)
  return allNotes
}
/*===============================================================================
Description: This function to get the last entry of SessionAdviceAcceptance from db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastSessionAdviceAcceptance()
{
  var queryString = "SELECT TOP (1) * FROM [SessionAdviceAcceptance] order by [CreatedDate] desc"
  var lastSessionAdviceAcceptance = ExecSQLQueryToReturnVal(queryString)
  return lastSessionAdviceAcceptance
}

/*===============================================================================
Description: This function to get all the Outcome ID of any session from db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetCHOutcomeIDSession()
{
  var queryString = "SELECT TOP (1) [Id],[CallHandlerOutcomeId] FROM [Session] order by [CreatedDate] desc"
  var CHOutcomeID = ExecSQLQueryToReturnVal(queryString)
  return CHOutcomeID
}
/*===============================================================================
Description: This function to get the Id from Outcome
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetOutcomeFromResponse()
{
  var queryString = "SELECT TOP (1)[Id],[Description],[CallbackAdvice] FROM [Outcome] Where [Id] IN (SELECT TOP (1) [CallHandlerOutcomeId] from [Session] order by [Modified] desc) order by [From] desc"
  var clinicalKey=ExecSQLQueryToReturnVal(queryString)
  return clinicalKey
}
/*===============================================================================
Description: This function to delete contact types from admin
Parameters: 
Return Value: 
=================================================================================*/
function DeleteAllRelationshipTypeFromAdmin()
{
  ExecSQLQueryFile("DeleteRelationTypeForInitialSetup")
} 
/*===============================================================================
Description: This function to delete person details from DB through NHS
Parameters: 
Return Value: 
=================================================================================*/

function DeletePatientTestDataByNHS()
{
  ExecSQLQueryFile("RemovePatientTestDataByNHS")
}
/*===============================================================================
Description: This function to get the last entry of SessionAdviceAcceptance from db(incomplete)
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function DeletePatientOutcome()
{
  Sys.OleObject("WScript.Shell").Run("iisreset MyComputer");
  
//  Sys.OleObject("WScript.Shell").Run("Restart-WebAppPool  -Name OdysseyHTTPSNew");
//  WshShell.Run("powershell -command Restart-WebAppPool -Name OdysseyHTTPSNew");
  WshShell.Run("powershell -command Stop-WebAppPool -Name OdysseyHTTPSNew");
  delayExecution("10")
  WshShell.Run("powershell -command Start-WebAppPool -Name OdysseyHTTPSNew");
}
/*===============================================================================
Description: This function to get the last entry in session history table
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetLastEntryFromSessionInProcess()
{
  var queryString = "SELECT TOP (1) [Id],[CreatedDate],[IterationType],[IterationVersion],[SessionType],[PriorityNurse],[CallHandlerSelectedUrgency],[ROSelectedUrgency],[ExamRecommendedUrgency], [IsPMHViewed] FROM [Session] Where DomainId=(Select Id from Domain where Description='"+Project.Variables.Domain+"') order by [CreatedDate] desc"
  
  var lastSession = ExecSQLQueryToReturnVal(queryString)
  return lastSession
}
/*===============================================================================
Description: This function to get all signpost list of any session from db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetSignpostsBySeesionID(SessionId)
{
  var queryString = "SELECT TOP (1) [SessionId],[SuggestedSignposts],[Description] FROM [SessionSignposts] where SessionId='"+SessionId+"' order by [AssignedDate] desc"
  var Signpost = ExecSQLQueryToReturnVal(queryString)
  return Signpost
}
/*===============================================================================
Description: This function to feature setting value in EmailConfiguration table of db
Parameters: 
            featureSetting:featureSetting value
Return Value:
=================================================================================*/
function UpdateEmailConfigModule(featureSetting)
{
    //var queryString = "Update EmailConfiguration set FeatureSetting="+featureSetting+";"
    var queryString = "Update EmailConfiguration set FeatureSetting="+featureSetting+" where DomainId=(Select DomainId from Domain where Description='"+Project.Variables.Domain+"')"
    ExecSQLQuery(queryString);
}

/*===============================================================================
Description: This function to delete person details from DB for permarmance module
Parameters: 
Return Value: 
=================================================================================*/
function DeletePersDetForPerformanceModule()
{
  for (i=0;i<15;i++)
  ExecSQLQueryFile("RemovePatientPerformanceModule")
}
/*===============================================================================
Description: This function to execute SQL query and check if no records found(Negative scenario)
Parameters: 
            queryString: sql query to execute
Return Value: true/false
=================================================================================*/
function ExecSQLQueryNoRecords(queryString)
{
    setDBConnection()
    var rs; cmd
    cmd.CommandText = queryString;
    cmd.CommandType = cmdText;
    rs = cmd.Execute();
    if(rs.EOF)
      return true;
    else
      return false; 
}

/*===============================================================================
Description: This function to get all signpost list of any session from db
Parameters: 
Return Value:true/false
=================================================================================*/
function GetSignpostsNegScenario(SessionId)
{
  var queryString = "SELECT TOP (1) [SessionId],[SuggestedSignposts],[Description] FROM [SessionSignposts] where SessionId='"+SessionId+"' order by [AssignedDate] desc"
  var result = ExecSQLQueryNoRecords(queryString)
  return result
}
/*===============================================================================
Description: This function to delete all the admin defined snomed code(having 123456 matching value) for any urgency from db
Parameters: 
Return Value:
=================================================================================*/
function DeleteUrgencySnomedCode()
{
  var queryString = "DELETE FROM [NewUrgencyText] WHERE (UrgencyText LIKE '%12345%')"
  ExecSQLQuery(queryString)
}
/*===============================================================================
Description: This DB function to enable/disable PostCode validation in ConfigSettings table of DB
Parameters: 
            configKey:PostcodeValidation/SessionTimeoutInMinutes
            configValue:True/False
Return Value:
=================================================================================*/
function SetConfigSettings(configKey,configValue)
{
    var queryString = "Update ConfigSetting set ConfigValue='"+configValue+"' where (ConfigKey='"+configKey+"' AND DomainId=(Select DomainId from Domain where Description='"+Project.Variables.Domain+"'));"
    ExecSQLQuery(queryString);
}

/*===============================================================================
Description: This DB function to enable/disable Signpost in OutcomeTypeConfiguration table of DB
Parameters: 
            module:FirstCall/Clinical/SelfAssess/Reception/FaceToFace
            outcomeType:Signpost/PatientOutcome
Return Value:
=================================================================================*/
function SetOutcomeType(module,outcomeType)
{
    var isSignposted = "False";
    if(aqString.ToUpper(outcomeType) == "SIGNPOST")
        isSignposted = "True";
    else
        isSignposted = "False";

    var queryString =  "Update [dbo].[OutcomeTypeConfiguration] set IsSignPosted = '"+isSignposted+"' Where Module = '"+module+"' and Domain=(Select Id from Domain where Description='"+Project.Variables.Domain+"');"
    ExecSQLQuery(queryString);
    //resetIISViaShellCommand()
}

/*=======Reporting Database specific functions========*/

/*===============================================================================
Description: Function to establish a connection to reporting database
Parameters:
	DBName:DB object which is created in page locator	
Return Value: N/A
Note: Connection is DB is done by passing the DB Obect which is created in pagelocators
===============================================================================*/
function setConnectionRepDB() 
{
     var connectionString;
     dbProvider = "SQLOLEDB";
     var dbserver=Project.Variables.DBServer
     var reportingdDbName = Project.Variables.reportingdDbName
     var reportingdDbUsername = Project.Variables.reportingdDbUsername
     var reportingdDbPassword = Project.Variables.reportingdDbPassword
     
     connectionString = "Provider=" + dbProvider + ";Server=" + dbserver + ";Database=" + reportingdDbName + ";Uid=" + reportingdDbUsername + ";Pwd=" + reportingdDbPassword + ";";

    cmd = ADO.CreateADOCommand();
    cmd.ConnectionString = connectionString;
}

/*===============================================================================
Description: This function to execute SQL query to return value
Parameters: 
            queryString: sql query to execute
Return Value: 
=================================================================================*/
function ExecSQLQueryRetValRepDB(queryString)
{
    setConnectionRepDB()
    var rs, rsCnt; cmd
    var myArray = [0]; //newly added line
    cmd.CommandText = queryString;
    cmd.CommandType = cmdText;
    rs = cmd.Execute();
    rsCnt = 0
    rs.MoveFirst();
    while (!rs.EOF) {
        if (!myArray[rsCnt]) {
            myArray[rsCnt] = {}
        }
        for (col = 0; col < rs.Fields.Count; col++) {
            myArray[rsCnt][col] = rs.Fields(col).Value;
        }
        rsCnt = rsCnt + 1;
        rs.MoveNext();
    }
    return (myArray);  
}
/*===============================================================================
Description: This function to get all response provided for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetResponseRepDB(SessionId)
{
  var queryString = "SELECT [ResponseId],[SessionId],[ProtocolName],[ShortQuestion],[Answer],[LongQuestion] FROM [Response] where SessionId='"+SessionId+"' order by [DateTime] desc"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}
/*===============================================================================
Description: This function to get demographic details of patient for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetDemographicDetRepDB(SessionId)
{
  var queryString = "SELECT [PatientName],[DateOfBirth],[PatientAgeYears],[Gender],[NhsNumber] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}
/*===============================================================================
Description: This function to get contact details of patient for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetContactDetRepDB(SessionId)
{
  var queryString = "SELECT [Address],[PhoneNumber],[GpPractice],[GpName] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}
/*===============================================================================
Description: This function to get content details used for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetContentDetRepDB(SessionId)
{
  var queryString = "SELECT [Culture],[Location],[IterationType],[Product],[IterationVersion] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}
/*===============================================================================
Description: This function to get clinician details and presenting complaint available for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetClinicianDetRepDB(SessionId)
{
  var queryString = "SELECT [Clinician], [PresentingComplaint], [OdysseyRecommendedUrgency], [UserSelectedUrgency], [Outcome] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}

/*===============================================================================
Description: This function to get Reception details and presenting complaint available for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetReceptionDetRepDB(SessionId)
{
  var queryString = "SELECT [Receptionist], [PresentingComplaint], [OdysseyRecommendedUrgency], [UserSelectedUrgency], [Outcome] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}

/*===============================================================================
Description: This function to get FirstCall details and presenting complaint available for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetFirstCallDetRepDB(SessionId)
{
  var queryString = "SELECT [CallHandler], [PresentingComplaint], [CallHandlerRecommendedUrgency], [CallHandlerSelectedUrgency], [CallHandlerOutcome] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}

/*===============================================================================
Description: This function to get Signpost details available for any session from reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetSignpostDetRepDB(SessionId)
{
  var queryString = "SELECT [SessionId], [Module], [SelectedSignpost], [SuggestedSignpost] FROM [SessionSignpost] where SessionId='"+SessionId+"' order by [AssignedDate] desc;"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}

/*===============================================================================
Description: This function to get FirstCall advice details available for any session in reporting db
Parameters: 
Return Value:dbRecord[][]
=================================================================================*/
function GetAdviceDetRepDB(SessionId)
{
  var queryString = "SELECT [CareAdviceText], [CareAdviceDelivered], [WorseningAdviceText], [WorseningAdviceDelivered], [WorseningStatementText], [WorseningStatementDelivered], [FirstAidAdviceText], [FirstAidAdviceDelivered] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}

/*===============================================================================
Description: This DB function to update value of any clumn(key) in Domain table of DB
Parameters: 
            Key:FeatureSetting
            Value:value to be updated with
Return Value:
=================================================================================*/
function SetDomainSettings(Key,Value)
{
    var queryString = "Update Domain set "+Key+"='"+Value+"' where Description='"+Project.Variables.Domain+"';"
    ExecSQLQuery(queryString);
}

/*===============================================================================
Description: This function to add GP details for automation testing while initial database configuration
Parameters: 
Return Value:
=================================================================================*/
function AddGPDetails()
{
    var queryString2 = "Select COUNT(Name) FROM Practice WHERE [Name]='Medi Claim'"
    resultArr = ExecSQLQueryToReturnVal(queryString2)
    if(resultArr[0][0]==0)
    {
        var queryString = "Insert into Practice ([Name],[Line1],[Email],[Telephone],[Visible],[PracticCode]) Values ('Medi Claim','CBC Street','mediclaim@live.in','9798435','True','111'),('NH Care','New Street','nhcare@gmail.in','7623476','True','222')"
        var queryString1 = "Insert into GP ([Surname],[PracticeId],[Forename],[Visible],[PracticeCode]) Values ('Jane',(select Id from Practice where [Name]='Medi Claim'),'Patrick','True','111')"
        var queryString3 = "Insert into GP ([Surname],[PracticeId],[Forename],[Visible],[PracticeCode]) Values ('Pan',(select Id from Practice where [Name]='NH Care'),'Peter','True','222')"
        ExecSQLQuery(queryString);
        ExecSQLQuery(queryString1);
        ExecSQLQuery(queryString3);
    }
    else
    {
        Log.Message("GP details is already present. Skipped adding it again.")
    }
}

/*===============================================================================
Description: This function to add Overridden Signpost details for automation testing while initial database configuration
Parameters: 
Return Value:
=================================================================================*/
function AddOverrideSignpost()
{
  var queryString = "Insert into OverriddenSignposts (SignpostId, DomainId, OverrideSignpostId) Values ('5', (Select Id from Domain where Description='"+Project.Variables.Domain+"'), '9')"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to add Aliased Signpost details for automation testing while initial database configuration
Parameters: 
Return Value:
=================================================================================*/
function AddAliasedSignpost()
{
  var queryString = "insert into AliasedSignposts (SignpostId, DomainId, Description) VALUES ('8', (Select Id from Domain where Description='"+Project.Variables.Domain+"'), 'Health assessment')";
  var queryString1 = "insert into AliasedSignposts (SignpostId, DomainId, ReducedCallLengthDescription) VALUES ('42', (Select Id from Domain where Description='"+Project.Variables.Domain+"'), 'Clinical contact')"
  var queryString2 = "insert into AliasedSignposts (SignpostId, DomainId, Description, ReducedCallLengthDescription) VALUES ('10', (Select Id from Domain where Description='"+Project.Variables.Domain+"'), 'Dentist contact', 'Dental care unit')"
  ExecSQLQuery(queryString)
  ExecSQLQuery(queryString1)
  ExecSQLQuery(queryString2)
}

/*===============================================================================
Description: This function to add content file details in IterationDataConfig table for automation testing while initial database configuration
Parameters: 
          contentDet: content details
Return Value:
=================================================================================*/
function AddClinicalContent(contentDet)
{
  var queryString = "insert into IterationDataConfig (Version, Culture, Location, Product, Type, FileName) VALUES ("+contentDet+")"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to get FirstCall advice details available for any session in reporting db
Parameters: 
          SessionId:
Return Value:dbRecord[][]
=================================================================================*/
function GetQuesTxtTypeRepDB(SessionId)
{
  var queryString = "SELECT [SessionId], [Clinician], [CallHandler], [QuestionTextType], [CallLength] FROM [SessionDetails] where SessionId='"+SessionId+"';"
  var responseRes = ExecSQLQueryRetValRepDB(queryString)
  return responseRes
}
/*===============================================================================
Description: This function to get FirstCall advice details available for any session in reporting db
Parameters: 
          contactType:contact type
          flag:corresponding flag
Return Value:dbRecord[][]
=================================================================================*/
function UpdateContactType(contactType, flag)
{
  var queryString = "Update ContactType set "+flag+"='True' where ContactType='"+contactType+"' and DomainId=(Select Id from Domain where Description='"+Project.Variables.Domain+"');"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to add content type version in the ClinicalContentType table of Odyssey Database
Parameters: 
          version:content version
Return Value:
=================================================================================*/
function AddClinicalContentType(version)
{
  var queryString = "Insert into ClinicalContentType(Product, Version) VALUES ('TeleAssess', '"+version+"');"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to del content type version in the ClinicalContentType table of Odyssey Database for auto update validations
Parameters: 
          version:content version
Return Value:
=================================================================================*/
function DelClinicalContentType(version)
{
  var queryString = "Delete from ClinicalContentType where Version='"+version+"';"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to delete content file details in IterationDataConfig table for auto update validations
Parameters: 
          version:
          location:
          type:
Return Value:
=================================================================================*/
function DelClinicalContent(version, location, type)
{
  var queryString = "Delete from IterationDataConfig where Version='"+version+"' and Location='"+location+"' and Type='"+type+"';"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This function to delete clinical content update history details in ClinicalContentUpdateHistory table for auto update validations
Parameters: 
          version:
Return Value:
=================================================================================*/
function DelContentUpdateHis(version)
{
  var queryString = "Delete from ClinicalContentUpdateHistory where ClinicalContentTypeId=(Select Id from ClinicalContentType where Version='"+version+"');"
  ExecSQLQuery(queryString)
}

/*===============================================================================
Description: This DB function to update clinical content type ID in Domain table of DB
Parameters: 
            version:content version to set
Return Value:
=================================================================================*/
function UpdateContentVersion(version)
{
    //var queryString = "Update Domain set ClinicalContentTypeId"='"+Value+"' where Description='"+Project.Variables.Domain+"';"
    var queryString = "Update Domain set ClinicalContentTypeId=(Select Id from ClinicalContentType where Version='"+version+"') where Description='"+Project.Variables.Domain+"';"
    ExecSQLQuery(queryString);
}
