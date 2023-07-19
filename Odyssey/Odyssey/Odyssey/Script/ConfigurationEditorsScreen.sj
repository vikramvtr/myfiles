//USEUNIT AdminSummaryScreen
//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT LoginScreen
//USEUNIT PageObjects
//USEUNIT AdminLoginScreen
//USEUNIT TestHarnessScreen
//USEUNIT ScreensOf3_12
//USEUNIT ScreensOf3_17
//USEUNIT DBFunctions

/*===============================================================================
Description: This function enter contact type
Parameters: 
Return Value: 
=================================================================================*/
function SetContactTypeText()
{
   Process = GetProcess()
   var ContactTypeList = Process.FindChild(["Name"],["WPFObject(\"contactTypeList\")"],100)
   var labelObj = ContactTypeList.FindChild(["Name"],[txt_ToAddContactType],100)
   if (labelObj.Exists)
   {
     labelObj.Click()
     Sys.Refresh()
     var TextBoxObj = ContactTypeList.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],100)
     TextBoxObj.Keys("TestAutomation")
   } 
} 
/*===============================================================================
Description: This function enter Address type
Parameters: 
Return Value: 
=================================================================================*/
function SetAddressTypeText()
{
   Process = GetProcess()
   var AddressTypeList = Process.FindChild(["Name"],["WPFObject(\"addressList\")"],100)
   var labelObj = AddressTypeList.FindChild(["Name"],[txt_ToAddContactType],100)
   if (labelObj.Exists)
   {
     labelObj.Click()
     Sys.Refresh()
     var TextBoxObj = AddressTypeList.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],100)
     TextBoxObj.Keys("TestAutomation")
   } 
} 
/*===============================================================================
Description: This function enter Ethnicity text
Parameters: 
Return Value: 
=================================================================================*/
function SetEthnicityText()
{
   Process = GetProcess()
   var EthnicityList = Process.FindChild(["Name"],["WPFObject(\"EthnicityList\")"],100)
   var labelObj = EthnicityList.FindChild(["Name"],[txt_ToAddContactType],100)
   if (labelObj.Exists)
   {
     labelObj.Click()
     Sys.Refresh()
     var TextBoxObj = EthnicityList.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],100)
     TextBoxObj.Keys("TestAutomationEthniciy")
     
   } 
} 
/*===============================================================================
Description: This function to enter text in the configuration editors options
Parameters:  type : CONTACT (or) ADDRESS (or) ETHNICITY
Return Value: 
=================================================================================*/
function SetTextInConfigurationEditors(Type)
{
   Process = GetProcess()
   
    switch ( aqString.ToUpper(Type) )
    {
      case "CONTACT":
        var List = Process.FindChild(["Name"],["WPFObject(\"contactTypeList\")"],100)
        break;

      case "ADDRESS":
        var List = Process.FindChild(["Name"],["WPFObject(\"addressList\")"],100)
        break;
    
       case "ETHNICITY":
        var List = Process.FindChild(["Name"],["WPFObject(\"EthnicityList\")"],100)
        break;
        
       case "MANAGEALLERGY":
        var List = Process.FindChild(["Name"],["WPFObject(\"allergiesList\")"],100)
        break;
        
       case "SESSIONTYPE":
        var List = Process.FindChild(["Name"],["WPFObject(\"TypesList\")"],100)
        break;
        
        case "QUESSETCLOSURE":
        var List = Process.FindChild(["Name"],["WPFObject(\"ExclusionReasonList\")"],100)
        break;
        
        case "ASSESMTSETCLOSURE":
        var List = Process.FindChild(["Name"],["WPFObject(\"ClosureReasonList\")"],100)
        break;
    }
   
     var labelObj = List.FindChild(["Name"],[txt_ToAddContactType],100)
     if (labelObj.Exists)
     {
       labelObj.Click()
       Sys.Refresh()
       var TextBoxObj = List.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],100)
       TextBoxObj.Keys("TestAutomation")
     
     } 
}
/*===============================================================================
Description: This function to set text for SetCallBackNumber
Parameters:
          value :
Return Value: 
=================================================================================*/
function SetCallBackNumber(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    var callbackNumber = siteSettings.Findchild(["Name"],["WPFObject(\"ComboBox\", \"\", 2)"],100)
    if(callbackNumber.Exists)
    {
        if(callbackNumber.wText != value)
        {
            for(i=0;i<callbackNumber.Items.Count;i++)
            {
                 if(aqString.ToUpper(callbackNumber.Items.Item(i).Value.OleValue) == aqString.ToUpper(value))
                 {
                   callbackNumber.ClickItem(i)
                   return callbackNumber.Items.Item(i).Value.OleValue
                   break;
                 }
            }           
        }
    }  
}

/*===============================================================================
Description: This function to Set call type
Parameters:  
          value:
Return Value: 
=================================================================================*/
function SetCallType(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    var CallType = siteSettings.Findchild(["Name"],["WPFObject(\"ComboBox\", \"\", 3)"],100)
    if(CallType.Exists)
    {
        if(CallType.wText != value)
        {
            for(i=0;i<CallType.Items.Count;i++)
            {
                if(aqString.ToUpper(CallType.Items.Item(i).Value.OleValue) == aqString.ToUpper(value))
                {
                    CallType.ClickItem(i)
                    return CallType.Items.Item(i).Value.OleValue
                }
            }  
        }
    }   
}

/*===============================================================================
Description: This function to Set call type
Parameters:  
Return Value: 
=================================================================================*/
function SettingDefaultvaluesInAdmin()
{
//  DeleteContactTypeForInitialSetup()
  LaunchApplication()
  if(Project.Variables.Process == "STANDALONE")
  {
    LoginAdmin(Project.Variables.AdminUsername,Project.Variables.AdminPassword)    
  }
  else
  {  
    selectWinFormsCmbBox(cmb_Role,"Administrator")
    setDataInTestHarness("Start","")
  }
//  waitforAdminSummaryScreen()
  clickItem(btn_ConfigEditor,"Configuration Editors")
  ExpandItem(btn_SiteSettings,"Site Settings")
  SetTemperatureQues("Uncheck")
  SetWeightQues("Uncheck")
  SetCallBackNumber("Visible and Not Mandatory")
  SetCallType("Visible and Not Mandatory")
  SetClinicalWarning("Uncheck")
  SetPauseAssessment("Check") 
  CollapseItem(btn_SiteSettings,"Site Settings")
  
  ExpandItem(btn_ManageClinicalContent,"Manage Clinical Content")  
  SetClinicalContentVersion(Project.Variables.ClinicalContentVersion)  
  CollapseItem(btn_ManageClinicalContent,"Manage Clinical Content")
  
  ExpandItem(btn_FirstCallConfig,"FirstCall Configuration")
  EnterUrgencyTxt("IMLT",PopUpMsg_IMLT)
  EnterUrgencyTxt("EMER",PopUpMsg_EMER)
  EnterUrgencyTxt("IMM1",PopUpMsg_IMM1)
  CheckUncheckPurpQues("Check")
  if(moduleName == "ReducedCallLength")
      ChangeCallLength("Purple and Red Questions")
  else
      ChangeCallLength("All Questions")
  CheckUncheckAmbTransTxt("Check")
  EnterAmbuTransTxt(lbl_AmbulanceTransport)
  CollapseItem(btn_FirstCallConfig,"FirstCall Configuration")
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    ToCheckFeatureToggle("PMH","CHECK")   
  }
  SaveAdminConfig();
  clickItem(btn_WPFButton,"Return to Admin Summary")
  closeApplication()
} 

