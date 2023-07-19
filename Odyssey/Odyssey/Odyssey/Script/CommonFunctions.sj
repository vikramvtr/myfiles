//USEUNIT PageObjects

/*===============================================================================
Description: This function is to get the process
Parameters:  
             Application:STANDALONE/INPROCESS
Return Value: 
=================================================================================*/
function GetProcess()
{
  Sys.Refresh()
  if (Project.Variables.Process =="STANDALONE")
  {
    return Sys.Process("Odyssey.eCover.App")
  }
  else if(Project.Variables.Process =="INPROCESSNEW")
  {
    return Sys.Process("Odyssey.InProcess.TestHarness.FrameWork")
  } 
  else if(Project.Variables.Process =="DOMAINCREATION")
  {
    return Sys.Process("Odyssey.Deployment.InitialUserInstall")
  }
  else
  {
    return Sys.Process("Odyssey.InProcess.TestHarness.Main")
  }
}

/*===============================================================================
Description: This function is to wait for the object
Parameters:             
             proArr:Property name in the array
             propValueArr:property value in the array
Return Value: 
=================================================================================*/
function waitForInformationMessage(proArr, propValueArr){
    // function to get the current time
    var d = new Date();
    var startTime = d.getTime();

    // loops for 2 mins if object does not exist
    do {
        var d = new Date();
        var endTime = d.getTime();
       Process = GetProcess()
        
        if (Process.Exists) {
            var currentItem = Process.FindChild(proArr, propValueArr, 100);
            if (currentItem.Exists && currentItem.VisibleOnScreen) {
                break;
            }
        }
    } while ((endTime - startTime) <= 180000)

    if (Process.Exists) {
          //delayExecution(2)

        if (currentItem.VisibleOnScreen)
        {
            Log.Message("Object is found...Exiting waitForItem")
            return true;
        }
        else {
            Log.Error("Object not visible on screen...Exiting waitForItem")
        }
    }
    Log.Error("Object not found...Exiting waitForItem")
}
/*===============================================================================
Description: This function is to set text
Parameters:    
             txt:text to set in the text box         
             name:name property value
             wpfControlName:wpfControlName property value OR
             obj:Object
Return Value: 
=================================================================================*/
function setText(txt,name,wpfControlName,obj)
{
   Process = GetProcess()
   if(!obj=="")
   {
      if((obj.Exists)&&(obj.Enabled))
      if (aqObject.IsSupported(obj,"Clear"))
      {
        obj.Clear()
      }
      obj.Click()
      obj.Keys(txt)
   }
   else
   {   
//   Process = GetProcess()
     var SetTxtObj= Process.FindChild(["Name","WPFControlName"], [name,wpfControlName], 100)
     if(SetTxtObj.Exists && SetTxtObj.Enabled)
     { 
        if (aqObject.IsSupported(SetTxtObj,"Clear"))
        {
          SetTxtObj.Clear()
        }
//        SetTxtObj    
        SetTxtObj.Keys(txt)
     }
      else 
     {

        Log.Warning("Set text failed")
        throw "Set text failed"
      
     }
   }
}


