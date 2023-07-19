﻿//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT ScreensOf3_12TreatmentPlan

/*===============================================================================
Description: This function is wait for the FTF History screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforFTFHistoryScreen()
{
  if(Project.Variables.Process == "INPROCESSNEW" && !ToCheckLablePresent("History Suggests:"))
  {
    ToScrollNewTestHarness("UP");
  }
  return waitForItemWithTime(btn_RemoveQuestionSet,"Remove Question Set",3)
}

/*===============================================================================
Description: This function to select answer of Questions
Parameters: 
          Ques:Question 
          Ans:Answer to select
Return Value: 
=================================================================================*/
function AnsweringFTFQues(Ques,Ans)
{
//   delayExecution(2)
   var Brk = false 
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
//var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount
   for (i=1;i<=ChildCount;i++)
   {
      var ListBoxItem = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],100)
      var Border1 = ListBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var TextBlock = Border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      var Text = TextBlock.WPFControlText
      if (aqString.ToUpper(Text)==aqString.ToUpper(Ques) )
      {
        var AnsPres = ListBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
         if(AnsPres.Exists)
         {
           var j=0
           for(i=0;i<AnsPres.DataContext.Answers.Count;)
           {
             
             j++
             if(AnsPres.DataContext.Answers.Item(i).DisplayText.OleValue==Ans)
             {
                AnsPres.Click()
//                delayExecution(2)
                var obj = process.FindChild(["Name","WPFControlText"],["WPFObject(\"ComboBoxItem\", \"\", "+j+")",Ans],100)
                if(obj.Exists)
                {
                  obj.Click()
                  delayExecution(2)
//                  AnsPres.Click()
                  Brk = true
                  break;
                }        
              }
              i++;
              if(i==AnsPres.DataContext.Answers.Count && Brk==false)
              {
                  Log.Warning(Ans+" is not found in assessment screen")
                  throw "Select answer action failed in AnsweringFTFQues function"                
                  Brk = true
              }
     
           }
        }
      } 
      if (Brk == true)
      {
        break
      } 
   } 
}

/*===============================================================================
Description: This function to select examination
Parameters: 
          examination:examination name to select
Return Value: 
=================================================================================*/
function selectExamination(examination)
{
  var process = GetProcess()
  var ftfExam = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"FtfExaminations\")","True"],100)
  var examinationObj = ftfExam.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examination+"*\", 1)"],20)
  if(examinationObj.Exists && examinationObj.VisibleOnScreen)
  {
    examinationObj.Click()
    return true;
  }
  else
  {
    return false;
  }
}

/*===============================================================================
Description: This function to select examination
Parameters: 
          examinationType:examination name to select
Return Value: 
=================================================================================*/
function selectExaminationType(examinationType)
{
  var process = GetProcess()
 // var examinationTypeObj = process.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examinationType+"*\", *)"],100)
  var examinationTypeObj = process.FindChild(["Name","WPFControlText"],["WPFObject(\"RadTabItem\", \"\", *)",examinationType+"*"],100)
  if(examinationTypeObj.Exists && examinationTypeObj.VisibleOnScreen)
  {
    examinationTypeObj.Click() 
  }
}

/*===============================================================================
Description: This function to select examination
Parameters: 
          examinationName:examination to select
Return Value: 
=================================================================================*/
function selectAdditionalExamination(examinationName)
{
  var process = GetProcess()
  var addExaminationOverlayObj = process.FindChild(["Name"],[obj_AddExaminationDialog],100)
  if(addExaminationOverlayObj.Exists && addExaminationOverlayObj.VisibleOnScreen)
  {
    var examToBeSelected =  addExaminationOverlayObj.FindChild(["Name","WPFControlText"],[btn_PresentComplaint,examinationName+"*"],100)
    if(examToBeSelected.Exists && examToBeSelected.VisibleOnScreen)
    {
      examToBeSelected.Click()
    }
    
  }
}
/*===============================================================================
Description: This function to add FTF note under History or Examination or Tretment notes grid 
Parameters: 
          noteType: History or Examination or Treatment
          noteText: note text to be entered
Return Value: 
=================================================================================*/
function addFTFNote(noteType,noteText)
{
  var process = GetProcess()
  noteType = GetNoteType(noteType);
  var noteTypeObj = process.FindChild(["WPFControlName"],[noteType+"NotesGrid"],100)
  if(noteTypeObj.Exists){
    var btn_addNote = noteTypeObj.FindChild(["Name"],["WPFObject(\"Button\", \"\", 1)"],100)
    if(btn_addNote.Exists && btn_addNote.Enabled)
    {
      btn_addNote.Click()
      
      var overlayObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Overlay\", \"\", *)","True"],100)
      if(overlayObj.Exists)
      {
        var noteObj;
        
        noteObj = overlayObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)","True"],100)
        if(!noteObj.Exists)
        {
          noteObj = overlayObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"NotesEditTextBox\")","True"],100)
        }
        setText(noteText,"","",noteObj)
      }
    }
  }  
}

