﻿//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT DBFunctions

/*===============================================================================
Description: This function to validate recommended urgency message under Outcome tab of FTF
Parameters: 
         expMessg:expected recommended urgency message
          expColor:font colour of action note or Blank(Red/Yellow/Black/"")
Return Value: true/false
=================================================================================*/
function ToCheckRecommUrgencyMessgFTF(expMessg,expColor)
{
  var actionPresent=false;
  var process = GetProcess();
  var lbl_recommended = process.FindChild(["Name","VisibleOnScreen"],[lbl_RecommendedLabel,"True"],100)
  if(lbl_recommended.Exists)
  {
    var parentObj = lbl_recommended.parent
    var recommUrgObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)","True"],20)
    if(aqString.ToUpper(recommUrgObj.Text)==aqString.ToUpper(expMessg))
    {
      Log.Message("Action "+expMessg+" found")
        if(ToCheckUrgencyColour(recommUrgObj,expColor))
        {
          Log.Message("Colour of action  "+expMessg+" matched")
          return true;
        }
        else
        {
          Log.Message("Colour of action "+expMessg+" not matched")
          return false;          
        }
    }
   }   
  
  else
  {
    Log.Warning("Summary section not found in Outcome tab")
  }  
}

/*===============================================================================
Description: This function to attempt to close the application and select option in the close app popup
Parameters: 
          action:Yes/No/""(blank)
Return Value: 
=================================================================================*/
function closeApplication3(action)
{
  Process = GetProcess()
  if(!ToFindObjToValidate("Name",obj_CloseAppOverlay))
  {
    Process.Close()
//    Delay(700)    
  }
  switch(aqString.ToUpper(action))
  {
    case "YES":
      var btn_yes = Process.FindChild(["Name"], [btn_CloseAppYes], 50)
      btn_yes.Click();
      break;
    case "NO":
      var btn_no = Process.FindChild(["Name"], [btn_CloseAppNo], 50)
      btn_no.Click();
      break;
    case "":
      break;     
  }
  Delay(1000)
}

/*===============================================================================
Description: This function to check application availability
Parameters: 
Return Value:true/false
=================================================================================*/
function ToCheckAppAvailability()
{
  if(Project.Variables.Process == "STANDALONE")
  {
    if(Sys.WaitProcess("Odyssey.eCover.App").Exists)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  else if(Project.Variables.Process == "INPROCESS")
  {
    if(Sys.WaitProcess("Odyssey.InProcess.TestHarness.Main").Exists)
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
Description: This function is to return the number of saved notes in Summary
Parameters: 
Return Value:noteCount
=================================================================================*/
function GetSavedNoteCountFTF()
{
  Sys.Refresh()
  Process = GetProcess()
  var outcomeTab= Process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"FaceToFaceTabControl\")","True"],100)
  var notesSection = outcomeTab.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Notes\", \"\", 1)","True"],100) 
  var savedNotes = notesSection.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", *)","True"],100).toArray();
  return savedNotes.length;
} 

/*===============================================================================
Description: This function is to click/doubleClick and compare the details of notes has been saved
Parameters: 
          noteText:Saved note text
          Action:Click/DoubleClick/""(blank for validating note presence)
Return Value:true/false
=================================================================================*/
function ToAccessCompNoteDetailsFTF(noteText,Action)
{
  Sys.Refresh()
  Process = GetProcess()
  var outcomeTab= Process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"FaceToFaceTabControl\")","True"],100)
  var notesSection = outcomeTab.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Notes\", \"\", 1)","True"],100)
