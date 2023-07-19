//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT ScreensOf3_12TreatmentPlan
//USEUNIT TestHarnessScreen

/*===============================================================================
Description: This function is wait for the Assessment screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforAssessmentScreen()
{
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    var process = GetProcess();
    var patientDetailsWnd =  process.FindChild(["Name","VisibleOnScreen"],[PopUpMsg_IntPatientDet,"True"],50)
    if(patientDetailsWnd!=undefined && patientDetailsWnd.Exists)
    {
      clickItem(btn_Ok1, "Ok")
    }  
  }
  return waitForItemWithTime(btn_SwitchView,"Switch View",2)
}

/*===============================================================================
Description: This function to click on Question type
Parameters: 
          Type:Question Type Needs to be selected
Return Value: 
=================================================================================*/
function ClickOnQuestionType(Type)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name","WPFControlText"],["WPFObject(\"root\")","System.Windows.Controls.ListBox Items.Count:4"],100)
  switch (aqString.ToUpper(Type))
  {
    case "EMERGENCYQUESTIONS":
        var ob = obj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 1)"],100)
        ob.Click()
    break;
  
    case "CRITICALQUESTIONS":
        var ob = obj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 2)"],100)
        ob.Click()
    break;
    
    case "URGENTQUESTIONS":
        var ob = obj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 3)"],100)
        ob.Click()
    break;
    
    case "ALLQUESTIONS":
        var ob = obj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 4)"],100)
        ob.Click()
    break;
  }
} 

/*===============================================================================
Description: This function to select Questions
Parameters: 
          Ques:Question 
          Ans:Answer to select
Return Value: 
=================================================================================*/
function AnsweringQues(Ques,Ans)
{
//   delayExecution(2)
   var Brk = false 
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
//var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount
   for (i=1;i<=ChildCount;i++)
   {
      var ListBoxItem = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],1000)
      var quesType = ListBoxItem.DataContext.ClrClassName;
      var Border1 = ListBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var TextBlock = Border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      var Text = TextBlock.WPFControlText
      if (aqString.ToUpper(Text)==aqString.ToUpper(Ques) )
      {
        var AnsPres = ListBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
         if(AnsPres.Exists)
         {
           var j=0,k;
           for(k=0;k<AnsPres.DataContext.Answers.Count;k++)
           {
             
             j++
             if(AnsPres.DataContext.Answers.Item(k).DisplayText.OleValue==Ans)
             {
                AnsPres.Click()
//                delayExecution(2)
                var obj = process.FindChild(["Name","WPFControlText"],["WPFObject(\"ComboBoxItem\", \"\", "+j+")",Ans],100)
                if(obj.Exists)
                {
                  obj.Click()
                  delayExecution(2)
//                  AnsPres.Click()
                  if(quesType == 'MultiAnswerQuestion')
                  {
                    ListBoxItem.Click()
                  }                  
                  Brk = true
                  break;
                }           
             }
     
           }
           if(Brk == false && k==AnsPres.DataContext.Answers.Count)
           {
                Log.Warning("Selecting aanswer "+Ans+" for Question "+Ques+" is failed in AnsweringQues function");
                throw "Selecting aanswer failed in AnsweringQues function"
           }
        }
      } 
      if (Brk == true)
      {
        break;
      } 
   } 
}
 
/*===============================================================================
Description: This function check buttons present on LHS of the screen
Parameters: 
          BtnName:Button Name
Return Value: 
=================================================================================*/
function ToChckButtonsOnLHS(BtnName)
{
    var obj = ToFindObj(["Name","WPFControlName"], [obj_Protocols,"Protocols"]);
    var quesSetObj = obj.FindChild(["Name","WPFControlText"],["WPFObject(\"ListBoxItem\", \"\", *)",BtnName],10);
    if (quesSetObj.Exists && quesSetObj.VisibleOnScreen) 
    {
        return true;
    }
    else
    {
        return false;
    }
} 
/*====================================================================================
Description: This function is to check the selected items from the checkable combobox
Parameters: 
          Content:Multiple/None/Empty
Return Value: True/False
=====================================================================================*/
function TochkValueOfCheckableCombBox(Content)
{
  delayExecution(4)
  var process = GetProcess()
  var obj1 = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"QuestionList\")","True"],100)
  var obj2 = obj1.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", 17)","True"],100)
  var obj = obj2.FindChild(["Name","VisibleOnScreen","WPFControlOrdinalNo","wItemCount"],[cmb_ChekableCmbBox,"True","1","10"],100)
  var dta =obj.DataContext.PreviousResponse
  if (dta!==null) 
  {
       if(aqString.ToUpper(Content)=="MULTIPLE")
       {
          var content1 = obj.DataContext.PreviousResponse.Answers.Item(0).DisplayText.OleValue
          var content2 = obj.DataContext.PreviousResponse.Answers.Item(1).DisplayText.OleValue
          if ((content1=="Bleeding disorder")&&(content2=="Past fracture"))
          {
            return true
          } 
          else
          {
            return false
          } 
      }
      if(aqString.ToUpper(Content)=="NONE")
      {
        var content1 = obj.DataContext.PreviousResponse.Answers.Item(0).DisplayText.OleValue
        if (content1=="None")
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
    if(aqString.ToUpper(Content)=="EMPTY")
    {
      return true
    }
    else
    {
      return false
    } 
  } 
} 

/*====================================================================================
Description: This function is to check the pop up messages
Parameters: 
          Name:Name property value of pop up
          Message:Message
Return Value: True/False
=====================================================================================*/