/*===============================================================================
Description: This function is used to press [Enter] key of keyboard
Parameters:
           name:nameProperty
Return Value: NA
===============================================================================*/
function ToPressEnterKey(name)
{
  var obj=ToFindObj(["Name"], [name])
  obj.Click()
  obj.keys("[Enter]")
} 

/*===============================================================================
Description: This function is used to enter range exam value
Parameters:
           value:range Exam Value
Return Value: NA
===============================================================================*/
function EnterRangeExamDetails(value)
{
  setText(value,txt_ValueTextBox,"ValueTextBox","")
  ToPressEnterKey(txt_ValueTextBox)
} 
/*===============================================================================
Description: This function is used to select Exam Type and Details 
Parameters:
           examinationType:examination name to select
           examination:examination name to select
           value:range Exam Value
Return Value: NA
===============================================================================*/
function EnterRangeExamTypeAndDetails(examinationType,examination,value)
{ 
  selectExaminationType(examinationType);
  selectExamination(examination);
  EnterRangeExamDetails(value);
} 

/*===============================================================================
Description: This function to select examination option
Parameters: 
         exam:exam option to select
Return Value: 
=================================================================================*/
function selectExaminationOption(exam)
{
  var process = GetProcess()
  var examinationObj = process.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+exam+"*\", 1)"],100)
  if(examinationObj.Exists && examinationObj.VisibleOnScreen)
  {
    examinationObj.Click() 
    return true;
  }
  else
  {
    return false;
  }
}

/*===============================================================================
Description: This function to select examination and name to select
Parameters: 
          examinationType:examination name to select
          examination:examination name to select
          exam:exam option to select
          wpfControlText:wpfControlText property value
Return Value: 
=================================================================================*/
function selectExaminationTypeAndName(examinationType,examination,exam,wpfControlText)
{
  selectExaminationType(examinationType);
  selectExamination(examination);
  selectExaminationOption(exam);
  clickItem(lbl_ExaminationResponse,wpfControlText);
}

