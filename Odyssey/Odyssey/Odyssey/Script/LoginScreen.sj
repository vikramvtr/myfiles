//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT PageObjects

/*===============================================================================
Description: This function is wait for the login screen
Parameters: 
Return Value: 
=================================================================================*/
function waitForLoginScreen()
{
  //waitForInformationMessage(["Name"],["WPFObject(\"LoginIdLabel\")"])
  return waitForItemWithTime("WPFObject(\"LoginIdLabel\")","Login ID:",2)
}

/*===============================================================================
Description: This function to Enter LoginID
Parameters: 
              username:UserName
Return Value: 
=================================================================================*/
function EnterLogInID(username)
{
  setText(username,txt_LoginId,"LoginID","")
}

/*===============================================================================
Description: This function to Enter Password
Parameters: 
              password:Password
Return Value: 
=================================================================================*/
function EnterPassword(password)
{
  setText(password,txt_Password,"Password","")
}

/*===============================================================================
Description: This function to login the application
Parameters: 
  UserName: username 
            Password: Password
            
Return Value: 
=================================================================================*/
function Login(UserName,Password)
{
  EnterLogInID(UserName)
  EnterPassword(Password)
  clickSignInButton()
  var acceptTerms = ToFindObjToValidate(["Name", "WPFControlText"], [btn_Accept, "Accept"])  
  if(acceptTerms)
  {
      clickItem(btn_Accept, "Accept")
  }
  var res = aqString.find(UserName,"admin",0)
  if(res==-1)
  {
      LoadingDone()
  }
}

/*===============================================================================
Description: This function is click sign in button and to wait for loading default screen
Parameters: 
Return Value: 
=================================================================================*/
function clickSignInButton()
{
  clickItem(btn_Login,"Login")
  waitfordefaultScreen()
}
/*===============================================================================
Description: This function check the email contains current username
Parameters: 
             user:Current User Name
Return Value: 
=================================================================================*/
function CheckEmailContainsCurrentUN(User)
{
  Process = GetProcess()
  var obj = Process.FindChild(["Name","Tag"],[txt_EmailTextBox,"Email"],100)
  var txt = obj.wText
  if(aqString.ToUpper(User)=="CLINICIAN")
  {
    if(txt==Project.Variables.ClinicianUsername)
    {
      Log.Message("clinic@advanced.engb mail id is showing for clinician User Id")
      return true
    
    }
    else
    {
      Log.Message("clinic@advanced.engb mail id is not showing for clinician User Id")
      return false
    }
  }
  if(aqString.ToUpper(User)=="RECEPTION")
  {
   if(txt==Project.Variables.ReceptionUsername)
    {
      Log.Message("reception@advanced.engb mail id is showing for reception User Id")
      return true
    
    }
    else
    {
      Log.Message("reception@advanced.engb mail id is not showing for reception User Id")
      return false
    }
   }
  if(aqString.ToUpper(User)=="CALLHANDLER")
  {
   if(txt==Project.Variables.CallHandlerUsername)
    {
      Log.Message("callhandler@advanced.engb mail id is showing for callhandler User Id")
      return true
    
    }
    else
    {
      Log.Message("callhandler@advanced.engb mail id is not showing for callhandler User Id")
      return false
    }
   }
}