function ToValidatePopUpMsg(Name,Message)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],[Name],100)
  var acttext = obj.WPFControlText
  if (aqString.Find(acttext, Message, false))
  {
    return true
  } 
  return false
} 

/*====================================================================================
Description: This function is to check the rationale exists
Parameters: 
          question:short question
Return Value: True/False
=====================================================================================*/
function ToValidateRationale(question)
{
  var process = GetProcess()
  var shortQues = process.FindChild(["WPFControlText"],[question],100)
  if(shortQues.VisibleOnScreen)
  {
      parentObj = shortQues.Parent.Parent;
      var ansObj = parentObj.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],100)
      if(ansObj.Exists)
      {
          ansObj.Click();
          
          var obj = process.FindChild(["Name"],["WPFObject(\"NonLogicalAdornerDecorator\", \"\", 1)"],100)
          var rationaleText;
          if (obj.Exists)
          {
              var rationaleText = obj.DataContext.Rationale.OleValue
          }
          
          ansObj.Click();   
          
          if (rationaleText!==null)
          {
            return rationaleText;
          } 
          return false;
      }  
  }
} 

/*====================================================================================
Description: This function is to validate Notes saved
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToChkNotesSaved()
{
  var process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"RichTextBoxWithChangeTracking\", \"\", 1)"],100)
  if (obj.Exists)
  {
    var txt = obj.DataContext.PlainText.OleValue
    if (txt=="abcd")
    {
      return true
    } 
    return false
  } 
} 

/*====================================================================================
Description: This function to set text in Notes 
Parameters: 
          notestext:notes text
Return Value: 
=====================================================================================*/
function SetNotes(notestext)
{
  var process = GetProcess()
  var obj = process.FindChild(["Name","ClrClassName","VisibleOnScreen"],[txt_AddNotes,"RichTextBoxWithChangeTracking",true],100)
  if (obj.Exists)
  {
    obj.Keys(notestext)
  }
} 

/*====================================================================================
Description: This function check Add Questionset popup
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToChckAddQuestionSetPopUp()
{
    return ToFindObjToValidate(["Name"], ["WPFObject(\"ProtocolSearch\", \"\", 1)"])
} 


/*====================================================================================
Description: This function to check the layout of Close Assessment
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToChkCloseAssessmentlayout()
{
return ToFindObjToValidate("Name", "WPFObject(\"CloseAssessmentOverlay\", \"\", 1)")
}

/*====================================================================================
Description: This function to Select reason to closing assessment 
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToValidateReasonsForClosingAssessment(reason)
{
 var obj = ToFindObj(["Name"],["WPFObject(\"Reasons\")"])
 for (i=0;i<obj.wItemCount;i++)
 {
   if (aqString.ToUpper(obj.Items.item(i).Text.OleValue) == aqString.ToUpper(reason))
   { 
     obj.ClickItem(i)
     return true
     delayExecution(2) 
   } 
 } 
 return false
} 

/*===============================================================================
Description: This function check duplication of protocols present on LHS of the assessment screen
Parameters: 
          BtnName:Button Name
Return Value: 
=================================================================================*/
function ToChckDuplicationOfProtocols(BtnName)
{
  var protocolsObj = ToFindObj(["Name"],["WPFObject(\"Protocols\")"])
  
  if(protocolsObj.Exists && protocolsObj.Enabled){
    Log.Message("Protocols are visible")
    var count = 0
    for(i=0;i<protocolsObj.ChildCount-1;i++){
    //aqString.ToUpper(protocolsObj.Items.item(i).WPFControlText)==aqString.ToUpper(BtnName)
      var current = i+1
      if(ToFindObjToValidate(["Name","WPFControlText"],["WPFObject(\"ListBoxItem\", \"\", "+current+")",BtnName])){
        count=count+1  
       } 
    }
    if(count==0){
      Log.Message(BtnName+" Protocol is not present")
      return false
    }
    else if(count==1){
      return true      
    }
    else{
      Log.Message(BtnName+" Protocol is duplicated")
      return false
    }
  }
  else{
    Log.Message("Protocols are not visible")
    return false
  }
} 

/*====================================================================================
Description: This function is to check the selected item from the single select combobox in assessment screen
Parameters:
          shortQues:Short question text
          selectedAnswer:SelectedItem/Blank
Return Value: True/False
=====================================================================================*/
function ToCheckSelectedAnswer(shortQues,selectedAnswer)
{
  var process = GetProcess();
  var questionList;
  questionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],50)
  if(!questionList.Exists)
  {
    questionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],50)
  }
 
  var numOfQues = questionList.ChildCount
  for(i=1;i<=numOfQues;i++)
  {
    var listBoxItem = questionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],50)
    var border1 = listBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
    var currentQues = border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
    if(aqString.ToUpper(currentQues.WPFControlText)==aqString.ToUpper(shortQues))
    {
      var ansPresenter = listBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
      if(aqString.ToUpper(selectedAnswer)=="BLANK" || aqString.ToUpper(selectedAnswer)=="")
      {
        if(ansPresenter.ChildCount == 0)
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
       
        if(aqString.ToUpper(ansPresenter.DataContext.AnswerResponseText.OleValue)==aqString.ToUpper(selectedAnswer))
        {
          return true
        }
        else
        {
          return false
        }
      }
    }
  }
}

