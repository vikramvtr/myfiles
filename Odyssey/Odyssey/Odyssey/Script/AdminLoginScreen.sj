//USEUNIT AdminSummaryScreen
//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT LoginScreen
//USEUNIT PageObjects


/*===============================================================================
Description: This function is click sign in button and to wait for loading default screen
Parameters: 
Return Value: 
=================================================================================*/
function clickSignInButtonForAdminUser()
{
  clickItem(btn_Login,"Login")
}

/*===============================================================================
Description: This function to login the application
Parameters: 
  UserName: username 
  Password: Password
            
Return Value: 
=================================================================================*/
function LoginAdmin(UserName,Password)
{
  EnterLogInID(UserName)
  EnterPassword(Password)
  clickSignInButtonForAdminUser()
}

