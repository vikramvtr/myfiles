//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT DBFunctions
//USEUNIT ScreensOf3_12

//Common functions
/*===============================================================================
Description: This function is to click the win forms item
Parameters:      
             name:name property value
             WinFormsControlName:WinFormsControlName property value
Return Value: 
=================================================================================*/
function clickWinformsItem(name,WinFormsControlName)
{
    Process = GetProcess()
    if(Project.Variables.Process == "INPROCESS")
    {
      var clickingItem = Process.FindChild(["Name","WinFormsControlName","VisibleOnScreen"], [name, WinFormsControlName,true], 100)
    
      if(clickingItem.Exists && clickingItem.Enabled)
      {
        clickingItem.Click()
        return true
      }
      else 
      {

        Log.Warning(WinFormsControlName +"Click action failed in clickItem function")
        throw "Click action failed in clickItem function"
      }
    }
    else
    {
      switch(name)
      {
        case chkBx_IncPatBan:
          ToCheckAndUncheck(chkBx_IncludePatientBanner,"CHECK")
          break;
        case btn_AbandonAssessment:
          if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_AbandonAssessmentNew,"Abandon Assessment"]))
          {
            ToScrollNewTestHarness("DOWN");
            delayExecution("1");
          }
          clickItem(btn_AbandonAssessmentNew,"Abandon Assessment")
          break;
        case btn_DropControlBtn:
          if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_DropControl,"Drop Control"]))
          {
            ToScrollNewTestHarness("DOWN");
            delayExecution("1");
          }
          clickItem(btn_DropControl,"Drop Control")
          break;
      }
    }
}
   
/*===============================================================================
Description: This function is to validate check box
Parameters:      
             name:name property value
             WinFormsControlName:WinFormsControlName property value
Return Value: 
=================================================================================*/
function ToValChkBox(name,WinFormsControlName)
{
  Process = GetProcess()
  var ChkBoxItem = Process.FindChild(["Name","WinFormsControlName","VisibleOnScreen"], [name, WinFormsControlName,true], 100)
  if (ChkBoxItem.Checked)
  {
    return true
  } 
  return false
} 

/*===============================================================================
Description: This function is to get text from text box
Parameters:             
             name: property value of name 
Return Value: 
=================================================================================*/
function getTextFromWinformsTextBox(name)
{  
    var obj
    if(Project.Variables.Process == "INPROCESS")
    {
      obj = ToFindObj(["Name"],[name])
    }
    else
    {
      switch(name)
      {
        case txt_SessionId:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_SessionIdNew,"True"])
          break;
        case txt_AssessmentStateText:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_AssessmentStateNew,"True"])
          break;
        case txt_PresentingComplaint:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_PresentingComplaintNew,"True"])
          break;
        case txt_Recommendation:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_RecommendationNew,"True"])
          break;
        case txt_OutcomeText:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_OutcomeTextNew,"True"])
          break;
        case txt_SelectedUrgencyCode:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_SelectedUrgencyCodeNew,"True"])
          break;
        case txt_SelectedUrgency:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_SelectedUrgencyNew,"True"])
          break;
        case txt_PriorityReason:
          obj = ToFindObj(["Name","VisibleOnScreen"],[txt_PriorityReasonNew,"True"])
          break;     
      }
    }
    return obj.Text.OleValue
}

/*===============================================================================
Description: This function is to check combo box has been selected
Parameters:             
             name: property value of name 
Return Value: 
=================================================================================*/
function TochkWinFormsComboboxSelected(name)
{

  Process = GetProcess() 

  var obj = Process.FindChild(["Name"],[name],100)
  return obj.wText
 
}