/*====================================================================================
Description: This function is to check the selected items from the checkable combobox
Parameters: 
          shortQues:Short question text
          selectedAnswer:Last Selected Responses / Blank
Return Value: True/False
=====================================================================================*/
function ToCheckMultiSelectQuestion(shortQues,selectedAnswers)
{
  delayExecution(4)
  var process = GetProcess()
  var questionList = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"questions\")","True"],100)
  var numOfQues = questionList.ChildCount
  var flag = true
  for(i=1;i<=numOfQues;i++)
  {
    var listBoxItem = questionList.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", "+i+")","True"],50)
    var border1 = listBoxItem.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Border\", \"\", 1)","True"],10)
    var currentQues = border1.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \"*\", 1)","True"],10)
    if(aqString.ToUpper(currentQues.WPFControlText)==aqString.ToUpper(shortQues))
    {  
       var ansPresenter = listBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
       var obj = ansPresenter.FindChild(["Name","VisibleOnScreen"],[cmb_ChekableCmbBox,"True"],100)
       var dta =obj.DataContext.PreviousResponse
       if (dta!==null) 
       {
           var  answerArray =  selectedAnswers.split(",")
           for(i=0;i<answerArray.length;i++)
           {   
                var answer = obj.DataContext.PreviousResponse.Answers.Item(i).DisplayText.OleValue         
                if (aqString.ToUpper(answer)==aqString.ToUpper(answerArray[i]))
                {
                  continue
                } 
                else
                {
                  return false
                } 
           }
           return true
      } 
      else
      {
          if(aqString.ToUpper(selectedAnswers)=="EMPTY" || aqString.ToUpper(selectedAnswers)=="BLANK" || aqString.ToUpper(selectedAnswers)=="")
          {
            return true
          }
          else
          {
            return false
          } 
      } 
   }
 }
} 

/*====================================================================================
Description: This function is to validate Notes saved
Parameters: 
          noteText : text of saved note
Return Value: True/False
=====================================================================================*/
function ToChkNotesSavedGeneric(noteText)
{
  var process = GetProcess()
  var notesGrid = process.FindChild(["Name"],["WPFObject(\"Notes\", \"\", 1)"],100)
  if(!notesGrid.Exists)
  {
    var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
    notesGrid = SummaryLable.parent    
  }
  var savedNotesSection = notesGrid.FindChild(["Name"],["WPFObject(\"ListBox\", \"\", 1)"],50)
  var noteCount = savedNotesSection.ChildCount-1
  if (savedNotesSection.Exists)
  {
    for(i=1;i<=noteCount;i++)
    {
      var curNote = savedNotesSection.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],10)
      var obj = curNote.FindChild(["Name"],[lbl_NotesSaved],10)
      var txt = obj.DataContext.Html.OleValue
      if (aqString.ToUpper(txt)==aqString.ToUpper(noteText))
      {
        return true
      } 
    } 
    return false
  } 
}
/*===============================================================================
Description: This function is to check warning message enable and displaying
Parameters:  
            ques1: Question
            Ans1: Answer
Return Value: 
=================================================================================*/
function AnsCallHandlerQues1(ques1,Ans1)
{
    ques1 = aqString.Replace(ques1, "|", ",")
    var process = GetProcess()
    var quesList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var count = quesList.ChildCount
    var flag=false
    for(i=1;i<count;i++)
    {
        var quesObj = quesList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],100)
        ques = quesObj.DataContext.Text.OleValue;
        //    Log.Message(ques)
        if (aqString.ToLower(ques)==aqString.ToLower(ques1))
        {
          if(quesObj.DataContext.ClrClassName == 'TeleQuestion')
          {
            var AnswerDropDown = quesObj.FindChild(["Name"],["WPFObject(\"AnswerList\")"],100)
            var itemCount = AnswerDropDown.Items.Count
            for (i=0;i<itemCount;i++)
            {
              var data = AnswerDropDown.Items.Item(i).LayText.OleValue
              if(aqString.ToLower(data) == aqString.ToLower(Ans1))
              {
                AnswerDropDown.ClickItem(i)
                flag=true
                break
              } 
            } 
          } 
          else if(quesObj.DataContext.ClrClassName == 'MultiAnswerQuestion')
          {
            var objAnswer = quesObj.FindChild(["Name"],["WPFObject(\"CheckableCombo\")"],100)
            for (var f = 0; f < objAnswer.Items.Count; f++)
            {
              var answerNo = objAnswer.Items.Item(f);
              var currentMultiAnswerText = answerNo.LayText.OleValue
              if (aqString.Trim(Ans1) == aqString.Trim(currentMultiAnswerText)) 
              {
                objAnswer.Click()
                f=f+1;
                var obj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBoxItem\", \"\", "+f+")","True"],100)
                if(obj.Exists)
                {
                  obj.Click();
                  delayExecution(1)
                  quesObj.Click()
                  flag=true
                  break              
                }
              }
            }   
          }
          if(flag)
          {
            break
          }
        } 
    } 
}
/*===============================================================================
Description: This function To Check Order Of Question Set buttons in assessment screen(Clinician/CallHandler)
Parameters: 
          BtnName:Button Name
          Position:Position of question set 1 or 2 or 3.....
Return Value: 
=================================================================================*/
function ToChckOrderOfQuestionSet(btnName,position)
{
  var expQuesSetBtnObj = ToFindObj(["Name","WPFControlText"],["WPFObject(\"ListBoxItem\", \"\", *)",btnName])
  if(expQuesSetBtnObj.Exists)
  {
    var positionInt = aqConvert.StrToInt(position)
    if(positionInt == expQuesSetBtnObj.WPFControlOrdinalNo)
    {
      Log.Message("Question Set order "+expQuesSetBtnObj.WPFControlOrdinalNo+" is correct")
      return true
    }
    else
    {
      Log.Message("Question Set order "+expQuesSetBtnObj.WPFControlOrdinalNo+" is wrong")
      return false
    }
  }
  else
  {
    Log.Message("Question Set object not found")
    return false
  }
} 
/*===============================================================================
Description: This function is to Answer remaining questions in TeleAssess assessment screen and navigate to triage screen
Parameters:
Return Value: 
=================================================================================*/
function AnsRemainingQuesClinician()
{
  ClickOnQuestionType("ALLQUESTIONS")
  
  var process = GetProcess()
  
  var protocolsObj = process.FindChild(["Name"],["WPFObject(\"Protocols\")"],50)
  var noOfQuestionSet = protocolsObj.ChildCount
  for(i=1; i<noOfQuestionSet; i++)
  {
    var currentProtocol = protocolsObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],20)
    if(currentProtocol.Exists && currentProtocol.Enabled)
    {
      if(aqString.ToUpper(currentProtocol.WPFControlText)!="GENERAL CONDITION")
      {
        currentProtocol.Click()
        Sys.Refresh()
        var questionList = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"questions\")","True"],100)
        var numOfQues = questionList.ChildCount
        for(j=1;j<numOfQues;j++)
        {
          var Ques = questionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+j+")"],100)
          if(Ques.DataContext.ClrClassName == 'TeleQuestion')
          {
            var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],100)
            if(AnsList.DataContext.HasResponse == false)
            {    
              //AnsList.ClickItem(0)
              AnsList.Click()
              var obj = process.FindChild(["Name"],["WPFObject(\"ComboBoxItem\", \"\", 1)"],100)
              obj.Click()
              delayExecution(1)       
            } 
          }
          else if((Ques.DataContext.ClrClassName == 'MultiAnswerQuestion')) 
          {
            var objAnswer = Ques.FindChild(["Name"],["WPFObject(\"CheckableCombo\")"],100)
            if(objAnswer.DataContext.HasResponse == false)
            {
              objAnswer.DropDown();
              var answerNo = objAnswer.Items.Item(0);
              answerNo.IsSelected = true;
              objAnswer.CloseUp();
              delayExecution(1) 
            }
          }
