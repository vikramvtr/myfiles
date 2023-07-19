//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT DBFunctions
//USEUNIT ScreensOf3_12Outcome

/*===============================================================================
Description: This function is wait for the Assessment screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforSummaryScreen()
{
 return waitForItemWithTime(btn_ClinicalSummary,"Clinical Summary",2)
}

/*===============================================================================
Description: This function is to select Patient Outcome or the 1st Signost
Parameters: 
          patientOutcome:patientOutcome value
Return Value: 
=================================================================================*/
function SelectPatientOutcome(patientOutcome)
{
    Process = GetProcess()
    if (Process.Exists) 
    {
        var currentItem = Process.FindChild(["Name"],["WPFObject(\"OutcomeComboBox\")"],100);
        if (currentItem.Exists && currentItem.VisibleOnScreen) 
        {
            //selectComboBoxByIndex("",patientOutcome,currentItem)
            var isOutcomeSelected = selectComboBoxByIndex("",patientOutcome,currentItem);
            selectedOutcome = patientOutcome
            return isOutcomeSelected;
        }
        else
        {
            currentItem = Process.FindChild(["Name"],[list_SignpostServiceList],100); 
            if (currentItem.Exists && currentItem.VisibleOnScreen) 
            {
                var signPostObj = currentItem.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", 1)","True"],100);
                if (signPostObj.Exists) 
                {
                    selectedOutcome = signPostObj.WPFControlText //Newly added
                    signPostObj.Click();
                }          
            }              
        }
    }
} 

/*===============================================================================
Description: This function is to check for selected Patient Outcome(Only for close assessment)
Parameters: 
          patientOutcome:patientOutcome value
Return Value: 
=================================================================================*/
function TochkPatientOutCome(wText)
{
  return ToFindObjToValidate(["Name","wText"],["WPFObject(\"TextBox\", \"\", 1)",wText])
}

/*===============================================================================
Description: This function is to check whether notes has been saved
Parameters: 
Return Value: 
=================================================================================*/
function ToChcNotesSavedItemCount()
{
  Sys.Refresh()
  Process = GetProcess()
  var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
  ParentObj = SummaryLable.parent
  var ListBox1 = ParentObj.FindChild(["Name","Visibility"],["WPFObject(\"ListBox\", \"\", 1)","Visible"],100)
  var cnt = ListBox1.ChildCount
  //Log.Message(cnt-1)
  return cnt-1
} 
/*===============================================================================
Description: This function is to click and compare the details of notes has been saved
Parameters: 
           Action:Click/DblClick
Return Value: 
=================================================================================*/
function ToCmpSavedNotesDetails(Action)
{
  Sys.Refresh()
  Process = GetProcess()
  var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
  ParentObj = SummaryLable.parent
//  var obj = ParentObj.FindChild(["Name"],["WPFObject(\"Notes\", \"\", 1)"],100)
//  var NotesParent = obj.parent
  var ListBox1 = ParentObj.FindChild(["Name","Visibility"],["WPFObject(\"ListBox\", \"\", 1)","Visible"],100)
  var ListBoxItem = ListBox1.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 1)"],100)
  if (Action == "Click")
  {
      ListBoxItem.Click()
      Sys.Refresh()
      var dateTime = getSystemDateTime("%#m/%#d/%#Y %#I:%M %p")
      Log.Message(dateTime)
      var obj = ListBoxItem.FindChild(["WPFControlText"],[dateTime+" : clinician@advanced.ennz "],100)
      if (obj.Exists)
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
    ListBoxItem.DblClick()
  }  
}
/*===============================================================================
Description: This function is to validate chrome browser opens PILs
Parameters: 
          pil:pil text
Return Value: 
=================================================================================*/
function ToChckCromeDoc(pil)
{
  delayExecution(2)
  Process = Sys.Process("chrome")
  var obj = Process.FindChild(["Name"],["Window(\"Chrome_WidgetWin_1\", \""+pil+" - Google Chrome\", *)"],100)
  if (obj.Visible)
  {
    return true
  } 
  else
  {
    return false
  } 
}

/*===============================================================================
Description: This function is to fetch saved notes text of first note
Parameters: 
Return Value: 
=================================================================================*/
function ToFetchSavedNotesText()
{
  Sys.Refresh()
  Process = GetProcess()
  var SummaryLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
  ParentObj = SummaryLable.parent
  var ListBoxItem = ParentObj.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 1)"],100)
  var txt = ListBoxItem.DataContext.Html.OleValue
  Log.Message(txt)
  return txt
}