//  var ListBox1 = notesSection.FindChild(["Name","Visibility"],["WPFObject(\"ListBox\", \"\", 1)","Visible"],100)
  var savedNotes = notesSection.FindAllChildren(["Name"],["WPFObject(\"ListBoxItem\", \"\", *)"],10).toArray();
  var i,noteFound=false;
  if(savedNotes.length>0)
  {
    for(i=0;i<savedNotes.length;i++)
    {
      var obj = savedNotes[i].FindChild(["Name","Exists"],["WPFObject(\"Paragraph\", \"\", 1)","True"],100)
      if(aqString.ToUpper(noteText) == aqString.ToUpper(obj.WPFControlText))
      {
        Log.Message("Note "+noteText+" is found");
        noteFound = true;
        break;
      }
    }
  }
  else
  {
    Log.Message("No note saved under outcome tab");    
  }
  

  if(noteFound == true)
  {
    if (aqString.ToUpper(Action) == "CLICK")
    {
        savedNotes[i].Click()
        Sys.Refresh()
        var dateTime = getSystemDateTime("%#m/%#d/%#Y %#I:%M %p")
        Log.Message(dateTime)
        var obj = savedNotes[i].FindChild(["WPFControlText"],["* : ftf@advanced.engb "],100)
        if (obj.Exists)
        {
          Log.Message("Note details matched");          
          return true
        } 
        else
        {
          Log.Message("Note details not matched");   
          return false
        } 
    }
    else if(aqString.ToUpper(Action) == "DOUBLECLICK")
    {
      savedNotes[i].DblClick()
    } 
    else if(aqString.ToUpper(Action) == "")
    {
      return true;
    }    
  }  
  else
  {
    Log.Message("Note "+noteText+" is not found");
    return false;    
  }
}
/*===============================================================================
Description: This function is to fetch saved notes text of firstnote in the grid
Parameters: 
Return Value:notetext
=================================================================================*/
function ToFetchSavedNoteTextFTF()
{
  Sys.Refresh()
  Process = GetProcess()
  var outcomeTab= Process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"FaceToFaceTabControl\")","True"],100)
  var notesSection = outcomeTab.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Notes\", \"\", 1)","True"],100)
  var ListBox1 = notesSection.FindChild(["Name","Visibility"],["WPFObject(\"ListBox\", \"\", 1)","Visible"],100)
  var ListBoxItem = ListBox1.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", 1)"],100)
  var txt = ListBoxItem.DataContext.Html.OleValue
  Log.Message(txt)
  return txt
}
/*===============================================================================
Description: This function to search the PILS in the list box 
Parameters: 
          data:Available or Selected
Return Value: true/false
=================================================================================*/  
function SetTextPILSSearch(data)
{
  var process = GetProcess()
  var obj1 = process.FindChild(["Name","VisibleOnScreen"],[txt_PILSSearch,true],100)
  if (obj1.Exists)
  {
    obj1.Click()
    setText(data,txt_PILSSearch,"PILSSearchInputBoxControl","")
    obj1.Click()
  } 

}
/*===============================================================================
Description: This function is to validate/compare the search result for PILS in the list box 
Parameters:             
             searchString:Search string entered/""(blank)
             expSearchResultCount:expected number of records in search result/""(blank)
Return Value: true/false
=================================================================================*/
function ToCheckPILsSearchResult(searchString,expSearchResultCount)
{
  var process = GetProcess()
  var ListObj = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"PILSLabel\")","True"],100)
  var parentObj = ListObj.parent
  var searchList = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Grid\", \"\", *)","True"],20)
  if(expSearchResultCount=="0")
  {
  
    var obj = process.FindChild(["WPFControlText","VisibleOnScreen"],["No results were found.","True"],10)
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
    var searchResultObjs = searchList.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", *)","True"],100).toArray();
    
    if(expSearchResultCount!="")
    {
      if(expSearchResultCount!=searchResultObjs.length)
      {
        Log.Message("PILs search result count not matched");
        return false;
      }
      else
      {
        Log.Message("PILs search result count matched");
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
        Log.Message("Current PILs "+currResult)
        var res = regexPattern.test(aqString.ToLower(currResult))        
        if(res==true)
        {
        return true;
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
Description: This function is to clear text from the search box of PILs.
Parameters: 
          number:number of times back space required
Return Value: 
=================================================================================*/
function ClearPILsSearchActionTextBox(number)
{
  var process = GetProcess()
  var txt_searchAction = process.Findchild(["WPFControlName","VisibleOnScreen"],["PILSSearchInputBoxControl","True"],100)
  if(txt_searchAction.Exists)
  {
    ToEnterBackSpace(txt_searchAction,number)    
  }
} 
/*===========================================================================s====
Description: This function to validate details of note added in DB
Parameters: 
            columnToBeFetched:column detail to be fetched from DB(TEXT/USERNAME)
            expValue:expected value for note
Return Value: 
=================================================================================*/
function ToCheckNoteDetails(columnToBeFetched,expValue)
{
  var dbRecord
  dbRecord = GetLastNote()
  var columnToBeFetched1 = aqString.ToUpper(columnToBeFetched)
  var expValue1 = aqString.ToUpper(expValue)
  
  switch(columnToBeFetched1)
  {
    case "TEXT":
      expValue1 = aqString.Find(dbRecord[0][1],expValue,false)
      if(expValue1!=-1)
      {
        return true;
      }
      else
      {
        return false;
      }
      break;
    case "USERNAME":
      if(expValue1 == aqString.ToUpper(dbRecord[0][3]))
      {
        return true
      }
      else
      {
        return false          
      }
      break;
  }
}
/*===========================================================================s====
Description: This function to select patient outcome for FTF
Parameters: 
            outcome:patient outcome to be selected
Return Value:
=================================================================================*/
function SelectPatientOutcomeFTF(outcome)
{
  var process = GetProcess()
  var PatientOutcomeLabelObj = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"PatientOutcomeLabel\")","True"],100)
  var parentObj = PatientOutcomeLabelObj.parent
  var cmb_PatientOutcomeFTF = parentObj.Findchild(["Name","VisibleOnScreen"],[cmb_CallType,"True"],100)
  selectComboBoxByIndex("",outcome,cmb_PatientOutcomeFTF)
}

/*===============================================================================
Description: This function is to add diagnosis note for assessment
Parameters: 
            noteText:diagnosis note text         
Return Value:
=================================================================================*/
function AddDiagnosisNoteFTF(noteText)
{
  var process = GetProcess()
  var DiagnosisGridObj = process.Findchild(["Name","VisibleOnScreen"],[grid_DiagnosisGrid,"True"],100)
  var txt_diagnosisNote = DiagnosisGridObj.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", 1)","True"],20)
  
  if(txt_diagnosisNote.Exists)
  {
    setText(noteText,"","",txt_diagnosisNote)
  }
  else
  {
    Log.Error("Diagnosis notes textbox not found")
  }
}
/*===============================================================================
Description: This function is to check diagnosis note saved in DB against session
Parameters: 
            expNoteText:expected diagnosis note text         
Return Value: true/false
=================================================================================*/
function ToCheckDiagnosisNote(expNoteText)
{
  var dbRecord
  dbRecord = GetLastEntryFromSession();
  var sessionID=dbRecord[0][0]
  sessionID = aqString.Replace(aqString.Replace(sessionID,"{",""),"}","")
  
  var  dbRecord1=GetAllNotesofSession(sessionID)
  
  if(dbRecord1.length>0)
  {
    expNoteText = aqString.ToUpper(expNoteText);
    for(var i=0;i<dbRecord1.length;i++)
    {  
      var noteText = aqString.ToUpper(dbRecord1[i][0]);
      if(aqString.Find(noteText,expNoteText,false)!=-1)
      {
        return true;
      }
      else
      {
        continue;  
      }
    }
    Log.Warning("Diagnosis note not found for session")
    return false;
  }
  else
  {
    Log.Warning("Not a single note found for session")
    return false;
  }
}