//          Log.Message("Done")        
        }
      }   
      Sys.Refresh()  
    }
    else
    {
      Log.Warning("Click action failed in AnsRemainingQuesClinician function")
    }
  }
  
  var btn_Continue = process.FindChild(["WPFControlText","VisibleOnScreen"],["Continue","True"],100)
  if(btn_Continue.Exists)
  {
    if(btn_Continue.Enabled)
    {
      btn_Continue.Click()
    } 
    else
    {
      AnsRemainingQuesClinician()  
    }    
  }
  else
  {
      Log.Warning("Continue button is missiing in assessment screen")
      throw "Click action failed in AnsRemainingQuesClinician function"    
  }
}

/*===============================================================================
Description: This function is to check for availability of an Answer for a single select question in TeleAssess assessment screen
Parameters:
            shortQues: ShortQuestion
            ans: Answer
Return Value: true/false
=================================================================================*/
function ToCheckAnswerPresence(shortQues,ans)
{
//   delayExecution(2)
   var i
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
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
           for(j=0;j<AnsPres.DataContext.Answers.Count;j++)
           {   
             if(AnsPres.DataContext.Answers.Item(j).DisplayText.OleValue==ans)
             {
                return true                         
             }    
           }
           if(j==AnsPres.DataContext.Answers.Count)
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
Description: This function is to Answer remaining questions by urgency in TeleAssess assessment screen
Parameters:
        urgencyType:EMERGENCYQUESTIONS/CRITICALQUESTIONS/URGENTQUESTIONS/ALLQUESTIONS
Return Value: 
=================================================================================*/
function AnsQuesByUrgencyClinician(urgencyType)
{
  ClickOnQuestionType(urgencyType)
  
  var process = GetProcess()
  var protocolsObj = process.FindChild(["Name"],["WPFObject(\"Protocols\")"],50)
  var noOfQuestionSet = protocolsObj.ChildCount
  for(i=1; i<noOfQuestionSet; i++)
  {
    var currentProtocol = protocolsObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],20)
    if(currentProtocol.Exists && currentProtocol.Enabled)
    {
      if(aqString.ToUpper(currentProtocol.WPFControlText)!="GENERAL CONDITION")
      {
        currentProtocol.Click()
        Sys.Refresh()
        var questionList = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"questions\")","True"],100)
        var numOfQues = questionList.ChildCount
        for(j=1;j<numOfQues;j++)
        {
          var Ques = questionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+j+")"],100)
          if(Ques.DataContext.ClrClassName == 'TeleQuestion')
          {
            var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],100)
            if(AnsList.DataContext.HasResponse == false)
            {    
              AnsList.Click()
              var obj = process.FindChild(["Name"],["WPFObject(\"ComboBoxItem\", \"\", 1)"],100)
              obj.Click()
              delayExecution(1)       
            } 
          }
          else if((Ques.DataContext.ClrClassName == 'MultiAnswerQuestion')) 
          {
            var objAnswer = Ques.FindChild(["Name"],["WPFObject(\"CheckableCombo\")"],100)
            if(objAnswer.DataContext.HasResponse == false)
            {
              objAnswer.DropDown();
              var answerNo = objAnswer.Items.Item(0);
              answerNo.IsSelected = true;
              objAnswer.CloseUp();
              delayExecution(1) 
            }
          }