/*===============================================================================
Description: This function to check multiple values added for an exam under Show Findings
Parameters: 
          examType:Type of exam
          examName:Name of exam(blank for range)
          valueList:List of value entered/selected
Return Value: true/false
=================================================================================*/
function ToValidateMultipleShowFindings(examType,examName,valueList)
{
  var process = GetProcess()
  var expExamValuesArr = valueList.split(",")
  
  var Exam = process.FindChild(["Name"],["WPFObject(\"DataGrid\", \"\", 1)"],100)
  var examRecords = Exam.FindAllChildren(["Name"],["WPFObject(\"DataGridRow\", \"\", *)"],100).toArray();

   if (examRecords.length>0) 
   {
      var i,j,status;
      var count=0;
      for(i=0;i<examRecords.length; i++)
      {
        
        if(examName=="")
        {
           var currentRecord = examRecords[i]
           var descriptionObj = currentRecord.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examType+"*\", 1)"],20)
           if(descriptionObj.Exists)
           {              
              status = false;
              for(j=0;j<expExamValuesArr.length;j++)
              {
                var parent = currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"DataGridCell\", \"\", 3)","True"],20)
                var obj = parent.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \"*\", 1)","True"],20)
                if(aqString.ToUpper(obj.WPFControlText)==aqString.ToUpper(expExamValuesArr[j]))
                {
                  status = true;
                  count++;
                  Log.Message(obj.WPFControlText+" matched for "+examType)
                  break;
                }
                else
                {
                  continue;
                }
              }
              if(status != true)
              {
                Log.Message(obj.WPFControlText+" Not matched for "+examType)
              }
           }
           else
           {
             continue;
           }
        }
        else
        {
          var currentRecord1 = examRecords[i]
          var descriptionObj1 = currentRecord1.FindChild(["ClrClassName","WPFControlText","VisibleOnScreen"],["TextBlock",examType+"*"+examName,"True"],100)
          if(descriptionObj1.Exists)
          {
            status = false;
            for(j=0;j<expExamValuesArr.length;j++)
            {
              var parent = currentRecord1.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"DataGridCell\", \"\", 3)","True"],20)
              var obj = parent.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \"*\", 1)","True"],20)
              if(aqString.ToUpper(obj.WPFControlText)==aqString.ToUpper(expExamValuesArr[j]))
              {
                status = true;
                count++;
                Log.Message(obj.WPFControlText+" matched for "+examType)
                break;
              }
              else
              {
                continue;
              }
            }
            if(status != true)
            {
              Log.Message(obj.WPFControlText+" Not matched for "+examType)
            }             
          }
          else
          {
            continue;
          } 
        }          
      }
      if(count==expExamValuesArr.length)
      {
        Log.Message("All the Examinations findings matched")
        return true;
      }
      else
      {
        Log.Message("All the Examinations findings not matched")
        return false;
      }
    }
    else
    {
      Log.Message("No records present under Findings")
      return false;
    }
}
/*===============================================================================
Description: This function to check tickmark against an examination
Parameters: 
          examination:examination name to select
Return Value:true/false
=================================================================================*/
function ToCheckExamTickMark(examination)
{
  var process = GetProcess()
  var ftfExam = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"FtfExaminations\")","True"],100)
  var examinationObj = ftfExam.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examination+"*\", 1)"],20)
  if(examinationObj.Exists && examinationObj.VisibleOnScreen)
  {
    var parent_Obj = examinationObj.parent
    var tickIcon_obj = parent_Obj.FindChild(["Name"],[icon_Tick],20)

      if(tickIcon_obj.Exists && tickIcon_obj.VisibleOnScreen)
      {
        Log.Message(examination+" is checked")
        return true;
      }
      else
      {
        Log.Message(examination+" is not checked")
        return false;        
      }
  }
  else
  {
    Log.Message(examination+" is not visible")
  }
}

/*===============================================================================
Description: This function to validate the range Examination message for invalid value
Parameters: 
         examinationType:examination name to select
         messgText:messg text to be validated/""
         value:range Exam Value
         name:nameProperty
Return Value: true/false
=================================================================================*/
function ToCheckRangeExamErrMssg(examinationType,examination,value,messgText)
{
  var process = GetProcess()
//  EnterRangeExamTypeAndDetails(examinationType,examination,value,txt_ValueTextBox)
  selectExaminationType(examinationType);
  selectExamination(examination);
  EnterRangeExamDetails(value);
  
  var errMssgBoxObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"MessageBoxControl\")","True"],100)
  
  var errMssgObj = errMssgBoxObj.FindChild(["ClrClassName","VisibleOnScreen"],["TextBlock","True"],20)
  
  if(errMssgObj.Exists)
  {   
    var btn_OKObj = errMssgBoxObj.FindChild(["Name","VisibleOnScreen"],[btn_OK,"True"],20)
    if(btn_OKObj.Exists)
    {
      btn_OKObj.Click()
      return true;
    }
    else
    {
      Log.Warning("Click action on OK failed in ToCheckRangeExamErrMssg function")
      throw "Click action on OK failed in ToCheckRangeExamErrMssg function"
    }  
  }
}
/*===============================================================================
Description: This function to select choice examination having dual laterality(Left & Right)
Parameters: 
          examinationType:examination name to select
          examination:examination name to select
          exam:exam option to select
          laterality:Left/Right
          answer:wpfControlText property value of answer
Return Value: 
=================================================================================*/
function SelectExamTypeWithDualLaterality(examinationType,examination,exam,laterality,answer)
{
  selectExaminationType(examinationType);
  selectExamination(examination);
  selectExaminationOption(exam);
  
  var process = GetProcess();
  var header;
  if(aqString.ToUpper(laterality)=="LEFT")
  {
    header="Left";
  }
  else
  {
    header="Right";
  }
  
  var header_obj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+header+"\", *)","True"],100)
  if(header_obj.Exists)
  {
    var parent = header_obj.parent;
    var answer_obj = parent.FindChild(["WPFControlText","VisibleOnScreen"],[answer,"True"],100)
    if(answer_obj.Exists)
    {
      answer_obj.Click();
    }
    else
    {
      Log.Warning("Click action of "+answer+" for "+laterality+" laterality failed in SelectExamTypeWithDualLaterality function")
      throw "Click action failed in SelectExamTypeWithDualLaterality function"      
    }
  }
  else
  {
    Log.Warning("Answer section not found in Examination tab")
  }
}

