//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT ScreensOf3_12TreatmentPlan
//USEUNIT DBFunctions

/*===============================================================================
Description: This function is to chech the colour and order of question based on urgency with multiple question sets in 1st assessment screen.
Parameters:
Return Value: true/false
=================================================================================*/
function CheckPurpleQues1stScr()
{
    var process = GetProcess()
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    FCQuesCount.push(QuesCountInList);
    for(j=0;j<FCQuesCount.length;j++)
    {
        var GeneralQuesFound = false;
        var protocol = "";
        var i;
        var checkUntil=FCQuesCount[j];
        if(j==0)
        {
            i=1;      
        }
        else
        {
            i=FCQuesCount[j-1];         
        }
        
        for (i;i<checkUntil;i++)
        {
              var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
              var QuesObj = Ques.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],5)
              var UrgencyLinked = Ques.DataContext.HighestSeverityType;
              //Validate urgency of each question with corresponding colour 
              if((GeneralQuesFound == false) && (UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal"))
              {
                  if(ToCheckActionColour(QuesObj,"INDIGO"))
                  {
                      //pass
                  }
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                    
                  }
              }
              else
              {
                  GeneralQuesFound = true;
                  if((!ToCheckActionColour(QuesObj,"INDIGO")) && (!(UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal")))
                  {
                      //pass
                  }
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                     
                  }
              }
              
              //Validate all the question of one set have same protocol code
              if(protocol == "")
              {
                  protocol = Ques.DataContext.ProtCode.OleValue;
                  Log.Message("Checking purple questions for protocol code :: "+protocol);         
              }
              else
              {
                  if(protocol == Ques.DataContext.ProtCode.OleValue)
                      continue;
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                      
                  }     
              }
        }        
    }
    return true;
}

/*===============================================================================
Description: This function is to Answer remaining questions in the current screen for CallHandler
Parameters:
Return Value: 
=================================================================================*/
function AnsRemainQuesInScrFC()
{
    var process = GetProcess()
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    for (i=1;i<QuesCountInList;i++)
    {
        var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
        if (Ques.DataContext.ClrClassName == 'TeleQuestion')
        {
            var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerList\")"],100)
            if(AnsList.DataContext.HasResponse == false)
            {
                AnsList.ClickItem(0)
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
            }
        }
    } 
}
/*===============================================================================
Description: This function is to chech the colour and order of question based on urgency with multiple question sets in 2nd assessment screen.
Parameters:
          questionSet:question set to check
Return Value: true/false
=================================================================================*/
function CheckPurpleQues2ndScr(questionSet)
{
    //Select question set if it is not preselected
    if(!TochkComboboxSelected(btn_QuestionSetOnLHS,questionSet))
    {
        clickItem(btn_QuestionSetOnLHS,questionSet);
    }
    
    var process = GetProcess()    
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    var GeneralQuesFound = false;
    var protocol = "";
    for (i=1;i<QuesCountInList;i++)
    {
          var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
          var QuesObj = Ques.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],5)
          var UrgencyLinked = Ques.DataContext.HighestSeverityType;
          //Validate urgency of each question with corresponding colour 
          if((GeneralQuesFound == false) && (UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal"))
          {
              if(ToCheckActionColour(QuesObj,"INDIGO"))
              {
                  //pass
              }
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                    
              }
          }
          else
          {
              GeneralQuesFound = true;
              if((!ToCheckActionColour(QuesObj,"INDIGO")) && (!(UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal")))
              {
                  //pass
              }
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                     
              }
          }
              
          //Validate all the question of one set have same protocol code
          if(protocol == "")
          {
              protocol = Ques.DataContext.ProtCode.OleValue;
              Log.Message("Checking purple questions for protocol code :: "+protocol);         
          }
          else
          {
              if(protocol == Ques.DataContext.ProtCode.OleValue)
                  continue;
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                      
              }
                      
          }
    }        
    return true;
}