/*===============================================================================
Description: This function to add contact type for default values in Configuration Editor screen
Parameters:  
Return Value: 
=================================================================================*/
function AddContactTypeForInitialSetup(contactTypeList)
{
  ExpCollContactType("Expand")
  var arrObj = contactTypeList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
    clickItem(btn_AddContactType,"")
    var listObj = ToFindObj("Name", "WPFObject(\"contactTypeList\")")
    var rowCount = listObj.ChildCount - 1
    var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\", "+rowCount+")"], 20)
    var contactObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
    contactObj.Click()
    var contactObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
    setText(arrObj[counter],"","",contactObj1)
  }
  ExpCollContactType("Collapse")
}

/*===============================================================================
Description: This function to add contact type for default values in Configuration Editor screen
Parameters:  
Return Value: 
=================================================================================*/
function AddAddressTypeForInitialSetup(AddressTypeList)
{
  ExpCollAddressType("Expand")
  var arrObj = AddressTypeList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
    clickItem(btn_AddaddressType,"")
    var listObj = ToFindObj("Name", "WPFObject(\"addressList\")")
    var rowCount = listObj.ChildCount - 1
    var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\", "+rowCount+")"], 20)
    var contactObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
    contactObj.Click()
    var contactObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
    setText(arrObj[counter],"","",contactObj1)
    var chkbx_active = currentRow.FindChild(["Name"], [chkBx_Active], 20)
    if(chkbx_active.VisibleOnScreen && chkbx_active.Enabled)
    {
      chkbx_active.ClickButton(cbChecked)
    }
  }
  ExpCollAddressType("Collapse")
}
/*===============================================================================
Description: This function to add 111 message in Configuration Editor screen
Parameters:  
          message:111 message text
          urgency:urgency for 111 message
Return Value: 
=================================================================================*/
function Add111Message(message,urgency)
{
  if(!ToFindObjToValidate(["WPFControlText"], ["Life Threatening Message"]))
  {
    ToScrollApplication("DOWN");
    delayExecution("1");
  }
  var process = GetProcess()
  var mssgList = process.FindChild(["Name"],[list_MessgList],50)
  var itemList = mssgList.FindChild(["Name"],["WPFObject(\"ItemsPresenter\", \"\", 1)"],30)
  var count = itemList.ChildCount
  var flag = false
  if(count>0)
  {
    var obj = itemList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+count+")"],10)
    var mssgObj = obj.FindChild(["Name"],["WPFObject(\"Label\", \"\", 2)"],20)
    if(mssgObj.Exists)
    {
      mssgObj.DblClick()
      Sys.Refresh()
      var mssgObj1 = obj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],20)
      setText(message,"","",mssgObj1)
      flag = true
    }
    else
    {
      var mssgObj1 = obj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],20)
      if(aqString.ToUpper(mssgObj1.Text)==aqString.ToUpper(message))
      {
        flag = true
      }
    }  
    if(flag)
    {
      var urgencyDropDown = obj.FindChild(["Name"],["WPFObject(\"UserControl\")"],20)
      urgencyDropDown.Click()
      var urgencyObj = process.FindChild(["Name"],["WPFObject(\"CheckBox\", \""+urgency+"\", 1)"],100)
      urgencyObj.Click()
      clickItem(btn_WPFButton,"Close")
    } 
  } 
}
/*===============================================================================
Description: This function to change status of 111 message in Configuration Editor screen
Parameters:  
          message:111 message text
Return Value: 
=================================================================================*/
function ChangeStatus111Message(message)
{
  if(!ToFindObjToValidate(["WPFControlText"], ["Life Threatening Message"]))
  {
    ToScrollApplication("DOWN");
    delayExecution("1");
  }
  var process = GetProcess()
  var mssgList = process.FindChild(["Name"],[list_MessgList],50)
  var itemList = mssgList.FindChild(["Name"],["WPFObject(\"ItemsPresenter\", \"\", 1)"],30)
  var count = itemList.ChildCount
  if(count>0)
  {
    for(counter=1;counter<=count;counter++)
    {
      var obj = itemList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+counter+")"],10)   
      var mssgObj1 = obj.FindChild(["Name"],["WPFObject(\"Label\", *, 2)"],20)
      if(aqString.ToUpper(mssgObj1.WPFControlText)==aqString.ToUpper(message))
      {
        var activeObj = obj.FindChild(["Name"],[lbl_Active],20)
        if(activeObj.VisibleOnScreen)
        {
          activeObj.Click()
          var checkBoxObj = obj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"\", 1)"],20)
          checkBoxObj.Click()
          break;
        }
      }
    }
  } 
}

/*===============================================================================
Description: This function to check the colour of outcome urgencies displayed 
Parameters: 
          outcomeObj:outcome object
          expColour:expected colour of action
Return Value:true/false
=================================================================================*/
function OutcomeUrgencyColour(outcomeObj,expColour)
{
    var  outcomeObj1 = outcomeObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Rectangle\", \"\", 1)","True"],100)
    var blueVal = outcomeObj1.Fill.Color.B
    var redVal = outcomeObj1.Fill.Color.R
    var greenVal = outcomeObj1.Fill.Color.G
    switch(aqString.ToUpper(expColour))
    {
      case "INDIGO":
        if(blueVal==255 && redVal==106 && greenVal==0)
        {
          colourMatch=true;
        }
        break;
      case "MAROON":
        if(blueVal==36 && redVal==161 && greenVal==0)
        {
          colourMatch=true;
        }
        break;
      case "RED":
        if(blueVal==0 && redVal==204 && greenVal==0)
        {
          colourMatch=true;
        }
        break;
      case "YELLOW":
        if(blueVal==51 && redVal==255 && greenVal==153)
        {
          colourMatch=true;
        }
        break;   
      case "LIGHTYELLOW":
        if(blueVal==0 && redVal==216 && greenVal==193)
        {
          colourMatch=true;
        }
        break;
      case "GREEN":
        if(blueVal==23 && redVal==96 && greenVal==169)
        {
          colourMatch=true;
        }
        break;
      case "BLUE":
        if(blueVal==151 && redVal==52 && greenVal==97)
        {
          colourMatch=true;
        }
        break;
      case "BLACK":
        if(blueVal==0 && redVal==0 && greenVal==0)
        {
          colourMatch=true;
        }
        break;
      case "":
        colourMatch=true;
        break;
    }  
    return colourMatch;
}