/*===============================================================================
Description: This function is to wait for the object with the defined time
Parameters:             
             name: name property value
             wpfControlText: wpfControlText property value 
             minutes: Minutes to wait for the object
Return Value: 
=================================================================================*/
function waitForItemWithTime(name, wpfControlText, minutes) {

    var d = new Date();
    var startTime = d.getTime();
    MilSeconds=minutes*60000

    do {
        var d = new Date();
        var endTime = d.getTime();
//        Process = GetProcess()
        Process = GetProcess() 
        var currentItem = Process.FindChild(["Name", "WPFControlText"], [name, wpfControlText], 100);
        if(!currentItem.Exists){
          currentItem = Process.FindChild(["WPFControlText"], [wpfControlText], 100);
        }
        if ((currentItem.Exists)&&(currentItem.Enabled)&&(currentItem.VisibleOnScreen)) {
            break;
        }

    } while ((endTime - startTime) <= MilSeconds)

    if (currentItem.Exists) {

        if (currentItem.VisibleOnScreen) {
            Log.Message(wpfControlText+" Object is found...Exiting waitForItem")
            return true;
        }
        else {

            Log.Error(wpfControlText+" Object not visible on screen...Exiting waitForItem")
        }
    }
    Log.Error("Object not found...Exiting waitForItem")
}
/*===============================================================================
Description: This function is to find the object
Parameters:             
             proArr: Property name in the array
             propValueArr: property value in the array
Return Value: 
=================================================================================*/
function ToFindObj(proArr, propValueArr)
{
//  Process = GetProcess()
  Process = GetProcess()
  if (Process.Exists) 
  {
      var currentItem = Process.FindChild(proArr, propValueArr, 100);
      if (currentItem.Exists && currentItem.VisibleOnScreen) 
      {
        return currentItem
      }
      else
      {
        Log.Error("Object not found")
      }
  }
}
/*===============================================================================
Description: This function is to wait for the object returns true or false
Parameters:             
             proArr: Property name in the array
             propValueArr: property value in the array
             Process:STANDALONE/INPROCESS
Return Value: 
=================================================================================*/
function waitForInformationMessageTrueOrFalse(proArr, propValueArr)
{
    
    // function to get the current time
    var d = new Date();
    var startTime = d.getTime();

    // loops for 2 mins if object does not exist
    do {
        var d = new Date();
        var endTime = d.getTime();
//        Process = GetProcess()
        var Process = GetProcess()
        if (Process.Exists) {
            var currentItem = Process.FindChild(proArr, propValueArr, 100);
            if (currentItem.Exists && currentItem.VisibleOnScreen) 
            {
                Log.Message("Object is found...Exiting waitForItem")
                return true;
            }
        }
    } while ((endTime - startTime) <= 60000)
    Log.Message("Object not found...Exiting waitForItem")
    return false
}

/*===============================================================================
Description: This function to close the application
Parameters: 
            gender:Male or female
Return Value: 
=================================================================================*/
function closeApplication()
{
  Process = GetProcess()
  if(Project.Variables.Process == "INPROCESSNEW")
  {
    Process.Terminate()
  }
  else
  {
    var exceptionObj = Process.FindChild(["Name"],["WPFObject(\"ExceptionText\")"],50)
    if(exceptionObj.Exists && exceptionObj.VisibleOnScreen)
    {
      Log.Warning("Encountered an application error in closeApplication")
      throw "application error in closeApplication"
    }    
    else
    {
      Process.Close()
      if(Sys.WaitProcess("Odyssey.eCover.App").Exists)
      {
        //var warningOverlay= Process.FindChild(["Name"], [obj_CloseAppOverlay], 50)
        var btn_yes = Process.FindChild(["Name"], ["Window(\"Button\", \"&Yes\", *)"], 50)
        //var btn_yes = Process.FindChild(["Name"], ["Button(\"Yes\")"], 50)
        //btn_yes.Click()
        if(btn_yes.Exists)
        {
          btn_yes.Click()  
        }      
      }        
    }
  
  }
  Delay(2000)
}

/*===============================================================================
Description: This function is to launch the application
Parameters:             
  ApplicationToTest: Standalone or Inprocess
Return Value: NA
=================================================================================*/
function LaunchApplication()
{
  if(Project.Variables.Process == "STANDALONE")
  {
    if(!Sys.WaitProcess("Odyssey.eCover.App").Exists)
    {
      TestedApps.Odyssey_3_26_Standalone.Run()
      //=====Changes for CI Start
      if(waitForProcessToStart("Odyssey.eCover.App"))
      {
        if(waitForInformationMessageTrueOrFalse(["Name"],[Wnd_MainWindow]))
        {
          Sys.Process("Odyssey.eCover.App").WPFObject("HwndSource: MainWindow").Maximize()  
        }
      }
      else
      {
        if(Sys.Process("dfsvc").Exists)
        {
          Log.Message("New odyssey version available and need to be upgraded");
          var currentProcess = Sys.Process("dfsvc");
          var upgradeOkBtn = currentProcess.FindChild(["Name"],["WinFormsObject(\"btnOk\")"],30);
          upgradeOkBtn.Click();
          waitForInformationMessage(["Name"],[Wnd_MainWindow])
          Sys.Process("Odyssey.eCover.App").WPFObject("HwndSource: MainWindow").Maximize()
        }
      }
     //=====Changes for CI End
      
//      waitForInformationMessage(["Name"],[Wnd_MainWindow])
//      Sys.Process("Odyssey.eCover.App").WPFObject("HwndSource: MainWindow").Maximize()
    }
  }
  else if(Project.Variables.Process == "INPROCESSNEW")
  {
    if(!Sys.WaitProcess("Odyssey.InProcess.TestHarness.FrameWork").Exists)
    {
      TestedApps.Odyssey_3_26_InProcessNew.Run()
      waitForInformationMessage(["Name"],[Wnd_TestHarnessNew])
      Sys.Process("Odyssey.InProcess.TestHarness.FrameWork").WPFObject("HwndSource: MainWindow").Maximize()
//      Sys.Process("Odyssey.InProcess.TestHarness.Main").WinFormsObject("Master").Maximize()
//    SetupTestHarness();
    }
  }
  else if(Project.Variables.Process == "INPROCESS")
  {
    if(!Sys.WaitProcess("Odyssey.InProcess.TestHarness.FrameWork").Exists)
    {
      TestedApps.Odyssey_3_26_InProcess.Run()
      waitForInformationMessage(["Name"],[Wnd_TestHarness])
//      Sys.Process("Odyssey.InProcess.TestHarness.FrameWork").WPFObject("HwndSource: MainWindow").Maximize()
      Sys.Process("Odyssey.InProcess.TestHarness.Main").WinFormsObject("Master").Maximize()
//    SetupTestHarness();
    }
  }
 
}