/*===============================================================================
Description: This function to validate range exam value
Parameters: 
         expVal:range Exam Value
Return Value: true/false
=================================================================================*/
function ToCheckRangeExamValue(expValue)
{
  var actValue = getTextFromTextBox(txt_ValueTextBox,"ValueTextBox")
  
  if(actValue==expValue)
  {
    return true;
  }
  else
  {
    return false;
  }
}
/*===============================================================================
Description: This function to check details added for an exam having dual laterality under Findings grid
Parameters: 
          examType:Type of exam
          examName:Name of exam(blank for range)
          laterality:Left/Right
          expValue:value to be checked for
Return Value: true/false
=================================================================================*/
function ToValFindingsWithLaterality(examType,examName,laterality,expValue)
{
   var laterality1;
   if(aqString.ToUpper(laterality)=="LEFT")
   {
      laterality1="Left";
   }
   else
   {
      laterality1="Right";
   }

   var process = GetProcess();
   var Exam = process.FindChild(["Name"],["WPFObject(\"DataGrid\", \"\", 1)"],100)
   var examRecords = Exam.FindAllChildren(["Name"],["WPFObject(\"DataGridRow\", \"\", *)"],100).toArray(); 
   if (examRecords.length>0) 
   {
      var i;
      for(i=0;i<examRecords.length; i++)
      {
          var currentRecord = examRecords[i]
          var descriptionObj = currentRecord.FindChild(["ClrClassName","WPFControlText","VisibleOnScreen"],["TextBlock",examType+"*"+examName+"*"+laterality1,"True"],100)
          
          if(descriptionObj.Exists)
          {
            var descriptionObj2=currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+expValue+"*\", 1)","True"],20)
            if(descriptionObj2.Exists)
            {
              Log.Message("Exam record and details found under Findings")
              return true;
            }
            else
            {
              Log.Message("Details of exam record not matched under Findings")
              return false;
            }  
          }          
      }
      if(i==examRecords.length)
      {
        Log.Message("Exam record not found under Findings")
        return false;
      }
   }
   else
   {
      Log.Message("No records present under Findings")
      return false;
   }  
}