/*===============================================================================
Description: This function to check the colour of outcome urgencies displayed 
Parameters: 
          outcomeUrgency:outcome Urgency
          expColour:expected colour of action
          role:""/Reception/CallHandler/FaceToFace(Blank for teleassess)
Return Value:true/false
=================================================================================*/
function ToCheckOutcomeColour(outcomeUrgency,expColour,role)
{
  var process = GetProcess()
  var list_PatientOutcome = process.FindChild(["Name","Enabled"],["WPFObject(\"OutcomeList"+role+"\")","True"],100)
  var obj_PatientOutcome = list_PatientOutcome.FindChild(["Name","Enabled"],["WPFObject(\"ListBoxItem\", \"\", 1)","True"],10)
  var cmb_PatientOutcomeObj = obj_PatientOutcome.FindChild(["Name","Enabled"],["WPFObject(\"CheckableCombo\")","True"],10) 
  if(cmb_PatientOutcomeObj.Exists)
  {
    var noOfUrgency = cmb_PatientOutcomeObj.Items.Count;
    var status = false;
    cmb_PatientOutcomeObj.Click();
    for(var i=1;i<=noOfUrgency;i++)
    {
      var currentItem = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBoxItem\", \"\", "+i+")","True"],100)
      if(currentItem.Exists)
      {
        if(aqString.ToUpper(currentItem.Content.Text)==aqString.ToUpper(outcomeUrgency))
        {
          if(OutcomeUrgencyColour(currentItem,expColour))
          {
            status = true;
          }
        }
      }
    }
    clickItem(btn_WPFButton,"Close")
    return status;
  }
}
/*===============================================================================
Description: This function to add outcome in Configuration Editor screen
Parameters:  
          message:patient outcome text
          detOutcome:detailed outcome
          urgencyList:list of urgencies for outcome
Return Value: 
=================================================================================*/
function AddPatientOutcome(message,detOutcome,urgencyList)
{
  clickItem(btn_addOutcome,"Add outcome")
  var process = GetProcess()
  var OutcomeListObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"OutcomeList"+"*"+"\")","True"],50)
  var OutcomeList = OutcomeListObj.FindAllChildren(["Name"],["WPFObject(\"ListBoxItem\", \"\", *)"],10).toArray();
  var count = OutcomeList.length
  var flag = false
  if(count>0)
  {
    var obj = OutcomeListObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+count+")"],10)
    var mssgObj1 = obj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"txtName\")","True"],20)
    if(mssgObj1.Exists && mssgObj1.wText=="")
    {
      mssgObj1.DblClick()
      Sys.Refresh()
      setText(message,"","",mssgObj1)
      var mssgObj2 = obj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],20)
      mssgObj2.DblClick()
      Sys.Refresh()
      setText(detOutcome,"","",mssgObj2)
      flag = true
    }
    else
    {
      var mssgObj1 = obj.FindChild(["Name"],["WPFObject(\"txtName\")"],20)
      if(aqString.ToUpper(mssgObj1.wText)==aqString.ToUpper(message))
      {
        flag = true
      }
    }  
    if(flag)
    {
      var arrObj = urgencyList.split("|")
      var count = arrObj.length
      var urgencyDropDown = obj.FindChild(["Name"],["WPFObject(\"UserControl\")"],20)
      for(i=0;i<count;i++)
      {
        urgencyDropDown.Click()
        
        var nameValue = "WPFObject(\"CheckBox\", \""+arrObj[i]+"\", 1)"
        
        var urgencyObj = process.FindChild(["Name"],[nameValue],100)
        urgencyObj.Click()
        clickItem(btn_WPFButton,"Close")        
      }
    } 
  } 
}
/*===============================================================================
Description: This function to add relation type for default values in Configuration Editor screen
Parameters:  
          relationTypeList:
Return Value: 
=================================================================================*/
function AddRelationTypeForInitialSetup(relationTypeList)
{
  ExpandItem(btn_RelationTypes,"Relationship Types")
  var arrObj = relationTypeList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
    clickItem(btn_AddRelationType,"")
    var listObj = ToFindObj("Name", "WPFObject(\"relationshipList\")")
    var rowCount = listObj.ChildCount - 1
    var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\", "+rowCount+")"], 20)
    var relationObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
    relationObj.Click()
    var relationObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
    setText(arrObj[counter],"","",relationObj1) 
  }
  CollapseItem(btn_RelationTypes,"Relationship Types")
}
/*===============================================================================
Description: This function to add manage allergies for default values in Configuration Editor screen
Parameters:  
            AddAllergiesList:Allergies to be added
Return Value: 
=================================================================================*/
function AddAllergiesForInitialSetup(AddAllergiesList)
{
  ExpandItem(btn_ManageAllergies,"Manage Allergies")
  var arrObj = AddAllergiesList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
    clickItem(btn_AddManageAllergies,"")
    Sys.Refresh()
    var listObj = ToFindObj("Name", "WPFObject(\"allergiesList\")")
    var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\", 1)"], 20)
    var allergyObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
    allergyObj.Click()
    var allergyObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
    setText(arrObj[counter],"","",allergyObj1)
  }
  CollapseItem(btn_ManageAllergies,"Manage Allergies")
}
/*===============================================================================
Description: This function to add edit session types for default values in Configuration Editor screen
Parameters:  
          EditSessionTypesList:Session Types to be added
Return Value: 
=================================================================================*/
function AddSessionTypesForInitialSetup(EditSessionTypesList)
{
  //var process = GetProcess()
  ExpandItem(btn_EditSessionTypes,"Edit Session Types")
  var arrObj = EditSessionTypesList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
    clickItem(btn_AddSessionType,"")
    var listObj = ToFindObj("Name", "WPFObject(\"TypesList\")")
   var rowCount = listObj.ChildCount - 1
    var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\","+rowCount+" )"], 20)
    var sessionObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
    sessionObj.Click()
    var sessionObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
    setText(arrObj[counter],"","",sessionObj1)    
  }
  CollapseItem(btn_EditSessionTypes,"Edit Session Types")
}
/*===============================================================================
Description: This function to add question set closure reason for default values in Configuration Editor screen
Parameters:  
          QuestionSetClosureReasonsList:QuestionSet Closure Reasons to be added
Return Value: 
=================================================================================*/
function AddQuestionSetClosureReasonsForInitialSetup(QuestionSetClosureReasonsList)
{
  ExpandItem(btn_QuesSetClosure,"Question Set Closure Reasons")
  var arrObj = QuestionSetClosureReasonsList.split("|")
  var count = arrObj.length
  
  for(counter=0;counter<count;counter++)
  {
      clickItem(btn_AddQuesSetClosure,"")
      var listObj = ToFindObj("Name", "WPFObject(\"ExclusionReasonList\")")
      var rowCount = listObj.ChildCount - 1
      var currentRow = listObj.FindChild(["Name"], ["WPFObject(\"ListBoxItem\", \"\", "+rowCount+")"], 20)
      var contactObj = currentRow.FindChild(["Name"], ["WPFObject(\"Label\", \"\", 1)"], 20)
      contactObj.Click()
      var contactObj1 = currentRow.FindChild(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 20)
      setText(arrObj[counter],"","",contactObj1)
      if(arrObj[counter]=="Other")
      {
          var requireNoteObj = currentRow.FindChild(["Name"], [chkBx_RequireNote], 20)
          if(requireNoteObj.VisibleOnScreen)
          {
              requireNoteObj.ClickButton(cbChecked)
          }
      }      
  }
  CollapseItem(btn_QuesSetClosure,"Question Set Closure Reasons")
}
/*===============================================================================
Description: This function to add question set closure reason for default values in Configuration Editor screen
Parameters:  
          outcomeType:Outcome Type(TeleAssess/Reception/FaceToFace/CallHandler)
Return Value: 
=================================================================================*/
function SelectOutcomeType(outcomeType)
{
  var expPatientOutcome = ToFindObj(["Name","WPFControlText"],[btn_PatientOutcomes,"Patient Outcomes"])
  var cmbOutcomeTypeObj = expPatientOutcome.FindChild(["Name","VisibleOnScreen"],[cmb_Culture2,"True"],10)
  cmbOutcomeTypeObj.ClickItem(outcomeType)
}
/*===============================================================================
Description: This function to check/uncheck feature toggles under Third Party Integration Configuration
Parameters:  
          featureType:PMH/MCS/SNOMED
          action:CHECK/UNCHECK
Return Value:
=================================================================================*/
function ToCheckFeatureToggle(featureType,action)
{
  ExpandItem(btn_ThirdPartyIntegration,"Third Party Integration Configuration")
  var parentObj = ToFindObj(["Name","WPFControlText"],[btn_ThirdPartyIntegration,"Third Party Integration Configuration"])
  var checkBoxObj;
  switch(aqString.ToUpper(featureType))
  {
    case "PMH":
      checkBoxObj =  parentObj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"\", 1)"],10)
      break;
    case "MCS":
      checkBoxObj =  parentObj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"\", 2)"],10)
      break;
    case "SNOMED":
      checkBoxObj =  parentObj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"\", 3)"],10)
      break;      
  }
  if(checkBoxObj.Exists)
  {
    if(aqString.ToUpper(action)=="CHECK")
    {
       checkBoxObj.ClickButton(cbChecked);
    }
    else
    {
       checkBoxObj.ClickButton(cbUnchecked); 
    } 
  }
  CollapseItem(btn_ThirdPartyIntegration,"Third Party Integration Configuration")  
}
/*===============================================================================
Description: This function to select Clinical Content Version
Parameters:
          Version : Clinical Content version
Return Value: 
=================================================================================*/
function SetClinicalContentVersion(value)
{
  var process = GetProcess()
  var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Manage Clinical Content\", *)"],100)
  var clinicalContent = siteSettings.Findchild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],100)
  if(value=="")
  {
      clinicalContent.ClickItem(0)
      return true
  }
  else if(clinicalContent.Exists)
  {
      for(i=0;i<clinicalContent.Items.Count;i++)
        if(clinicalContent.Items.Item(i).Version.OleValue == value)
        {
             clinicalContent.ClickItem(i)
             if(ToFindObjToValidate(["Name"], [lbl_ReasonForChange]))
             {
                setText("Providing reason for changing content version to "+value, txt_WaterMarkedTtextBox, "", "")
             }
             return true
        }
      return false
  }
}
/*===============================================================================
Description: This function to set text for SetCallBackNumber
Parameters:
          value :Check/Uncheck
Return Value: 
=================================================================================*/
function SetClinicalWarning(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    if(!ToFindObjToValidate(["WPFControlText"], [Project.Variables.Domain]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }    
    var clinicalWarning = siteSettings.Findchild(["Name"],["WPFObject(\"CheckBox\", \"\", 5)"],10)
    if(clinicalWarning.Exists)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           clinicalWarning.ClickButton(cbChecked);
        }
        else
        {
           clinicalWarning.ClickButton(cbUnchecked); 
        } 
    } 
}
/*===============================================================================
Description: This function to set name for Organisation Name under Site Settings of Cofiguration Editors
Parameters:
          name :Organisation Name
Return Value: 
=================================================================================*/
function SetOrganisationName(name)
{
    var OrgNameLabel = ToFindObj(["Name"],[lbl_OrganisationName]);
    var obj = OrgNameLabel.Parent
    var OrganisationNameTxt = obj.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 2)","True"],10)
    if(OrganisationNameTxt.Enabled)
    {
        setText(name,"","",OrganisationNameTxt);
    }
    else
    {
        Log.Warning("Set text failed in SetOrganisationName")
        throw "Set text failed in SetOrganisationName"
    }
}
/*===============================================================================
Description: This function to get/fetch Organisation name under Site Settings of Cofiguration Editors
Parameters:
Return Value: organisationName
=================================================================================*/
function GetOrganisationName()
{
    var OrgNameLabel = ToFindObj(["Name"],[lbl_OrganisationName]);
    var obj = OrgNameLabel.Parent
    var OrganisationNameTxt = obj.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 2)","True"],10)
    if(OrganisationNameTxt.Exists)
    {
        return OrganisationNameTxt.wText;
    }
    else
    {
        Log.Warning("Get text failed in GetOrganisationName")
        throw "Get text failed in GetOrganisationName"
    }
}