/*===============================================================================
Description: This function is to check button enable or disable
Parameters:             
             wpfControlText: property value of wpfControlText 
Return Value: 
=================================================================================*/
function ToCheckButtonEnaborDisab(wpfControlText)
{
    Process = GetProcess()

    var btn= Process.FindChild(["Name", "WPFControlText"], [btn_WPFButton, wpfControlText], 100)
    if(!btn.Exists)
    {
      btn = Process.FindChild(["WPFControlText"], [wpfControlText], 100)
    }
    
   if(btn.Exists && btn.Enabled)
   {
      Log.Message(wpfControlText+" Button is enable")
      return true
   }
    else 
    {
      Log.Message(wpfControlText+" Button is disable")
      return false
    }
}

/*===============================================================================
Description: This function is to check lable present in the page
Parameters:             
             wpfControlText: property value of wpfControlText 
Return Value: 
=================================================================================*/
function ToCheckLablePresent(wpfControlText)
{
//   Process = GetProcess()
  Sys.Refresh()
  Process = GetProcess()
   var label= Process.FindChild(["WPFControlText"], [wpfControlText], 100)
   //Sys.HighlightObject(label)
   if(label.Exists && label.VisibleOnScreen)
   {
      Log.Message(wpfControlText+" Label is present in the screen")
      return true
   }
    else 
    {
      Log.Message(wpfControlText+" Label is not present in the screen")
      return false     
    }
}

/*===============================================================================
Description: This function is to check the text box presenting on screen
Parameters:     
             name: value of Name property       
             wpfControlText: property value of wpfControlText 
Return Value: 
=================================================================================*/
function ToCheckSearchBoxPresent(name,wpfControlText)
{
//   Process = GetProcess()
   Process = GetProcess()
   var searchbox= Process.FindChild(["Name"], [name], 100)
   if(searchbox.Exists && searchbox.Enabled)
   {
      Log.Message(wpfControlText+" is presenting and enabled")
      return true
   }
    else 
   {
      Log.Message(wpfControlText+" is not presenting/enabled")
      return false
          
   }
}
/*===============================================================================
Description: This function is to select Combo box with item name
Parameters:             
             comboBoxName: property value of name 
             itemName: Name of the item to select
Return Value: 
=================================================================================*/
function selectComboBoxItem(comboBoxName,itemName)
{
//  var Process = GetProcess()
  Process = GetProcess()
  var comboBoxObj=  Process.FindChild(["ClrClassName","Name"],["ComboBox",comboBoxName],50);
  if(comboBoxObj.Exists)
   {
     for(i=0;i<comboBoxObj.Items.Count;i++)
     {
       if(comboBoxObj.Items.Item(i)==itemName)
       {
         comboBoxObj.ClickItem(itemName)
         return true
         break;
       }
     
     }
   }
   
   else
   {
     Log.Message("Combo box object is not found")
   }
}
 
