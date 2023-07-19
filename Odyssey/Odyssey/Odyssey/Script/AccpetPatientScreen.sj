﻿//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT TestHarnessScreen
//USEUNIT ScreensOf3_12

/*===============================================================================
Description: This function is wait for the Accept screen
Parameters: 
Return Value: 
=================================================================================*/
function waitforAcceptPatientScreen()
{
  if(Project.Variables.Process == "INPROCESSNEW" && !ToCheckLablePresent("Presenting Complaint:"))
  {
    ToScrollNewTestHarness("UP");
  }
  return waitForItemWithTime(btn_ReturnToQueue,"Return to queue",2 )
}

/*===============================================================================
Description: This function is to validate saved notes
Parameters: 
Return Value: 
=================================================================================*/
function ToCheckSavedNotes()
{
  var Process = GetProcess()
  var obj = Process.FindChild(["Name"],["WPFObject(\"RichTextBoxWithChangeTracking\", \"\", 1)"],100)
  return(obj.DataContext.PlainText.OleValue)
} 

/*===============================================================================
Description: This function is to validate saved note text
Parameters: noteText:text of saved notes
Return Value: true/false
=================================================================================*/
function ToCheckSavedNoteText(noteText)
{ 
  var Process = GetProcess()
  if (Process.Exists) 
  {
      var currentItem = Process.FindChild(["Name","WPFControlText"], ["WPFObject(\"Paragraph\", \"\", 1)",noteText], 100);
      if (currentItem.Exists) 
      {
        return true
      }
      else
      {
        return false
      }
  }  
} 
