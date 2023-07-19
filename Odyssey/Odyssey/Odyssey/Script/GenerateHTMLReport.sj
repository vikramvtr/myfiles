//USEUNIT AccpetPatientScreen
//USEUNIT AdminLoginScreen
//USEUNIT AssessmentScreen
//USEUNIT CommonActItems_Clinician
//USEUNIT CommonActItems_Reception
//USEUNIT CommonFunctions
//USEUNIT CompareFiles
//USEUNIT ConfigurationEditorsScreen
//USEUNIT DefaultScreen
//USEUNIT DemographicScreen
//USEUNIT LoginScreen
//USEUNIT PageObjects
//USEUNIT PresentingCompliantScreen
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
Description : This script unit holds all the functions required to create the HTML 
              results report for every run.
              A "Results" folder in pre-defined format is required.
              For multiple module runs a consolidated report with links to 
              individual module report is provided

Author      : Automation Team
===============================================================================*/



/*===============================================================================
Description: This function is used to verify the results and write to the log file
Parameters : 
    VariableVal     : This holds the Actual result
    ConditionalVal  : This holds the Expected result
    PassMesg        : This holds the message to write if verification passes
    FailMesg        : This holds the message to write if verification fails
    FlagtoLog       : This holds the value for type of comparison (0|1|2)
===============================================================================*/
function HTMLLog2(VariableVal, ConditionalVal, PassMesg, FailMesg, FlagtoLog)
{
    if(VariableVal == null)
      VariableVal = "null";
    else if(ConditionalVal == null)
      ConditionalVal = "null";
    
    if(aqString.Find(VariableVal,"(") != -1)
    {
//      var func = VariableVal.split("eval")[1]
//      func =aqString.Remove(func,0,1)
//      var len=aqString.GetLength(func)
//      func= aqString.Remove(func,len-1,1)
      VariableVal=eval(VariableVal)
      
    }
      
    if(FlagtoLog == "0" || FlagtoLog == "1"){
        
        if(aqString.ToUpper(VariableVal) == aqString.ToUpper(ConditionalVal))
        {
            Log.Checkpoint(PassMesg);
            writelog("PASS",PassMesg);
        }
        else{
            // Beep();
            Log.Error(FailMesg);
            writelog("FAIL",FailMesg);
        }
    }
    else if(FlagtoLog == "2"){
		    var Res;
        Res = aqString.Find(aqString.ToUpper(VariableVal),aqString.ToUpper(ConditionalVal))
        if(Res != -1)
        {
            Log.Checkpoint(PassMesg);
            writelog("PASS",PassMesg);
        }
        else{
//            Beep();
            Log.Error(FailMesg);
            writelog("FAIL",FailMesg);
        }
    }
    else if(FlagtoLog == "3"){
        if(aqString.StrMatches(ConditionalVal, VariableVal))
        {
            Log.Checkpoint(PassMesg);
            writelog("PASS",PassMesg);
        }
        else{
//            Beep();
            Log.Error(FailMesg);
            writelog("FAIL",FailMesg);
        }
    }
}
/*===============================================================================
Description: This function is used to write the status and message based on the verification result
Parameters : 
    strStatus       : This holds the status of the verification for the step
    strDescription  : This holds the message based on verification result
===============================================================================*/
function writelog(strStatus, strDescription)
{
  if(aqString.Compare(aqString.ToUpper(strStatus), "PASS", false) == 0)
  {
    CreateReport(aqString.ToUpper(strStatus), strDescription) 
  }
  else
  {
    CreateReport(aqString.ToUpper(strStatus), strDescription);
    testStatus = "FAIL";
  }                     
}        
/*===============================================================================
Description: This function is used to create the XML Report
Parameters:
===============================================================================*/
function CreateXML()
{
    var objDOM;
    var objNode;
    
    var strPath = LogResultsPath + "Results\\Consolidated.xml";
    if(aqFile.Exists(strPath)== false)
    {
      // Create the main xml node
      objDOM = Sys.OleObject("Microsoft.XMLDOM");

      
      objNode = objDOM.createNode(1, "Root", "");
      objDOM.appendChild(objNode);
      
      objIntro = objDOM.createProcessingInstruction("xml-stylesheet","type='text/xsl' href='XmlReference/ConsolidatedLogReport.xsl'");  
      objDOM.insertBefore(objIntro,objDOM.childNodes(0));
    
      objDOM.save(strPath);
      
      //This holds the browser name in which the execution is done
//      objNode = objDOM.selectSingleNode(".//Root")
//      objStartNode = objDOM.createNode( 1, "Browser", "")
//      //objStartNode.Text = aqString.ToUpper(browserName) + " - Version: " + Browsers.Item(browserName).Version;
//      objStartNode.Text = aqString.ToUpper("BrowserName") + " - Version: " +"BrowserName";
      
//      objNode.appendChild(objStartNode)
      
//      objNode = objDOM.selectSingleNode(".//Root")
//      objStartNode = objDOM.createNode( 1, "Executer", "")
//      objStartNode.Text = aqString.ToUpper("vandhana");
//      objNode.appendChild(objStartNode)
//      
//      objDOM.save(strPath);
    }
    
    strPath = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";
   
    if(aqFile.Exists(strPath)== false)
    {
      // Create the main xml node
      objDOM = Sys.OleObject("Microsoft.XMLDOM");

      
      objNode = objDOM.createNode(1, "Root", "");
      objDOM.appendChild(objNode);
      
      objIntro = objDOM.createProcessingInstruction("xml-stylesheet","type='text/xsl' href='DetailXmlReference/LogReport.xsl'");  
      objDOM.insertBefore(objIntro,objDOM.childNodes(0));
    
      objDOM.save(strPath);
      
      //This holds the start time of execution
      objNode = objDOM.selectSingleNode(".//Root")
      objStartNode = objDOM.createNode( 1, "StartTime", "")
      objStartNode.Text = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d/%b/%Y") + "   " + VarToString(aqDateTime.Time());
      objNode.appendChild(objStartNode)
      
      //This holds the browser name in which the execution is done
      objNode = objDOM.selectSingleNode(".//Root")
      objStartNode = objDOM.createNode( 1, "Browser", "")
//      objStartNode.Text = aqString.ToUpper(browserName) + " - Version: " + Browsers.Item(browserName).Version;
      objStartNode.Text = aqString.ToUpper("BrowserName") + " - Version: " +"BrowserName";
      objNode.appendChild(objStartNode)
      
      //This holds the module name
      objNode = objDOM.selectSingleNode(".//Root")
      objStartNode = objDOM.createNode( 1, "Module", "")
      objStartNode.Text = aqString.ToUpper(moduleName);
      objNode.appendChild(objStartNode)
      objDOM.save(strPath);
    }
}  
/*===============================================================================
Description: This function is used to create the XML Report
Parameters:
===============================================================================*/
function DeleteXML()
{
////  Backup the results before completion of execution
  CreateBackupResults(LogResultsPath,ResultsBackUp,"Results");
  //Delete the screenshots captured after the back up process
  aqFileSystem.DeleteFile(LogResultsPath + "Results\\Module Results\\Snapshot\\*.png");

  aqFileSystem.DeleteFile(LogResultsPath + "Results\\*.xml");
  aqFileSystem.DeleteFile(LogResultsPath + "Results\\Module Results\\*.xml");
}