/*===============================================================================
Description: This function to select combo box item
Parameters: 
           comboBoxName:value of name property
           itemName:item name needs to validate
Return Value: true/false
=================================================================================*/
function selectWinFormsCmbBox(comboBoxName,itemName)
{
  if(Project.Variables.Process == "INPROCESS")
  {
    var Process = GetProcess()
    var comboBoxObj=  Process.FindChild(["ClrClassName","Name"],["ComboBox",comboBoxName],50);
    if(comboBoxObj.Exists)
     {
        comboBoxObj.ClickItem(itemName)
     }    
  }
  else
  {
    if(comboBoxName==cmb_Role)
    {
       var roleLabelObj = ToFindObj(["Name","VisibleOnScreen"],["WPFObject(\"Label\", \"Role\", 3)","True"])
       var parentObj = roleLabelObj.parent    
       var roleCmbObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"ComboBox\", \"\", 1)","True"], 10); 
       if(roleCmbObj!==undefined)
       {
          for(i=0;i<roleCmbObj.Items.Count;i++)
          {
            if(aqString.ToUpper(roleCmbObj.Items.Item(i).Name.OleValue) == aqString.ToUpper(itemName))
            {
              roleCmbObj.ClickItem(i)
              break;
            }
          }
        }
      }
  }
}

/*===============================================================================
Description: This function is to check button enable or disable
Parameters:         
             name: property value of name     
             WinFormsControlName: property value of WinFormsControlName 
Return Value: 
=================================================================================*/
function ToCheckWinFormsButtonEnaborDisab(Name,WinFormsControlName)
{
    Process = GetProcess()

    var btn= Process.FindChild(["Name", "WinFormsControlName"], [Name, WinFormsControlName], 100)
   if(btn.Exists && btn.Enabled)
   {
      Log.Message(WinFormsControlName+" Button is enable")
      return true
   }
    else 
    {
      Log.Message(WinFormsControlName+" Button is disable")
      return false
          
    }
}

/*===============================================================================
Description: This function is to check object enabled or disabled
Parameters:      
             name:name property value
             WPFControlName:WPFControlName property value
Return Value: 
=================================================================================*/
function ToCheckWinFormsObjEnableorDisable(name,WinFormsControlName)
{
    
   var obj= Process.FindChild(["Name", "WinFormsControlName"], [name, WinFormsControlName], 100)
    
   if(obj.Exists && obj.Enabled && obj.VisibleOnScreen)
   {
      Log.Message(WinFormsControlName+" object is enable")
      return true
   }
    else 
    {
      Log.Message(WinFormsControlName+" object is disable")
      return false
          
    }
}

/*===============================================================================
Description: This function to select combo box item
Parameters: 
           comboBoxName:Value of name property
Return Value: true/false
=================================================================================*/
function ToValDataExistInCmbBox(comboBoxName)
{
  var Process = GetProcess()
  var comboBoxObj=  Process.FindChild(["ClrClassName","Name"],["ComboBox",comboBoxName],50);
  if(comboBoxObj.Exists)
   {
      var count = comboBoxObj.wItemCount
      if (count<=0)
      {
        return false
      } 
     return true  
   }
}


//Functions specific to Test cases
/*===============================================================================
Description: This function to validate comboBox Data in the alphabatical order
Parameters: 
Return Value: true/false
=================================================================================*/
function ToValcmbData()
{
  var data1 = TochkWinFormsComboboxSelected(cmb_PresCompl)
  if (aqString.GetChar(data1,0) == "A")
  {
    return true
  } 
  else
  {
    return false
  } 
} 