/*===============================================================================
Description: This function to check FTF note under History or Examination or Tretment notes grid 
Parameters: 
          noteType: History or Examination or Treatment
          noteText: note text to be entered
Return Value: 
=================================================================================*/
function ToCheckFTFNote(noteType,noteText)
{
  var process = GetProcess()
  noteType = GetNoteType(noteType);
  var noteTypeObj = process.FindChild(["WPFControlName"],[noteType+"NotesGrid"],100)
  if(noteTypeObj.Exists)
  {
    var noteObj = noteTypeObj.FindChild(["Name","WPFControlText"],["WPFObject(\"TextBlock\", \"\", 1)","Note:  "+noteText],100)
    if(noteObj.Exists && noteObj.VisibleOnScreen)
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
Description: This function to return correct note type - History or Examination or Tretment note
Parameters: 
          noteType: History or Examination or Treatment
Return Value:noteTypeAct
=================================================================================*/
function GetNoteType(noteType)
{
  switch(aqString.ToUpper(noteType))
  {
    case "HISTORY":
      return "History";
      break;
    case "EXAMINATION":
      return "Examination";
      break;
    case "TREATMENT":
      return "Treatment"
  }
}

/*===============================================================================
Description: This function to check whether history section display in left side of the assessment screen.
Parameters:
         Section: Section which can be examination/History/Treatment plan 
         Ques: Assessment questions
         Ans: Assessment answers
Return Value: true/false
=================================================================================*/
function ToCheckDetailsPresentInNoteSection(Section,Ques,Ans)
{ 
   if(aqString.ToUpper(Section)=="HISTORY")
   {
     Section = "HistoryNotesGrid"
   }
  var process = GetProcess();
  var noteSection = process.FindChild(["WPFControlName","VisibleOnScreen"],[Section,"True"],100)
  if(noteSection.Exists)
  {
    //AnsweringFTFQues(Ques,Ans);
    var Ques_Obj = noteSection.FindChild(["WPFControlText","VisibleOnScreen"],[Ques+"*","True"],100)
  
    if(Ques_Obj.Exists) 
    {
      var parent = Ques_Obj.parent;
      var answer_Obj = parent.FindChild(["WPFControlText","VisibleOnScreen"],[Ans+"*","True"],100)
      if(answer_Obj.Exists)
      {
        Log.Message("Answerd question "+Ques+" and its answer "+Ans+" logged under "+Section)
        return true;
      }
      else
      {
        Log.Message("Answerd question "+Ques+" and its answer "+Ans+" is not logged under "+Section)
        return false;
      }
    }
  } 
}

/*===============================================================================
Description: This function to validate the show findings
Parameters: 
          type:HISTORY/EXAMINATION
          message:Urgency message/""(blank)     
Return Value: true/false
=================================================================================*/
function ToValidUrgency(type,message)
{
  var process=GetProcess()
  
  var messageObj
  switch(aqString.ToUpper(type))
  {
     case "HISTORY":
        messageObj = process.FindChild(["Name","VisibleOnScreen"],[txt_History,"True"],100)
        if(aqString.ToUpper(message)==aqString.ToUpper(messageObj.Text))
        {
          Log.Message("History urgency messg "+message+" is displaying")
          return true
         }
         else
         {
          Log.Message("History urgency messg "+message+" is not displaying")
          return false;           
         }
          
        break;
      case "EXAMINATION":
         messageObj = process.FindChild(["Name","VisibleOnScreen"],[txt_Examination,"True"],100);
         if(aqString.ToUpper(message)==aqString.ToUpper(messageObj.Text))
         {
           Log.Message("Examination urgency messg "+message+" is displaying")
           return true
         }
         else
         {
          Log.Message("Examination urgency messg "+message+" is not displaying")
          return false; 
            
          }   
          break; 
  }
}
/*===============================================================================
Description: This function to check button present on examination/History/Treatment plan 
Parameters: 
          noteType:examination/History/Treatment plan  
          BtnName:Button Name
Return Value: 
=================================================================================*/
function ToChckButtons(noteType,BtnName)
{
  noteType = GetNoteType(noteType);
  return ToFindObjToValidate(["Name","WPFControlText"],["WPFObject(\"RadTabItem\", \"\", *)",BtnName])
} 

/*===============================================================================
Description: This function to check application version on Login or any other screen
Parameters: 
          expAppVer: expected application version
          screen: Login/Lock/Inprocess/""(blank for any screens of Standalone)
Return Value:true/false
=================================================================================*/
function ToCheckAppVersion(expAppVer,screen)
{
  var process = GetProcess()
  var appVersObj
  if(screen!="")
  {
    var parent = process.FindChild(["Name","Visible"],["WPFObject(\"Version\", \"\", *)","True"],100)
    if(parent.Exists)
    {
      appVersObj = parent.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", *)"],10)
      
      if(aqString.Find(appVersObj.WPFControlText, expAppVer) != -1)
      {
        Log.Message("Application version matched :: "+expAppVer)
        return true;
      }
      else
      {
        Log.Message("Application version not matching :: "+expAppVer)
        return false;
      }
    }
    else
    {
      Log.Message("Application version not displayed")
      return false;      
    }
  }
  else
  {
    appVersObj = process.FindChild(["Name","WPFControlText","VisibleOnScreen"],["WPFObject(\"versionLabel\")",expAppVer+"*","True"],100)
    if(appVersObj.Exists)
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
Description: This function to check content version used for the application.
Parameters: 
          expContentVer : expected content version
          expCulture : expected Culture(en)
          expLocation : expected Location(GB/NZ/AU...)
Return Value:true/false
=================================================================================*/
function ToCheckContentVersion(expContentVer,expCulture,expLocation)
{
  var process = GetProcess()
  
  expContentVer = aqString.Trim(expContentVer)
  expCulture = aqString.ToLower(aqString.Trim(expCulture))
  expLocation = aqString.ToUpper(aqString.Trim(expLocation))
  
  var obj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"versionLabel\")","True"],100)
  if(obj.Exists)
  {
    var parentObj = obj.parent;
    var contentVersObj = parentObj.FindChild(["WPFControlText","VisibleOnScreen"],["TeleAssess "+expContentVer+" "+expCulture+"-"+expLocation,"True"],100)
    
    if(contentVersObj.Exists)
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
    Log.Message("Content version not displayed")
    return false;
  }
}

