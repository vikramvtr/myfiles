//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT PageObjects
//USEUNIT ScreensOf3_12

/*===============================================================================
Description: This function is wait for the Admin Summary screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforAdminSummaryScreen()
{
  if(!ToCheckLablePresent("Admin Summary"))
  {
      ToScrollNewTestHarness("UP");
  }
  return waitForItemWithTime(lbl_AdminSummary,"Admin Summary",2 )
}

/*===============================================================================
Description: This function is to verify the labels
Parameters:  System Admin reports or Total Contacts or Outcome Summary or Logged on users
Return Value: true/false
=================================================================================*/
function ToVerifyLabels(labelName)
{
  var process = GetProcess()
  var AdminSumm = process.FindChild(["Name"],["WPFObject(\"AdminSummary\")"],100)
  for (i=1;i<5;i++)
  {
    var panel = AdminSumm.FindChild(["Name"],["WPFObject(\"Border\", \"\", "+i+")"],100)
    var ContentControl = panel.FindChild(["Name"],["WPFObject(\"ContentControl\", \"\", 1)"],100)
    var label = ContentControl.Tag.OleValue
    if (label == labelName)
    {
      Log.Message("True")
      return true
    } 
  }  
} 

/*===============================================================================
Description: This function is to click the buttons in summary screen
Parameters:  BtnNm:URGENCYADMIN/USERADMIN/CONFIGEDITORS
Return Value:
=================================================================================*/ 
function ClickBtnsInAdminSummaryScreen(BtnNm)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"TextBlock\", \"Admin Summary\", 1)"],100)
  var obj1 = obj.parent
  var obj2 = obj1.FindChild(["Name"],["WPFObject(\"StackPanel\", \"\", 2)"],100)
  var obj3 = obj2.FindChild(["Name"],["WPFObject(\"ContentControl\", \"\", 1)"],100)
  var H = obj3.ActualHeight
  var W = obj3.ActualWidth
  var h1 = H/2
  var w1 = W/2
  
  switch (BtnNm)
  {
    case "URGENCYADMIN":
      obj3.click(w1,h1)
    break;
  
    case "USERADMIN":
      obj3.click(w1-150,h1)
    break;
      
    case "CONFIGEDITORS":
      obj3.click(w1+150,h1)
    break;
  } 
} 

/*===============================================================================
Description: This function is to click the buttons in summary screen for InProcess
Parameters:  BtnNm:URGENCYADMIN/CONFIGEDITORS
Return Value:
=================================================================================*/ 
function ClickBtnsInAdminSummaryScreenForInProcess(BtnNm)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"TextBlock\", \"Admin Summary\", 1)"],100)
  var obj1 = obj.parent
  var obj2 = obj1.FindChild(["Name"],["WPFObject(\"StackPanel\", \"\", 2)"],100)
  var obj3 = obj2.FindChild(["Name"],["WPFObject(\"ContentControl\", \"\", 1)"],100)
  var H = obj3.ActualHeight
  var W = obj3.ActualWidth
  var h1 = H/2
  var w1 = W/2
  
  switch (BtnNm)
  {
    case "URGENCYADMIN":
      obj3.click(w1-50,h1)
      break;
    case "CONFIGEDITORS":
      obj3.click(w1+50,h1)
      break;
  }
} 