/*===============================================================================
Description: This function is used to backup the existing results
Parameters:
  source : The path to the Results folder (Ex : "E:\\AdvanceLearning\\Project\\Progresso\\")
  destination : The path to backup the results folder (Ex : "E:\\AdvanceLearning\\Results_BCK")
  copyFolder : The folder of which we need to take the backup (Ex : "Results")
===============================================================================*/
function CreateBackupResults(source,destination,copyFolder)
{
    //Create the backup folder if does not exists 
    if (!aqFileSystem.Exists(destination)) 
    {
            // Creates the folder
            aqFileSystem.CreateFolder(destination);
    }
    var d = new Date();
    var backupTime = d.getYear(destination)+""+(d.getMonth()+1)+""+d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
    destFolder = destination + "\\" + moduleName + "_" + backupTime
    aqFileSystem.CreateFolder(destFolder);
    sourcePath = source + copyFolder;
    aqFileSystem.CopyFolder(sourcePath, destFolder);
}

/*===============================================================================
Description: This function is used to create the XML body for the test case in which we write all the details
Parameters : 
    strTestCaseName : This holds the name of the test case currently being executed
===============================================================================*/
function StartTestcase(strTestCaseName)
{
    var objDOM
    var objManager
    var objGrandChildNode
    
    CreateXML();
    
//    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var strXMLPath = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";
    
    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")
    
    var intStepCount = objNode.childNodes.length

    objAttrib = objDOM.createElement("TestCase")    
    objAttrib.setAttribute("StartTime", VarToString(aqDateTime.Time()))
//    objAttrib.setAttribute("TestCaseID", VarToString("TC_" + Sys.HostName + VarToString(intStepCount + 1)))
//    objAttrib.setAttribute("ModuleName", VarToString(strTestCaseName));   
    objAttrib.setAttribute("ModuleName", VarToString(moduleName))
    objAttrib.setAttribute("ModuleName", VarToString(strTestCaseName))
    objNode.appendChild(objAttrib)
    objDOM.save(strXMLPath)
    
    intStepCount = objNode.childNodes.length
    objManager = objNode.childNodes.Item(intStepCount - 1)
    
    intStepCount = objManager.childNodes.length 
    
    // testcase name
    objGrandChildNode = objDOM.createNode( 1, "TestCaseName", "")
    objGrandChildNode.Text = strTestCaseName
    objManager.appendChild(objGrandChildNode)
    
    objDOM.save(strXMLPath)
}   