//          Log.Message("Done")        
        }
      }   
      Sys.Refresh()  
    }
    else
    {
      Log.Warning("Click action failed in AnsQuesByUrgencyClinician function")
      throw "Click action failed in AnsQuesByUrgencyClinician function"
    }  
  }
}
/*===============================================================================
Description: This function is to Answer all the remaining questions of a question set in TeleAssess assessment screen
Parameters:
          questionSet:Question Set
Return Value: 
=================================================================================*/
function AnsRemQuesByQuesSetClinician(questionSet)
{
  ClickOnQuestionType("ALLQUESTIONS");
  clickItem(btn_QuestionSetOnLHS,questionSet);
  
  var process = GetProcess()
  var questionList = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"questions\")","True"],100)
  var numOfQues = questionList.ChildCount
  for(j=1;j<numOfQues;j++)
  {
    var Ques = questionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+j+")"],100)
    if(Ques.DataContext.ClrClassName == 'TeleQuestion')
    {
      var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],100)
      if(AnsList.DataContext.HasResponse == false)
      {    
        AnsList.Click()
        var obj = process.FindChild(["Name"],["WPFObject(\"ComboBoxItem\", \"\", 1)"],100)
        obj.Click()
        delayExecution(1)       
      } 
    }
    else if((Ques.DataContext.ClrClassName == 'MultiAnswerQuestion')) 
    {
      var objAnswer = Ques.FindChild(["Name"],["WPFObject(\"CheckableCombo\")"],100)
      if(objAnswer.DataContext.HasResponse == false)
      {
        objAnswer.DropDown();
        var answerNo = objAnswer.Items.Item(0);
        answerNo.IsSelected = true;
        objAnswer.CloseUp();
        delayExecution(1) 
      }
    }
//    Log.Message("Done")        
  }
}

/*===============================================================================
Description: This function to answer BMI question
Parameters: 
          Weight:Question
          Height:Question
          BMICalcValueExp:Compare
          Answer:Answer to select
Return Value: True/False
=================================================================================*/
function AnsweringBMIQues(Weight,Height,BMICalcValueExp,Answer)
{
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
//var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount
   for (i=1;i<=ChildCount;i++)
   {
      var ListBoxItem = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],100)
      var Border1 = ListBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var TextBlock = Border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      var Text = TextBlock.WPFControlText
      if (aqString.ToUpper(Text)=="BMI")
      {
        var AnsPres = ListBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
         if(AnsPres.Exists)
         {
           AnsPres.Click();
           
           if(ToCheckLablePresent("BMI conversion calculator"))
           {
             
             var obj_weight = ToFindObj(["Name","WPFControlName"],[txt_Weight,"Weight"])
             var obj_parent = obj_weight.Parent
             var obj_Height = obj_parent.FindChild(["Name"],[txt_Height],10)
             setText(Weight,"","",obj_weight)
             setText(Height,"","",obj_Height)
             
             clickItem(btn_Calculate,"Calculate")
             Sys.Refresh()
             var BMICalcValueObj = process.FindChild(["Name"],[txt_BMI],50)
             if(BMICalcValueObj.Exists && BMICalcValueObj.VisibleOnScreen)
             {
               if(BMICalcValueObj.Text.OleValue == BMICalcValueExp)
               {
                  Log.Message("BMI value: "+BMICalcValueObj.Text+" matched")
                  clickItem(btn_Hide,"Hide")
//                  Sys.Refresh()
                  var obj = process.FindChild(["Name"],["WPFObject(\"ComboBoxItem\", \"\", "+Answer+")"],100)
                  if(obj.Exists)
                  {
                    obj.Click()
                    delayExecution(2)
  //                  AnsPres.Click()
                    break;
                  }
               }
               else
               {
                 throw "Calculated BMI value not matched"
               }
             }
           }
         }
      }
       
   }  
}

/*====================================================================================
Description: This function is to validate BMI Notes saved
Parameters: 
          height: height value
          weight: weight value
          BMI: BMI value
Return Value: True/False
=====================================================================================*/
function ToChkBMINotesSaved(height, weight, BMI)
{
  var process = GetProcess()
  noteText = "The height is "+height+" mt,weight "+weight+"kg, BMI is "+BMI+""
//  var notesGrid = process.FindChild(["Name"],["WPFObject(\"Notes\", \"\", 1)"],100)
  var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
  notesGrid = SummaryLable.parent   
  var savedNotesSection = notesGrid.FindChild(["Name"],["WPFObject(\"ListBox\", \"\", 1)"],50)
  var noteCount = savedNotesSection.ChildCount-1
  if (savedNotesSection.Exists)
  {
    for(i=1;i<=noteCount;i++)
    {
      var curNote = savedNotesSection.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],10)
      var obj = curNote.FindChild(["Name"],[lbl_NotesSaved],10)
      var txt = obj.DataContext.Html.OleValue
      if (aqString.ToUpper(txt)==aqString.ToUpper(noteText))
      {
        return true
      } 
    } 
    return false
  } 
}

