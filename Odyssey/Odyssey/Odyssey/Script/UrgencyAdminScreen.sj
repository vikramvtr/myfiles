//USEUNIT CommonFunctions
//USEUNIT PageObjects

/*===============================================================================
Description: This function is wait for the Urgency Admin screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforUrgencyAdminscreen()
{
  return waitForItemWithTime(btn_WPFButton,"Back to Admin Summary",2 )
}

/*===============================================================================
Description: This function is to expand urgency grid in the Urgency Admin screen
Parameters: 
          urgency:urgency grid to be expanded(Immediate / Urgent / ...)
Return Value: 
=================================================================================*/
function expandCollapseUrgencyGrid(urgency)
{
    var obj = ToFindObj(["Name"],["WPFObject(\"TextBlock\", "+urgency+", 1)"]);
    if(obj.Exists)
    {
        obj.Click();
    }
    return obj;
}

/*===============================================================================
Description: This function is to expand urgency grid in the Urgency Admin screen
Parameters: 
          Urgency:urgency grid to be expanded(Immediate / Urgent / ...)
Return Value: true/false
=================================================================================*/
function ValidateUrgencyMssgTitle(Urgency)
{
  expandCollapseUrgencyGrid(Urgency);
  var CallHandMessg = ToCheckLablePresent("Call handler Message")
  var UrgencyMessg = ToCheckLablePresent("Urgency Message")
  var FirstCallWorsTXT = ToCheckLablePresent("Contact Information")
  var SnomedTXT = ToCheckLablePresent("Snomed")
  expandCollapseUrgencyGrid(Urgency);
  if(CallHandMessg && UrgencyMessg && FirstCallWorsTXT && SnomedTXT)
      return true;
  else
      return false;
}

/*===============================================================================
Description: This function is to edit the Urgency message for any Urgency Type
Parameters: 
          urgency:urgency grid to be expanded(Immediate / Urgent / ...)
          heading:Heading of Urgency Message(Call handler Message/Face to Face Examination Banner message/Urgency Message/.....)
          updatedValue:updated message
Return Value:
=================================================================================*/
function UpdateUrgencyMessage(urgency,heading,updatedValue)
{
    var obj = expandCollapseUrgencyGrid(urgency);
    var parentObj = obj.parent
    var headingObjList = parentObj.FindAllChildren(["Name"],["WPFObject(\"GridViewRow\", \"\", *)"],5).toArray();
    if(headingObjList.length>0)
    {
        for(i=0;i<headingObjList.length;i++)
        {
            headingObj = headingObjList[i].FindChild(["Name"],["WPFObject(\"GridViewCell\", \"*\", 1)"],5)
            if(aqString.ToUpper(headingObj.WPFControlText) == aqString.ToUpper(heading))
            {
                valueObj = headingObjList[i].FindChild(["Name"],["WPFObject(\"GridViewCell\", \"*\", 2)"],5)
                if(valueObj.Exists)
                {
                    valueObj.Click();
                    valueObj1 = valueObj.FindChild(["ClrClassName","VisibleOnScreen"],["WatermarkedTextBox","True"],5)
                    if(!valueObj1.Exists)
                    {
                        valueObj1 = valueObj.FindChild(["WinFormsControlName","VisibleOnScreen"],["SnomedUrgency","True"],5)
                    }
                    valueObj1.Click();
                    valueObj1.Keys(updatedValue);
                    valueObj1.keys("[Tab]")
                }
            }
        }
    }
//    expandCollapseUrgencyGrid(urgency);
}

/*===============================================================================
Description: This function is to check for Revert to Default button in the Urgency Admin screen
Parameters: 
          urgency:urgency grid to be expanded(Immediate / Urgent / ...)
          revert:blank/click
Return Value: true/false
=================================================================================*/
function CheckReverttoDefault(urgency,revert)
{
     var obj = ToFindObj(["Name"],["WPFObject(\"TextBlock\", "+urgency+", 1)"]);
     var parentObj = obj.parent
     var snomed= parentObj.FindChild(["Name"],["WPFObject(\"GridViewCell\", \"Snomed\", *)"], 10)
     var parent = snomed.parent
     var label= parent.FindChild(["WPFControlText"], ["Revert to Default"], 10)
     if(label.Exists && label.VisibleOnScreen)
     {
        Log.Message("Revert to Default Label is present in the screen")
        if(revert!="")
        {
            label.Click();
        }
        return true
     }
      else 
     {
        Log.Message("Revert to Default Label is not present in the screen")
        return false     
     }
}
