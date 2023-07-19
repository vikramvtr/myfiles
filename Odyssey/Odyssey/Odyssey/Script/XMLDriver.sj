//USEUNIT AccpetPatientScreen
//USEUNIT AdminLoginScreen
//USEUNIT AdminSummaryScreen
//USEUNIT AssessmentScreen
//USEUNIT CommonActItems_Clinician
//USEUNIT CommonActItems_Reception
//USEUNIT CompareFiles
//USEUNIT ConfigurationEditorsScreen
//USEUNIT DBFunctions
//USEUNIT DefaultScreen
//USEUNIT DemographicScreen
//USEUNIT GenerateHTMLReport
//USEUNIT LoginScreen
//USEUNIT PageObjects
//USEUNIT PresentingCompliantScreen
//USEUNIT RolesScreen
//USEUNIT ScreensOf3_11
//USEUNIT SummaryScreen
//USEUNIT TestHarnessScreen
//USEUNIT TriageScreen
//USEUNIT ScreensOf3_12
//USEUNIT ScreensOf3_12Outcome
//USEUNIT ScreensOf3_12TreatmentPlan
//USEUNIT ScreensOf3_13
//USEUNIT ScreensOf3_17
//USEUNIT ScreensOf3_12Examination
//USEUNIT UrgencyAdminScreen
//USEUNIT ReportingDB
//USEUNIT ScreensOf3_22
//USEUNIT DomainCreation

/*===============================================================================
'Description      : This function is to execute all the test cases 
'Author           : 
'Date             : 27/Oct/2016
'Last changed by  : 
'Reviewed by      :
'Last Changed Date: 2/Nov/2016
================================================================================*/


/*===============================================================================
Description: This function gets the module list to be executed from the XML
Parameters: N/A
Return Value: N/A
================================================================================*/

function GetModules()
{
  moduleName = "";
  moduleList = [];
  driverPathList = [];
  inputPathList = [];
//  SetTimeZone("GMT Standard Time");
  DeleteXML();
  
  var xmlPath = driverFilePath;
  var xmlDoc = Sys.OleObject("Microsoft.XMLDOM");
  xmlDoc.async = false;
  xmlDoc.load(xmlPath);
  x = xmlDoc.getElementsByTagName("MainDriver");
  if(x.length > 0)
  {
    for (i=0;i<x.length;i++)
    {
      y = x(i).childNodes;
      for(j=0;j < y.length;j++)
      {
        if(aqString.ToUpper(y(j).childNodes(2).text) == "YES")
        {
          moduleList.push(y(j).nodeName);
          driverPathList.push(y(j).childNodes(0).text);
          inputPathList.push(y(j).childNodes(1).text);
        }
      }
    }
  }
//    for(i=0;i<moduleList.length;i++)
    while(moduleList.length > 0)
    {
      moduleName = moduleList[0];
      strModuleFldr = Log.CreateFolder("Module : " + moduleName);
      Log.PushLogFolder(strModuleFldr);
      //Create new XML for the new module
      StartModuleExecution();
    
      GetDriverTC();
      moduleList = moduleList.slice(1,moduleList.length);
      driverPathList = driverPathList.slice(1,driverPathList.length);
      inputPathList = inputPathList.slice(1,inputPathList.length);
      //End execution of the test case by creating closing nodes for respective module results
      EndExecution();
      //End Module Execution and cresting closing nodes for the module in consolidated report
      EndModuleExecution();
      Log.PopLogFolder();
    }
  //  Backup the results after completion of execution
  CreateBackupResults(LogResultsPath,ResultsBackUp,"Results");
//  if(Sys.WaitBrowser("BroserName").Exists)
//  {
//    Sys.WaitBrowser(browserName).Close();
//    ClickOnBrowserPopUp("OK");
//  }
//  while(Sys.WaitBrowser(browserName).Exists)
//  {
//    Sys.WaitBrowser(browserName).Terminate();
//  }  
//  SetTimeZone("India Standard Time");
}