/*===============================================================================
Description: This function to set data in the test harness
Parameters: 
            Item: Item
            val: 
Return Value: true/false
=================================================================================*/
function setDataInTestHarness(Item,Val)
{
  if(Project.Variables.Process == "INPROCESS")
  {
    switch (Item)
    {
      case "FirstName":
       var firstName = ToFindObj(["Name"],[txt_PatFirstName])
       setText(Val,"","",firstName)
      break;
  
      case "LastName":
       var LastName = ToFindObj(["Name"],[txt_PatLastName])
       setText(Val,"","",LastName)
      break;

      case "DOBType":
       selectDOBTypeInProcess(type);
       break;      
          
      case "DateOfBirth":
       if(Project.Variables.ServerType == "remote")
       {
         Val = ChangeDateFormat(Val)
       }
       var DOB = ToFindObj(["Name"],[cmb_DatePicker])
       DOB.wDate = Val
      break;
      
      case "NumOfWeeks":
       var Weeks = ToFindObj(["Name"],[txt_NumOfWeeks])
       setText(Val,"","",Weeks)
       break;
    
      case "Gender":
       var Gender = ToFindObj(["Name"],[cmb_Gender])
       Gender.ClickItem(Val)
      break;
    
      case "CallBackNumbr":
       var CBN = ToFindObj(["Name"],[txt_CallbackNumber])
       setText(Val,"","",CBN)
      break;
    
      case "Reference":
       var Ref = ToFindObj(["Name"],[btn_RefG])
       Ref.Click()
      break;
    
      case "Start":
       var Start = ToFindObj(["Name"],[btn_Start])
       Start.Click()
      break
    
      case "SessionID":
       var SessionID = ToFindObj(["Name"],[txt_SessionIdentifier])
       setText(sessionId,"","",SessionID)
      break
    }
  }
   else
   {
     setDataInNewTestHarness(Item,Val)
   }
} 
/*===============================================================================
Description: This function is to wait for the object with the defined time
Parameters:             
             name: name property value
             WinFormsControlName: WinFormsControlName property value 
             minutes: Minutes to wait for the object
Return Value: 
=================================================================================*/
function waitForItemWithTimeForWinForms(name, WinFormsControlName, minutes) {

    var d = new Date();
    var startTime = d.getTime();
    MilSeconds=minutes*60000

    do {
        var d = new Date();
        var endTime = d.getTime();
        Process = GetProcess() 
        var currentItem = Process.FindChild(["Name", "WinFormsControlName"], [name, WinFormsControlName], 100);
        if ((currentItem.Exists)&&(currentItem.Enabled)&&(currentItem.VisibleOnScreen)) {
            break;
        }

    } while ((endTime - startTime) <= MilSeconds)

    if (currentItem.Exists) {

        if (currentItem.VisibleOnScreen) {
            Log.Message(WinFormsControlName+" Object is found...Exiting waitForItem")
            return true;
        }
        else {

            Log.Error(WinFormsControlName+" Object not visible on screen...Exiting waitForItem")
        }
    }
    Log.Error("Object not found...Exiting waitForItem")
}

/*===============================================================================
Description: This function is wait for the XML Screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforXMLScreen()
{
  if(Project.Variables.Process == "INPROCESSNEW")
  {
  
    //return waitForItemWithTime("WPFObject(\"Label\", \"Session Id\", *)","Session Id",3)
    return waitForItemWithTime(lbl_AssessmentState,"Assessment State",3)    
  }
  else
  {
    return waitForItemWithTimeForWinForms("WinFormsObject(\"sessionIdLabel\")","sessionIdLabel",3)
  }
}

/*===============================================================================
Description: This function is to get session Id
Parameters:             
Return Value: 
=================================================================================*/
function getSessionId()
{
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    sessionId = getTextFromWinformsTextBox(txt_SessionId);
  }
  else
  {
    var obj = ToFindObj(["Name"],[txt_SessionId])
    sessionId = obj.Text.OleValue    
  }

 
}

/*===============================================================================
Description: This function is to get session Id
Parameters:             
Return Value: 
=================================================================================*/
function CompareSessionID()
{
  var sessionId1;
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    sessionId1 = getSessionId()
  }
  else
  {
    var obj = ToFindObj(["Name"],[txt_SessionId])
    sessionId1 = obj.Text.OleValue    
  }
  if (sessionId==sessionId1)
  {
    return true
  } 
  else
  {
    return false
  } 
 
}

/*===============================================================================
Description: This function to check and uncheck the checkbox
Parameters: 
          Name:Name property of the object
Return Value: true/false
=================================================================================*/ 
function ToValCheckAndUncheck(Name)
{
  Process = GetProcess()
  if(Project.Variables.Process == "INPROCESS")
  {  
    var obj = Process.FindChild(["Name"],[Name],100)
    if(obj.Exists)
    {
      if (obj.Checked)
      {
       return true
      }
      else
      {
        return false
      } 
    }
  }
  else
  {
    if(Name==chkBx_IncPatBan)
    {
      return ToValCheckBoxStatus(chkBx_IncludePatientBanner,"CHECKED");
    }
  }
} 

