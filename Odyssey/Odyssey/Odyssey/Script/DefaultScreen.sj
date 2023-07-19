//USEUNIT CommonFunctions
//USEUNIT DBFunctions
//USEUNIT PageObjects

/*===============================================================================
Description: This function is wait for the defualt screen
Parameters: 
Return Value: 
=================================================================================*/
function waitfordefaultScreen()
{
  return waitForItemWithTime(btn_Refreshqueue,"Refresh queue",3)
}
/*===============================================================================
Description: This function is wait for the defualt screen for Negative test
Parameters: 
Return Value: 
=================================================================================*/
function WaitforDefualtScreenForNgtvTst()
{
  return waitForInformationMessageTrueOrFalse(["Name","WPFControlText"], [btn_Refreshqueue,"Refresh queue"])
} 
/*===============================================================================
Description: This function to wait to load the patients in the queue 
Parameters: 
Return Value: 
=================================================================================*/
function LoadingDone()
{
  Process = GetProcess()
  var d = new Date();
  var startTime = d.getTime();
  do
  {
    var Status=ToCheckLablePresent("Loading...")
    var d = new Date();
    var endTime = d.getTime();
  if (Status==false)
    {
      break
    }
  } while((endTime - startTime) <= 180000) 
}
/*===============================================================================
Description: This function to validate the tooltip of patients in the queue
Parameters: 
Return Value: Tru/False
=================================================================================*/
function ToValidateTipToolForPatientsInQ()
{

  var process = GetProcess()
//  delayExecution(2)
  var obj = process.FindChild(["Name"],["WPFObject(\"SessionList\")"],100)
  if (obj.Exists)
  {
   Log.Message("obj exist")
//    delayExecution(2)
    var obj2 = obj.FindChild(["Name","WPFControlText"],["WPFObject(\"Label\", \"Waiting\", 5)","Waiting"],100)
    obj2.HoverMouse()
    var obj1=obj2.Parent
    if (obj1.Exists)
    {
      Log.Message("obj1 exist")
      if (obj1.ToolTip.OleValue=="Anonymous Patient 54 years Female ")
      {
        Log.Message("Tool tip is showing")
        return true
      } 
      else
      {
        Log.Message("Tool tip is not showing")
        return false
      } 
    } 
    else
    {
      Log.Message("obj1 does not exist")
    }  
  }
}
/*===============================================================================
Description: This function to fetch the Address details from the search
Parameters: 
Return Value: 
=================================================================================*/
function ToCheckAddressLablePresent()
{
   Process = GetProcess()
   var obj= Process.FindChild(["Name"], ["WPFObject(\"AddressLabel\", \"\", 1)"], 100)
   return obj.DataContext.DisplayForCurrentLocation.OleValue
}

