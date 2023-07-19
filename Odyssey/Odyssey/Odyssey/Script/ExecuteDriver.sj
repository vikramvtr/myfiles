//USEUNIT XMLDriver
//USEUNIT PageObjects
//USEUNIT Misc


/*===============================================================================
Description: This function is to start execution
Parameters: N/A
Return Value: N/A 
================================================================================*/
function ExecuteDriver()
{
  Log.LockEvents()
  getVarValues()
  
 projectPath = Project.Variables.solutionPath
  
  //Get project variables/
  driverFilePath = projectPath + "\\MainDriver.xml";
  CTFFilesPath = projectPath + "\\CTFFiles\\";
  LogResultsPath = projectPath + "\\";
  
  //Get variables from batch file 
  ResultsBackUp = ProcessCommandLineArgument("ResultsBackUp");
  UserName = ProcessCommandLineArgument("UserName");
  browserList = [];
  var xmlPath = projectPath + "\\Environment.xml" ;
  var xmlDoc = Sys.OleObject("Microsoft.XMLDOM");
  xmlDoc.async = false;
  xmlDoc.load(xmlPath);
  x = xmlDoc.getElementsByTagName("Environment");
  if(x.length > 0)
  {
    for (i=0;i<x.length;i++)
    {
      y = x(i).childNodes;
      for(j=0;j < y.length;j++)
      {
        if(aqString.ToUpper(y(j).nodeName) == "BROWSER")
        {
          browserName = y(j).text;
          executionUser = Sys.HostName;
//         SettingDefaultvaluesInAdmin()
          GetModules();
        }
      }
    }
  }
}