/*===============================================================================
Description: This function to validate patient banner visible
Parameters: 
Return Value: true/false
=================================================================================*/ 
function ToValPatientBannerVisible()
{
  return ToFindObjToValidate(["Name"],["WPFObject(\"PatientBanner\")"])
} 
/*===============================================================================
Description: This function to validate abandon messageclose
Parameters: 
Return Value: true/false
=================================================================================*/ 
function ToValAdaondonMsg()
{
  var UserName = getEnvVariable("Username")
  var obj = ToFindObj(["Name","VisibleOnScreen"],["WPFObject(\"AssessmentAbandoned\", \"\", 1)","True"])
  var msgObj = obj.FindChild(["Name"],["WPFObject(\"TextBlock\", \"The session has been abandoned on * at *  by "+UserName+" * because Abandon\", 1)"],100)
  if (msgObj.VisibleOnScreen)
  {
    return true
  } 
  else
  {
    return false
  } 
} 
/*===============================================================================
Description: This function to validate the description of audit record created 
Parameters:
            auditSummary:Summary of Audit record
            auditDescription:Description of Audit record
Return Value: true/false
=================================================================================*/ 
function ToValAuditDescription(auditSummary,auditDescription)
{
  var dbRecord
  dbRecord = GetLastEntryFromSession()
  var sessionID=dbRecord[0][0]
  sessionID = aqString.Replace(aqString.Replace(sessionID,"{",""),"}","")
  
  var  dbRecord1=GetLastEntryFromAudit(sessionID)
//  Log.Message(dbRecord1.length)
  if(dbRecord1.length>0)
  {
    auditSummary = aqString.ToUpper(aqString.Trim(auditSummary))
    auditDescription = aqString.ToUpper(aqString.Trim(auditDescription))
    
    if(aqString.ToUpper(aqString.Trim(dbRecord1[0][2]))==auditSummary && aqString.ToUpper(aqString.Trim(dbRecord1[0][3]))==auditDescription)
    {
      return true
    }
    else
    {
      return false
    }
  }
  else
  {
      Log.Warning("Audit record is not created")
      throw "Audit record is not created"    
  }
} 