/*===============================================================================
Description: This function to answer Pregnency calculator
Parameters: 
          Type:EDD/LMD
          Val: Answer/""
Return Value: True/False
=================================================================================*/
function AnsweringPregencyQues(Type,Val)
{
   var process = GetProcess()
   var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
//var QuestionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],100)
   var ChildCount = QuestionList.ChildCount
   for (i=1;i<=ChildCount;i++)
   {
      var ListBoxItem = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],100)
      var Border1 = ListBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var TextBlock = Border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      var Text = TextBlock.WPFControlText
      if (aqString.ToUpper(Text)=="EDD**")
      {
        var AnsPres = ListBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
         if(AnsPres.Exists)
         {
           AnsPres.Click();          
           if(ToCheckLablePresent("Pregnancy Conversion Calculator"))
           {
              switch (Type)
              {
                case "EDD":
                  var DatePicker = ToFindObj(["Name"],[txt_EDD])
                     if(DatePicker.exists)
                     {
                        DatePicker.click()
                        setText(Val,txt_EDD,"EddDatePicker","")
                        DatePicker.Keys("^[Enter]");
                    }                     
                     break;
  
                case "LMD":
                  var DatePicker = ToFindObj(["Name"],[txt_LMD])
                     if(DatePicker.exists)
                     {
                       DatePicker.click()
                       setText(Val,txt_LMD,"PregnancyDatePicker","")
                       DatePicker.Keys("^[Enter]");
                     }
                     break;
                }
                clickItem(btn_Calculate,"Calculate")
                return true
            }
         }
      }
   }
   return false;     
}  
/*===============================================================================
Description: This function is to validate/compare the search result for add question set
Parameters:             
             searchString:Search string entered/""(blank)
             expSearchResultCount:expected number of records in search result/""(blank)
Return Value: true/false
=================================================================================*/
function ToCheckAddQuesSearchResult(searchString,expSearchResultCount)
{
  var process = GetProcess()
  var searchList = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"ProtocolSearch\", \"\", *)","True"],100)
  
  if(expSearchResultCount=="0")
  {
    var parentObj = searchList.parent
    var obj = parentObj.FindChild(["WPFControlText","VisibleOnScreen"],["No results were found.","True"],10)
    if(obj.Exists)
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
    var searchResultObjs = searchList.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", *)","True"],10).toArray();
    
    if(expSearchResultCount!="")
    {
      if(expSearchResultCount!=searchResultObjs.length)
      {
        Log.Message("Add question set result count not matched");
        return false;
      }
      else
      {
        Log.Message("Add question set result count matched");
      }
    }
  
    if(searchResultObjs.length>0)
    {
      searchString=aqString.ToLower(searchString)
      var pattern = "[a-z]*"+searchString+"[a-z]*";
      var regexPattern = new RegExp(pattern);
      var i;
      for(i=0;i<searchResultObjs.length;i++)
      {
        var currResult = searchResultObjs[i].WPFControlText
        Log.Message("Add Question set: "+currResult)
        var res = regexPattern.test(aqString.ToLower(currResult))        
        if(res==false)
        {
          return false;
        }       
      }
      if(i==searchResultObjs.length)
      {
        return true;
      }
    }
    else
    {
      Log.Message("No results displayed after search");
      return false;
    }
  }
}

/*===============================================================================
Description: This function is validate allergies details in the patient details popup of Assessment screen
Parameters: 
          allergyList:
          dateList:
Return Value: true/false
=================================================================================*/
function ToValAllergyDetails(allergyList,dateList)
{
  var allergyArr = allergyList.split(",")
  var dateArr = dateList.split(",")
  var count = allergyArr.length
  
  var patientDetailsWnd =  ToFindObj(["Name","VisibleOnScreen"],[PopUpMsg_IntPatientDet,"True"])
  if(patientDetailsWnd.Exists)
  {
    var actAllergyObjList = patientDetailsWnd.FindAllChildren(["Name"],["WPFObject(\"Paragraph\", \"\", *)"],10).toArray();
    if(actAllergyObjList.length==count)
    {
      for(i=0;i<count;i++)
      {
        var actAllergyArr = actAllergyObjList[i].WPFControlText.split(" ");
        var actAllergy = aqString.ToUpper(aqString.Replace(actAllergyArr[1], ",", ""))
        var actDate = actAllergyArr[2]
        var status=false;
        for(j=0;j<count;j++)
        {
          if(actAllergy==aqString.ToUpper(allergyArr[j]))
          {
            if(Project.Variables.ServerType == "remote")
            {
              dateArr[j] = ChangeDateFormat(dateArr[j])
            }
            if(actDate!=dateArr[j])
            {
              Log.Warning(actAllergy+"'s UpdatedOn date is not matching")
              return false;              
            }
            else
            {
              status=true;
              Log.Message(actAllergy+" allergy is matched")
              break;
            }
          }
        }
        if(!status)
        {
          Log.Warning(actAllergy+" allergy is not matched")
          return false;
        }
      }
      return true;
    }
    else
    {
      return false;
    }
  }    
}