/*===============================================================================
Description: This function is to validate notes text box
Parameters: 
Return Value: 
=================================================================================*/
function ToChkNotesTextBox()
{
  Sys.Refresh()
  var Process = GetProcess()
  var obj = Process.FindChild(["Name","WPFControlText"],[btn_CancelNotesSave,"Cancel"],100)
  var obj1 = obj.parent
  if ((obj1.Exists)&&(obj1.VisibleOnScreen))
  {
    Log.Message(true)
    return true
  } 
  else
  {
    Log.Message(false)
    return false
  } 
} 

/*===============================================================================
Description: This function is to strike the text
Parameters: 
Return Value: 
=================================================================================*/
function ToStrikeTheText()
{
  Sys.Refresh()
  var Process = GetProcess()
  var obj = Process.FindChild(["Name","WPFControlName","VisibleOnScreen"],[txt_AddNotes,"NotesTextBox",true],100)
//  var obj1 = obj.parent
//  obj1.Click()
  ToEnterBackSpace(obj,5)
}

/*===============================================================================
Description: This function is to strike the text
Parameters: 
Return Value: 
=================================================================================*/
function SelectContent()
{
  var Hieght = Aliases.Odyssey_eCover_App.HwndSource_MainWindow.MainWindow.DockPanel.SummaryControlMain.CareText.ActualHeight
  var Width = Aliases.Odyssey_eCover_App.HwndSource_MainWindow.MainWindow.DockPanel.SummaryControlMain.CareText.ActualWidth
  Drag(txt_careText,"CareText","",1,1,(Hieght/2)-100,(Width/2)-100)
} 
/*===============================================================================
Description: This function is to set text in UrgencyVariationOverlay
Parameters: 
            text:
Return Value: 
=================================================================================*/
function SetTextUrgencyVariation(text)
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],[txt_UrgencyVariationOverlay],100)
  var obj1 = obj.FindChild(["Name"],["WPFObject(\"WatermarkedTextBox\", \"\", 1)"],100)
  setText(text,"","",obj1)
}

/*===============================================================================
Description: This function is to validate action adviced
Parameters:
          text:
Return Value: 
=================================================================================*/
function ValActionAdviced(text)
{
  var process = GetProcess()
  var actAdv = process.FindChild(["Name"],[txt_ActionRequired],100)  
  if (actAdv.Exists && actAdv.VisibleOnScreen)
  {
      if(aqString.ToUpper(actAdv.WPFControlText)==aqString.ToUpper(text))
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
      Log.Message("Action advised message is not found");
      return false;
  }
}

/*===============================================================================
Description: This function is wait for the Emergency Protocol screen
Parameters: 
          itemName:
Return Value: 
=================================================================================*/
function ValActSelectedCmbItems(itemName)
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"AvailableActions\")"],100)
  for(i=0;i<obj.wItemCount;i++)
  {
     if (obj.Items.Item(i).CallHandlerMessage.OleValue==itemName)
      {
        return true
      } 
  }
  return false
}

/*===============================================================================
Description: This function is to validate currently selected action selected
Parameters: 
Return Value: 
=================================================================================*/
function ValActSelected()
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"AvailableActions\")"],100)
  return obj.Items.CurrentItem.CallHandlerMessage.OleValue
}

/*===============================================================================
Description: This function is to validate currently selected action selected
Parameters: 
Return Value: 
=================================================================================*/
function ValCareAdviceSelected()
{
  process = GetProcess()
  var obj = process.FindChild(["Name"],["WPFObject(\"SelectedHeader\")"],100)
  return obj.wText
}