/*===============================================================================
Description: This function gets the testcse list to be executed based on the module to be executed from the XML
Parameters: N/A
Return Value: N/A
================================================================================*/
function GetDriverTC()
{
  var tcNo = [];
  var desc = [];
  var xmlPath = projectPath + "\\DataSheets\\" + driverPathList[0];
  var xmlDoc = Sys.OleObject("Microsoft.XMLDOM");
  xmlDoc.async = false;
  xmlDoc.load(xmlPath);
  var tagName = driverPathList[0].split(".")[0];
    
  x = xmlDoc.getElementsByTagName(tagName);
  if(x.length > 0)
  {
    for (i=0;i<x.length;i++)
    {
      y = x(i).childNodes;
      for(j=0;j < y.length;j++)
      {
        if(aqString.ToUpper(y(j).childNodes(1).text) == "YES")
        {
          tcNo.push(y(j).nodeName);
          desc.push(y(j).childNodes(0).text);
        }
      }
    }
  }
  ExecuteTCs(0,tcNo,desc);
}


/*===============================================================================
Description: This function executes test cases line by line based on the tag in XML
Parameters:
  startId: The start point for execution in xml
  tcId: Array contains all the TC Ids to be executed
  tcDesc: Array contains the description for all the TCs listed in tcId array
================================================================================*/
function ExecuteTCs(startId,tcId,tcDesc)
{
  for(tcCount=startId;tcCount<tcId.length;tcCount++)
  {
    var xmlPath = projectPath + "\\DataSheets\\" + inputPathList[0];
    var xmlDoc = Sys.OleObject("Microsoft.XMLDOM");
    xmlDoc.async = false;
    xmlDoc.load(xmlPath);
    try    
    {
      testStatus = "PASS";
      strTCFldr = Log.CreateFolder(tcId[tcCount] + "--" + tcDesc[tcCount]);
      Log.PushLogFolder(strTCFldr);
      //Create tags for the test case in report XML file
      StartTestcase(tcId[tcCount]);
      x = xmlDoc.getElementsByTagName(tcId[tcCount]);
      if(x.length > 0)
      {
        for (i=0;i<x.length;i++)
        {
          y = x(i).childNodes;
          for(j=0;j < y.length;j++)
          {
            if(aqString.ToUpper(y(j).nodeName) == "AT")
            {
              Log.Message(y(j).text)
              eval(y(j).text);
            }
           else if(aqString.SubString(y(j).nodeName,0,2) == "AV")
            {
             var SptVal = y(j).text.split(",");
             SptVal[0] = aqString.Replace(SptVal[0],"ResultLog(","")
             SptVal[5] = aqString.Replace(SptVal[5],")","")              
             ResultLog(SptVal[0],SptVal[1],SptVal[2],SptVal[3],SptVal[4],SptVal[5]);
            }
          }
        }
      }
        //Close tags for the test case in report XML file
        EndTestcase(testStatus,tcDesc[tcCount]);
        Log.PopLogFolder();
      }
    
    catch(error)
    {
      Log.Error(error.description);
      Beep(1000,1000);
      writelog("FAIL",error.description);
      //Close tags for the test case in report XML file
      EndTestcase("FAIL",tcDesc[tcCount]);
      Log.PopLogFolder();
//      Beep(3000,1000);
      ErrorHandling();
      ExecuteTCs(tcCount+1,tcId,tcDesc);
    }
  }
}


/*===============================================================================
Description: This function is used to Close and re-launch browser when exception occurs
Parameters: N/A
Return Value: N/A
================================================================================*/
function ErrorHandling()
{
  closeApplication1()
  DeletePatientsFromTheQueue()
  ToDeleteAllthePatients()
//  DeletePersonDetailFromDB()
//  DeleteGPDetailFromDB()
  Delete111Messages()
  UpdateContentVersion(Project.Variables.ClinicalContentVersion)
  DelContentDetails(ccusVersion,locationType,"Clinical|Lay")
  DeleteSessionTypefromAdmin()
  DeleteAllegiesAddedfromAdmin()
  SetConfigSettings("PostcodeValidation","False")
  SetConfigSettings("SessionTimeoutInMinutes","10")
  SetConfigSettings("UseRuleOfThreeWarning","true")
  SetDomainSettings("FeatureSetting","30")
  CheckUncheckEmailModule("FirstCall|TeleAssess","CHECK")
  SettingDefaultvaluesInAdmin()    
  return;
}

function bero()
{
  Beep(2000,500)
}