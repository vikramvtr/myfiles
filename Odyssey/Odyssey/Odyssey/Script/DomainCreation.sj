//USEUNIT PageObjects
//USEUNIT CommonFunctions

/*===============================================================================
Description: This function is to launch the domain creation application
Parameters:             
Return Value: NA
=================================================================================*/
function LaunchDomainCreation()
{
    Project.Variables.Process = "DOMAINCREATION";
    if(!Sys.WaitProcess("Odyssey.Deployment.InitialUserInstall").Exists)
    {
      TestedApps.DomainCreationTool.Run()
      if(waitForProcessToStart("Odyssey.Deployment.InitialUserInstall"))
      {
        if(waitForInformationMessageTrueOrFalse(["Name"],[wnd_DomainEditor]))
        {
          Sys.Process("Odyssey.Deployment.InitialUserInstall").WPFObject("HwndSource: DomainEditor", "Odyssey Domain Editor").Maximize()  
        }
      }
    }
}

/*===============================================================================
Description: This function is wait for the Domain Creation default screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforDomainCreation()
{
  return waitForItemWithTime("WPFObject(\"Label\", \"Installation Type:\", 1)","Installation Type:",2)
}

/*===============================================================================
Description: This function is to connect to Database for new domain creation
Parameters:             
  installationtype: Standalone or Inprocess or Integration
Return Value: NA
=================================================================================*/
function SelectDomainType(installationtype)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"InstallationType\")"]);
    obj_InstallationType = parentobj.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],10)
    if(obj_InstallationType.Exists && obj_InstallationType.VisibleOnScreen)
    {
         for(i=0;i<obj_InstallationType.Items.Count;i++)
         {
           if(obj_InstallationType.Items.Item(i).OleValue==installationtype)
           {
             obj_InstallationType.ClickItem(i)
             break;
           }
         }
    }
    else
    {
      Log.Warning("Select action failed in SelectDomainType function")
      throw "Select action failed in SelectDomainType function"
    }
}

/*===============================================================================
Description: This function is to enter Database Name for new domain creation
Parameters:             
Return Value: NA
=================================================================================*/
function EnterDBName()
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"InstallationType\")"]);
    obj_DBName = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
    if(obj_DBName.Exists && obj_DBName.VisibleOnScreen)
    {
      obj_DBName.Click()
      obj_DBName.Keys(Project.Variables.dbName)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}
 
/*===============================================================================
Description: This function is to enter Sever Address for new domain creation
Parameters:             
Return Value: NA
=================================================================================*/
function EnterServerAddress()
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"InstallationType\")"]);
    obj_ServerAddress = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],10)
    if(obj_ServerAddress.Exists && obj_ServerAddress.VisibleOnScreen)
    {
      obj_ServerAddress.Click()
      obj_ServerAddress.Keys(Project.Variables.DBServer)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}  

/*===============================================================================
Description: This function is to enter User Login for new domain creation
Parameters:             
Return Value: NA
=================================================================================*/
function EnterUserLogin()
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"InstallationType\")"]);
    obj_UserLogin = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],10)
    if(obj_UserLogin.Exists && obj_UserLogin.VisibleOnScreen)
    {
      obj_UserLogin.Click()
      obj_UserLogin.Keys(Project.Variables.reportingdDbUsername)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter User Password for new domain creation
Parameters:             
Return Value: NA
=================================================================================*/
function EnterUserPassword()
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"InstallationType\")"]);
    obj_UserPassword = parentobj.FindChild(["Name"],["WPFObject(\"Password\")"],10)
    if(obj_UserPassword.Exists && obj_UserPassword.VisibleOnScreen)
    {
      obj_UserPassword.Click()
      obj_UserPassword.Keys(Project.Variables.reportingdDbPassword)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to connect to database for new domain creation
Parameters: 
          installationtype: Standalone or Inprocess or Integration            
Return Value: NA
=================================================================================*/
function ConnectDatabase(installationtype)
{
    waitforDomainCreation();
    SelectDomainType(installationtype);
    EnterDBName();
    EnterServerAddress();
    EnterUserLogin();
    EnterUserPassword();
    clickItem("WPFObject(\"Button\", \"Connect to Database\", 1)","Connect to Database");
}

/*===============================================================================
Description: This function is wait for the Domain Editor screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforDomainEditScreen()
{
  return waitForItemWithTime(btn_Savecontinue,"Save & continue",2)
}

/*===============================================================================
Description: This function is to select location for new domain
Parameters:             
  location: English (United Kingdom) / English (Australia) / English (New Zealand) / English (Ireland)
Return Value: NA
=================================================================================*/
function SelectLocation(location)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_location = parentobj.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],10)
    if(obj_location.Exists && obj_location.VisibleOnScreen)
    {
         for(i=0;i<obj_location.Items.Count;i++)
         {
             if(aqString.ToUpper(obj_location.Items.Item(i).Description.OleValue) == aqString.ToUpper(location))
             {
               obj_location.ClickItem(i)
               break;
             }
         }
    }
    else
    {
      Log.Warning("Select action failed in SelectLocation function")
      throw "Select action failed in SelectLocation function"
    }
}