/*===============================================================================
Description: This function to change the patient age for multiple times
Parameters: 
Return Value: 
=================================================================================*/
function ToDeleteAllthePatients()
{
  for (i=0;i<15;i++)
  DeletePersonDetailFromDB()
} 
/*===============================================================================
Description: This function to scroll patient queue and select assessment
Parameters: 
            expToolTip:Tool tip of assessment
Return Value: assessment object
=================================================================================*/
function ToScrollPatientQueue(expToolTip)
{
  //Add one space at the end
  //expToolTip = aqString.Concat(expToolTip, " ")
  Process = GetProcess()
  
  var homeBtn = Process.FindChild(["WPFControlText"],["Home"],100)
  if(homeBtn.Enabled==true)
  {
    homeBtn.Click()
  }  
  
  var assessmentQueue = Process.FindChild(["Name"],["WPFObject(\"RoundedPatientList\")"],100)
  var queueLabelObj = assessmentQueue.FindChild(["Name"],["WPFObject(\"Label\", *, 2)"],100)
  if(queueLabelObj.Exists){
    Log.Message("Assessment queue label exist")
    var noOfAssessment = aqString.SubString(queueLabelObj.WPFControlText,0,3)
    var div = noOfAssessment/20
    var rem =  noOfAssessment%20
    var noOfPage
    if(rem>0){
      noOfPage = Math.ceil(div)
    }
    else{
      noOfPage = div
    }
   
    var nextBtn = Process.FindChild(["WPFControlText"],["Next Page"],50)
    var sessionList = Process.FindChild(["Name","WPFControlName"],["WPFObject(\"SessionList\")","SessionList"],50)
    var scrollViewer = sessionList.FindChild(["Name"],["WPFObject(\"ScrollViewer\", \"\", 1)"],100)

    var flag = false
    do {
		    var count = scrollViewer.ScrollableHeight
        if(count>0)
		    {
          scrollViewer.VScroll.Pos = count-1
        }
        var assessmentList = Process.FindChild(["Name"],["WPFObject(\"ItemsPresenter\", \"\", 1)"],100)
        var childCount = assessmentList.ChildCount
        for(i=1;i<=childCount;i++)
		    {
          var parent = assessmentList.FindChild(["Name"],["WPFObject(\"ListBoxItem\", \"\", "+i+")"],50)
          var current = parent.FindChild(["Name"],["WPFObject(\"Grid\", \"\", 1)"],20)
          var pickupBtn = current.FindChild(["WPFControlText"],["Pick Up"],20)
          pickupBtn.HoverMouse()
          Delay(500)
          
          //var obj1=pickupBtn.parent.parent
          var obj1=pickupBtn.parent
          if(obj1.Exists)
		    {
			       curToolTip = aqString.Trim(obj1.ToolTip.OleValue)
             if(aqString.ToUpper(curToolTip)==aqString.ToUpper(expToolTip)){  
             Log.Message("Tool tip matched")
				      return obj1
//              if(pickupBtn.Enabled){
//                Log.Message("Pickup button enabled")
//                pickupBtn.Click()
                flag = true
//                break
//              }
//              else{
//                Log.Message("Pickup button disabled")
//                flag = true
//                break
//              }
            }    
          }
        }
//       if(flag == true){
//         break
//       }
       nextBtn.Click()
       noOfPage=noOfPage-1
    }while(noOfPage>0)
    if(flag == false){
      Log.Message("assessment is not present in queue")
    }
  }
  else{
    Log.Message("Assessment queue label does not exist")
  }
}
/*===============================================================================
Description: This function to select patient assessment from queue
Parameters: 
            expToolTip:Tool tip of assessment
            type:Action type(URGENCY/STATUS/PRESENTINGCOMPLAINT/PICKUP/LASTMODIFIED)
            expValue:expected value blank for pickup
Return Value: 
=================================================================================*/
function ToPerformActionOnQueue(expToolTip,type,expValue)
{
  expToolTip = aqString.Trim(expToolTip)
  var assessmentObj = ToScrollPatientQueue(expToolTip)

  switch (aqString.ToUpper(type))
  {       
    case "STATUS":
      var statusObj = assessmentObj.FindChild(["Name"],["WPFObject(\"Label\", \"*\", 5)"],20)
      if(aqString.ToUpper(statusObj.WPFControlText)==aqString.ToUpper(expValue))
      {
        return true
      }
      else
      {
        return false
      }
      break;
    case "PICKUP":
      var pickupBtn = assessmentObj.FindChild(["WPFControlText"],["Pick Up"],20)
      if(pickupBtn.Exists==true)
      {
         if(pickupBtn.Enabled)
         {
           Log.Message("Pickup button enabled")
           pickupBtn.Click()
         }
         else
         {
            Log.Message("Pickup button disabled") 
         }
      }
      else
      {
        Log.Message("Pickup button doesnot exist") 
      }  
      break;
    case "URGENCY":
      var statusObj = assessmentObj.FindChild(["Name"],["WPFObject(\"Label\", \"*\", 3)"],20)
      if(aqString.ToUpper(statusObj.WPFControlText)==aqString.ToUpper(expValue))
      {
        return true
      }
      else
      {
        return false
      }
      break;
    case "PRESENTINGCOMPLAINT":
      var statusObj = assessmentObj.FindChild(["Name"],["WPFObject(\"Label\", \"*\", 8)"],20)
      if(aqString.ToUpper(statusObj.WPFControlText)==aqString.ToUpper(expValue))
      {
        return true
      }
      else
      {
        return false
      }
      break;
    case "LASTMODIFIED":
      var lastModifiedObj = assessmentObj.FindChild(["Name"],["WPFObject(\"Label\", \"*\", 2)"],20)
      if(aqString.Find(lastModifiedObj.WPFControlText, "min"))
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
/*===============================================================================
Description: This function to check address details displayed in Home screen.
Parameters: 
            addressType:Type of address
            addressLine1:Address Line 1
            town:Town Name
            postCode:PostCode
Return Value: true/false
=================================================================================*/
function ToCheckAddrDetHomeScreen(addressType,addressLine1,town,postCode)
{
  var process=GetProcess();
  var addressList = process.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"AddressLabel\", \"\", *)","True"],100).toArray();
  if(addressList.length>0)
  {
    for(var i=0;i<addressList.length;i++)
    {
      var currAddr = addressList[i]
      if(aqString.ToUpper(currAddr.AddressType.OleValue)==aqString.ToUpper(addressType))
      {
        actAddress1 = aqString.ToUpper(currAddr.Address1.OleValue)
        actTown = aqString.ToUpper(currAddr.Town.OleValue)
        actPostCode = aqString.ToUpper(currAddr.Postcode.OleValue)
        
        if(aqString.ToUpper(addressLine1)==actAddress1 && aqString.ToUpper(town)==actTown && aqString.ToUpper(postCode)==actPostCode)
        {
          return true;
        }
        else
        {
          return false;
        }
      } 
    }
    Log.Message("Address Type not found")
    return false;
  }
}
/*===============================================================================
Description: This function to check address details displayed in Home screen.
Parameters: 
            contDet:Contact Details
Return Value: true/false
=================================================================================*/
function ToCheckContactDetHomeScreen(contDet)
{
  var process=GetProcess();
  var contactList = process.FindAllChildren(["Name","VisibleOnScreen"],["WPFObject(\"ContDisplay\")","True"],100).toArray();
  if(contactList.length>0)
  {
    for(var i=0;i<contactList.length;i++)
    {
      var currContact = aqString.Trim(contactList[i].DisplayValue.OleValue)
      contDet = aqString.Trim(contDet)
      if(aqString.ToUpper(currContact)==aqString.ToUpper(contDet))
      {   
        return true;
      } 
    }
    Log.Message("Contact Details not found")
    return false;
  }
}
/*===============================================================================
Description: This function to select patient assessment from queue
Parameters: 
            firstname:firstname
            lastname:lastname
            type:Action type(URGENCY/STATUS/PRESENTINGCOMPLAINT/PICKUP)
            expValue:expected value blank for pickup
Return Value: 
=================================================================================*/
function ToPickAssessQueuePerfModule(firstname,lastname,type,expValue)
{
  var firstname1 =  aqString.Concat(firstNamePerf,aqString.ToLower(firstname))
  firstname1 =  aqString.Concat(firstname1," ")
  var lastname1 =  aqString.Concat(lastNamePerf,aqString.ToLower(lastname))
  
  var fullName=aqString.Concat(firstname1,lastname1)
  
  ToPerformActionOnQueue(fullName,type,expValue);
}
/*===============================================================================
Description: This function to search patient for Perf Module
Parameters: 
            lastname:lastname
Return Value: 
=================================================================================*/
function SearchPatientPerfModule(lastname)
{
  var lastname1 =  aqString.Concat(lastNamePerf,aqString.ToLower(lastname))

  setText(lastname1,txt_WaterMarkedTtextBox,"","")
}