/*===============================================================================
Description: This function is to check session status in DB
Parameters: columnToBeFetched:column detail to be fetched from DB(STATUS/ROLE)
Return Value: sessionDetail(Reception/Advanced Clinician/Call Handler/IntFaceToFaceClinician)
=================================================================================*/
function ToCheckSessionHistoryDet(columnToBeFetched)
{
  var dbRecord
  dbRecord = GetLastEntryFromSessionHistory()
  var columnToBeFetched1 = aqString.ToUpper(columnToBeFetched)
  
  switch(columnToBeFetched1)
  {
    case "STATUS":
      return dbRecord[0][4]
      break;
      
    case "ROLE":
      return dbRecord[0][2]
      break;
  }
}
/*===============================================================================
Description: This function is to check session details in DB
Parameters: 
            columnToBeFetched:column detail to be fetched from DB(ITERATIONTYPE/ITERATIONVERSION/ID/CLINICIANURGENCY/CHURGENCY/RECEPTIONURGENCY/FTFURGENCY/APPVERSION)
            expValue:expected value for session(blank for ID/APPVERSION)
Return Value: sessionDetail
=================================================================================*/
function ToCheckSessionDet(columnToBeFetched,expValue)
{
  var dbRecord
  dbRecord = GetLastEntryFromSession()
  var columnToBeFetched1 = aqString.ToUpper(columnToBeFetched)
  var expValue1 = aqString.ToUpper(expValue)
  switch(columnToBeFetched1)
  {
    case "ITERATIONTYPE":
      return ToCheckDBDetails(dbRecord,2,expValue1);
      break;
    case "ID":
      sessionId = dbRecord[0][0]
      break;
    case "CLINICIANURGENCY":
      return ToCheckDBDetails(dbRecord,5,expValue1); 
      break;
    case "CHURGENCY":
      return ToCheckDBDetails(dbRecord,6,expValue1);     
      break;
    case "RECEPTIONURGENCY":
      return ToCheckDBDetails(dbRecord,7,expValue1);    
      break;
    case "FTFURGENCY":
      return ToCheckDBDetails(dbRecord,8,expValue1);
      break;
    case "APPVERSION":
      return ToCheckDBDetails(dbRecord,9,expValue1);
      break;
    case "ITERATIONVERSION":
      return ToCheckDBDetails(dbRecord,3,expValue1);
      break;
  }
}
/*===============================================================================
Description: This function is to DB details of any column
Parameters: 
            dbRecord:
            columnToBeFetched:column number of dbrecord to be checked for
            expValue:expected value for session
Return Value: true/false
=================================================================================*/
function ToCheckDBDetails(dbRecord,columnToBeFetched,expValue)
{
    if(expValue == "")
    {
      if(dbRecord[0][columnToBeFetched] == null || dbRecord[0][columnToBeFetched] == "")
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
      if(expValue == aqString.ToUpper(dbRecord[0][columnToBeFetched]))
      {
        return true
      }
      else
      {
        return false          
      }
    }   
}