/*===============================================================================
Description: This function to compare application version of Login screen with any other screen
Parameters: 
Return Value:true/false 
=================================================================================*/
function ToCompareAppVersion()
{
  var process = GetProcess()
  appVersObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"versionLabel\")","True"],100)
  if(appVersObj.Exists)
  {
    if(appVersObj.WPFControlText == appVersion)
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
    Log.Message("Application version not displayed")
    return false;
  } 
}
/*===============================================================================
Description: This function to check note added under examination notes grid for Consent To Examination check box
Parameters: 
Return Value:true/false 
=================================================================================*/
function ToCheckConsentToExamNote()
{
  var process = GetProcess()
  var noteTypeObj = process.FindChild(["WPFControlName"],["ExaminationNotesGrid"],100)
  if(noteTypeObj.Exists)
  {
    var noteObj = noteTypeObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ContentPresenter\", \"\", 1)","True"],30)
    if(noteObj.Exists)
    {
      var obj = noteObj.FindChild(["Text","VisibleOnScreen"],["Patient consented to examination","True"],30)
      if(obj.Exists)
      {
        return true;
      }
      else
      {
        Log.Message("Patient consented to examination is not displayed")
        return false;
      }
    }
    else
    {
      //Log.Message("No Exam notes displayed under section")
      return false;
    }
  } 
  else
  {
    Log.Message("Exam notes grid not displayed")
    return false;    
  }
}

/*===============================================================================
Description: This function to check whether examination section display key exam details in left side of the assessment screen.
Parameters:
          group:STANDRAD OBS/CLINCIAN GEN OBS ...
          examType:Type of exam
          examName:Name of exam(blank for range)
          valueList:List of value entered/selected
Return Value: true/false
=================================================================================*/
function ToCheckDetailsAddedInExamNoteSection(group,examType,examName,valueList)
{
  var process=GetProcess()
  valueList = aqString.Replace(valueList,",",", ")
  var examinationNotesGridObj=process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"ExaminationNotesGrid\")","True"],100)
  var actionObj=examinationNotesGridObj.FindChild(["Name"],["WPFObject(\"ItemsControl\")"],50)
  var action=actionObj.ChildCount
  if(action>0)
  {
    for(var i=1; i<=action; i++)
    {     
       var currentRecord = actionObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ContentPresenter\", \"\", "+i+")","True"],3)     
       var groupObj = currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+group+"\", *)","True"],10)     
       if(groupObj.Exists)
       {
          if(examName=="")
          {    
             var description=currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+examType+"\", 1)","True"],20)
             if(description.Exists)
             {  
              
                var descriptionObj1=currentRecord.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examType+"*"+valueList+"*\", 1)"],100)
                if(descriptionObj1.Exists)
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
            else 
            {
              var descriptionObj2=currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+examType+"\", 1)","True"],20)
              if(descriptionObj2.Exists)
              {
                 var descriptionObj3=currentRecord.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examName+"*"+valueList+"*\", 1)"],100)
                 if(descriptionObj3.Exists)
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
       else
       {
        Log.Message("Move to next group");
       }
    }
  }
  else
  {
    Log.Message("No exam records added under ExamNotesgrid");
    return false;
  }
}

/*===============================================================================
Description: This function is used to press keyboard keys
Parameters:
             proArr: Property name in the array
             propValueArr: property value in the array
             keyToPress:keyboard to be pressed
Return Value: NA
===============================================================================*/
function ToPressKeyboardKeys(proArr,propValueArr,keyToPress)
{
  var obj = ToFindObj(proArr, propValueArr)
  obj.keys(keyToPress)
} 