/*===============================================================================
Description: This function is to select negative answer to remaining purple questions in the current screen for CallHandler
Parameters:
Return Value: 
=================================================================================*/
function AnsRemainPurpQuesFirstScr()
{
    var process = GetProcess()
    var purpleQuesList = [];
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    for (i=1;i<QuesCountInList;i++)
    {
        var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
        var UrgencyLinked = Ques.DataContext.HighestSeverityType;
        
        if(UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal")
        {
            //adding unanswered purple question to array list
            if (Ques.DataContext.ClrClassName == 'TeleQuestion')
            {
                var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerList\")"],100)
                if(AnsList.DataContext.HasResponse == false)
                {
                    purpleQuesList.push(aqConvert.IntToStr(i))
                } 
            }
            else if((Ques.DataContext.ClrClassName == 'MultiAnswerQuestion')) 
            {
                var objAnswer = Ques.FindChild(["Name"],["WPFObject(\"CheckableCombo\")"],100)
                if(objAnswer.DataContext.HasResponse == false)
                {
                    purpleQuesList.push(aqConvert.IntToStr(i))
                }
            }
        }
    } 
    for(j=0;j<purpleQuesList.length;j++)
    {
        var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +purpleQuesList[j]+")"],100)    
        if (Ques.DataContext.ClrClassName == 'TeleQuestion')
        {
            var AnsList = Ques.FindChild(["Name"],["WPFObject(\"AnswerList\")"],100)
            if(AnsList.DataContext.HasResponse == false)
            {
                AnsList.ClickItem(0)
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
            }
        }
    }
}

/*===============================================================================
Description: This function is to select negative answer to remaining purple questions in the current screen for CallHandler
Parameters:
Return Value: 
=================================================================================*/
function AnsRemainPurpQuesSecondScr()
{
    var process = GetProcess()
    var protocolsObj = process.FindChild(["Name"],["WPFObject(\"Protocols\")"],50)
    var noOfQuestionSet = protocolsObj.ChildCount
    for(k=1; k<noOfQuestionSet; k++)
    {      
        var currentProtocol = protocolsObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+k+")"],5)
        if(currentProtocol.Exists && currentProtocol.Enabled)
        {
            currentProtocol.Click();
            AnsRemainPurpQuesFirstScr()
            if(ToFindObjToValidate(["Name"], [PopUpMsg]))
            {
                break;
            }
        }
        else
        {
          Log.Warning("Click action failed in AnsRemainingQuesClinician function")
        }
    } 
}
/*===============================================================================
Description: This function is to check the Title of Advice in the First Aid Advice overlay for CallHandler
Parameters:
Return Value: true/false
=================================================================================*/
function CheckAdviceOverlayTitle()
{
    var adviceOverlay = ToFindObj(["Name"],[obj_CareAdviceOverlay]);
    var lbl_advice = ToFindObj(["Name"],[lbl_FirstAidAdvice]);
    if(adviceOverlay.TitleText.OleValue == "Advice" && lbl_advice.WPFControlText == "First Aid Advice")
        return true;
    else
        return false;
}