/*===============================================================================
Description: This function is used to close the XML body for the test case in which we write all the details
Parameters : 
    strStatus      : This holds the status of the test case (PASS|FAIL)
    strDescription : This holds the description of the test case
===============================================================================*/
function EndTestcase(strStatus, strDescription)
{
    var objDOM
    var objNode
    var objGrandChildNode

//    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var strXMLPath = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";

    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")
    
    var intStepCount = objNode.childNodes.length
    if (intStepCount == 0)
    {
      objManager = objNode
    }
    else
    {
      objManager = objNode.childNodes.Item(intStepCount - 1)
    }
    
    intStepCount = objManager.childNodes.length 
    
    // Step Executed Time
    objGrandChildNode = objDOM.createNode( 1, "TestCaseDescription", "")
    objGrandChildNode.Text = strDescription
    objManager.appendChild(objGrandChildNode)
    
    // Result
    objGrandChildNode = objDOM.createNode( 1, "Result", "")
    objGrandChildNode.Text = aqString.ToUpper(strStatus)
    objManager.appendChild(objGrandChildNode)
    
    // End Time
    objGrandChildNode = objDOM.createNode( 1, "EndTime", "")
    objGrandChildNode.Text = VarToString(aqDateTime.Time())
    objManager.appendChild(objGrandChildNode)
    
    objDOM.save(strXMLPath)
}


/*===============================================================================
Description: This function is used to input the child nodes in the XML report based on the results
Parameters : 
    strStatus      : This holds the status of the step executed (PASS|FAIL)
    strDescription : This holds the message for verification of the step
===============================================================================*/
function CreateReport(strStatus, strDescription)
{
    var objDOM
    var objNode
    var objGrandChildNode
    var objAttribute
    var objElement
    var objManager
    var strPath
    
//    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var strXMLPath = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";
    
    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")
    
    var intStepCount = objNode.childNodes.length
    if (intStepCount == 0)
    {
      objManager = objNode
    }
    else
    {
      objManager = objNode.childNodes.Item(intStepCount - 1)
    }
    
    intStepCount = objManager.childNodes.length
    
    objAttrib = objDOM.createElement("Step")
    objAttrib.setAttribute("Number", VarToString(intStepCount))

    objManager.appendChild(objAttrib)
    
    ObjTesterNode = objDOM.createElement("LowLevelInfo")
    
    // Tester Step ID
    objGrandChildNode = objDOM.createNode(1, "StepID", "")
    objGrandChildNode.Text = intStepCount
    ObjTesterNode.appendChild (objGrandChildNode)
    
    // Description
    objGrandChildNode = objDOM.createNode( 1, "Description", "")
    objGrandChildNode.Text = strDescription
    ObjTesterNode.appendChild(objGrandChildNode)
    
    // Step Executed Time
    objGrandChildNode = objDOM.createNode( 1, "StepExecutedTime", "")
    objGrandChildNode.Text = VarToString(aqDateTime.Time())
    ObjTesterNode.appendChild(objGrandChildNode)
    
    // Screen shot name
    objAttrib1 = objDOM.createElement("ScreenShot")
    if(aqString.ToUpper(strStatus)=="PASS")
    {
      objAttrib1.setAttribute("Name", "N/A")
      strPath = "N/A"  
      objAttrib1.Text = "N/A"
    }
    else
    {
      // Post picture to log
      objAttrib1.setAttribute("Name", "View")
      var now=aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%m/%d/%y %H:%M:%S"); 
      strPath = aqDateTime.GetMonth(now) + "_" + aqDateTime.GetDay(now) + "_" + aqDateTime.GetHours(now) + "_" + aqDateTime.GetMinutes(now) + "_" + aqDateTime.GetSeconds(now) + ".png"
      var obj = Sys.Desktop.ActiveWindow().Picture()
      obj.SaveToFile(LogResultsPath + "Results\\Module Results\\Snapshot\\" + strPath)
      objAttrib1.Text = "..\\Module Results\\Snapshot\\" + strPath
    }
    
    ObjTesterNode.appendChild(objAttrib1)
    
    // Result
    objGrandChildNode = objDOM.createNode( 1, "Result", "")
    objGrandChildNode.Text = aqString.ToUpper(strStatus)
    ObjTesterNode.appendChild(objGrandChildNode)
    
    objAttrib.appendChild(ObjTesterNode)
    
    objDOM.save(strXMLPath)
}