/*====================================================================================
Description: This function check Remove Question set popup
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToChckRemoveQuestionSetPopUp()
{
 return ToFindObjToValidate(["Name"], ["WPFObject(\"CloseQuestionSetOverlay\", *)"],100)
}  

/*====================================================================================
Description: This function checks the current status(checked/unchecked) of any checkbox
Parameters:
          name:Name property of the object
          status:Checked or Unchecked
Return Value: True/False
=====================================================================================*/
function ToValCheckBoxStatus(name,status)
{
  var obj = ToFindObj(["Name"], [name]);
  var currentStatus = obj.IsChecked.OleValue;
  if(aqString.ToUpper(status)=="CHECKED")
  {
    if(currentStatus)
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
    if(!currentStatus)
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
Description: This function to validate the color of show findings
Parameters: 
          type:HISTORY/EXAMINATION
          message:Urgency message/""(blank)
          expColor:font colour of action note or Blank(Red/Yellow/Black/"")
               
Return Value: true/false
=================================================================================*/
function ToCheckExaminationBannerColor(type,message,expColor)
{
var process=GetProcess()
  ToValidUrgency(type,message)
   switch(aqString.ToUpper(type))
  {
     case "HISTORY":
          // var process=GetProcess()
         var messageObj = process.FindChild(["Name","VisibleOnScreen"],[txt_History,"True"],100)
          if(ToCheckActionColour(messageObj,expColor))
          {
          Log.Message("Colour of action  "+message+" matched")
          return true;
          }
         else
          {
          Log.Message("Colour of action "+message+" not matched")
          return false;          
           }
     case "EXAMINATION":
         messageObj = process.FindChild(["Name","VisibleOnScreen"],[txt_Examination,"True"],100);
         if(ToCheckActionColour(messageObj,expColor))
          {
          Log.Message("Colour of action  "+message+" matched")
          return true;
          }
         else
          {
          Log.Message("Colour of action "+message+" not matched")
          return false;          
           }
    }
}

/*===============================================================================
Description: This function to check whether examination section display in left side of the assessment screen.
Parameters:
          group:STANDRAD OBS/CLINCIAN GEN OBS 
          examType:Type of exam
          examName:Name of exam(blank for range)
          valueList:List of value entered/selected
Return Value: true/false
=================================================================================*/
function ToCheckDetailsPresentInExaminationNoteSection(group,examType,examName,valueList)
{
  var process=GetProcess()
  valueList = aqString.Replace(valueList,",",", ")
  var examinationNotesGridObj=process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"ExaminationNotesGrid\")","True"],100)
  var scroll=examinationNotesGridObj.FindChild(["Name"],["WPFObject(\"ScrollViewer\", \"\", 1)"],100)
  var actionObj=examinationNotesGridObj.FindChild(["Name"],["WPFObject(\"ItemsControl\")"],50)
  var action=actionObj.ChildCount
  
  if(action>0)
  {
    for(var i=1; i<=action; i++)
    {     
       var currentRecord = actionObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ContentPresenter\", \"\", "+i+")","True"],20)     
       var groupObj = currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+group+"\", *)","True"],10)
       if(groupObj.Exists)
       {
          if(examName=="")
          {    
             var description=currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+examType+"\", 1)","True"],20)
             if(description.Exists)
             {      
                var descriptionObj1=currentRecord.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examType+"*"+valueList+"*\", 1)"],100)
                if(descriptionObj1.Exists)
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
            else 
            {
          
              var descriptionObj2=currentRecord.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \""+examType+"\", 1)","True"],20)
              if(descriptionObj2.Exists)
              {
                var descriptionObj3=currentRecord.FindChild(["Name"],["WPFObject(\"TextBlock\", \""+examName+"*"+valueList+"*\", 1)"],100)
                 if(descriptionObj3.Exists)
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
       else
       {
        Log.Message("Move to next group"); 
        if(scroll.Exists)
        {
          var count = scroll.ScrollableHeight
          if(count>0)
          {
            scroll.VScroll.Pos = count-1
          }
        }  
       }
    }
  }
  else
  {
    Log.Message("No exam records added under ExamNotesgrid");
    return false;
  }
}