/*===============================================================================
Description: This function to check the colour actions displayed 
Parameters: 
          actionObj:action object
          expColour:expected colour of action(INDIGO/RED/LIGHTRED/YELLOW/LIGHTYELLOW/GREEN/BLUE/BLACK)
Return Value:true/false
=================================================================================*/
function ToCheckUrgencyColour(actionObj,expColour)
{
    var blueVal = actionObj.Background.Color.B
    var redVal = actionObj.Background.Color.R
    var greenVal = actionObj.Background.Color.G
    
    var colourMatch=false;
    switch(aqString.ToUpper(expColour))
    {
      case "INDIGO":
        if(blueVal==255 && redVal==106 && greenVal==0)
        {
          colourMatch=true;
        }
        break;
      case "RED":
        if(blueVal==36 && redVal==161 && greenVal==0)
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
     case "LIGHTYELLOW":
        if(blueVal==0 && redVal==216 && greenVal==193)
        {
          colourMatch=true;
        }
        break;
     case "LIGHTRED":
        if(blueVal==0 && redVal==204 && greenVal==0)
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
      case "":
        colourMatch=true;
        break;
    }  
    return colourMatch;
}

/*===============================================================================
Description: This function is to copy and paste text in Frist name field
Parameters: 
Return Value: 
=================================================================================*/
function copyAndPasteNoteFTF()
{
  var process = GetProcess()
  var obj1 = process.Findchild(["Name"],[txt_PILSSearch],100)
  obj1.Keys("^a");
  obj1.Keys("^c");
  Log.Message(Sys.Clipboard);
  var obj2 = process.Findchild(["Name"],[txt_AddNotes],100)
  obj2.Keys("^v");
} 