/*===============================================================================
Description: This function to check/uncheck for PauseAssessment setting under configuration editor
Parameters:
          value :Check/Uncheck
Return Value: 
=================================================================================*/
function SetPauseAssessment(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    if(!ToFindObjToValidate(["WPFControlText"], [Project.Variables.Domain]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
    var pauseAssessment = siteSettings.Findchild(["Name"],["WPFObject(\"CheckBox\", \"\", 6)"],10)
    if(pauseAssessment.Exists)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           pauseAssessment.ClickButton(cbChecked);
        }
        else
        {
           pauseAssessment.ClickButton(cbUnchecked); 
        } 
    } 
}

/*===============================================================================
Description: This function to validate overridden and aliased signpost functionality in Configuration screen
Parameters:  
          signpost:signpost text
          newSignpostText:overridden/aliased signpost text
Return Value:true/false
=================================================================================*/
function CheckOverRidAliasSignpost(signpost, newSignpostText)
{
    ExpandItem(btn_Signposting,"Signposting")
    var sinpostObj = ToFindObj(["Name","WPFControlText"],["WPFObject(\"TextBlock\", \""+signpost+"\", *)",signpost])
    var result = false;
    if(sinpostObj.Exists)
    {
        parentObj = sinpostObj.Parent.Parent.Parent;
        var overriddenSignpostObj = parentObj.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+newSignpostText+"\", *)"],10)
        if(overriddenSignpostObj.Exists)
        {
           result = true;
        }
    }
    else
    {
        Log.Message(signpost+" is not found under Signpost grid")
    }
    CollapseItem(btn_Signposting,"Signposting")
    return result;
}

/*===============================================================================
Description: This function to validate Email Server Settings in Configuration screen
Parameters:  
          SMTPStatus:Check/Uncheck
Return Value:
=================================================================================*/
function ToCheckEmailServerSett(SMTPStatus)
{
  ExpandItem(btn_ManageEmailServerSettings,"Manage Email Server Settings")
  
  if(Project.Variables.Process == "INPROCESSNEW" || Project.Variables.Process == "INPROCESS")
  {
      ToScrollApplication("DOWN");
  }
  
  ToCheckAndUncheck(chkBx_ActiveCheckBox,SMTPStatus)
  var parentObj = ToFindObj(["Name","WPFControlText"],[btn_ManageEmailServerSettings,"Manage Email Server Settings"])
  var chkBx_EnableSSL = parentObj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"\", 1)"],10)
  var txt_Host = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
  var txt_Account = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],10)
  var txt_Password = parentObj.FindChild(["Name"],["WPFObject(\"SmtpPasswordBox\")"],10)
  var txt_AdminNotifyEmail = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],10)
  var txt_From = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 4)"],10)
  var txt_Alias = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 5)"],10)
  var txt_Delay = parentObj.FindChild(["Name"],["WPFObject(\"IntegerTextBox\", \"\", 1)"],10)
  var btn_TestSMTPSettings = parentObj.FindChild(["Name"],["WPFObject(\"button\")"],10)
  
  var status = false;
  if(aqString.ToUpper(SMTPStatus) == "CHECK")
  {
      if(chkBx_EnableSSL.Enabled && txt_Host.Enabled && txt_Account.Enabled && txt_Password.Enabled && txt_AdminNotifyEmail.Enabled && txt_From.Enabled && txt_Alias.Enabled && txt_Delay.Enabled)
      {
         txt_Host.Clear()
         txt_Host.Keys("Host-smtp@gmail.com")
         if(btn_TestSMTPSettings.Enabled)
         {
             Log.Message("All the controls under Manage Email Server Settings are enabled");
             status = true;         
         }
         else
         {
             Log.Message("TestSMTPSettings is not enabled on entering host name");             
         }
      }
      else
      {
         Log.Message("All the controls under Manage Email Server Settings are not enabled");
      } 
  }
  else
  {
      txt_Host.Clear()
      if(!(chkBx_EnableSSL.Enabled || txt_Host.Enabled || txt_Account.Enabled || txt_Password.Enabled || txt_AdminNotifyEmail.Enabled || txt_From.Enabled || txt_Alias.Enabled || txt_Delay.Enabled || btn_TestSMTPSettings.Enabled))
      {
         Log.Message("All the controls under Manage Email Server Settings are disabled");
         status = true;         
      }
      else
      {
         Log.Message("Controls under Manage Email Server Settings are enabled");      
      }
  }
  CollapseItem(btn_ManageEmailServerSettings,"Manage Email Server Settings")
  return status;  
}

