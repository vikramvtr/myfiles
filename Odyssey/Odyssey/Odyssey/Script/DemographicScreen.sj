//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT DefaultScreen

/*===============================================================================
Description: This function is to set text in GP Name
Parameters: 
          name:GP name
Return Value: 
=================================================================================*/
function SetGPName(name)
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"GP\")"],100)
  var GPNameTxtBox = obj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],100)
  if ((GPNameTxtBox.Exists)&&(GPNameTxtBox.VisibleOnScreen))
  {
      setText(name,"","",GPNameTxtBox)
  } 
} 

/*===============================================================================
Description: This function is to validate Current GP
Parameters: 
          name:current GP name
Return Value: 
=================================================================================*/
function ToChkCurrentGP(name)
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"gpEditorControl\")"],100)
  if(!obj.Exists)
  {
    obj = process.FindChild(["Name"],["WPFObject(\"GPEditor\", \"\", 1)"],100)
  }
  var CurrentGPObj = obj.FindChild(["Name"],["WPFObject(\"ContentPresenter\", \"\", 1)"],100)
  if ((CurrentGPObj.Exists)&&(CurrentGPObj.VisibleOnScreen))
  {
    var CurrGP = CurrentGPObj.DataContext.GPNameForAudit.OleValue
//    if (aqString.Trim(CurrGP)=="Patrick Jane (Medi Claim)")
    if (aqString.Trim(CurrGP)==name)
    {
      return true
    } 
    
  } 
} 
/*===============================================================================
Description: This function to validate the patient age 
Parameters: 
Return Value: true/false
=================================================================================*/
function ToValidatePatientAge(Value)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"ApproximateAge\")"],100)
  obj.click()
  if (obj.Exists)
  {
    var txt = obj.Text.OleValue
    if (txt==Value)
    {
      return true
    } 
    return false
  }
}
/*===============================================================================
Description: This function to enter note under emergency protocol screen
Parameters: 
            noteText:text to be entered
Return Value:
=================================================================================*/
function EnterNoteEmerProtocolSCreen(noteText)
{
  var noteLblObj = ToFindObj(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \"Notes\", 1)","True"])
  var parentObj = noteLblObj.parent
  var noteTxtObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)","True"],10)
  if(noteTxtObj!=undefined)
  {
    setText(noteText,"","",noteTxtObj)
  }
}
/*===============================================================================
Description: This function to check for any field with 'Validation_HasError' set to True for invalid/missing value
Parameters: 
            fieldName:Postcode/Firstname/patientNumber
Return Value:
=================================================================================*/
function ToCheckErrorBorder(fieldName)
{
  var process = GetProcess()
  var obj;
  switch(fieldName)
  {
    case "Postcode" : 
      obj = process.Findchild(["Name","VisibleOnScreen"],[txt_PostCode,"True"],100)
      break;
    case "patientNumber" : 
      obj = process.Findchild(["Name","VisibleOnScreen"],[txt_NHSNumber,"True"],100)
      break;
    case "Firstname" : 
      obj = process.Findchild(["Name","VisibleOnScreen"],[txt_FirstName,"True"],100)
      break;     
  }
  
  if(obj.Exists)
  {
      if(obj.Validation_HasError)
      {
          Log.Message("Error border is shown for "+fieldName);
          return true;
      }
      else
      {
          Log.Message("Error border is not shown for "+fieldName);
          return false;
      }
  }
  else
  {
      Log.Warning("ToCheckErrorBorder failed for "+fieldName)
      throw "ToCheckErrorBorder failed"
  }
}

/*===============================================================================
Description: This function is wait for the Demographic screen to appear
Parameters: 
Return Value: 
=================================================================================*/
function waitforDemogInfoScreen()
{
  return waitForItemWithTime(lbl_BasicDemographicInfo,"Basic Demographic Information",2 )
}

/*===============================================================================
Description: This function to change the aptient age for multiple times
Parameters: 
Return Value: 
=================================================================================*/
function ToChangePatientAge()
{
  for(i=1;i<20;i++)
  {
      clickItem(btn_WPFButton,"Edit")
      waitforDemogInfoScreen()
      clickItem("WPFObject(\"TextBlock\", \"Home tel. - 1298654*\", 1)","Home tel. - 1298654*")
      setText("1298654"+i,txt_Contact,"contact","")
      clickItem(btn_WPFButton,"Save and go back")
      waitfordefaultScreen()
      setText("Automation",txt_WaterMarkedTtextBox,"","")
      clickItem(btn_WPFButton,"_Search")
  }
} 

/*===============================================================================
Description: This function is to select GP from search result
Parameters: 
Return Value: 
=================================================================================*/
function SelectGP()
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"GP\")"],100)
  var GPDetails= obj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 1)"],100)
  if ((GPDetails.Exists)&&(GPDetails.VisibleOnScreen))
  {
      GPDetails.Click();
  } 
} 