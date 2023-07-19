//USEUNIT CommonFunctions
//USEUNIT PageObjects

/*===============================================================================
Description: This function to validate actions displayed under Treatment Plan tab with its related groupName and Colour
Parameters: 
          action:action text
          groupName:group name of action
          colourType:font colour of action or Blank(Red/Yellow/Blue/"")
Return Value:true/false
=================================================================================*/
function ToCheckSuggestedActions(action,groupName,colourType)
{
  var process = GetProcess();
  var chkbx_Actions = process.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"CheckBoxAction\")","True"],100).toArray();
  
  if (chkbx_Actions.length>0)
  {
    var actionObj, actionPresent, groupMatch, i;
    var colourMatch=false;
    for(i=0;i<chkbx_Actions.length;i++)
    {
      if(aqString.ToUpper(chkbx_Actions[i].WPFControlText)==aqString.ToUpper(action))
      {
        Log.Message("Suggested action "+action+" found")
        actionObj = chkbx_Actions[i]
        actionPresent=true;
        break;
      }
    }
    if(actionPresent==true)
    {
      colourMatch = ToCheckActionColour(actionObj,colourType)
      
      var groupObj = actionObj.parent.parent.parent
      if(aqString.ToUpper(groupObj.Content.Name.OleValue)==aqString.ToUpper(groupName))
      {
        Log.Message("Suggested action "+action+" group name "+groupName+" matched")
        groupMatch=true;      
      }
      
      if(actionPresent && colourMatch && groupMatch)
      {
        Log.Message("Colour of Suggested action "+action+" matched")
        return true;
      }
      else
      {
        Log.Message("Colour of Suggested action "+action+" not matched")
      }
    }
    else
    {
      Log.Message("Suggested action "+action+" not found")
      return false;
    }
  }
}

/*===============================================================================
Description: This function to check the colour actions displayed 
Parameters: 
          actionObj:action object
          expColour:expected colour of action
Return Value:true/false
=================================================================================*/
function ToCheckActionColour(actionObj,expColour)
{
    var blueVal = actionObj.Foreground.Color.B
    var redVal = actionObj.Foreground.Color.R
    var greenVal = actionObj.Foreground.Color.G
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
      case "LIGHTRED":
        if(blueVal==0 && redVal==204 && greenVal==0)
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
Description: This function to validate actions logged as a note and its colour 
Parameters: 
          actionText:action text
          expColour:font colour of action note or Blank(Red/Yellow/Black/"")
Return Value:true/false
=================================================================================*/
function ToCheckActionNotes(actionText,expColour)
{
  var actionPresent=false;
  var process = GetProcess();
  var treatmentNotesGridObj = process.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"TreatmentNotesGrid\")","True"],100)
  var actionObjs = treatmentNotesGridObj.FindAllChildren(["Name","ClrClassName","VisibleOnScreen"],["WPFObject(\"TextBox\", \"\", *)","TextBox","True"],50).toArray();
  
  if(actionObjs.length>0)
  {
    for(var k=0;k<actionObjs.length;k++)
    {
      if(aqString.ToUpper(actionText) == aqString.ToUpper(actionObjs[k].wText))
      {
        Log.Message("Action "+actionText+" found as note")
        if(ToCheckActionColour(actionObjs[k],expColour))
        {
          Log.Message("Colour of action note "+actionText+" matched")
          return true;
        }
        else
        {
          Log.Message("Colour of action note "+actionText+" not matched")
          return false;          
        }
      }
    } 
    Log.Message("Action "+actionText+" not found as note") 
    return false; 
  }
  else
  {
      Log.Message("No Action note present under Treatment Plan")
      return false;    
  }
}
/*===============================================================================
Description: This function to check and uncheck Suggested Actions under Treatment Plan tab 
Parameters: 
          actionText:action text
Return Value:
=================================================================================*/
function ToSelectActions(actionText)
{
  actionText = aqString.Replace(actionText,"|",","); 
  clickItem(chkBx_CheckBoxAction,actionText);
  
}
/*===============================================================================
Description: This function to check order of Suggested Actions for emergency under Treatment Plan tab 
Parameters: 
Return Value:true/false
=================================================================================*/
function ToCheckOrderEmergencyActions()
{
  var process = GetProcess();
  var chkbx_Action = process.FindChild(["Name","WPFControlText","VisibleOnScreen"],["WPFObject(\"CheckBoxAction\")","Based on history, consider further opinion as emergency","True"],100);
  
  if(chkbx_Action.Exists)
  {
    Log.Message("Suggested action Based on history, consider further opinion as emergency found")    
    var parentObj = chkbx_Action.parent.parent.parent;
    
    if(parentObj.WPFControlOrdinalNo == "1")
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
    Log.Message("Suggested action Based on history, consider further opinion as emergency not found") 
    return false;       
  }
}

/*===============================================================================
Description: This function is to clear text from the search box of Add Treatment dialog.
Parameters: 
          number:number of times back space required
Return Value: 
=================================================================================*/
function ClearSearchActionTextBox(number)
{
  var process = GetProcess()
  var txt_searchAction = process.Findchild(["WPFControlName","VisibleOnScreen"],["ActionSearchTerm","True"],100)
  if(txt_searchAction.Exists)
  {
    ToEnterBackSpace(txt_searchAction,number)    
  }
} 

/*===============================================================================
Description: This function is to validate/compare the search result for presenting complaint and result count
Parameters:             
             searchString:Search string entered/""(blank)
             expSearchResultCount:expected number of records in search result/""(blank)
Return Value: true/false
=================================================================================*/
function ToCheckAddTreatSearchResult(searchString,expSearchResultCount)
{
  var process = GetProcess()
  var searchList = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"AddActionsListBox\")","True"],100)
  
  if(expSearchResultCount=="0")
  {
    var parentObj = searchList.parent
    var obj = parentObj.FindChild(["WPFControlText","VisibleOnScreen"],["No matches were found.","True"],10)
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
        Log.Message("Add Treatment search result count not matched");
        return false;
      }
      else
      {
        Log.Message("Add Treatment search result count matched");
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
        Log.Message("Current treatment "+currResult)
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
Description: This function is to add a note under treatment plan using Copy to Treatment Plan button
Parameters:             
Return Value:
=================================================================================*/
function CopyTreatmentPlanNote()
{
  var process = GetProcess();
  var treatmentPlainTabControlObj = process.Findchild(["Name","VisibleOnScreen"],["WPFObject(\"TreatmentPlainTabControl\")","True"],100)
  var careTextObj = treatmentPlainTabControlObj.FindChild(["Name","VisibleOnScreen"],["WPFObject(\"CareText\")","True"],10)
  careTextObj.Drag(202, 13, -184, -11);  
  clickItem(btn_CopytoTreatmentPlan,"Copy to Treatment Plan")
}