/*===============================================================================
Description: This function to enter demographic details in the test harness
Parameters: 
            dob:date of birth(MM/DD/YYYY)
            gender:Male/Female
Return Value:
=================================================================================*/
function entDemographicsDetTestHarness(dob,gender)
{
  setDataInTestHarness("FirstName","PatientFirstName")
  setDataInTestHarness("LastName","PatientLastName")
  setDataInTestHarness("DateOfBirth",dob)
  setDataInTestHarness("Gender",gender)
  setDataInTestHarness("CallBackNumbr","87912345")
  if(Project.Variables.Process == "INPROCESSNEW" && !ToCheckLablePresent("Reference"))
  {
      ToScrollNewTestHarness("DOWN");
  }
  setDataInTestHarness("Reference","")
  setDataInTestHarness("Start","")
}
/*===============================================================================
Description: This function to enter demographic details in the new test harness
Parameters: 
            dob:date of birth(MM/DD/YYYY)
            gender:Male/Female
Return Value:
=================================================================================*/
function entDemogDetNewTestHarness(dob,gender)
{
  setDataInTestHarness("FirstName","PatientFirstName")
  setDataInTestHarness("LastName","PatientLastName")
  setDataInTestHarness("DateOfBirth",dob)
  setDataInTestHarness("Gender",gender)
  setDataInTestHarness("CallBackNumbr","87912345")
  setDataInTestHarness("Reference","")
}
/*===============================================================================
Description: This function to set data in the new test harness
Parameters: 
            Item: Item
            val: entered value
Return Value: true/false
=================================================================================*/
function setDataInNewTestHarness(Item,Val)
{
    switch (Item)
    {
      case "FirstName":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var firstName = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
       setText(Val,"","",firstName)
       break;
      case "LastName":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var LastName = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 2)","True"], 10);
       setText(Val,"","",LastName)
       break;
      case "DOBType":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var cmb_DOB = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"ComboBox\", \"\", 1)","True"], 10);
       cmb_DOB.ClickItem(Val)
       break;
      case "DateOfBirth":
       if(Project.Variables.ServerType == "remote")
       {
         Val = ChangeDateFormat(Val)
       }
       var DOB = ToFindObj(["Name","VisibleOnScreen"],[txt_DOB1,"True"])
       DOB.Keys(Val)
       break;
      case "NumOfWeeks":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var Weeks = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 3)","True"], 10);
       setText(Val,"","",Weeks)
       break;
      case "Gender":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var Gender = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"ComboBox\", \"\", 2)","True"], 10);
       Gender.ClickItem(Val)
       break;
      case "CallBackNumbr":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var CBN = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 4)","True"], 10);
       setText(Val,"","",CBN)
       break;
      case "NHSNumber":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var NHS = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 5)","True"], 10);
       setText(Val,"","",NHS)
       break;
      case "Reference":
       var firstNameLblObj = ToFindObj(["Name","VisibleOnScreen"],[txt_FirstName1,"True"])
       var parentObj = firstNameLblObj.parent
       var Ref = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 6)","True"], 10);
       if(Val=="")
       {
         Val = RandomNumberGen("2222","9999")+"Automation"
       }
       setText(Val,"","",Ref)
       break;
      case "Start":
       var isScrolled=false;
       if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_StartAssessment,"Start Assessment"]))
       {
         ToScrollNewTestHarness("DOWN");
         isScrolled=true;
         delayExecution("1");
       }
       clickItem(btn_StartAssessment,"Start Assessment")
       if(isScrolled==true)
       {
         ToScrollNewTestHarness("UP");
       }
       break;
      case "SessionID":
       ToScrollNewTestHarness("DOWN");
       var startBtnObj = ToFindObj(["Name","VisibleOnScreen"],[btn_StartAssessment,"True"])
       var parentObj = startBtnObj.parent.parent  
       var sessionIDObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
       setText(sessionId,"","",sessionIDObj)
       break;
    }
}  
/*===============================================================================
Description: This function to get data from the new test harness
Parameters: 
            Item: Item
Return Value: val
=================================================================================*/
function getDetFromNewTestHarness(Item)
{
  switch (Item)
  {  
    case "SERVICEURL":
      var serviceURLLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_ServiceURL,"True"])
      var parentObj = serviceURLLblObj.parent
      var serviceURLObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
      return serviceURLObj.wText
      break;
    case "USERNAME":
      var domainLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Domain,"True"])
      var parentObj = domainLblObj.parent
      var usernameObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
      return usernameObj.wText
      break;     
    case "DOMAIN":
      var domainLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Domain,"True"])
      var parentObj = domainLblObj.parent
      var domainObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 2)","True"], 10);
      return domainObj.wText
      break;      
    case "ROLE":
      var domainLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Domain,"True"])
      var parentObj = domainLblObj.parent
      var roleCmbObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"ComboBox\", \"\", 1)","True"], 10);
      return roleCmbObj.wText
      break; 
    case "PRODUCT":
      var productLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Product,"True"])
      var parentObj = productLblObj.parent
      var productObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
      return productObj.wText
      break;   
    case "PRODUCTTYPE":
      var productLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Product,"True"])
      var parentObj = productLblObj.parent
      var productTypeObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 2)","True"], 10);
      return productTypeObj.wText
      break;
    case "CULTURE":
      var productLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Product,"True"])
      var parentObj = productLblObj.parent
      var cultureObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 3)","True"], 10);
      return cultureObj.wText
      break;
    case "LOCATION":
      var productLblObj = ToFindObj(["Name","VisibleOnScreen"],[lbl_Product,"True"])
      var parentObj = productLblObj.parent
      var locationObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 4)","True"], 10);
      return locationObj.wText
      break; 
  }
}
/*===============================================================================
Description: This function is to generate random number and return
Parameters:
          MaxNumber:
          MinNumber:
Return Value: 
=================================================================================*/
function RandomNumberGen(MaxNumber,MinNumber)
{
  var number = Math.floor(Math.random() * (MaxNumber - MinNumber + 1)) + MinNumber;
  return Math.abs(number);
}
/*===============================================================================
Description: This function is to add Allergy under New TestHarness
Parameters:
          allergyList:
          dateList:
          snomedList:
Return Value: 
=================================================================================*/
function addAllergy(allergyList,dateList,snomedList)
{
  ToScrollNewTestHarness("DOWN");
  var allergyArr = allergyList.split("|")
  var dateArr = dateList.split("|")
  var snomedArr = snomedList.split("|")
  var count = allergyArr.length
  
  var tabAllergiesObj = ToFindObj(["Name", "VisibleOnScreen"], ["WPFObject(\"TextBlock\", \"Allergies\", 1)","True"])
  if(tabAllergiesObj.Exists)
  {
    var obj1 = tabAllergiesObj.parent.parent
    obj1.Click();
    
    var updatedOnObj = ToFindObj(["Name", "VisibleOnScreen"], ["WPFObject(\"Label\", \"Updated On\", 2)","True"])
    if(updatedOnObj.Exists)
    {
      var parentObj = updatedOnObj.parent
      var txtDescriptionObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
      var txtSnomedObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 2)","True"], 10);
      var dateUpdatedOnObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"txtID\")","True"], 10);
      var obj = parentObj.parent
      var btnAddAllergyObj = obj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"Button\", \"\", 1)","True"], 10);
    
      for(counter=0;counter<count;counter++)
      {
        setText(allergyArr[counter],"","",txtDescriptionObj)
        if(Project.Variables.ServerType == "remote")
        {
          dateArr[counter] = ChangeDateFormat(dateArr[counter])
        }        
        dateUpdatedOnObj.Keys(dateArr[counter])
        setText(snomedArr[counter],"","",txtSnomedObj)
        btnAddAllergyObj.Click();      
      }
    }  
  }
}
/*===============================================================================
Description: This function is to add Allergy under New TestHarness
Parameters:
          medicationsList:
          dateList:
          snomedList:
Return Value: 
=================================================================================*/
function addMedications(medicationsList,dateList,snomedList)
{
  ToScrollNewTestHarness("DOWN");
  var medicationsArr = medicationsList.split("|")
  var dateArr = dateList.split("|")
  var snomedArr = snomedList.split("|")
  var count = medicationsArr.length
  
  var tabMedicationsObj = ToFindObj(["Name", "VisibleOnScreen"], ["WPFObject(\"TextBlock\", \"Medications\", 1)","True"])
  if(tabMedicationsObj.Exists)
  {
    var obj1 = tabMedicationsObj.parent.parent
    obj1.Click();
    
    var updatedOnObj = ToFindObj(["Name", "VisibleOnScreen"], ["WPFObject(\"Label\", \"Updated On\", 2)","True"])
    if(updatedOnObj.Exists)
    {
      var parentObj = updatedOnObj.parent
      var txtDescriptionObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
      var txtSnomedObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 2)","True"], 10);
      var dateUpdatedOnObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"DatePicker\", \"\", 1)","True"], 10);
      var obj = parentObj.parent
      var btnAddMedicationObj = obj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"Button\", \"\", 1)","True"], 10);
    
      for(counter=0;counter<count;counter++)
      {
        setText(medicationsArr[counter],"","",txtDescriptionObj)
        if(Project.Variables.ServerType == "remote")
        {
          dateArr[counter] = ChangeDateFormat(dateArr[counter])
        } 
        dateUpdatedOnObj.Keys(dateArr[counter])
        setText(snomedArr[counter],"","",txtSnomedObj)
        btnAddMedicationObj.Click();      
      }
    }  
  }
}
/*===============================================================================
Description: This function is to compare XML details or check for any empty tag
Parameters:
          tagName:Name of tag to be fetched
          expValue:expected value of tag/sub-tag
Return Value:true/false
=================================================================================*/
function ToCheckXMLDetails(tagName,expValue)
{
  var xmlObj, xmlData;
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    var parentObj = ToFindObj(["Name","WPFControlName"],["WPFObject(\"rtbXML\")","rtbXML"])
    xmlObj = parentObj.FindChild(["Name"],["WPFObject(\"Paragraph\", \"\", 1)"],10) 
    xmlData = xmlObj.WPFControlText;   
  }
  else
  {
    xmlObj = ToFindObj(["Name","WinFormsControlName"],["WinFormsObject(\"xmlText\")","xmlText"])
    //xmlData = xmlObj.Text;  //For New TestHarness
    xmlData = xmlObj.Text.OleValue; //For Old InProcess 
  }
  if(xmlObj.Exists)
  {
    var str, arrObj1, arrObj2;
    str = "<"+tagName+">";
    
    arrObj1 = xmlData.split(str);
    if(arrObj1.length>1)
    {
      str = "</"+tagName+">";
    
      arrObj2=arrObj1[1].split(str);
      if(aqString.Find(arrObj2[0], "</")!=-1)
      {
        if(aqString.Find(arrObj2[0], expValue)!=-1)
        {
          return true;
        }
        else
        {
          return false;
        }
      }
      else if(aqString.ToUpper(expValue)==aqString.ToUpper(arrObj2[0]))
      {
        Log.Message(tagName+" has value "+arrObj2[0]+" in XML")
        return true;
      }
      else
      {
        Log.Message(tagName+" has value "+arrObj2[0]+" in XML")
        return false;
      }      
    }
    else
    {
      var str1 = "<"+tagName+" />";
      var arr = xmlData.split(str1);
      if(arr.length>1 && expValue=="")
      {
        Log.Message(tagName+" is an empty tag in XML")
        return true;
      }
      else
      {
        Log.Message(tagName+" is missing in XML")
        return false;        
      }
    }
  }
}
/*===============================================================================
Description: This function is to reset sessionID field in Testharness to blank.
Parameters:
Return Value:
=================================================================================*/
function ToSetSessionIDasBlank()
{
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    ToScrollNewTestHarness("DOWN");
  }
   var startBtnObj = ToFindObj(["Name","VisibleOnScreen"],[btn_StartAssessment,"True"])
   var parentObj = startBtnObj.parent.parent   
   var sessionIDObj = parentObj.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"TextBox\", \"\", 1)","True"], 10);
   setText("","","",sessionIDObj)
}
/*===============================================================================
Description: This function to click select application version
Parameters:
          Version:Select application version
Return Value:true/false
=================================================================================*/
function SelectAppVersion(value)
{
  var process = GetProcess()
  var DownloadPackage = process.Findchild(["Name"],["WPFObject(\"PackageDownload\", \"\", 1)"],100)
  var GetVersion = DownloadPackage.Findchild(["Name"],["WPFObject(\"combobox1\")"],100)
  if(GetVersion.Exists)
    {
        for(i=0;i<GetVersion.Items.Count;i++)
        if(GetVersion.Items.Item(i).OleValue == value)
         {
           GetVersion.ClickItem(i)
           return true
         }
          return false
    }
}
/*===============================================================================
Description: This function to select DOB Type in InProcess application
Parameters:
          type:Select DOB Type(DOB/NULLDOB/'1/1/0001'/APPROXAGE)
Return Value:
=================================================================================*/
function selectDOBTypeInProcess(type)
{
    var process = GetProcess()
    var WinFormsControlNameValue;
    switch(aqString.ToUpper(type))
    {
      case "DOB":
        WinFormsControlNameValue = "radioDateOfBirth";
        break;
      case "NULL":
        WinFormsControlNameValue = "radioNullDOB";
        break;
      case "1/1/0001":
        WinFormsControlNameValue = "radioFirstDate";
        break;
      case "APPROXAGE":
        WinFormsControlNameValue = "radioApproxAge";
        break;            
    }
    var rbtn_DOBType = process.FindChild(["WinFormsControlName","VisibleOnScreen"],[WinFormsControlNameValue,"True"],50)
    if(rbtn_DOBType.Exists)
    {
      rbtn_DOBType.Click();
      Log.Message("DOB Type "+type+" is selected");
    }
}
/*===============================================================================
Description: This function is to compare outcome in XML details
Parameters:
                 
Return Value:true/false
=================================================================================*/
function ToCheckOutcomeDetailsInXML()
{
  var process= GetProcess()
  if(ToCheckXMLDetails("SelectedOutcome",selectedOutcome))
  {
     Log.Message("Patient outcome "+selectedOutcome+" is displaying")
     return true;
  }
  else if (ToCheckXMLDetails("Signpost",selectedOutcome))
  { 
    Log.Message("Signpost outcome "+selectedOutcome+" is displaying")
    return true;
  }
  else
  {
    return false;
  }
  
}
/*===============================================================================
Description: This function to select patient gender
Parameters: 
            gender:Male or female
Return Value: 
=================================================================================*/
function selectGenderMissingInfo(gender)
{
  Process = GetProcess()
  var Gender = Process.FindChild(["Name"],["WPFObject(\"gender\")"],100)
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
Description: This function to select DOB type as approx age and enter age in weeks
Parameters: 
            numOfWeeks:Number Of Weeks
Return Value: 
=================================================================================*/
function enterApproxAge(numOfWeeks)
{
    Process = GetProcess()
    var lbl_DOBType = Process.FindChild(["Name"],["WPFObject(\"Label\", \"DOB Type\", 3)"],100)
    var parentObj = lbl_DOBType.parent
    var cmb_DOBType = parentObj.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],10)
    if (cmb_DOBType.Exists)
    {
        cmb_DOBType.ClickItem(3);
    }
    setDataInTestHarness("NumOfWeeks",numOfWeeks);
}