/*===============================================================================
Description: This function is to select Combo box with index value
Parameters:             
             comboBoxName: property value of name 
             itemName: Name of the item to select
             obj:object to pass
Return Value: 
=================================================================================*/
function selectComboBoxByIndex(comboBoxName,itemName,obj)
{
//  var Process = GetProcess()
  Process = GetProcess()
  if ((comboBoxName!==null)&&(comboBoxName!==""))
  {
  var comboBoxObj=  Process.FindChild(["ClrClassName","Name"],["ComboBox",comboBoxName],50);
  if(comboBoxObj.Exists)
   {
     for(i=0;i<comboBoxObj.Items.Count;i++)
     {
        var dta = comboBoxObj.Items.Item(i).Type
        if (dta!=undefined)
        {
           if(comboBoxObj.Items.Item(i).Type.OleValue == itemName)
           {
             comboBoxObj.ClickItem(i)
             return true
             break;
           }
        }
        else 
        {
        
          if(comboBoxObj.Items.Item(i).Description.OleValue == itemName)
           {
             comboBoxObj.ClickItem(i)
             return true
             break;
           }
        } 
      }
    }
  }
   else
   {
   
    if(obj!==undefined)
   {
     for(i=0;i<obj.Items.Count;i++)
     {
        var dta = obj.Items.Item(i).Type
        if (dta!=undefined)
        {
           if(obj.Items.Item(i).Type.OleValue == itemName)
           {
             obj.ClickItem(i)
             return true
             break;
           }
        }
        else 
        {
         if(obj.Items.Item(i).Description!=undefined)
         {
          if(obj.Items.Item(i).Description.OleValue == itemName)
           {
             obj.ClickItem(i)
             return true
             break;
           }
          }
          else
          {
          if (obj.Items.Item(i).Text!=undefined)
          {
            if (obj.Items.Item(i).Text.OleValue == itemName)
            {
               obj.ClickItem(i)
               return true
               break;
            } 
          }
          else
          {
          if (obj.Items.Item(i).QueueUrgency!=undefined)
          {          
            if (obj.Items.Item(i).QueueUrgency.OleValue == itemName)
            {
               obj.ClickItem(i)
               return true
               break;
            } 
          }
          else
          {
            if (obj.Items.Item(i).OleValue == itemName)
            {
               obj.ClickItem(i)
               return true
               break;
            } 
          } 
          } 
          } 
        } 
      }
     
   }
  }
}
/*===============================================================================
Description: This function is to get text from text box
Parameters:             
             name: property value of name 
             wpfControlName: property value of wpfControlName 
Return Value: 
=================================================================================*/
function getTextFromTextBox(name,wpfControlName)
{  
  var obj = ToFindObj(["Name","WPFControlName"],[name,wpfControlName])
  return obj.wText
}
/*===============================================================================
Description: This function is to check combo box has been selected
Parameters:             
             name: property value of name 
             wpfControlText: property value of wpfControlText 
Return Value: 
=================================================================================*/
function TochkComboboxSelected(name,wpfControlText)
{
  Process = GetProcess() 
  var obj = Process.FindChild(["Name","WPFControlText"],[name,wpfControlText],100)
  return obj.IsSelected
 
}