/*===============================================================================
Description: This function is to chech that EMER and IMLT question are not in Purple colour and order of question based on urgency with multiple question sets in 1st assessment screen.
Parameters:
Return Value: true/false
=================================================================================*/
function CheckNoPurpleQues1stScr()
{
    var process = GetProcess()
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    FCQuesCount.push(QuesCountInList);
    for(j=0;j<FCQuesCount.length;j++)
    {
        var GeneralQuesFound = false;
        var protocol = "";
        var i;
        var checkUntil=FCQuesCount[j];
        if(j==0)
        {
            i=1;      
        }
        else
        {
            i=FCQuesCount[j-1];         
        }
        
        for (i;i<checkUntil;i++)
        {
              var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
              var QuesObj = Ques.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],5)
              var UrgencyLinked = Ques.DataContext.HighestSeverityType;
              //Validate urgency of each question with corresponding colour 
              if((GeneralQuesFound == false) && (UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal"))
              {
                  if(ToCheckActionColour(QuesObj,"BLACK") || ToCheckActionColour(QuesObj,"BLUE"))
                  {
                      //pass
                  }
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                    
                  }
              }
              else
              {
                  GeneralQuesFound = true;
                  if((!ToCheckActionColour(QuesObj,"INDIGO")) && (!(UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal")))
                  {
                      //pass
                  }
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                     
                  }
              }
              
              //Validate all the question of one set have same protocol code
              if(protocol == "")
              {
                  protocol = Ques.DataContext.ProtCode.OleValue;
                  Log.Message("Checking purple questions for protocol code :: "+protocol);         
              }
              else
              {
                  if(protocol == Ques.DataContext.ProtCode.OleValue)
                      continue;
                  else
                  {
                      Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                      return false;                      
                  }     
              }
        }        
    }
    return true;
}

/*===============================================================================
Description: This function is to chech that EMER and IMLT question are not in purple colour and order of question based on urgency with multiple question sets in 2nd assessment screen.
Parameters:
          questionSet:question set to check
Return Value: true/false
=================================================================================*/
function CheckNoPurpleQues2ndScr(questionSet)
{
    //Select question set if it is not preselected
    if(!TochkComboboxSelected(btn_QuestionSetOnLHS,questionSet))
    {
        clickItem(btn_QuestionSetOnLHS,questionSet);
    }
    
    var process = GetProcess()    
    var QuestionList = process.FindChild(["Name"],["WPFObject(\"HistoryListControl\")"],100)
    var QuesCountInList = QuestionList.ChildCount
    var GeneralQuesFound = false;
    var protocol = "";
    for (i=1;i<QuesCountInList;i++)
    {
          var Ques = QuestionList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\"," +i+")"],100)
          var QuesObj = Ques.FindChild(["Name"],["WPFObject(\"TextBlock\", \"*\", 1)"],5)
          var UrgencyLinked = Ques.DataContext.HighestSeverityType;
          //Validate urgency of each question with corresponding colour 
          if((GeneralQuesFound == false) && (UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal"))
          {
              if(ToCheckActionColour(QuesObj,"BLACK") || ToCheckActionColour(QuesObj,"BLUE"))
              {
                  //pass
              }
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                    
              }
          }
          else
          {
              GeneralQuesFound = true;
              if((!ToCheckActionColour(QuesObj,"INDIGO")) && (!(UrgencyLinked=="ImmediateLifeThreatening" || UrgencyLinked=="RecommendedCallDisposal")))
              {
                  //pass
              }
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                     
              }
          }
              
          //Validate all the question of one set have same protocol code
          if(protocol == "")
          {
              protocol = Ques.DataContext.ProtCode.OleValue;
              Log.Message("Checking purple questions for protocol code :: "+protocol);         
          }
          else
          {
              if(protocol == Ques.DataContext.ProtCode.OleValue)
                  continue;
              else
              {
                  Log.Message("Failed for Question :: "+Ques.DataContext.Text.OleValue)
                  return false;                      
              }
                      
          }
    }        
    return true;
}