/*===============================================================================
Description: This function to return sessionid/status details under Log section for assessment in TestHarness. SessionID is saved in Global variable.
Parameters: 
            detailReq:sessionId/status
Return Value: 
=================================================================================*/
function GetLogDetInProcess(detailReq)
{
    ToScrollNewTestHarness("DOWN");
    var obj_Log = ToFindObj(["Name","WPFControlName"], [txt_rtbLog,"rtbLog"])
    var obj = obj_Log.FindChild(["Name"],["WPFObject(\"FlowDocument\", \"\", 1)"],100)
    for(i=obj.ChildCount;i>0;i--)
    {
        var parent = obj.FindChild(["Name"],["WPFObject(\"Paragraph\", \"\"," +i+")"],5)
        var obj_curLog = parent.FindChild(["Name"],["WPFObject(\"Run\", \"*\", 1)"],5)
        var curLogText = obj_curLog.Text.OleValue;
        var pattern, regexPattern, res;
        switch (aqString.ToUpper(detailReq))
        {
            case "SESSIONID":
                pattern = "Session Id assigned: "+"[0-9a-z-]*";
                regexPattern = new RegExp(pattern);
                res = regexPattern.test(curLogText);
                if(res==true)
                {
                   sessionId = aqString.Trim((curLogText.split(":"))[1])
                }
                break;
            case "STATUS":
                pattern = "Assessment "+"[A-Za-z]*"+".. results Retrieved";
                regexPattern = new RegExp(pattern);
                res = regexPattern.test(curLogText); 
                if(res==true)
                {
                   return aqString.Trim((curLogText.split("."))[0]);
                }
                break;                                       
        }
        //Coming out of loop after session id saved to global variable 
        if(res==true)
            break;
    }
}

/*===============================================================================
Description: This function to change the date format as per local machine
Parameters: 
            datetoenter:date to enter
Return Value: 
=================================================================================*/
function ChangeDateFormat(datetoenter)
{
    dateArr = datetoenter.split("/");
    datetoenter = dateArr[1]+"/"+dateArr[0]+"/"+dateArr[2];
    return datetoenter;
}