/*===============================================================================
Description: This function is validate allergies details in the patient details popup of Assessment screen
Parameters: 
          medicationsList:
          dateList:
Return Value: true/false
=================================================================================*/
function ToValMedicationDetails(medicationsList,dateList)
{
  var medicationArr = medicationsList.split(",")
  var dateArr = dateList.split(",")
  var count = medicationArr.length
  
  var patientDetailsWnd =  ToFindObj(["Name","VisibleOnScreen"],[PopUpMsg_IntPatientDet,"True"])
  if(patientDetailsWnd.Exists)
  {
    var actMedicationObjList = patientDetailsWnd.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"DataGridRow\", \"\", *)","True"],10).toArray();
    if(actMedicationObjList.length==count)
    {
      for(i=0;i<count;i++)
      {
        var actMedicationObj = actMedicationObjList[i].FindChild(["Name","VisibleOnScreen"],["WPFObject(\"DataGridCell\", \"*\", 1)","True"],10)
        var actMedicationDateObj = actMedicationObjList[i].FindChild(["Name","VisibleOnScreen"],["WPFObject(\"DataGridCell\", \"*\", 2)","True"],10)
        var actMedicationTxt = aqString.ToUpper(actMedicationObj.WPFControlText)
        var actMedicationDate = actMedicationDateObj.WPFControlText
        var status=false;
        for(j=0;j<count;j++)
        {
          if(actMedicationTxt==aqString.ToUpper(medicationArr[j]))
          {
            if(Project.Variables.ServerType == "remote")
            {
              dateArr[j] = ChangeDateFormat(dateArr[j])
            }
            if(actMedicationDate!=dateArr[j])
            {
              Log.Warning(actMedicationTxt+"'s Issued date is not matching")
              return false;              
            }
            else
            {
              status=true;
              Log.Message(actMedicationTxt+" medication is matched")
              break;
            }
          }
        }
        if(!status)
        {
          Log.Warning(actMedicationTxt+" medication is not matched")
          return false;
        }
      }
      return true;
    }
    else
    {
      return false;
    }
  }    
}
/*===============================================================================
Description: This function is validatethat allergy or medication details is blank in the patient details popup of Assessment screen
Parameters: 
          patientDetType:allergy/medication
Return Value: true/false
=================================================================================*/
function ToValPatientDetailsBlank(patientDetType)
{
  patientDetType = aqString.ToUpper(patientDetType)
  
  var patientDetailsWnd =  ToFindObj(["Name","VisibleOnScreen"],[PopUpMsg_IntPatientDet,"True"])
  if(patientDetailsWnd.Exists)
  {
    if(patientDetType=="ALLERGY")
    {
      var actAllergyDetObj = patientDetailsWnd.FindChild(["Name","Exists"],["WPFObject(\"Paragraph\", \"\", 1)","True"],10);
      if(actAllergyDetObj.WPFControlText=="No details to display")
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
      var parentObj = patientDetailsWnd.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ContentPresenter\", \"\", 1)","True"],10);
      var actMedicationDetObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)","True"],10);
      if(actMedicationDetObj.wText=="No details to display")
      {
        return true;
      }
      else
      {
        return false;
      }      
    }
  }   
}
/*===============================================================================
Description: This function is wait for the Patient Details window for Allergy and Medication in InProcess
Parameters: 
Return Value: true/false
=================================================================================*/
function waitforPatientDetWindow()
{
  return waitForItemWithTime(PopUpMsg_IntPatientDet,"",2)
}
/*===============================================================================
Description: This function is check for Clinical Warning overlay displayed in assessment screen for Clinician
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckforClinWarnOverlay()
{
  return ToFindObjToValidate(["Name"], [obj_ClinicalWarningOverlay])
}
/*===============================================================================
Description: This function is check for Clinical Warning icon and its tooltip displayed in assessment screen for Clinician
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckforClinWarnIcon()
{
    var obj = ToFindObj(["Name","WPFControlName"], [obj_Protocols,"Protocols"]);
    var parentObj = obj.Parent.Parent.Parent.Parent;
    var ClinWarnIcon = parentObj.FindChild(["Name"],["WPFObject(\"Button\", \"\", 1)"],10);
    if(ClinWarnIcon.VisibleOnScreen)
    {
        if(ClinWarnIcon.ToolTip.OleValue == "Clinical Warning")
        {
            return true;
        }
        else
        {
            Log.Message("Tooltip is not getting displayed for Clinical Warning icon");
            return false;
        }
    }
    else
    {
        Log.Message("Clinical Warning icon is not getting displayed in assessment screen");
        return false;
    }
}
/*===============================================================================
Description: This function to click on Clinical Warning icon in assessment screen and open Clinical Warning overlay for Clinician
Parameters: 
Return Value:
=================================================================================*/
function ClickClinicalWarningIcon()
{
    var obj = ToFindObj(["Name","WPFControlName"], [obj_Protocols,"Protocols"]);
    var parentObj = obj.Parent.Parent.Parent.Parent;
    var ClinWarnIcon = parentObj.FindChild(["Name"],["WPFObject(\"Button\", \"\", 1)"],10);
    if(ClinWarnIcon.VisibleOnScreen)
    {
        if(ClinWarnIcon.ToolTip.OleValue == "Clinical Warning")
        {
            ClinWarnIcon.Click();
        }
        else
        {
            Log.Warning("ClinWarn ToolTip is not matched Click action failed in ClickClinicalWarningIcon function")
            throw "Click action failed in ClickClinicalWarningIcon function"
        }
    }
    else
    {
        Log.Warning("ClinWarnIcon is not available Click action failed in ClickClinicalWarningIcon function")
        throw "Click action failed in ClickClinicalWarningIcon function"
    }
}
/*===============================================================================
Description: This function is validate the color of short questions for clinician role in assessment screen
Parameters: 
          shortques:short question text
          expColour:INDIGO/RED/YELLOW/BLUE/BLACK
Return Value: true/false
=================================================================================*/
function ToCheckShortQuesColour(shortques,expColour)
{
    shortQuesObj = ToFindObj(["WPFControlText"], [shortques])
    return ToCheckActionColour(shortQuesObj,expColour);
}