/*===============================================================================
Description: This function to validate the audit record created for Purple Question configuration change on/off made in Admin screen
Parameters:
            status:on/off
Return Value: true/false
=================================================================================*/ 
function ToValPurpQuesConfigAudit(status)
{ 
    var  dbRecord1=GetLastAuditEntryWithoutSession();
    if(dbRecord1.length>0)
    {
      
        var summary = aqString.ToUpper(aqString.Trim(dbRecord1[0][2]));
        var category = aqString.ToUpper(aqString.Trim(dbRecord1[0][1]))
        var identity = aqString.ToLower(aqString.Trim(dbRecord1[0][4]))
    
        if(summary=="UPDATESHOWPURPLECOLOUREDQUESTION" && category=="UPDATESHOWPURPLECOLOUREDQUESTION" && identity==aqString.ToLower(Project.Variables.AdminUsername))
        {
            var flag = false;
            status = aqString.ToLower(aqString.Trim(status))
            if(status == "on" && aqString.Trim(dbRecord1[0][3]) == "Show Purple coloured questions turned "+status+".")
            {
                flag = true;
            }
            else if(status == "off" && aqString.Trim(dbRecord1[0][3]) == "Show Purple coloured questions turned "+status+".")
            {
                flag = true;
            }
            return flag;
        }
        else
        {
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
Description: This function to validate the audit record created for toggleing of Ambulance Transport Text configuration change on/off made in Admin screen
Parameters:
            status:enabled/disabled
Return Value: true/false
=================================================================================*/ 
function ToValAmbuTransTxtAudit(status)
{ 
    var  dbRecord1=GetLastAuditEntryWithoutSession();
    if(dbRecord1.length>0)
    {
      
        var summary = aqString.ToUpper(aqString.Trim(dbRecord1[0][2]));
        var category = aqString.ToUpper(aqString.Trim(dbRecord1[0][1]))
        var identity = aqString.ToLower(aqString.Trim(dbRecord1[0][4]))
    
        if(summary=="SHOWAMBULANCETRANSPORTTEXT" && category=="SHOWAMBULANCETRANSPORTTEXT" && identity==aqString.ToLower(Project.Variables.AdminUsername))
        {
            var flag = false;
            status = aqString.ToLower(aqString.Trim(status))
            if(status == "enabled" && aqString.ToLower(aqString.Trim(dbRecord1[0][3])) == "display of ambulance transport text is "+status+".")
            {
                flag = true;
            }
            else if(status == "disabled" && aqString.ToLower(aqString.Trim(dbRecord1[0][3])) == "display of ambulance transport text is "+status+".")
            {
                flag = true;
            }
            return flag;
        }
        else
        {
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
Description: This function to validate the audit record created for changing of Message Text under FirstCall Configuration in Admin screen
Parameters:
          messgType:AMBULANCETEXT/IMLT/EMER/IMM1
Return Value: true/false
=================================================================================*/ 
function ValFirstCalMessgChangAudit(messgType)
{ 
    var  dbRecord1=GetLastAuditEntryWithoutSession();
    if(dbRecord1.length>0)
    {
        var summary = aqString.ToUpper(aqString.Trim(dbRecord1[0][2]));
        var category = aqString.ToUpper(aqString.Trim(dbRecord1[0][1]))
        var identity = aqString.ToLower(aqString.Trim(dbRecord1[0][4]))
    
        if(summary=="TEXTMESSAGEUPDATE" && category=="TEXTMESSAGEUPDATE" && identity==aqString.ToLower(Project.Variables.AdminUsername))
        {
            var actDescription = aqString.Trim(dbRecord1[0][3])
            switch(aqString.ToUpper(messgType))
            {
                case "AMBULANCETEXT":
                    expMessgPart1 = "The message for the text type AmbulanceTransport is updated from '"
                    expMessgPart2 = lbl_AmbulanceTransport
                    expMessgPart3 = "Admin Configured "+lbl_AmbulanceTransport
                    break;
                case "IMLT":
                    expMessgPart1 = "The message for the text type WarningIMLT is updated from '"
                    expMessgPart2 = PopUpMsg_IMLT
                    expMessgPart3 = "Admin Configured "+PopUpMsg_IMLT
                    break;
                case "EMER":
                    expMessgPart1 = "The message for the text type WarningEMER is updated from '"
                    expMessgPart2 = PopUpMsg_EMER
                    expMessgPart3 = "Admin Configured "+PopUpMsg_EMER
                    break;
                case "IMM1":
                    expMessgPart1 = "The message for the text type WarningIMM1 is updated from '"
                    expMessgPart2 = PopUpMsg_IMM1
                    expMessgPart3 = "Admin Configured "+PopUpMsg_IMM1
                    break;                    
            }
                
            var expDescription = expMessgPart1
                                  +expMessgPart2
                                  +"' to '"
                                  +expMessgPart3
                                  +"'.";
            if(actDescription == expDescription)
            {
                return true;
            }
            else
            {
                Log.Warning("Actual Message:: "+actDescription+" not matching with Expected Message:: "+expDescription)
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    else
    {
        Log.Warning("Audit record is not created")
        throw "Audit record is not created"    
    }
} 

/*====================================================================================
Description: This function to Select reason to change in urgency for FirstCall
Parameters: 
          reason:urgency change reason
Return Value: True/False
=====================================================================================*/
function SelUrgChangeReasonFC(reason)
{
    var obj_UrgencyChangeReasons = ToFindObj(["Name"],[cmb_changeUrgencyReason])
    var obj_UrgencyChangeReasons1 = obj_UrgencyChangeReasons.FindChild(["Name"], ["WPFObject(\"ComboBox\", \"\", 1)"], 5);
    if (obj_UrgencyChangeReasons1.Exists && obj_UrgencyChangeReasons1.VisibleOnScreen)
    {
        for(i=0;i<obj_UrgencyChangeReasons1.Items.Count;i++)
        {
            if(aqString.ToUpper(obj_UrgencyChangeReasons1.Items.item(i).Reason.OleValue) == aqString.ToUpper(reason))
            { 
                obj_UrgencyChangeReasons1.ClickItem(i)
                return true
            } 
        } 
        return false
    }
    else
    {
      Log.Error("Object not found")
    }
}