/*===============================================================================
Description: This function is to check clinicalkey details in DB
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckClinicalKey()
{
  var dbRecord
  dbRecord = GetLastEntryFromSession()
  var sessionID=dbRecord[0][0]
  sessionID = aqString.Replace(aqString.Replace(sessionID,"{",""),"}","")
  
  var  dbRecord1=GetClinicalKeyFromResponse(sessionID)
//  Log.Message(dbRecord1.length)
  
  for(var i=0;i<dbRecord1.length;i++)
  {
    if(dbRecord1[i][2]==null || dbRecord1[i][2]=="")
    {
      return false
    }
    else
    {
      continue;  
    }
  }
  return true;
}
/*===============================================================================
Description: This function is to check session deails in DB for InProcess(Written for columns available only in InProcess)
Parameters: columnToBeFetched:column detail to be fetched from DB(ISPMHVIEWED)
Return Value: sessionDetail(Reception/Advanced Clinician/Call Handler/IntFaceToFaceClinician)
=================================================================================*/
function ToCheckSessionDetInProcess(columnToBeFetched)
{
  var dbRecord
  dbRecord = GetLastEntryFromSessionInProcess()
  var columnToBeFetched1 = aqString.ToUpper(columnToBeFetched)
  
  switch(columnToBeFetched1)
  {
    case "ISPMHVIEWED":
      return dbRecord[0][9]
      break;
  }
}
/*===============================================================================
Description: This function is to check PILS url in Summary/Outcome Screen of Clinician/FTF
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckPILSUrl()
{
    var process = GetProcess();
    var parentObj = process.FindChild(["Name","WPFControlName"],["WPFObject(\"LinkList\")","LinkList"],100)
    if(!parentObj.Exists)
    {
        parentObj=process.FindChild(["Name","WPFControlName","VisibleOnScreen"],["WPFObject(\"CallHandlerTabControl\")","CallHandlerTabControl","True"],100)
    }
    var PILSList = parentObj.FindAllChildren(["Name"],["WPFObject(\"ExternalHyperlink\", \"\", 1)"],100).toArray();
    if(PILSList.length>0)
    {
        return ValPilsURL(PILSList);
    }
    else
    {
        Log.Message("No PILS available for the assessment")
        return true;
    }
}
/*===============================================================================
Description: This function is to check Star next to Signpost outcome and select it for Clinician/Call Handler
Parameters: signpostOutcome:signpost Outcome to be checked
Return Value: true/false
=================================================================================*/
function ToCheckSignpostStarIcon(signpostOutcome)
{
  Process = GetProcess()
  if (Process.Exists) 
  {
    var currentItem = Process.FindChild(["Name"],["WPFObject(\"SignpostServiceList\")"],100); 
    if (currentItem.Exists && currentItem.VisibleOnScreen) 
    {
      var signpostCount = currentItem.ChildCount
      for(i=1;i<signpostCount;i++)
      {
        var signPostObj = currentItem.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", "+i+")","True"],100);
        if(aqString.ToUpper(signpostOutcome)==aqString.ToUpper(signPostObj.WPFControlText))
        {
          var signpostPreferedStarIconObj = signPostObj.FindChild(["Name","Exists"],["WPFObject(\"SignpostPreferedStarIcon\")","True"],10);
          if(signpostPreferedStarIconObj.VisibleOnScreen)
          {
            Log.Message("Signpost Outcome "+signpostOutcome+" is preferred and starred")
            //signPostObj.Click();
            return true;
          }
          else
          {
            Log.Message("Signpost Outcome "+signpostOutcome+" is not preferred and starred")
            //signPostObj.Click();
            return false;            
          }
        }
      }
      Log.Warning("Signpost Outcome "+signpostOutcome+" not found")
      return false;         
    }              
  }
}
/*===============================================================================
Description: Function to validate the pre-selected signpost when number of suggested signpost is One 
Parameters:      
Return Value:true/false
=================================================================================*/
function ToValidatePreSelectSignpost()
{
  var process=GetProcess()
  var SignpostList = process.FindChild(["Name","VisibleOnScreen"],[list_SignpostServiceList,"True"],100);
  var signpostCount=SignpostList.wItemCount
  var signPostObj = SignpostList.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", 1)","True"],100);
  if(signpostCount==1)
  {
      if (signPostObj.Exists && signPostObj.IsSelected) 
      {
        Log.Message("Signpost is preselected")
        return true
      } 
      else(signPostObj.Exists && signPostObj.IsSelected)
     {
        Log.Message("Signpost is not preselected")
        return false
      }    
  }
  else
  {
      if (signPostObj.Exists && !signPostObj.IsSelected) 
      {
        Log.Message("Multiple signpost exist and signpost is not pre selected")
        return true
      } 
      else
      {
        Log.Message("Multiple signpost exist and signpost is  pre selected")
        return false
      }
   }
}
/*===============================================================================
Description: This function is to select SignPost for Clinician and CallHandler and check selected signpost is highlighted
Parameters: 
          signPost:SignPost text to be selected
Return Value:true/false
=================================================================================*/
function SelectSignPost(signPost)
{
    Process = GetProcess()
    if (Process.Exists) 
    {
        var SignpostServiceListObj = Process.FindChild(["Name"],[list_SignpostServiceList],100); 
        if (SignpostServiceListObj.Exists && SignpostServiceListObj.VisibleOnScreen) 
        {
        
            for(i=1;i<SignpostServiceListObj.ChildCount;i++)
            {
                var curSignPostObj = SignpostServiceListObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", "+i+")","True"],100);
                if (aqString.ToUpper(curSignPostObj.WPFControlText)==aqString.ToUpper(signPost)) 
                {
                  curSignPostObj.Click();
                  Sys.Refresh();
                  if(curSignPostObj.IsSelected)
                  {
                      Log.Message(signPost+" SignPost is highlighted upon click");
                      return true;  
                  }
                  else
                  {
                      Log.Message(signPost+" SignPost is not highlighted upon click");
                      return false;
                  }
                }          
            }
            Log.Message(signPost+" SignPost is not found for the assessment");
            return false;
        }              
    }
} 
/*===============================================================================
Description: This function is to check the urgency selected and its backgound color in SUmmary screen
Parameters: 
          urgencySelected:urgencySelected text
          backgroundColor:expected background colour(INDIGO/RED/LIGHTRED/YELLOW/LIGHTYELLOW/GREEN/BLUE)
Return Value:true/false
=================================================================================*/
function ToCheckUrgencySelClinician(urgencySelected,backgroundColor)
{
    Process = GetProcess()
    if (Process.Exists) 
    {
        var urgencySelectedLbl = Process.FindChild(["WPFControlText","VisibleOnScreen"],["Clinician Selected:","True"],100);
        var parentObj = urgencySelectedLbl.Parent
        var borderObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Border\", \"\", 1)","True"],100);
        var urgencySelectedObj = borderObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBlock\", \"*\", 1)","True"],100);
        if(aqString.ToUpper(urgencySelectedObj.WPFControlText)==aqString.ToUpper(urgencySelected))
        {
          if(backgroundColor=="")
          {
              return true;
          }
          else if(ToCheckUrgencyColour(borderObj,backgroundColor))
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
            Log.Message(urgencySelected+" is not matching")
            return false;
        }
    }  
}
/*===============================================================================
Description: This function is to validate suggested signpost and selected signpost in DB
Parameters: 
    columnToBeFetched: column detail to be fetched from DB
    Value: Expected signpost
Return Value: true/false
=================================================================================*/
function ToCheckSignpost(columnToBeFetched, Value)
{
    var dbRecord
    dbRecord=GetLastEntryFromSessionInProcess()
    var SessionId = dbRecord[0][0]
    var columnToBeFetched1 = aqString.ToUpper(columnToBeFetched)    
    var dbRecord1=GetSignpostsBySeesionID(SessionId)
    switch(columnToBeFetched1)
    {
      case "DESCRIPTION":
          var expValue1 = aqString.ToUpper(Value)
          return ToCheckDBDetails(dbRecord1,2,expValue1);
      case "SUGGESTEDSIGNPOST":
           var valueArr=Value.split(",");
           var actValueArr=dbRecord1[0][1]
           var actValueArr1=actValueArr.split("|")
           if(valueArr.length==actValueArr1.length)
           {
             for (var i=0;i<valueArr.length;i++)
             {
                 if(aqString.ToUpper(valueArr[i])==aqString.ToUpper(actValueArr1[i]))
                 {
                    continue
                 }
                 else
                 return false
             }
             Log.Message("Suggested signpost is stored in the database")
             return true
          }
          else
          {
              Log.Message("Suggested signpost is not stored in the database")
              return  false  
          }      
      }
}
/*===============================================================================
Description: Function to validate the pre-selected signpost when number of suggested signpost is One 
Parameters:
          SelectedSignpost:Selected Signpost text
Return Value:true/false
=================================================================================*/
function ToValidateSelectedSignpost(SelectedSignpost)
{
    var process=GetProcess()
    var SignpostList = process.FindChild(["Name","Exists"],[list_SignpostServiceList,"True"],100);
  
    if(SignpostList.VisibleOnScreen)
    {
        if(SelectedSignpost!="")
        {
            var actSignpostSelected = SignpostList.SelectedItem.Text.OleValue;
            if(aqString.ToUpper(SelectedSignpost)==aqString.ToUpper(actSignpostSelected))
            {
              Log.Message(SelectedSignpost+" is selected in Summary screen");
              return true;
            }
            else
            {
              Log.Message(SelectedSignpost+" is not selected in Summary screen");
              return false;
            }      
        }
        else
        {
            var actSignpostSelected = SignpostList.SelectedItem;
            if(actSignpostSelected==null)
            {
              Log.Message("None of the signpost is selected in Summary screen");
              return true;
            }
            else
            {
              Log.Message("Signpost is already selected in Summary screen");
              return false;
            }  
        }
    }
}
/*===============================================================================
Description: This function is to validat PILs url in Summary Screen of Call Handler/Clinician/FTF
Base url of config table should be - http://ahc-demo-plain.adastra.co.uk/3.10/PILS/
Parameters: 
Return Value: true/false
=================================================================================*/
function ValPilsURL(PILSList)
{
    var pattern = "https://www.nhs.uk/conditions/"+"[a-bA-B]*|[-]*"+"/";
//    var pattern = "https://www.nhs.uk/conditions/"+"(\\w+|[-])"+"/";
    var regexPattern = new RegExp(pattern);
    var count=0;
    for(i=0;i<PILSList.length;i++)
    {
      currPIL = PILSList[i];
      var actURL = currPIL.NavigateUri.OriginalString.OleValue
      var res = regexPattern.test(actURL)        
      if(res==false)
      {
        Log.Error("URL of :: "+currPIL.Tag.OleValue+" is not matching")
        return false;
      }
      count++;
    }
    if(count==PILSList.length)
    {
      return true;
    }  
}
/*===============================================================================
Description: This function is to validate suggested signpost and selected signpost in DB
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckSignpostNegScenario()
{
    var dbRecord
    dbRecord=GetLastEntryFromSessionInProcess()
    var SessionId = dbRecord[0][0]   
    var result=GetSignpostsNegScenario(SessionId)
    if(result)
        return true
    else
        return false
}

/*===============================================================================
Description: This function is to fetch saved notes text of first note
Parameters: 
Return Value: true/false
=================================================================================*/
function ToCheckNotesSectEnableClinSumm()
{
    if(Project.Variables.Process == "INPROCESSNEW" && !ToCheckLablePresent("Care Advice"))
    {
      ToScrollNewTestHarness("UP");
    }
    Process = GetProcess()
    var NotesLable = Process.FindChild(["Name"],["WPFObject(\"Label\", \"Notes\", 1"],100)
    ParentObj = NotesLable.parent
    var notesTextBoxObjs = ParentObj.FindAllChildren(["Name"],["WPFObject(\"NotesTextBox\")"],10).toArray();
    var notesTextBox = notesTextBoxObjs[1]
    if(notesTextBox.Exists && notesTextBox.Enabled && notesTextBox.VisibleOnScreen)
    {
        Log.Message(notesTextBox.WPFControlName+" object is enable")
        return true
    }
    else 
    {
        Log.Message(notesTextBox.WPFControlName+" object is disable")
        return false
    }
}