/*===============================================================================
Description: This function is to click the item
Parameters:      
             name:name property value
             wpfControlText:wpfControlText property value
Return Value: 
=================================================================================*/
function clickItem(name,wpfControlText)
{
    Process = GetProcess()
    var clickingItem = Process.FindChild(["Name","WPFControlText","VisibleOnScreen"], [name, wpfControlText,true], 100)
    if(!clickingItem.Exists)
    {
      clickingItem=Process.FindChild(["WPFControlText","VisibleOnScreen"], [wpfControlText,true], 100)
    }
    
    if(clickingItem.Exists && clickingItem.Enabled)
    {
      clickingItem.Click()
      return true
    }
    else
    {
      Log.Warning(wpfControlText +"Click action failed in clickItem function")
      throw "Click action failed in clickItem function"
    }
}
/*===============================================================================
Description: This function is to find the object to validate
Parameters:             
             proArr: Property name in the array
             propValueArr: property value in the array
Return Value: 
=================================================================================*/
function ToFindObjToValidate(proArr, propValueArr)
{
  Process = GetProcess()
  if (Process.Exists) 
  {
      var currentItem = Process.FindChild(proArr, propValueArr, 100);
      if (currentItem.Exists && currentItem.VisibleOnScreen) 
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
Description: This function to check and uncheck the checkbox
Parameters: 
          Name:Name property of the object
          Action:Check or Uncheck
Return Value: true/false
=================================================================================*/ 
function ToCheckAndUncheck(Name,Action)
{
  Process = GetProcess()
  var obj = Process.FindChild(["Name"],[Name],100)
  if(obj.Exists)
  {
    if(aqString.ToUpper(Action)=="CHECK")
    {
       obj.ClickButton(cbChecked);
       return true
    }
    else
    {
       obj.ClickButton(cbUnchecked); 
       return false
    } 
    
   } 
} 

/*===============================================================================
Description: This function to validate ToolTip
Parameters: 
          obj1:Object
          ToolTip:ToolTip content
Return Value: true/false
=================================================================================*/ 
function ToValidateTipTool(obj1,ToolTip)
{
  if (obj1.ToolTip.OleValue!=undefined)
  {
    if (obj1.ToolTip.OleValue==ToolTip)
    {
      return true
    } 
    else
    {
      Log.Warning(obj1.ToolTip.OleValue +"Validation of Tool Tip failed in ToValidateTipTool function")
      return false
    } 
  }
  else
  {
    if (obj1.ToolTip.Text.OleValue==ToolTip)
    {
      return true
    } 
    else
    {
      Log.Warning(obj1.ToolTip.Text.OleValue +"Validation of Tool Tip failed in ToValidateTipTool function")
      return false
    } 
  } 
} 


/*===============================================================================
Description: This function to do drag operation
Parameters: 
          Name:
          wpfControlName:
          wpfControlText:
          X1:
          X2:
          Y1:
          Y2:
Return Value: true/false
=================================================================================*/
function Drag(Name,wpfControlName,wpfControlText,X1,X2,Y1,Y2)
{
  Process = GetProcess()
  var obj = Process.FindChild(["Name","WPFControlName","WPFControlText"],[Name,wpfControlName,wpfControlText],100)
  obj.Drag(X1, X2, Y1, Y2);
}

/*===============================================================================
Description: This function to do right click on object for the specific coordinates
Parameters: 
          Name:
          wpfControlName:
          wpfControlText:
          x:
          y:
Return Value:
=================================================================================*/
function RightClick(Name,wpfControlName,wpfControlText,x,y)
{
    Process = GetProcess()
    var obj = Process.FindChild(["Name","WPFControlName","WPFControlText","VisibleOnScreen"],[Name,wpfControlName,wpfControlText,true],100)
    if (x!="")
    {
        obj.ClickR(x,y)
    }
    else
    {
        obj.ClickR()
    } 
} 

/*===============================================================================
Description: This function is used to get system date and time in the required format
Parameters:
   format:  format specifier
Return Value: NA
===============================================================================*/
function getSystemDateTime(format)
{
  value =aqDateTime.Now()
  dateTime = aqConvert.DateTimeToFormatStr(value, format);
  return dateTime
} 

/*===============================================================================
Description: This function is used to enter backspace
Parameters:
           obj:  
           num:
Return Value: NA
===============================================================================*/
function ToEnterBackSpace(obj,num)
{
  obj.Click()
  for (i=0;i<num;i++)
  {
    
    obj.keys("[BS]")
  } 
} 
 
/*===============================================================================
Description: This function is to double the item
Parameters:      
             name:name property value
             wpfControlText:wpfControlText property value
Return Value: 
=================================================================================*/
function DblclickItem(name,wpfControlText)
{
    Sys.Refresh()
    Process = GetProcess()
    var clickingItem = Process.FindChild(["Name","WPFControlText","Exists"], [name, wpfControlText,true], 100)
    
    if(clickingItem.Exists)
    {
        if (wpfControlText == "Test automation reason")
        {
          clickingItem = clickingItem.parent.parent.parent
        } 
        clickingItem.DblClick()
    }
    else 
    {
        Log.Warning(wpfControlText +"Click action failed in clickItem function")
        throw "Click action failed in clickItem function"   
    }
}

/*===============================================================================
Description: This function is to get environment variable
Parameters:             
             item: item to get value
Return Value: 
=================================================================================*/
function getEnvVariable(item)
{
  switch (item)
  {
    case "Username" : 
      var val = aqEnvironment.GetEnvironmentVariable("Username");
      return val
      break;
  }
}

/*===============================================================================
Description: This function to validate the items in the Combo Box of address details
Parameters: 
           comboBoxName:value of name property
           itemName:item name needs to validate
Return Value: true/false
=================================================================================*/
function chkComboBoxItem(comboBoxName,itemName)
{
  var Process = GetProcess()
  var comboBoxObj=  Process.FindChild(["ClrClassName","Name"],["ComboBox",comboBoxName],50);
  if(comboBoxObj.Exists)
   {
     for(i=0;i<comboBoxObj.Items.Count;i++)
     {
       if (comboBoxObj.ItemContainerGenerator.Items.Item(i).OleValue==undefined)
       {
          if(comboBoxObj.ItemContainerGenerator.Items.Item(i).Type==undefined)
          {
            if (comboBoxObj.ItemContainerGenerator.Items.Item(i).Description.OleValue==itemName)
            {
            return true
            break;
            }
          }
          else
          {
             if (comboBoxObj.ItemContainerGenerator.Items.Item(i).Type.OleValue==itemName)
            {
              return true
              break;
            } 
          } 
       }
       else
       {
          if(comboBoxObj.ItemContainerGenerator.Items.Item(i).OleValue==itemName)
          {
            return true
            break;
          } 
       } 
            
     }
   } 
   else
   {
     return false
   }
}

/*===============================================================================
Description: This function to validate item selected
Parameters: 
            Item: Item
            WPFControlText: WPFControlText
Return Value: true/false
=================================================================================*/
function ToValItemSelected(Name,WPFControlText)
{
    var obj = ToFindObj(["Name","WPFControlText"],[Name,WPFControlText])
    return obj.IsSelected
} 

/*===============================================================================
Description: This function is to expand the item
Parameters:      
             name:name property value
             wpfControlText:wpfControlText property value
Return Value: 
=================================================================================*/
function ExpandItem(name,wpfControlText)
{
    Process = GetProcess()
    var clickingItem = Process.FindChild(["Name", "WPFControlText"], [name, wpfControlText], 100)
    
    if(clickingItem.Exists && clickingItem.Enabled)
    {
      clickingItem.Expand()
    }
    else 
    {

      Log.Warning(wpfControlText +"Click action failed in clickItem function")
      throw "Click action failed in clickItem function"
      
    }
}


/*===============================================================================
Description: This function is to Collapse the item
Parameters:      
             name: name property value
             wpfControlText: wpfControlText property value
Return Value: 
=================================================================================*/
function CollapseItem(name,wpfControlText)
{
    Process = GetProcess()
    var clickingItem = Process.FindChild(["Name", "WPFControlText"], [name, wpfControlText], 100)
    
    if(clickingItem.Exists && clickingItem.Enabled)
    {
      clickingItem.Collapse()
    }
    else 
    {
      Log.Warning(wpfControlText +"Click action failed in clickItem function")
      throw "Click action failed in clickItem function"
    }
}

/*===============================================================================
Description: This function is to delay execution
Parameters:
          sec:
Return Value: 
=================================================================================*/
function delayExecution(sec) 
{
    var delaymin = sec * 1000
    Delay(delaymin)
}
/*===============================================================================
Description: This function is to check object enabled or disabled
Parameters: 
             name:name property value
             WPFControlName:WPFControlName property value
             WPFControlText:WPFControlText property value
Return Value: 
=================================================================================*/
function ToCheckObjEnableorDisable(name,WPFControlName,WPFControlText)
{
    Process = GetProcess()
    var obj
    if((WPFControlText!="")&&(WPFControlText!=null)&&(WPFControlText!=undefined))
    {
      obj= Process.FindChild(["Name", "WPFControlText"], [name, WPFControlText], 100)
    }
    else
    {
      obj= Process.FindChild(["Name", "WPFControlName"], [name, WPFControlName], 100)
    } 
   if(obj.Exists && obj.Enabled && obj.VisibleOnScreen)
   {
      Log.Message(WPFControlName+" object is enable")
      return true
   }
    else 
    {
      Log.Message(WPFControlName+" object is disable")
      return false
    }
}
/*===============================================================================
Description: This function is to check object enabled or disabled
Parameters: 
Return Value: 
=================================================================================*/
function delay2Sec()
{
  delayExecution("2")
} 
/*===============================================================================
Description: This function is to use left key
Parameters: 
          obj:
          num:
Return Value: 
=================================================================================*/
function ToEnterLeftKey(obj,num)
{
  obj.Click()
  for (i=0;i<num;i++)
  {
    obj.keys("[Left]")
  } 
}

/*===============================================================================
Description: This function is to clear the text
Parameters: 
          name:
          wpfControlText:
          wpfControlName:
Return Value: 
=================================================================================*/

function ClearText(name,wpfControlText,wpfControlName)
{
    var process = GetProcess()
    var obj = process.FindChild(["Name","WPFControlText","WPFControlName"],[name,wpfControlText,wpfControlName],100)
    obj.clear()
} 


/*===============================================================================
Description: This function is to delay execution
Parameters:
Return Value: 
=================================================================================*/
function delay() 
{
    delayExecution(2)
}

/*===============================================================================
Description: This function is used to enter backspace
Parameters:
           obj1:  
           obj2:
Return Value: NA
===============================================================================*/
function ToEnterCopyandPaste(obj1,obj2)
{  
    obj1.Keys("^c")
    obj2.Keys("^v")
} 

/*===============================================================================
Description: This function is to use left key
Parameters: 
          obj:
          num:
Return Value: 
=================================================================================*/
function ShiftandleftKey(obj,num)
{
  obj.Click()
  for (i=0;i<num;i++)
  {
    obj.keys("![Left]")
  } 
}

/*===============================================================================
Description: This function to close/terminate the application for error handling
Parameters: 
Return Value: 
=================================================================================*/
function closeApplication1()
{
    Process = GetProcess()
  // TestedApps.Odyssey_eCover_App.Terminate()
    if(Process.Exists)
    {
        var exceptionObj = Process.FindChild(["Name"],["WPFObject(\"ExceptionText\")"],50)
        if(exceptionObj.Exists && exceptionObj.VisibleOnScreen)
        {
          Process.Terminate()
        }
        else
        {
          if(Project.Variables.Process == "INPROCESSNEW")
          {
            Process.Terminate()
          }
          else
          {
    //        if(ToFindObjToValidate(["Name"],["WPFObject(\"ErrorDisplay\", \"\", 1)"]))
    //        {
    //          
    //        }
      
            Process.Close()
            if(Sys.WaitProcess("Odyssey.eCover.App").Exists)
            {
              //var warningOverlay= Process.FindChild(["Name"], [obj_CloseAppOverlay], 50)
              var btn_yes = Process.FindChild(["Name"], ["Window(\"Button\", \"&Yes\", *)"], 50)
              btn_yes.Click()
            }    
          }
        }
        Delay(2000)        
    }

}
/*===============================================================================
Description: This function is to delay execution to let application change status of assessment
Parameters: 
        delayTime: pass delay time in minutes
Return Value: 
=================================================================================*/
function delayInMinutes(delayInMin)
{ 
  delayTime = delayInMin * 60
  delayExecution(delayTime)
} 

/*===============================================================================
Description: This function is used to copy text of the object
Parameters:
           Name:Name property value of object 
Return Value: NA
===============================================================================*/
function ToEnterCopy(Name)
{
    process = GetProcess()
    var obj1 = process.FindChild(["Name"],[Name],100)
    obj1.Keys("^c")
}

/*===============================================================================
Description: This function is used to paste copeid text to the object
Parameters:
           Name:Name property value of object   
Return Value: NA
===============================================================================*/
function ToEnterPaste(Name)
{
    process = GetProcess()
    var obj1 = process.FindChild(["Name"],[Name],100)
    obj1.Keys("^v")
}

/*===============================================================================
Description: This function is to wait for the process to start and returns true or false
Parameters:             
             processName: Process name
Return Value: true/false
=================================================================================*/
function waitForProcessToStart(processName)
{
    var d = new Date();
    var startTime = d.getTime();
  
    // loops for 10 seconds if process does not start
    do {
        var d = new Date();
        var endTime = d.getTime();
    
       // var expectedProcess = Sys.Process(processName);
      
        var expectedProcess = Sys.WaitProcess(processName, 2000);
        if(expectedProcess.Exists)
        {
          Log.Message(processName+" Process is found.....Exiting waitForProcessToStart");
          return true;
        }
    }while((endTime-startTime)<=10000)
    Log.Message(processName+" Process is not found.....Exiting waitForProcessToStart")
    return false;
}