/*====================================================================================
Description: This function is to check the selected items from the single select combobox in assessment screen
Parameters: 
          shortQues:Short question text
          selectedAnswer:SelectedItem/Blank
          value:Temperature/Weight
Return Value: True/False
=====================================================================================*/
function ToCheckSelectedConvAnswer(shortQues,selectedAnswer,value)
{
    var process = GetProcess();
    var questionList;
    questionList = process.FindChild(["Name"],["WPFObject(\"questions\")"],50)
    if(!questionList.Exists)
    {
        questionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],50)
    }
  
    var numOfQues = questionList.ChildCount
    for(i=1;i<=numOfQues;i++)
    {
      var listBoxItem = questionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],50)
      var border1 = listBoxItem.FindChild(["Name"],["WPFObject(\"Border\", \"\", 1)"],10)
      var currentQues = border1.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],10)
      if(aqString.ToUpper(currentQues.WPFControlText)==aqString.ToUpper(shortQues))
      {
        var ansPresenter = listBoxItem.FindChild(["Name"],["WPFObject(\"AnswerPresenter\")"],10)
        if(aqString.ToUpper(selectedAnswer)=="BLANK" || aqString.ToUpper(selectedAnswer)=="")
        {
            if(ansPresenter.ChildCount == 0)
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
            var j=0, k;
            if(value=='Temperature')
            {
               for(k=0;k<ansPresenter.DataContext.Answers.Count;k++)
               {
                   j++
                   if(aqString.ToUpper(ansPresenter.DataContext.Answers.Item(k).TextWithTemperatureConversion.OleValue)==aqString.ToUpper(selectedAnswer))
                   {
                        return true
                   }
               }
            } 
             else
             {
               for(k=0;k<ansPresenter.DataContext.Answers.Count;k++)
               {
                   j++
                   if(aqString.ToUpper(ansPresenter.DataContext.Answers.Item(k).TextWithWeightConversion.OleValue)==aqString.ToUpper(selectedAnswer))
                   {
                      return true
                   }
                }
             }
          }
       }
    }
}
/*===============================================================================
Description: This function is wait for the Assessment screen and urgency popup is displayed
Parameters: 
Return Value: 
=================================================================================*/
function waitforAssessScrUrgPopup()
{
  return waitForItemWithTime(btn_NoLabel,"Go Back",2)
}

/*====================================================================================
Description: This function to check the layout of Close Question Set
Parameters: 
Return Value: True/False
=====================================================================================*/
function ToChckCloseQuestionSetPopUp()
{
    return waitForItemWithTime(obj_CloseQuestionSetOverlay,"",1)
}

/*====================================================================================
Description: This function to check the message displayed on close of question set
Parameters: 
          messg:
Return Value: True/False
=====================================================================================*/
function ToChckCloseQuesSetMessg(messg)
{
    if(waitForItemWithTime(btn_Yes,"Yes",1))
        return ToCheckLablePresent(messg)
}

/*====================================================================================
Description: This function to check question set checkbox in close question set overlay
Parameters: 
          qSetList:
Return Value: True/False
=====================================================================================*/
function SelCloseQuesSet(qSetList)
{
    var obj_overlay = ToFindObj(["Name"],[obj_CloseQuestionSetOverlay])
    var qSetListObj = obj_overlay.FindChild(["Name"],["WPFObject(\"ListBox\")"],10)
    if(qSetList == "")
    {
        var quesSet1 = qSetListObj.FindChild(["Name"],["WPFObject(\"CheckBox\", \"*\", 1)"],10)
        quesSet1.Click()
    }
    else
    {
        var arr_qSetList = qSetList.split("|")
        var arr_qSetObj = qSetListObj.FindAllChildren(["Name"],["WPFObject(\"CheckBox\", \"*\", 1)"],10).toArray();
        for(i=0;i<arr_qSetList.length;i++)
        {
            for(j=0;j<arr_qSetObj.length;j++)
            {
                if(aqString.ToUpper(arr_qSetList[i]) == aqString.ToUpper(arr_qSetObj[j].WPFControlText))
                {
                    arr_qSetObj[j].Click()
                    break;
                }
            }
        }
    }
}

/*====================================================================================
Description: This function to check question set checkbox in close question set overlay
Parameters: 
          reason:
Return Value: True/False
=====================================================================================*/
function SelCloseQuesSetReason(reason)
{
    var obj_overlay = ToFindObj(["Name"],[obj_CloseQuestionSetOverlay])
    var cmb_closureReason = obj_overlay.FindChild(["Name"],["WPFObject(\"ComboBox\", \"\", 1)"],10)
    if(reason == "")
    {
        cmb_closureReason.ClickItem(1)
    }
    else
    {
        for(i=0;i<cmb_closureReason.Items.Count;i++)
        {
            if(cmb_closureReason.Items.Item(i).Description.OleValue == reason)
            {
                cmb_closureReason.ClickItem(i)
                break;
            }
        }
    }
    if(ToCheckSearchBoxPresent(txt_ReasonText, ""))
    {
        setText("Additional details for closure reason", txt_ReasonText, "ReasonText", "")
    }
}

/*====================================================================================
Description: This function to Select question set and reason to close
Parameters: 
          qSetList:
          closureReason:
Return Value:
=====================================================================================*/
function SelCloseQuesSetAndReason(qSetList, closureReason)
{
    SelCloseQuesSet(qSetList);
    SelCloseQuesSetReason(closureReason);
}

/*====================================================================================
Description: This function to validate list of available question set for closure
Parameters: 
          qSetList:
Return Value: True/False
=====================================================================================*/
function ToValCloseQuesSetList(qSetList)
{
    var obj_overlay = ToFindObj(["Name"],[obj_CloseQuestionSetOverlay])
    var qSetListObj = obj_overlay.FindChild(["Name"],["WPFObject(\"ListBox\")"],10)
    var arr_qSetObj = qSetListObj.FindAllChildren(["Name"],["WPFObject(\"CheckBox\", \"*\", 1)"],10).toArray();
    var arr_qSetList = qSetList.split(",")
    var qSetFound;
    for(i=0;i<arr_qSetList.length;i++)
    {
        qSetFound = false;
        for(j=0;j<arr_qSetObj.length;j++)
        {
            if(aqString.ToUpper(arr_qSetList[i]) == aqString.ToUpper(arr_qSetObj[j].WPFControlText))
            {
                Log.Message("Question set found "+arr_qSetList[i])
                qSetFound = true;
                break;
            }
        }
        if(qSetFound == false)
            return false;
    }
    return true;
}