/*===============================================================================
Description: This function to check the banner details(History  and Examination Suggests) of FTF
Parameters: 
             detail: detail need to check
              expColor:font colour of action note or Blank(Blue)
Return Value: 
=================================================================================*/
function CheckUrgencyDetails(detail,expColor)
{
    var Process = GetProcess()
    switch (aqString.ToUpper(detail))
    {   
      case "HISTORY":
        var obj= Process.FindChild(["Name","VisibleOnScreen"],[txt_History,"True"],100)
        ToCheckActionColour(obj,expColor)
        return true
        break;
       
      case "EXAMINATION":
        var obj= Process.FindChild(["Name","VisibleOnScreen"],[txt_Examination,"True"],100);
        ToCheckActionColour(obj,expColor)
        return true
        break;
    } 
}
/*===============================================================================
Description: This function is wait for the FTF History screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforFTFExaminationScreen()
{
 return waitForItemWithTime(btn_AddExamination,"Add Examination",3)
}

/*===============================================================================
Description: This function is to check for selected Answer for a single select question in FTF history screen
Parameters:
            shortQues: ShortQuestion
            ans: Answer
Return Value: true/false
=================================================================================*/
function ToCheckSelectedAnsFTF(shortQues,ans)
{
//   delayExecution(2)
   var i
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
//var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount
   for (i=1;i<ChildCount;i++)
   {
      var ListBoxItem = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],100)
      var Border1 = ListBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var TextBlock = Border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      var Text = TextBlock.WPFControlText
      if (aqString.ToUpper(Text)==aqString.ToUpper(shortQues) )
      {
        var AnsPres = ListBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
         if(AnsPres.Exists)
         {
            var ansObj = AnsPres.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
             if(ansObj.WPFControlText==ans)
             {
                return true                         
             }    
             else
             {
               return false
               Log.Warning(ans+" Answer is missing")
             }
        }
      } 
   } 
   if(i==ChildCount)
   {
     return false
     Log.Warning(shortQues+" shortQues is missing")
   }
}

/*===============================================================================
Description: This function is to scroll NewTestHarness application
Parameters:
          scroll:UP/DOWN
Return Value: 
=================================================================================*/
function ToScrollNewTestHarness(scroll)
{
  var scrollBarObj = ToFindObj(["Name"], [scroll_TestHarness])
  if(scrollBarObj.Exists)
  {
    if(aqString.ToUpper(scroll)=="UP")
    {
      RightClick(scroll_TestHarness,"","","","")
      clickItem("WPFObject(\"MenuItem\", \"Page Up\", 6)","Page Up")
    }
    else
    {
      RightClick(scroll_TestHarness,"","","","")
      clickItem("WPFObject(\"MenuItem\", \"Page Down\", 7)","Page Down")
    }
  }
}
/*===============================================================================
Description: This function is to scroll main application grid
Parameters:
          scroll:UP/DOWN
Return Value: 
=================================================================================*/
function ToScrollApplication(scroll)
{
  Sys.Refresh();
  Process = GetProcess()
  var obj_MainControlGrid = Process.FindChild(["Name"], ["WPFObject(\"MainControlGrid\")"], 100);
  if(!obj_MainControlGrid.Exists)
     obj_MainControlGrid = Process.FindChild(["Name"], ["WPFObject(\"OdysseyMainGrid\")"], 100); 
  
  var scrollBarObj = obj_MainControlGrid.FindChild(["Name","VisibleOnScreen"], ["WPFObject(\"ScrollBar\", \"\", 1)","True"],50)
  if(scrollBarObj.Exists)
  {
    if(aqString.ToUpper(scroll)=="UP")
    {
      scrollBarObj.ClickR()
      clickItem("WPFObject(\"MenuItem\", \"Top\", 2)","Top")
//      scrollBarObj.PopupMenu.Click("Page Up");
        //scrollBarObj.wPosition = 0;
    }
    else
    {
      scrollBarObj.ClickR()
      clickItem("WPFObject(\"MenuItem\", \"Bottom\", 3)","Bottom")
//      scrollBarObj.PopupMenu.Click("Page Down");
      //scrollBarObj.wPosition = scrollBarObj.wMax;
    }
  }
}