/*===============================================================================
Description: This function is wait for the Configuration Editor screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforConfigEditScreen()
{
 return waitForItemWithTime(btn_QuesSetClosure,"Question Set Closure Reasons",2 )
}

/*===============================================================================
Description: This function to check for SNOMED field for any outcome in Configuration Editor screen
Parameters:  
Return Value: 
=================================================================================*/
function CheckOutcomeSnomed()
{
  clickItem(btn_addOutcome,"Add outcome")
  var process = GetProcess()
  var OutcomeListObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"OutcomeList"+"*"+"\")","True"],50)
  var OutcomeList = OutcomeListObj.FindAllChildren(["Name"],["WPFObject(\"ListBoxItem\", \"\", *)"],10).toArray();
  var count = OutcomeList.length
  if(count>0)
  {
    var obj = OutcomeListObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+count+")"],10)
    var parent = obj.FindChild(["Name"],["WPFObject(\"StackPanel\", \"\", 2)"],10)
    var txt_snomed = parent.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],5)
    if(txt_snomed.Exists && txt_snomed.Enabled)
    {
      if(txt_snomed.ToolTip.OleValue == "Please enter a SNOMED code ranging between 6 to 18 numbers")
        return true;
      else
        return false;
    }
    else
    {
        Log.Message("SNOMED field is not available or disabled")
        return false;
    }  
  } 
}

/*===============================================================================
Description: This function to check/uncheck for Coloured Short Question setting under configuration editor
Parameters:
          value :Check/Uncheck
Return Value: 
=================================================================================*/
function SetColouredShortQues(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    var colouredShortQues = siteSettings.Findchild(["Name"],["WPFObject(\"CheckBox\", \"\", 3)"],10)
    if(colouredShortQues.Exists)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           colouredShortQues.ClickButton(cbChecked);
        }
        else
        {
           colouredShortQues.ClickButton(cbUnchecked); 
        } 
    } 
}
/*===============================================================================
Description: This function to check/uncheck for Temperature answer in centigrade and fahrenheit should  setting under configuration editor
Parameters:
          value :Check/Uncheck
Return Value:
=================================================================================*/
function SetTemperatureQues(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    var TemperatureQues = siteSettings.Findchild(["Name"],["WPFObject(\"ShowTemperatureConversionCheckBox\")"],10)
    if(TemperatureQues.Exists)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           TemperatureQues.ClickButton(cbChecked);
        }
        else
        {
           TemperatureQues.ClickButton(cbUnchecked);
        }
    }
}

/*===============================================================================
Description: This function to check/uncheck for Temperature answer in centigrade and fahernheit should  setting under configuration editor
Parameters:
          value :Check/Uncheck
Return Value:
=================================================================================*/
function SetWeightQues(value)
{
    var process = GetProcess()
    var siteSettings = process.Findchild(["Name"],["WPFObject(\"Expander\", \"Site Settings\", 1)"],100)
    var WeightQues = siteSettings.Findchild(["Name"],["WPFObject(\"ShowWeightConversionCheckBox\")"],10)
    if(WeightQues.Exists)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           WeightQues.ClickButton(cbChecked);
        }
        else
        {
           WeightQues.ClickButton(cbUnchecked);
        }
    }
}

/*===============================================================================
Description: This function to check/uncheck for signpost option for any module under configuration editor
Parameters:
          module :TeleAssess/FirstCall
          value :Check/Uncheck
Return Value:
=================================================================================*/
function CheckUncheckSignpost(module,value)
{
    var process = GetProcess()
    var Signposting = process.Findchild(["Name"],[btn_Signposting],100)
    var obj_label = Signposting.Findchild(["Name"],["WPFObject(\"TextBlock\", \""+module+"\", 1)"],10)
    var obj_parent = obj_label.Parent
    var obj_module = obj_parent.Findchild(["Name"],["WPFObject(\"CheckBox\", \"\", *)"],5)
    if(obj_module.Exists && obj_module.Enabled)
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           obj_module.ClickButton(cbChecked);
        }
        else
        {
           obj_module.ClickButton(cbUnchecked);
        }
    }
}

/*===============================================================================
Description: This function to check for enabled modules for a domain under Site Settings of configuration editor
Parameters:
          enabledModuleList :FaceToFace/FirstCall/Reception/TeleAssess
Return Value:True/False
=================================================================================*/
function CheckEnabledModule(moduleList)
{
    if(!ToFindObjToValidate(["WPFControlText"], ["Display Clinical Warning (for TeleAssess only)"]))
    {
      ToScrollApplication("DOWN");
      delayExecution("1");
    }
    var  moduleListArray =  moduleList.split(",");
    var process = GetProcess();
    var parent = process.Findchild(["Name"],["WPFObject(\"FeatureConfigurationList\")"],100);
    var obj_modulelist = parent.FindAllChildren(["Name"],["WPFObject(\"ListBoxItem\", \"\", *)"],10).toArray();
    
    for(i=0;i<obj_modulelist.length;i++)
    {
        var currModule = aqString.ToUpper(obj_modulelist[i].DataContext.Role.OleValue);
        var status = aqConvert.VarToBool(obj_modulelist[i].DataContext.IsChecked);
        var editable = aqConvert.VarToBool(obj_modulelist[i].IsEnabled)
        var moduleFound = false;
        for(j=0;j<moduleListArray.length;j++)
        {
            if(currModule == aqString.ToUpper(moduleListArray[j]))
            {
                moduleFound = true;
                if(status == false || editable)
                    return false; 
                
                break;              
            }
        }
        if(moduleFound == false)
        {
            if(status == true || editable)
                return false;            
        }    
    }
    return true;
}

/*===============================================================================
Description: This function to check/uncheck for PQ(Purple Question) option for FirstCall under configuration editor
Parameters:
          value :Check/Uncheck
Return Value:
=================================================================================*/
function CheckUncheckPurpQues(value)
{
    var process = GetProcess();
    if(!ToFindObjToValidate(["WPFControlText"], ["Ambulance Transport Text"]))
    {
      ToScrollApplication("DOWN");
      delayExecution("1");
    }
    var lblPQObj = process.Findchild(["Name"],[lbl_TurnPurpQuesOn],100)
    var parentObj = lblPQObj.Parent
    var chkBx_TurnPurpQuesOn = parentObj.Findchild(["Name","Enabled"],["WPFObject(\"CheckBox\", \"\", 1)","True"],3)
    
    if (chkBx_TurnPurpQuesOn.Exists && chkBx_TurnPurpQuesOn.VisibleOnScreen) 
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           chkBx_TurnPurpQuesOn.ClickButton(cbChecked);
        }
        else
        {
           chkBx_TurnPurpQuesOn.ClickButton(cbUnchecked);
        }
    }
    else
    {
        Log.Error("Object not found")
    }
}

/*===============================================================================
Description: This function to check/uncheck for Ambulance Transport Text option for FirstCall under configuration editor
Parameters:
          value :Check/Uncheck
Return Value:
=================================================================================*/
function CheckUncheckAmbTransTxt(value)
{
    var process = GetProcess();
    if(!ToFindObjToValidate(["WPFControlName"], ["AmbulanceTransportText"]))
    {
      ToScrollApplication("DOWN");
      delayExecution("1");
    }
    var lblPQObj = process.Findchild(["Name"],[lbl_AmbulanceTranspTxt],100)
    var parentObj = lblPQObj.Parent
    var chkBx_AmbulanceTranspTxt = parentObj.Findchild(["Name","Enabled"],["WPFObject(\"CheckBox\", \"\", 2)","True"],3)
    
    if (chkBx_AmbulanceTranspTxt.Exists && chkBx_AmbulanceTranspTxt.VisibleOnScreen) 
    {
        if(aqString.ToUpper(value)=="CHECK")
        {
           chkBx_AmbulanceTranspTxt.ClickButton(cbChecked);
        }
        else
        {
           chkBx_AmbulanceTranspTxt.ClickButton(cbUnchecked);
        }
    }
    else
    {
        Log.Error("Object not found")
    }
}