/*===============================================================================
Description: This function is to select product type for new domain
Parameters:             
  productType: TeleAssess / SelfAssess etc.
Return Value: NA
=================================================================================*/
function SelectProductType(productType)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_producttype = parentobj.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 2)"],10)
    if(obj_producttype.Exists && obj_producttype.VisibleOnScreen)
    {
         for(i=0;i<obj_producttype.Items.Count;i++)
         {
             if(aqString.ToUpper(obj_producttype.Items.Item(i).Description.OleValue) == aqString.ToUpper(productType))
             {
               obj_producttype.ClickItem(i)
               break;
             }
         }
    }
    else
    {
      Log.Warning("Select action failed in SelectProductType function")
      throw "Select action failed in SelectProductType function"
    }
}

/*===============================================================================
Description: This function is to enter Domain Name for new domain creation
Parameters:   
          domainName:domain name          
Return Value: NA
=================================================================================*/
function EnterDomainName(domainName)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_DomainName = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
    if(obj_DomainName.Exists && obj_DomainName.VisibleOnScreen)
    {
      obj_DomainName.Click()
      obj_DomainName.Keys(domainName)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter admin email for new domain creation
Parameters:   
          email:admin email       
Return Value: NA
=================================================================================*/
function EnterAdminEmail(email)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_AdminEmail = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],10)
    if(obj_AdminEmail.Exists && obj_AdminEmail.VisibleOnScreen)
    {
      obj_AdminEmail.Click()
      obj_AdminEmail.Keys(email)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter UnknownGP email for new domain creation
Parameters:   
          email:UnknownGP email       
Return Value: NA
=================================================================================*/
function EnterUnknownGPEmail(email)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_UnknownGPEmail = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 4)"],10)
    if(obj_UnknownGPEmail.Exists && obj_UnknownGPEmail.VisibleOnScreen)
    {
      obj_UnknownGPEmail.Click()
      obj_UnknownGPEmail.Keys(email)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter NotFoundGP email for new domain creation
Parameters:   
          email:NotFoundGP email       
Return Value: NA
=================================================================================*/
function EnterNotFoundGPEmail(email)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_NotFoundGPEmail = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 5)"],10)
    if(obj_NotFoundGPEmail.Exists && obj_NotFoundGPEmail.VisibleOnScreen)
    {
      obj_NotFoundGPEmail.Click()
      obj_NotFoundGPEmail.Keys(email)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter license request email for new domain creation
Parameters:   
          email:request email       
Return Value: NA
=================================================================================*/
function EnterRequestEmail(email)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_RequestEmail = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 6)"],10)
    if(obj_RequestEmail.Exists && obj_RequestEmail.VisibleOnScreen)
    {
      obj_RequestEmail.Click()
      obj_RequestEmail.Keys(email)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter admin email details for new domain creation
Parameters:   
          email:admin email       
Return Value: NA
=================================================================================*/
function EnterEmail(email)
{
    EnterAdminEmail(email);
    if(ToCheckLablePresent("Unknown GP Email:"))
    {
        EnterUnknownGPEmail(email);
        EnterNotFoundGPEmail(email);
    }
    EnterRequestEmail(email);
}

/*===============================================================================
Description: This function is to enter license count for new domain creation
Parameters:   
          count:license count      
Return Value: NA
=================================================================================*/
function EnterLicenseCount(count)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
    obj_LicenseCount = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],10)
    if(obj_LicenseCount.Exists && obj_LicenseCount.VisibleOnScreen)
    {
      obj_LicenseCount.Click()
      obj_LicenseCount.Keys(count)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter Domain Setting details for new domain in Domain Editor screen
Parameters:   
           location:
           productType:
           domainName:
           email:
Return Value: NA
=================================================================================*/
function EnterDomainSetting(location, productType, domainName, email)
{
    waitforDomainEditScreen();
    SelectLocation(location);
    SelectProductType(productType);
    EnterDomainName(domainName);
    EnterEmail(email);
    EnterLicenseCount("5")
    EnterReportingDBName();
}

/*===============================================================================
Description: This function select modules for new domain in domain editor screen
Parameters:
          modulelist:list of module to be selected
Return Value:
=================================================================================*/
function SelectModule(modulelist)
{ 
  modulelistarr = modulelist.split("|")
  for(i=0;i<modulelistarr.length;i++)
  {
      parentobj = ToFindObj(["Name"],["WPFObject(\"DomainSettings\", \"\", 1)"]);
      obj_ModuleArr = parentobj.FindAllChildren(["ClrClassName","VisibleOnScreen"],["CheckBox","True"],10).toArray();
      
      for(j=0;j<obj_ModuleArr.length;j++)
      {
          if(aqString.ToUpper(modulelistarr[i]) == aqString.ToUpper(obj_ModuleArr[j].WPFControlText))
          {
              obj_ModuleArr[j].Click();
          }
      }
  }
}

/*===============================================================================
Description: This function is to enter Reporting Database Name in Reporting Settings section
Parameters:             
Return Value: NA
=================================================================================*/
function EnterReportingDBName()
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"ReportingSettings\", \"\", 1)"]);
    obj_ReportingDBName = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
    if(obj_ReportingDBName.Exists && obj_ReportingDBName.VisibleOnScreen)
    {
      obj_ReportingDBName.Click()
      obj_ReportingDBName.Keys(Project.Variables.reportingdDbName)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter username for new domain creation
Parameters:   
          email:admin email       
Return Value: NA
=================================================================================*/
function EnterUsername(email)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"UserSettings\", \"\", 1)"]);
    obj_Username = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
    if(obj_Username.Exists && obj_Username.VisibleOnScreen)
    {
      obj_Username.Click()
      obj_Username.Keys(email)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}