/*===============================================================================
Description: Function to enter file name and Save the Summary report as a PDF document
Parameters:
          filename:PDF File Name
Return Value:
=================================================================================*/
function SaveSummaryPDF(filename)
{
    clickItem(btn_SaveasPDF, "Save as PDF")
    waitForItemWithTime(PopUpMsg, "", 1)
    clickItem(btn_YesLabel, "Ok")
    delay2Sec()
    obj_parent = ToFindObj(["Name"], ["Window(\"FloatNotifySink\", \"\", 1)"])
    cmb_filename = obj_parent.FindChild(["Name"], ["Window(\"ComboBox\", \"\", 1)"], 5);
    
    var d = new Date();
    cmb_filename.Keys(Project.Variables.solutionPath+"\\PDFs\\PDF\\"+filename)
    btn_savefile = ToFindObj(["Name"], ["Window(\"Button\", \"&Save\", *)"])
    btn_savefile.Click()
    if(ToFindObjToValidate(["Name"], ["Window(\"*\", \"Confirm Save As\", *)"]))
    {
        btn_Yes = ToFindObj(["Name"], ["Window(\"Button\", \"&Yes\", *)"])
        btn_Yes.Click();
    }
}

/*===============================================================================
Description: This function is used to backup the existing PDFs of previous run
Parameters:
===============================================================================*/
function CreatePDFBackup()
{
    source = Project.Variables.solutionPath+"\\PDFs\\";
    destination = Project.Variables.solutionPath+"\\PDFs\\PDFs_BCK";
    copyFolder = "PDF";
    //Create the backup folder if does not exists
    if (!aqFileSystem.Exists(destination)) 
    {
            // Creates the folder
            aqFileSystem.CreateFolder(destination);
    }
    var d = new Date();
    var backupTime = d.getYear(destination)+""+(d.getMonth()+1)+""+d.getDate()+""+d.getHours()+""+d.getMinutes()+""+d.getSeconds();
    destFolder = destination + "\\" + "_" + backupTime
    aqFileSystem.CreateFolder(destFolder);
    sourcePath = source + copyFolder;
    aqFileSystem.CopyFolder(sourcePath, destFolder);
    aqFileSystem.DeleteFile(source + "PDF\\*.pdf");
}