/*===============================================================================
Description: This function to Enter Ambulance Transport Text option for FirstCall
Parameters: 
              ambulanceTxt:Ambulance Text
Return Value: 
=================================================================================*/
function EnterAmbuTransTxt(ambulanceTxt)
{
    if(!ToFindObjToValidate(["WPFControlName"], ["AmbulanceTransportText"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
	
    if(getTextFromTextBox(txt_AmbulanceTransportText, "AmbulanceTransportText") != ambulanceTxt)
    {
        setText(ambulanceTxt,txt_AmbulanceTransportText,"AmbulanceTransportText","")
    } 	
}

/*===============================================================================
Description: This function to Enter Urgency Text for FirstCall
Parameters: 
              urgencyTxtType:IMLT/EMER/IMM1
              messgTxt:message txt to be entered
Return Value: 
=================================================================================*/
function EnterUrgencyTxt(urgencyTxtType,messgTxt)
{
    if(!ToFindObjToValidate(["WPFControlName"], [urgencyTxtType+"WarningMessage"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
    nameValue = "WPFObject(\""+urgencyTxtType+"WarningMessage\")"
    wpfControlNameValue = urgencyTxtType+"WarningMessage"
    if(getTextFromTextBox(nameValue, wpfControlNameValue) != messgTxt)
    {
        setText(messgTxt,"WPFObject(\""+urgencyTxtType+"WarningMessage\")",urgencyTxtType+"WarningMessage","")
    }  
}

/*===============================================================================
Description: This function to validate Email Server Settings in Configuration screen
Parameters:  
          host:host details
          account:account details
          password:password
          admin:admin email
          from:from email
Return Value:
=================================================================================*/
function EnterEmailServerSett(host, account, password, admin, from)
{
  ExpandItem(btn_ManageEmailServerSettings,"Manage Email Server Settings")
  if(!ToFindObjToValidate(["WPFControlText"], ["Delay"]))
  {
      ToScrollApplication("DOWN");
      delayExecution("1");
  }
  ToCheckAndUncheck(chkBx_ActiveCheckBox,"CHECK")
  var parentObj = ToFindObj(["Name","WPFControlText"],[btn_ManageEmailServerSettings,"Manage Email Server Settings"])
  var txt_Host = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 1)"],10)
  setText(host,"","",txt_Host)
  var txt_Account = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 2)"],10)
  setText(account,"","",txt_Account)
  var txt_Password = parentObj.FindChild(["Name"],["WPFObject(\"SmtpPasswordBox\")"],10)
  setText(password,"","",txt_Password)
  var txt_AdminNotifyEmail = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 3)"],10)
  setText(admin,"","",txt_AdminNotifyEmail)
  var txt_From = parentObj.FindChild(["Name"],["WPFObject(\"TextBox\", \"\", 4)"],10)
  setText(from,"","",txt_From)
  CollapseItem(btn_ManageEmailServerSettings,"Manage Email Server Settings")  
}

/*===============================================================================
Description: This function to add clinical content in database
Parameters: 
          fileNames:content file names         
Return Value: 
=================================================================================*/
function AddContentDetails(fileNames)
{
    fileNameArr = fileNames.split("|");
    for(i=0; i<fileNameArr.length; i++)
    {
        contentFileName = fileNameArr[i]
        contentFileDetArr = contentFileName.split("_")
        contentStr = "'"+contentFileDetArr[5]+"', '"+contentFileDetArr[1]+"', '"+contentFileDetArr[2]+"', 'TeleAssess', '"+contentFileDetArr[4]+"', '"+contentFileName+"'"
        AddClinicalContent(contentStr)
        Log.Message("Clinical Content "+contentFileName+" is added in database")
    }
}

/*===============================================================================
Description: This function to select Clinical Content Version and save
Parameters:
          Version : Clinical Content version
Return Value: 
=================================================================================*/
function SetClinicalContentAndSave(Version)
{
    ExpandItem(btn_ManageClinicalContent,"Manage Clinical Content")
    SetClinicalContentVersion(Version)
    // Enter reason of change
    
    CollapseItem(btn_ManageClinicalContent,"Manage Clinical Content")
    if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_WPFButton,"Save Changes"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
    clickItem(btn_WPFButton,"Save Changes")
}

/*===============================================================================
Description: This function need to be run on a new domain to configure it for auto regression
Parameters:  
          location:GB / IE / NZ / AUS
Return Value: 
=================================================================================*/
function InitialSetupConfigScreen(location)
{
  //Project.Variables.Domain = domainName;
  AddGPDetails()  // Need to run only once
  AddContentTypeVersion(versionlist)  // Need to run only once
  AddContentDetails(contentFiles) // Need to run only once for a location
  AddContentDetails(oldContentFiles)  // Need to run only once for a location
  AddOverrideSignpost()
  AddAliasedSignpost()
  CheckUncheckEmailModule("FirstCall|TeleAssess","CHECK")
  SetConfigSettings("UseRuleOfThreeWarning","true")
  SetConfigSettings("PILSBaseUri","https://www.nhs.uk")
  SetConfigSettings("EmergencyProtocolsBaseUri","https://ahc-demo-plain.adastra.co.uk/Content/emergencyprotocoldata/")
  if(location=="AUS" || location=="NZ")
  {  
    SetDomainSettings("TwoLevelUrgent", "True")
  } 
  LaunchApplication();
  if(Project.Variables.Process == "STANDALONE")
  { 
    SetConfigSettings("PatientNamesAvailableToQueue","Yes")
    UpdateContactTypeList("Home tel.|Work tel.|Mobile tel.", "IsHome|IsWork|IsMobile")
  
    LoginAdmin(Project.Variables.AdminUsername,Project.Variables.AdminPassword)
    clickItem(btn_ConfigEditor,"Configuration Editors")
    waitforConfigEditScreen()
    //Add Contact Type
    AddContactTypeForInitialSetup("Home tel.|Work tel.|Mobile tel.|Email|Next of Kin tel.|School tel.|Care Home tel.|Other")
    SaveAdminConfig()
    //Add Address Type
    AddAddressTypeForInitialSetup("Home|Temporary Address|Work|School|Care Home|Other")
    SaveAdminConfig()
    //Add Allergies
    AddAllergiesForInitialSetup("animal fur")
    SaveAdminConfig()
  } 
  else if(Project.Variables.Process == "INPROCESSNEW")
  {
    selectWinFormsCmbBox(cmb_Role,"Administrator")
    setDataInTestHarness("Start","")
    waitforAdminSummaryScreen()
    ClickBtnsInAdminSummaryScreenForInProcess("CONFIGEDITORS")
    waitforConfigEditScreen()
    ToCheckFeatureToggle("PMH","CHECK")
    SaveAdminConfig() 
  }
  //Uncheck Signpost checkbox
  ExpCollSignposting("Expand")
  CheckUncheckSignpost("TeleAssess","Uncheck")
  CheckUncheckSignpost("FirstCall","Uncheck")
  ExpCollSignposting("Collapse")
  SaveAdminConfig()
  //TeleAssess Outcome
  ExpandItem(btn_PatientOutcomes,"Patient Outcomes")
  SelectOutcomeType("TeleAssess")
  AddPatientOutcome("Test Outcome","Test Outcome","Emergency Ambulance|face to face assessment Now|face to face assessment within 2 hours|face to face assessment within 6 hours|face to face assessment within 24 hours|face to face assessment within routine timeframe|self care")
  if(location=="AUS" || location=="NZ")
  {  
    AddPatientOutcome("Attend Emergency Department","Attend Emergency Department","face to face assessment within 12 hours")
  } 
  CollapseItem(btn_PatientOutcomes,"Patient Outcomes")
  SaveAdminConfig()
  //Reception Outcome
  ExpandItem(btn_PatientOutcomes,"Patient Outcomes")
  SelectOutcomeType("Reception")
  AddPatientOutcome("Test Outcome","Test Outcome","Queue Category 1|Suggest clinical assessment now|Queue Category 2|Queue Category 3|Queue Category 4")
  CollapseItem(btn_PatientOutcomes,"Patient Outcomes")
  SaveAdminConfig()
  //CallHandler Outcome -- Not applicable for NZ and AUS
  if(location=="IE" || location=="GB")
  {
    ExpandItem(btn_PatientOutcomes,"Patient Outcomes")
    SelectOutcomeType("CallHandler")
    AddPatientOutcome("Test Outcome","Test Outcome","Emergency Ambulance|face to face assessment Now|face to face assessment within 2 hours|face to face assessment within 6 hours|face to face assessment within 24 hours|face to face assessment within routine timeframe|self care")
    CollapseItem(btn_PatientOutcomes,"Patient Outcomes")
    SaveAdminConfig() 
  }
  //Question Set Closure Reasons
  AddQuestionSetClosureReasonsForInitialSetup("Opened in error|Patient changed response|Not relevant to this assessment|Other")
  SaveAdminConfig()
 //Site Settings
  ExpCollSiteSetting("Expand")
  SetCallBackNumber("Visible and Not Mandatory")
  SetCallType("Visible and Not Mandatory")
  SetClinicalWarning("Uncheck")
  SetPauseAssessment("Check")  
  ExpCollSiteSetting("Collapse")
  SaveAdminConfig()
  //Add Session Type
  AddSessionTypesForInitialSetup("OOH")
  SaveAdminConfig()
  //Update FirstCall Configuration Details -- Not applicable for NZ and AUS
  if(location=="IE" || location=="GB")
  {
    ExpandItem(btn_FirstCallConfig,"FirstCall Configuration")
    EnterUrgencyTxt("IMLT",PopUpMsg_IMLT)
    EnterUrgencyTxt("EMER",PopUpMsg_EMER)
    EnterUrgencyTxt("IMM1",PopUpMsg_IMM1)
    CheckUncheckPurpQues("Check")
    CheckUncheckAmbTransTxt("Check")
    EnterAmbuTransTxt(lbl_AmbulanceTransport)
    CollapseItem(btn_FirstCallConfig,"FirstCall Configuration")
    SaveAdminConfig() 
  }
//  Add Email Server Settings
//  Settings for UK Test Servers
//  EnterEmailServerSett("192.168.210.55", "", "", Project.Variables.AdminUsername, "OdysseyCore12@gmail.com")
//  Settings for Local Setup
  EnterEmailServerSett("smtp.sendgrid.net:587", "apikey", "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", Project.Variables.AdminUsername, "Chelladurai.palraj@oneadvanced.com") 
  SaveAdminConfig()
  //Assessment Closure reason not required to be updated
  clickItem(btn_WPFButton,"Return to Admin Summary")
  waitforAdminSummaryScreen()
  closeApplication()
}

/*===============================================================================
Description: This function to click Save Changes in the Admin Configuration screen
Parameters:
Return Value: 
=================================================================================*/
function SaveAdminConfig()
{
    if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_WPFButton,"Save Changes"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
    clickItem(btn_WPFButton,"Save Changes")
}

/*===============================================================================
Description: This function to click Save Changes in the Admin Configuration screen
Parameters:
          contactTypeList:
          flagList:
Return Value: 
=================================================================================*/
function UpdateContactTypeList(contactTypeList, flagList)
{
    contactTypeArr = contactTypeList.split("|")
    flagArr = flagList.split("|")
    for(i=0; i<contactTypeArr.length; i++)
    {
        UpdateContactType(contactTypeArr[i], flagArr[i])
    }
}

/*===============================================================================
Description: This function to check the selected content version in Current Selected Clinical Content version combobox
Parameters:
          version:Clinical Content version
Return Value: true/false
=================================================================================*/
function CheckAdminContentVersion(version)
{
    var obj_manageclinicalcontent = ToFindObj(["Name"], [btn_ManageClinicalContent])
    var obj_currentcontent = obj_manageclinicalcontent.FindChild(["Name"], ["WPFObject(\"ComboBox\", \"\", 1)"], 100)
    if(obj_currentcontent.Exists && obj_currentcontent.VisibleOnScreen)
    {
        if(version == obj_currentcontent.Text)
            return true;
        else
            return false;
    }
    else
    {
        Log.Error("Object not found")
    } 
}
/*===============================================================================
Description: This function to check the new content version available under Manage Clinical Content
Parameters:
          version:New Content version
          duration:number of days to auto-update
Return Value: true/false
=================================================================================*/
function CheckNewContentVersion(version,duration)
{
    var obj_manageclinicalcontent = ToFindObj(["Name"], [btn_ManageClinicalContent])
    var obj_Array = obj_manageclinicalcontent.FindAllChildren(["Name"], ["WPFObject(\"TextBox\", \"\", 1)"], 100).toArray();
    if(obj_Array.length>0)
    {
        if(obj_Array[1].wText==version && obj_Array[0].wText==duration)
        {
            return true;
        }
        else
        {
            return false;
        }      
    }
}

/*===============================================================================
Description: This function to check the first entry of Content Version Update History grid
Parameters:
          version:New Content version
          note:decline reason note
Return Value: true/false
=================================================================================*/
function CheckContentUpdateHis(version,note)
{
    var obj_UpdateHistoryRow = ToFindObj(["Name"], ["WPFObject(\"DataGridRow\", \"\", 1)"])
    var obj_Array = obj_UpdateHistoryRow.FindAllChildren(["Name"], ["WPFObject(\"DataGridCell\", \"*\", *)"], 100).toArray();
    if(obj_Array[1].WPFControlText==note && obj_Array[2].WPFControlText==version && obj_Array[0].WPFControlText==Project.Variables.AdminUsername)
    {
        return true;
    }
    else
    {
        return false;
    } 
}

/*===============================================================================
Description: This function to check the first entry of Content Version Update History grid
Parameters:
          version:New Content version
          note:decline reason note/blank for accept 
Return Value: true/false
=================================================================================*/
function CheckContentUpdateAudit(version,note)
{
    var dbRecord=GetLastAuditEntryWithoutSession();
    if(dbRecord.length>0)
    { 
        var summary = aqString.Trim(dbRecord[0][2]);
        var category = aqString.Trim(dbRecord[0][1]);
        var description = aqString.Trim(dbRecord[0][3]);
        
        if(category=="ClinicalContent" && summary=="User has changed clinical content for domain")
        {
            if(note=="" && description=="User has Accepted the new clinical content "+version)
            {
                return true;   
            }
            else if(note!="" && description=="User has declined the new clinical content "+version+", with reason - "+note+".")
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            Log.Warning(category+" is the category and "+summary+" is the summary found")
            return false;
        }
    }
    else
    {
        Log.Warning("Audit record is not created")
        throw "Audit record is not created"    
    }   
}

/*===============================================================================
Description: This function to del content details from DB after completing AUTO-UPDATE script testing
Parameters: 
          version:content version
          location:GB/IE/NZ/AU
          typelist:Clinical/Lay
Return Value:
=================================================================================*/
function DelContentDetails(version,location,typelist)
{
    DelContentUpdateHis(version)
    typelistArr = typelist.split("|")
    for(i=0; i<typelistArr.length; i++)
    {
        DelClinicalContent(version,location,typelistArr[i])
    }
    DelClinicalContentType(version)
}


/*===============================================================================
Description: This function to add all clinical content type versions in the ClinicalContentType table of Odyssey Database
Parameters: 
          versionlist:content version list
Return Value:
=================================================================================*/
function AddContentTypeVersion(versionlist)
{
    versionlistArr = versionlist.split("|");
    for(i=0; i<versionlistArr.length; i++)
    {
        AddClinicalContentType(versionlistArr[i])
        Log.Message("Content Type version "+versionlistArr[i]+" is added in database")
    }
}

/*===============================================================================
Description: This function to change call length for FirstCall user under Manage Call Length dropdown
Parameters:
          callLength :All Questions/Purple and Red Questions
Return Value:
=================================================================================*/
function ChangeCallLength(callLength)
{
    if(!ToFindObjToValidate(["WPFControlText"], ["Manage Call Length"]))
    {
      ToScrollApplication("DOWN");
      delayExecution("1");
    }
    var process = GetProcess();
    var lblCallLengthObj = process.Findchild(["WPFControlText"],["Manage Call Length"],100)
    var parentObj = lblCallLengthObj.Parent
    var cmbBx_CallLength = parentObj.Findchild(["Name","Enabled"],["WPFObject(\"ComboBox\", \"\", 1)","True"],1)
    
    if (cmbBx_CallLength.Exists && cmbBx_CallLength.VisibleOnScreen) 
    {
        if(aqString.ToUpper(callLength)!=aqString.ToUpper(cmbBx_CallLength.wText))
        {
           for(i=0;i<cmbBx_CallLength.Items.Count;i++)
           {
             if(cmbBx_CallLength.Items.Item(i).Value.OleValue==callLength)
             {
               cmbBx_CallLength.ClickItem(i)
               break;
             }
           }
        }
    }
    else
    {
        Log.Error("Object not found")
    }
}

/*===============================================================================
Description: This function to expand or collapse Site Settings section in Admin Configuration screen
Parameters:
        action:expand/collapse
Return Value: 
=================================================================================*/
function ExpCollSiteSetting(action)
{
    if(aqString.ToUpper(action) == "EXPAND")
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_SiteSettings,"Site Settings"]))
        {
            ToScrollApplication("DOWN");
            delayExecution("1");
        }
        ExpandItem(btn_SiteSettings,"Site Settings")      
    }
    else
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_SiteSettings,"Site Settings"]))
        {
            ToScrollApplication("UP");
            delayExecution("1");
        }
        CollapseItem(btn_SiteSettings,"Site Settings")
    }
}