/*===============================================================================
Description: This function is to enter username for new domain creation
Parameters:       
Return Value: NA
=================================================================================*/
function EnterDomainPassword()
{
    setText("C0rrect","WPFObject(\"TxtPassword\")","TxtPassword","")
}

/*===============================================================================
Description: This function is to enter forename for new domain creation
Parameters:   
          forename:admin forename       
Return Value: NA
=================================================================================*/
function EnterForename(forename)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"UserSettings\", \"\", 1)"]);
    obj_Forename = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],10)
    if(obj_Forename.Exists && obj_Forename.VisibleOnScreen)
    {
      obj_Forename.Click()
      obj_Forename.Keys(forename)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is to enter surname for new domain creation
Parameters:   
          surname:admin surname       
Return Value: NA
=================================================================================*/
function EnterSurname(surname)
{
    parentobj = ToFindObj(["Name"],["WPFObject(\"UserSettings\", \"\", 1)"]);
    obj_Surname = parentobj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 4)"],10)
    if(obj_Surname.Exists && obj_Surname.VisibleOnScreen)
    {
      obj_Surname.Click()
      obj_Surname.Keys(surname)
    }
    else
    {
      Log.Warning("Set text failed")
      throw "Set text failed"
    }
}

/*===============================================================================
Description: This function is wait for the Success Message
Parameters: 
Return Value: 
=================================================================================*/
function waitforSuccessMssg()
{
  if(ToFindObjToValidate(["Name"], ["Window(\"Static\", \"Domain successfully created\", 1)"]))
  {
    Log.Message("Domain creation successfully done")
    btn_OK = ToFindObj(["Name"], ["Window(\"Button\", \"OK\", 1)"])
    btn_OK.Click();
  }
}

/*===============================================================================
Description: This function is to enter Admin User Setting details for new domain in Domain Editor screen
Parameters:   
           username:
           forename:
           surname:
Return Value: NA
=================================================================================*/
function EnterAdminSetting(username, forename, surname)
{
    EnterUsername(username);
    EnterDomainPassword();
    EnterForename(forename);
    EnterSurname(surname);
    clickItem("WPFObject(\"Button\", \"Save & continue\", 1)","Save & continue");
    delay2Sec();
    waitforSuccessMssg();
}

/*===============================================================================
Description: This function to close the DomainCreation application
Parameters: 
Return Value: 
=================================================================================*/
function closeDomainCreation()
{
  waitforDomainCreation();
  Process = GetProcess();
  Process.Terminate();
}