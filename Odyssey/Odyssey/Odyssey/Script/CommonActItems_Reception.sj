//USEUNIT CommonActItems_Clinician
//USEUNIT CommonFunctions
//USEUNIT DefaultScreen
//USEUNIT LoginScreen
//USEUNIT PageObjects
//USEUNIT PresentingCompliantScreen

/*===============================================================================
Description: This function is wait for the reception screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforReceptionscreen()
{
  if(Project.Variables.Process=="STANDALONE")
  {
    waitForItemWithTime(btn_SaveCalltoQueue,"Save call to queue",2) 
  }
  else
  {
    waitForItemWithTime(btn_WPFButton,"Pass to Nurse",2) 
  }
}

/*===============================================================================
Description: This function to launch and login and add patients in the queue
Parameters: 
Return Value: 
=================================================================================*/
function AddPatientsInTheQueue()
{
  LaunchApplication()
  Login(Project.Variables.ReceptionUsername,Project.Variables.ReceptionPassword)
  AddPatientsInReception()
}
/*===============================================================================
Description: This function to Add Patients in the queue
Parameters: 
Return Value: 
=================================================================================*/
function AddPatientsInReception()
{
    Process = GetProcess()
    var obj = Process.FindChild(["Name"],[lbl_QueueIsEmpty],100)
    if(obj.Exists)
    {
      n=21;
    }
    else
    {
        var obj = Process.FindChild(["Name"],[lbl_QueueCount],100)
        var txt = obj.WPFControlText
        txt=txt.split(" ");
        n=txt[0]
        n=21-n
    }
    if (n!=0)
    {
        for (i=1;i<=n;i++)
        {
            LoadingDone()
            clickItem(btn_UseAnonymousPatient,"Use anonymous patient")
            setText("54",txt_ApproximateAge,"ApproximateAge","")
            selectGender("Female")
            clickItem(btn_WPFButton,"Continue")
            waitforPresentingScreen()
            clickItem(btn_PresentComplaint,"Abdomen / Stomach")
            clickItem(btn_PresentComplaint,"Abdominal injury")
            setText("7566576",txt_ContactInfo,"ContactInfoTextBox","")
            clickItem(btn_WPFButton,"Proceed to Odyssey Reception")
            waitforReceptionscreen()
            clickItem(btn_SaveCalltoQueue,"Save call to queue")
        }
    }
}
 
/*===============================================================================
Description: This function to find the Ques List object
Parameters: 
           ListNo: 1 or 2 or 3 or 4
Return Value:
=================================================================================*/
function ToFindQuesListObject(ListNo)
{
  var process = GetProcess()
  var QuesList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
  var Listitem = QuesList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+ListNo+")"],100)
  var AnsList = Listitem.FindChild(["Name"],["WPFObject(\"AnswerList\")"],10)
  return AnsList
} 

/*===============================================================================
Description: Function to select Answers from question list
Parameters: 
           ListNo: ListNumber
           ItemName : Item Name
Return Value: 
=================================================================================*/
function ToSelectAnsForQuesListInAssesmtnScreen(ListNo,ItemName)
{
  var obj = ToFindQuesListObject(ListNo)
  return selectComboBoxByIndex("",ItemName,obj)
} 

/*===============================================================================
Description: Function to select Selected Urgency Combo box
Parameters: 
          ItemName: ItemName to select
Return Value: 
=================================================================================*/
function ToSelectSelectedUrgency(ItemName)
{
  var label = ToFindObj(["Name"],["WPFObject(\"TextBlock\", \"Recommended queue urgency: \", 1)"])
  var par = label.Parent
  var CmbBox = par.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],100)
  return selectComboBoxByIndex("",ItemName,CmbBox)
} 

/*===============================================================================
Description: This function is to check whether notes has been saved
Parameters: 
Return Value: 
=================================================================================*/
function ToChcNotesSavedItemCountRecp()
{
  Sys.Refresh()
  Process = GetProcess()
  var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"TextBlock\", \"Notes\", *)"],100)
  var obj = SummaryLable.Parent
  var noteslist = obj.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", *)","True"],10).toArray();
  var cnt = noteslist.length
  Log.Message(cnt)
  return cnt
} 

/*===============================================================================
Description: This function is to wait for Reception assessment screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforRecpAssessmentScreen()
{
  return waitForItemWithTime(txt_Complianceof," Complains of ",2 )
} 

/*===============================================================================
Description: This function is to validate Close Assessment button
Parameters: 
Return Value: 
=================================================================================*/
function ToValidateCloseAssessmentBtn()
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"Button\", \"Return to Assessment\", *)"],100)
  var parObj = obj.parent
  var obj1 = parObj.FindChild(["Name"],["WPFObject(\"Button\", \"Close Assessment\", *)"],100)
  if ((obj1.Exists) && (obj1.enabled))
  {
    return true
  } 
  else
  {
    return false
  } 
} 