/*===============================================================================
Description: This function is used to input the child node for the the time of end of execution of the complete test set i.e., the complete input sheet
Parameters:
===============================================================================*/
function EndExecution()
{
    var objDOM
    var objNode
    var objGrandChildNode
    //Stops the timer                                     
    StopWatchObj.Stop(); 
    //Stores the time in hh:mm:ss.mmm format                          
    totalTimeTaken = StopWatchObj.ToString();
    var timeArray = totalTimeTaken.split(":");
    totalTimeTaken = timeArray[0] + ":" + timeArray[1] + ":" + timeArray[2].split(".")[0];
    
//    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var strXMLPath = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";
    
    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")
    
    var intStepCount = objNode.childNodes.length
    if (intStepCount == 0)
    {
      objManager = objNode
    }
    else
    {
      objManager = objNode.childNodes.Item(intStepCount - 1)
    }
    
    intStepCount = objManager.childNodes.length
    
    // Step Executed Time
    objGrandChildNode = objDOM.createNode( 1, "EndExecutionTime", "")
    objGrandChildNode.Text = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d/%b/%Y") + "   " + VarToString(aqDateTime.Time());
    objManager.appendChild(objGrandChildNode)
    
    //Total Time taken for module execution
    objGrandChildNode = objDOM.createNode( 1, "TotalTimeTaken", "")
    objGrandChildNode.Text = totalTimeTaken;
    objManager.appendChild(objGrandChildNode);
    
    objDOM.save(strXMLPath);
}


/*===============================================================================
Description: This function is used to create and insert nodes for the consolidated report with reference to the individual module report
Parameters:
===============================================================================*/
function StartModuleExecution()
{
  var objDOM
  var objManager
  var objGrandChildNode
  
  totalTimeTaken = "";
  StopWatchObj = HISUtils.StopWatch;
  //Starts the timer                                   
  StopWatchObj.Start();    
    
    CreateXML();
    
//    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";
    var moduleResultFile = LogResultsPath + "Results\\Module Results\\Consolidated_" + moduleName + ".xml";
    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")

     var ClinicalContentVersion = objDOM.createNode(1,"ClinicalContentVersion","")
     ClinicalContentVersion.text = Project.Variables.ClinicalContentVersion
     objNode.appendChild(ClinicalContentVersion)
     
     var appVersion = objDOM.createNode(1,"ApplicationVersion","")
     appVersion.text = Project.Variables.ApplicationVersion
     objNode.appendChild(appVersion)
        
    var intStepCount = objNode.childNodes.length
    
    //Create node for each module
    objAttrib = objDOM.createElement("ModuleName")    
    objAttrib.setAttribute("Module", VarToString(moduleName)); 
    objNode.appendChild(objAttrib)
    objDOM.save(strXMLPath)
    
    intStepCount = objNode.childNodes.length
    objManager = objNode.childNodes.Item(intStepCount - 1)
    
    intStepCount = objManager.childNodes.length 
    
    //Execution start time for the module
    objGrandChildNode = objDOM.createNode( 1, "StartTime", "")
    objGrandChildNode.Text = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d/%b/%Y") + "   " + VarToString(aqDateTime.Time());
    objManager.appendChild(objGrandChildNode)
    
    //Path reference for the respective module report
    objAttrib1 = objDOM.createElement("ModuleLog")
    objAttrib1.setAttribute("Name", moduleName)
    objAttrib1.Text = "..\\Results\\Module Results\\Consolidated_" + moduleName + ".xml";
    objManager.appendChild(objAttrib1);
    
    objDOM.save(strXMLPath)
}