/*===============================================================================
Description: This function to expand or collapse Address Type section in Admin Configuration screen
Parameters:
        action:expand/collapse
Return Value: 
=================================================================================*/
function ExpCollAddressType(action)
{
    if(aqString.ToUpper(action) == "EXPAND")
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_AddressTypes,"Address Types"]))
        {
            ToScrollApplication("UP");
            delayExecution("1");
        }
        ExpandItem(btn_AddressTypes,"Address Types")      
    }
    else
    {
        CollapseItem(btn_AddressTypes,"Address Types")
    }
}

/*===============================================================================
Description: This function to expand or collapse Contact Type section in Admin Configuration screen
Parameters:
        action:expand/collapse
Return Value: 
=================================================================================*/
function ExpCollContactType(action)
{
    if(aqString.ToUpper(action) == "EXPAND")
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_ContactTypes,"Contact Types"]))
        {
            ToScrollApplication("UP");
            delayExecution("1");
        }
        ExpandItem(btn_ContactTypes,"Contact Types")      
    }
    else
    {
        CollapseItem(btn_ContactTypes,"Contact Types")
    }
}

/*===============================================================================
Description: This function to expand or collapse Signposting section in Admin Configuration screen
Parameters:
        action:expand/collapse
Return Value: 
=================================================================================*/
function ExpCollSignposting(action)
{
    if(aqString.ToUpper(action) == "EXPAND")
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_Signposting,"Signposting"]))
        {
            ToScrollApplication("DOWN");
            delayExecution("1");
        }
        ExpandItem(btn_Signposting,"Signposting")      
    }
    else
    {
        CollapseItem(btn_Signposting,"Signposting")
    }
}

