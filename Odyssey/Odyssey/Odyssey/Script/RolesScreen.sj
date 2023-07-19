//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT PageObjects
//USEUNIT AdminLoginScreen

/*===============================================================================
Description: This function is to select claim for a user 
Parameters: 
Return Value: 
=================================================================================*/
function ToSelectClaims(ClaimToBeSelected)
{
  if(!ToCheckLablePresent("Available Claims"))
  {
    ExpandItem("WPFObject(\"ClaimsExpander\")","Claims")   
  }
  var process = GetProcess()
  var ClaimsAvail = process.FindChild(["Name"],["WPFObject(\"ClaimAvailable\")"],100)
  var claims = ClaimsAvail.FindChild(["Name","WPFControlText"],["WPFObject(\"ListBoxItem\", \"\", *)",ClaimToBeSelected],100)
  if(claims.Exists && claims.VisibleOnScreen)
  {
    claims.Click()
  }
  else
  {
  //  ClaimsAvail.VScroll.Pos = 0;
    var maxPosition = ClaimsAvail.VScroll.Max+1;
    for (i=0;i<maxPosition;i++)
    {
      ClaimsAvail.VScroll.Pos = i;
      claims = ClaimsAvail.FindChild(["Name","WPFControlText"],["WPFObject(\"ListBoxItem\", \"\", *)",ClaimToBeSelected],100)
      if (claims.Exists && claims.VisibleOnScreen)
      {
         claims.Click()
         break
      }
   }
  } 
  var btn = process.FindChild(["Name","Enabled"],["WPFObject(\"Button\", \">\", 1)","True"],100)
  if (btn.Exists)
  {
    btn.Click()
  } 
} 

/*===============================================================================
Description: This function is wait for the User Admin screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforUserAdminscreen()
{
  return waitForItemWithTime(btn_WPFButton, "New User", 2)
}

/*===============================================================================
Description: This function need to be run on a new domain to configure it for auto regression
Parameters:  
          location:GB / IE / NZ / AUS
Return Value: 
=================================================================================*/
function InitialSetupUsersScreen(location)
{
  if(Project.Variables.Process == "STANDALONE")
  {
    LaunchApplication();
    LoginAdmin(Project.Variables.AdminUsername,Project.Variables.AdminPassword)
    waitforAdminSummaryScreen()
    clickItem(btn_UserAdmin,"User Admin")
    waitforUserAdminscreen()
    //Add Clinician Role
    clickItem(btn_WPFButton,"New User")
    clickItem(rbtn_AdvancedClinician,"Clinician")
    setText(Project.Variables.ClinicianUsername,txt_EmailTextBox,"","")
    setText("clinician",txt_ForeNameTextBox,"","")
    setText("user",txt_SurNameBox,"SurnameBox","")
    setText("Mr",txt_TitleBox,"","")
    setText(Project.Variables.ClinicianPassword,txt_Password,"Password","")
    setText("36587634",txt_ContactBox,"","")
    clickItem(btn_WPFButton,"Save Changes")
    Log.Message("New Clinician user created")
    clickItem(btn_WPFButton,"Back to Admin Summary")
    waitforAdminSummaryScreen()
    clickItem(btn_UserAdmin,"User Admin")
    waitforUserAdminscreen()
    clickItem("WPFObject(\"TextBlock\", \"clinician user\", 1)","clinician user")
    ToSelectClaims("Can proceed directly to outcome")
    ToSelectClaims("Can save the session as PDF")
    ToSelectClaims("Can View Audit")
    clickItem(btn_WPFButton,"Save Changes")
    Log.Message("All the required claims added to Clinician user")
    clickItem(btn_WPFButton,"Back to Admin Summary")
    waitforAdminSummaryScreen()       
    //Add Reception Role
    clickItem(btn_UserAdmin,"User Admin")
    waitforUserAdminscreen()
    clickItem(btn_WPFButton,"New User")
    clickItem(rbtn_reception,"Reception")
    setText(Project.Variables.ReceptionUsername,txt_EmailTextBox,"","")
    setText("reception",txt_ForeNameTextBox,"","")
    setText("user",txt_SurNameBox,"SurnameBox","")
    setText("Mrs",txt_TitleBox,"","")
    setText(Project.Variables.ReceptionPassword,txt_Password,"Password","")
    setText("36587734",txt_ContactBox,"","")
    clickItem(btn_WPFButton,"Save Changes")
    Log.Message("New Reception user created")
    clickItem(btn_WPFButton,"Back to Admin Summary")
    waitforAdminSummaryScreen()
    clickItem(btn_UserAdmin,"User Admin")
    waitforUserAdminscreen()
    clickItem("WPFObject(\"TextBlock\", \"reception user\", 1)","reception user")
    ToSelectClaims("Can view summary of previous encounters")
    ToSelectClaims("Can save the session as PDF")
    clickItem(btn_WPFButton,"Save Changes")
    Log.Message("All the required claims added to Reception user")
    clickItem(btn_WPFButton,"Back to Admin Summary")
    waitforAdminSummaryScreen()
    //Add CallHandler Role -- Not applicable for NZ and AUS
    if(location=="GB" || location=="IE")
    {    
      clickItem(btn_UserAdmin,"User Admin")
      waitforUserAdminscreen()
      clickItem(btn_WPFButton,"New User")
      clickItem(rbtn_CallHandler,"Call Handler")
      setText(Project.Variables.CallHandlerUsername,txt_EmailTextBox,"","")
      setText("callhandler",txt_ForeNameTextBox,"","")
      setText("user",txt_SurNameBox,"SurnameBox","")
      setText("Mrs",txt_TitleBox,"","")
      setText(Project.Variables.CallHandlerPassword,txt_Password,"Password","")
      setText("36587365",txt_ContactBox,"","")
      clickItem(btn_WPFButton,"Save Changes")
      Log.Message("New CallHandler user created")
      clickItem(btn_WPFButton,"Back to Admin Summary")
      waitforAdminSummaryScreen()
      clickItem(btn_UserAdmin,"User Admin")
      waitforUserAdminscreen()
      clickItem("WPFObject(\"TextBlock\", \"callhandler user\", 1)","callhandler user")
      ToSelectClaims("Can View Audit")
      clickItem(btn_WPFButton,"Save Changes")
      Log.Message("All the required claims added to CallHandler user")
      clickItem(btn_WPFButton,"Back to Admin Summary")
      waitforAdminSummaryScreen()
    }
  } 
  else if(Project.Variables.Process == "INPROCESSNEW")
  {
    Log.Message("Not applicable for InProcess setup.")
  }
}

/*===============================================================================
Description: This function is to add multiple odyssey user(designed to validate of pagination)
Parameters: 
          numofuser:number of user to be created
Return Value:
=================================================================================*/
function AddMultipleUser(numofuser)
{
    numofuser = numofuser+20;
    for(i=20;i<numofuser;i++)
    {
        clickItem(btn_WPFButton,"New User")
        clickItem(rbtn_AdvancedClinician,"Clinician")
        setText("clinicianTestAutomation"+i+"@advanced.engb",txt_EmailTextBox,"","")
        setText("Automation"+i,txt_ForeNameTextBox,"","")
        setText("Test"+i,txt_SurNameBox,"SurnameBox","")
        setText("Testing",txt_TitleBox,"","")
        setText("12345"+i,txt_ContactBox,"","")
        setText("C0rrect",txt_Password,"Password","")
        clickItem(btn_WPFButton,"Save Changes")      
    }
    delayExecution("1")
}