/*===============================================================================
Description: This function is to validate Selected Urgency
Parameters: 
Return Value: 
=================================================================================*/
function SelectedUrgency()
{
  var process = GetProcess()
  var recomendedQueueUrgencyText = process.Findchild(["Name"],["WPFObject(\"TextBlock\", \"Recommended queue urgency: \", 1)"],100)
  var Grid = recomendedQueueUrgencyText.parent
  var obj = Grid.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBox\", \"\", 1)",true],100)
  return obj.Text.OleValue
} 

/*====================================================================================
Description: This function is to check the selected items from the single select combobox in assessment screen
Parameters: 
          quesNum: 1 or 2 or 3 .....
          selectedAnswer:SelectedItem/Blank
Return Value: True/False
=====================================================================================*/
function ToCheckSelectedAnswerReception(quesNum,selectedAnswer)
{
    var quesObj = ToFindQuesListObject(quesNum)
    
    //To validating blank questions
    if(selectedAnswer=="" || aqString.ToUpper(selectedAnswer)=="BLANK" || aqString.ToUpper(selectedAnswer)=="EMPTY")
    {
      if(quesObj.ChildCount == 0)
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
      var obj = quesObj.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],20)
      if(obj.Exists)
      {
        if(aqString.ToUpper(obj.WPFControlText)==aqString.ToUpper(selectedAnswer))
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
        return false
      }
    }
}

/*===============================================================================
Description: Function to select Answers from Muti Select Question
Parameters: 
           1istNo: List Number
           answer : answer to be selected
Return Value: 
=================================================================================*/
function SelectAnsForMutiSelQuesReception(ListNo,answer)
{
  var process = GetProcess()
  var QuesList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
  var Listitem = QuesList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+ListNo+")"],100)
  var quesObj = Listitem.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"CheckableCombo\")","True"],20)
  
  quesObj.Click()
        
  var nameValue = "WPFObject(\"CheckBox\", \""+answer+"\", 1)"
        
  var ansObj = process.FindChild(["Name","VisibleOnScreen"],[nameValue,"True"],100)
  if(ansObj.Exists)
  {
    ansObj.Click()    
  }
  Listitem.Click()
}
/*===============================================================================
Description: This function to count number of questions in reception
Parameters: 
          Count: Count no.of question present in assessment screen
Return Value: 
=================================================================================*/
function ToCheckAdditionalQues(Count)
{
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount-1
   if(Count == ChildCount)
   {
     return true
   }
   else
   {
     return false
   }
}
/*===============================================================================
Description: This function is to select Patient Outcome in reception assessment screen
Parameters: 
          patientOutcome:patientOutcome value
Return Value: 
=================================================================================*/
function SelectPatOutcomeRecep(patientOutcome)
{
  Process = GetProcess()
  if (Process.Exists) 
  {
    var currentItem = Process.FindChild(["Name"],[lbl_PatientOutcome],100);
    if (currentItem.Exists && currentItem.VisibleOnScreen) 
    {
      var parentObj = currentItem.Parent;
      var patientOutcomeObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBox\", \"\", 1)","True"],100);
      selectComboBoxByIndex("",patientOutcome,patientOutcomeObj)
    }
    else
    {
              
    }
  }
}
/*===============================================================================
Description: This function is to wait for Summry Report screen for Recepton/Clinician user
Parameters: 
Return Value: 
=================================================================================*/
function waitforSummaryReportScreen()
{
  return waitForInformationMessageTrueOrFalse(["Name"], [obj_InternetExpl]);
} 
/*===============================================================================
Description: This function is to check for warning message displayed for old clinical content file being used
Parameters: 
          latestversion:latest content version
Return Value: true/false
=================================================================================*/
function ToValOldContentWarning(latestversion)
{
   warnMessage = "Clinical Content Version "+latestversion+" is now available. This version will be applied automatically in 14 day(s). Using out of date content may carry risk."
   
   return ToCheckLablePresent(warnMessage)
}

/*===============================================================================
Description: This function is to check enter notes text
Parameters: 
          note:note text
Return Value: 
=================================================================================*/
function EnterNotesText(note)
{
  Process = GetProcess()
  var noteslist = Process.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"NotesTextBox\")","True"],100).toArray();
  setText(note,"","",noteslist[1])
} 
/*===============================================================================
Description: This function is to check the selected Patient Outcome in reception assessment screen
Parameters: 
          patientOutcome:patientOutcome value
Return Value: 
=================================================================================*/
function ToChckPatOutSelectedRecep(patientOutcome)
{
    Process = GetProcess()
    if (Process.Exists) 
    {
        var currentItem = Process.FindChild(["Name"],[lbl_PatientOutcome],100);
        if (currentItem.Exists && currentItem.VisibleOnScreen) 
        {
            var parentObj = currentItem.Parent;
            var patientOutcomeObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBox\", \"\", 1)","True"],10);
            if(aqString.ToUpper(patientOutcomeObj.wText)==aqString.ToUpper(patientOutcome))
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
              
        }
    }
}