/*===============================================================================
Description: This function to validate selected patient outcome under Outcome tab of FTF
Parameters: 
         expOutcome:expected Outcome selected
Return Value: true/false
=================================================================================*/
function ToCheckSelectedOutcomeFTF(expOutcome)
{
  var process = GetProcess();
  var lbl_PatientOutcomeObj = process.FindChild(["Name","VisibleOnScreen"],[lbl_PatientOutcomeLabel,"True"],100)
  if(lbl_PatientOutcomeObj.Exists)
  {
    var parentObj = lbl_PatientOutcomeObj.parent
    var PatientOutcomeObj = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ComboBox\", \"\", 1)","True"],20)
    if(PatientOutcomeObj.Exists)
    {
      if(aqString.ToUpper(PatientOutcomeObj.Text)==aqString.ToUpper(expOutcome))
      {
        Log.Message("PatientOutcome "+expOutcome+" matched")
        return true;
      }
      else
      {
        return false;
      }      
    }
    else
    {
      Log.Warning("Patient Outcome combobox not found")      
    }   
  }    
  else
  {
    Log.Warning("Summary section not found in Outcome tab")
  }  
}

/*===============================================================================
Description: This function to validate the unique PIL search result
Parameters: 
          PILName: Name of the PIL
Return Value: true/false
=================================================================================*/
function ToValUniquePIL(PILName)
{
  var process = GetProcess()
  var ListObj = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"PILSLabel\")","True"],100)
  var parentObj = ListObj.parent
  var searchList = parentObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"Grid\", \"\", *)","True"],20)
  var obj = searchList.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ItemsPresenter\", \"\", *)","True"],100)
  var ListCount = obj.ChildCount
  if(obj.Exists)
  {
  var count =0 ;
  for(var i=1;i<=ListCount;i++)
    {
      var currentPilObj = obj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"ListBoxItem\", \"\", "+i+")","True"])
      var pil = currentPilObj.FindChild(["WPFControlText","VisibleOnScreen"],[PILName,"True"],20)
      if(pil.Exists)
      {
        count = count+1;       
      }
    }
    if(count==0)
    {
     Log.Message(PILName+" PIL not found")
      return false    
    }
  
    else if(count==1)
    {
      Log.Message(PILName+"PIL is unique")
      return true
    }
    else
    {
      Log.Message(PILName+" PIL is duplicated")
      return false
    }
  }
else
{
    Log.Message("Pil result is not visible")
    return false
  }
}
/*===============================================================================
Description: This function is wait for the FTF Outcome screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforFTFOutcomeScreen()
{
 return waitForItemWithTime(lbl_PILSLabel,"Patient Information Leaflets",3)
}