/*===============================================================================
Description: This function to expand or collapse Urgency Variation Text section in Admin Configuration screen
Parameters:
        action:expand/collapse
Return Value: 
=================================================================================*/
function ExpCollUrgVariation(action)
{
    if(aqString.ToUpper(action) == "EXPAND")
    {
        if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_UrgencyVariationText,"Urgency Variation Text"]))
        {
            ToScrollApplication("DOWN");
            delayExecution("1");
        }
        ExpandItem(btn_UrgencyVariationText,"Urgency Variation Text")      
    }
    else
    {
        CollapseItem(btn_UrgencyVariationText,"Urgency Variation Text")
    }
}

/*===============================================================================
Description: This function to select Urgency Variation Text type from dropdown
Parameters:  
          variationType:Outcome Type(TeleAssess/CallHandler)
Return Value: 
=================================================================================*/
function SelectUrgVarType(variationType)
{
  var expUrgencyVariation = ToFindObj(["Name","WPFControlText"],[btn_UrgencyVariationText,"Urgency Variation Text"])
  var cmbUrgVarTypeObj = expUrgencyVariation.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBox\", \"\", 1)","True"],10)
  for(i=0;i<cmbUrgVarTypeObj.Items.Count;i++)
  {
     if(aqString.ToUpper(cmbUrgVarTypeObj.Items.item(i).Value.OleValue) == aqString.ToUpper(variationType))
     { 
         cmbUrgVarTypeObj.ClickItem(i)
         return true
     } 
  } 
  return false
}

/*===============================================================================
Description: This function to update Urgency Variation Reason message text/status under Urgency Variation Text
Parameters:
          status :Check/Uncheck/Blank
          existingMssg:
          newMssg:
Return Value:
=================================================================================*/
function UpdateUrgencyVariation(status,existingMssg,newMssg)
{
    if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_UrgencyVariationText,"Urgency Variation Text"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }    
    if(!ToFindObjToValidate(["Name","WPFControlText"], [btn_WPFButton,"Save Changes"]))
    {
        ToScrollApplication("DOWN");
        delayExecution("1");
    }
    obj_existingMssg = ToFindObj(["Name","VisibleOnScreen"],["WPFObject(\"AccessText\", \""+existingMssg+"*\", 1)","True"])
    obj_existingMssg.Click();
    
    txt_existingMssg = ToFindObj(["Name","wText","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)",existingMssg+"*","True"])
    if(status!="")
    {
        obj_parent = txt_existingMssg.Parent
        chkBx_IsActive = obj_parent.FindChild(["Name"],[chkBx_Active],5)
        if(chkBx_IsActive.Exists)
        {
            if(aqString.ToUpper(status)=="CHECK")
            {
               chkBx_IsActive.ClickButton(cbChecked);
               return true
            }
            else
            {
               chkBx_IsActive.ClickButton(cbUnchecked); 
               return false
            } 
        }
        else
        {
            Log.Error("Object not found")
        }
    }
    else
    {
        setText(newMssg, "", "", txt_existingMssg)
    }
}