/*===============================================================================
Description: This function is used to create and insert end nodes for the consolidated report with reference to the individual module report
Parameters:
===============================================================================*/
function EndModuleExecution()
{
    var objDOM
    var objNode
    var objGrandChildNode
    
    var strXMLPath = LogResultsPath + "Results\\Consolidated.xml";

    // Create the main xml node
    objDOM = Sys.OleObject("Microsoft.XMLDOM")
    
    objDOM.Load(strXMLPath)
    
    objNode = objDOM.selectSingleNode(".//Root")
    
    var intStepCount = objNode.childNodes.length
    if (intStepCount == 0)
    {
      objManager = objNode
    }
    else
    {
      objManager = objNode.childNodes.Item(intStepCount - 1)
    }
    
    intStepCount = objManager.childNodes.length 
    
    // End Time of module execution
    objGrandChildNode = objDOM.createNode( 1, "EndTime", "")
    objGrandChildNode.Text = aqConvert.DateTimeToFormatStr(aqDateTime.Now(), "%d/%b/%Y") + "   " + VarToString(aqDateTime.Time());
    objManager.appendChild(objGrandChildNode)
    
    
    //Total Time taken for module execution
    objGrandChildNode = objDOM.createNode( 1, "TotalTimeTaken", "")
    objGrandChildNode.Text = totalTimeTaken;
    objManager.appendChild(objGrandChildNode);
    
    objDOM.save(strXMLPath)
}


/*===============================================================================
Description: This function is used to verify the results and write to the log file
Parameters : 
    func1  : This holds the Actual result
    func2  : This holds the Expected result
    type   : This holds the message to write if verification passes
    expVal : This holds the message to write if verification fails
    PassMesg: This holds the value for type of comparison (0|1|2)
    FailMesg: This holds the value for type of comparison (0|1|2)

===============================================================================*/
function HTMLLog(func1,func2,type,expVal,PassMesg,FailMesg)
{
    
    if(aqString.ToUpper(type)=="EVALUATE")
    { 
      func1=aqString.Replace(func1,"'","\"")
      actualVal =eval(func1)
    } 
    else
    {
     func1=aqString.Replace(func1,"'","\"")
     func2=aqString.Replace(func2,"'","\"")
     actualVal1 =eval(func1)
     actualVal2 =eval(func2)
     if(actualVal1==actualVal2)
     {
      actualVal=true
     }
     else
     {
      actualVal=false
     }
    }
    if(aqString.ToUpper(actualVal) == aqString.ToUpper(expVal))
    {
            Log.Checkpoint(PassMesg);
            writelog("PASS",PassMesg);
    }
    else
    {
            // Beep();
            Log.Error(FailMesg);
            writelog("FAIL",FailMesg);
    }
    
       
}

/*===============================================================================
Description: This function is used to verify the results and write to the log file
Parameters : 
    func1  : This holds the Actual result
    func2  : This holds the Expected result
    type   : EVALUATE/COMPARE
    expVal : expected value
    PassMesg: Pass message
    FailMesg: Fail Message

===============================================================================*/
function ResultLog(func1,func2,type,expVal,PassMesg,FailMesg)
{
    if(aqString.ToUpper(type)=="EVALUATE")
    { 
        func1=aqString.Replace(func1,"|",",")
        actualVal =eval(func1)
    } 
    else
    {
     
       func1=aqString.Replace(func1,"|",",")
       func2=aqString.Replace(func2,"|",",")
       actualVal1 =eval(func1)
       actualVal2 =eval(func2)
       if(VarToStr(actualVal1)==VarToStr(actualVal2))
       {
          actualVal=true
       }
       else
       {
          actualVal=false
       }
    }
      if(aqString.ToUpper(actualVal) == aqString.ToUpper(expVal))
      {
           Log.Checkpoint(PassMesg);
           writelog("PASS",PassMesg);
      }
      else
      {
              // Beep();
          Log.Error(FailMesg);
          writelog("FAIL",FailMesg);
      }   
}