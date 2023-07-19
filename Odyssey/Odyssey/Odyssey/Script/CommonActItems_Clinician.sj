﻿//USEUNIT CommonFunctions
//USEUNIT PageObjects

/*===============================================================================
Description: This function to logout app
Parameters: 
Return Value: 
=================================================================================*/
function LogoutApp()
{
  clickItem(btn_Logout,"Logout")
}

/*===============================================================================
Description: This function to Lock app
Parameters: 
Return Value: 
=================================================================================*/
function LockApp()
{
  clickItem(btn_WPFButton,"Lock")
}

/*===============================================================================
Description: This function to select patient gender
Parameters: 
            gender:Male or female
Return Value: 
=================================================================================*/
function selectGender(gender)
{
  Process = GetProcess()
  var Gender = Process.FindChild(["Name"],["WPFObject(\"GenderControl\")"],100)
  if(!Gender.Exists)
  {
    var Gender = Process.FindChild(["Name"],["WPFObject(\"ContentControl\", \"\", 1)"],100)
  }
  if (Gender.Exists)
  {
    Gender.Click()
    var obj = Process.FindChild(["ClrClassName","Content"],["ComboBoxItem",gender],100)
    if(obj.Exists)
    {
      obj.Click()
    }
  }
}

/*===============================================================================
Description: This function to click Undo changes button in addresses
Parameters: 
Return Value: true/false
=================================================================================*/
function clickUndoCHangesInAddress()
{
    var process = GetProcess()
    var AddressEditorControl=  Process.FindChild(["ClrClassName","Name"],["AddressEditor",btn_AddreessEditControl],100);
    var btn = AddressEditorControl.FindChild(["WPFControlText"],["Undo changes"],100);
    btn.click()
}
/*===============================================================================
Description: This function to check the allergies in the list box
Parameters: 
          BoxName:Available or Selected
Return Value: true/false
=================================================================================*/
function chkAllergies(BoxName)
{
    var process = GetProcess()
    var lbl_Available = process.FindChild(["Name"],["WPFObject(\"Label\", \"Available\", 1)"],100)
    var parentObj = lbl_Available.parent
    if (aqString.ToUpper(BoxName)=="AVAILABLE")
    {
       var obj = parentObj.FindChild(["Name"],["WPFObject(\"ListBox\", \"\", 1)"],100);
    }
    else
    {
       var obj = parentObj.FindChild(["Name"],["WPFObject(\"ListBox\", \"\", 3)"],100);
     
    } 
  
    if(obj.Exists)
    {
       var item = obj.FindChild(["Name"],["WPFObject(\"TextBlock\", \"animal fur\", 1)"],10);
       if (item.Exists)
       {
          item.Click()
          return true
       }
       else
       {
          return false
       }
    } 
} 
/*===============================================================================
Description: This function to enter details for a new patient in demographic screen.
Parameters:
          age:age of patient
          gender:gender of patient
Return Value:
=================================================================================*/ 
function enterNewPatientDet(age,gender)
{
    setText("Test",txt_FirstName,"firstName","")
    setText(age,txt_ApproximateAge,"ApproximateAge","")
    setText(nhsNumber,txt_NHSNumber,"patientNumber","")
    selectGender(gender)
  //  clickItem(icon_AddAddress,"")
    selectComboBoxByIndex(cmb_Description,"Work")
    setText("No 1 Narrow street",txt_Address1,"address1","")
    if(locationType=="AUS")
    {
        setText("2001",txt_PostCode,"postcode","")
        clickItem(btn_FindAddresses,"Find Addresses")  
    }    
    else
    {
        setText("New Town",txt_town,"town","")
        setText("35001",txt_PostCode,"postcode","")        
    }
  //  clickItem(icon_AddContact,"")
    selectComboBoxItem(cmb_ContactTypes,"Home tel.")
    setText("1298654",txt_Contact,"contact","")
}
/*===============================================================================
Description: This function to enter details for a new patient in demographic screen.
Parameters:
          age:age of patient
          gender:gender of patient
          firstname:firstname
          lastname:lastname
Return Value:
=================================================================================*/ 
function enterNewPatDetPerfModule(age,gender,firstname,lastname)
{
  var firstname1 =  aqString.Concat(firstNamePerf,firstname)
  var lastname1 =  aqString.Concat(lastNamePerf,lastname)
  
  setText(firstname1,txt_FirstName,"firstName","")
  setText(lastname1,txt_Surname,"surname","")
  setText(age,txt_ApproximateAge,"ApproximateAge","")
 // setText(nhsNumber,txt_NHSNumber,"patientNumber","")
  selectGender(gender)
//  clickItem(icon_AddContact,"")
  selectComboBoxItem(cmb_ContactTypes,"Other")
  setText("1298654",txt_Contact,"contact","")
//  clickItem(icon_AddAddress,"")
  selectComboBoxByIndex(cmb_Description,"Work")
  setText("No 1 Narrow street",txt_Address1,"address1","")
  setText("New Town",txt_town,"town","")
  setText("35001",txt_PostCode,"postcode","")
}
/*===============================================================================
Description: This function is to check the rule of three warning icon and its tooltip
Parameters: 
Return Value: 
=================================================================================*/
function ToChkRuleofThree()
{
  return ToFindObjToValidate(["Name"],[icon_WarningIcon])
}

/*===============================================================================
Description: This function to reset IIS pause for few seconds
Parameters: 
Return Value: 
=================================================================================*/
function resetIISViaShellCommand()
{
    WshShell.Run("powershell -command iisreset /noforce");
//    WshShell.Run("powershell -command Import-Module WebAdministration");
//    WshShell.Run("powershell -command Restart-WebAppPool \"Odyssey_HTTPS\"");
    delayExecution("30")
}