//USEUNIT CommonFunctions
//USEUNIT PageObjects
//USEUNIT DBFunctions

/*===============================================================================
Description: This function is to validate question and their respective answer saved in reporting DB for the last session
Parameters:
    ques: shortQues
    answer: selected answer
    longQues: longQues text
    protocolName: protocolName of ques    
Return Value: true/false
=================================================================================*/
function ToCheckResponseRepDB(ques,answer,longQues,protocolName)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetResponseRepDB(SessionId)
    var shortQuesMatch, longQuesMatch, protocolMatch;
    var quesFound = false;
    for(i=0; i<dbRecord1.length; i++)
    {
        shortQuesMatch = (aqString.ToUpper(aqString.Trim(dbRecord1[i][3])) == aqString.ToUpper(aqString.Trim(ques)))
        protocolMatch = (aqString.ToUpper(aqString.Trim(dbRecord1[i][2])) == aqString.ToUpper(aqString.Trim(protocolName)))
        longQuesMatch = (aqString.ToUpper(aqString.Trim(dbRecord1[i][5])) == aqString.ToUpper(aqString.Trim(longQues)))
        if(shortQuesMatch && protocolMatch && longQuesMatch)
        {
            quesFound = true;
            if(aqString.ToUpper(aqString.Trim(answer)) == aqString.ToUpper(aqString.Trim(dbRecord1[i][4])))
            {
                return true;
            }   
        }
    }
    if(quesFound == false)
    {
        Log.Warning("Ques not found in Reporting DB")
        throw "Ques not found in Reporting DB"        
    }   
    
    return false;
}

/*===============================================================================
Description: This function is to validate patient details for a session saved in reporting DB
Parameters:
    PatientName: PatientName
    DateOfBirth: DateOfBirth
    PatientAgeYears: PatientAgeYears
    Gender: Gender 
    NhsNumber: NHS Number   
Return Value: true/false
=================================================================================*/
function ToCheckPatDetRepDB(PatientName,DateOfBirth,PatientAgeYears,Gender,NhsNumber)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]  
    Log.Message("###### Session ID ####### :: "+SessionId) 
    var dbRecord1=GetDemographicDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var PatientNameMatch=true, DateOfBirthMatch=true, PatientAgeYearsMatch=true, GenderMatch=true, NhsNumberMatch=true;

    if(PatientName!="")
    {    
        PatientNameMatch = (PatientName == dbRecord1[0][0])
    }
    
    if(DateOfBirth!="")
    {
        var res = aqString.Find(dbRecord1[0][1], DateOfBirth, false)
        if(res < 0)
        {
            DateOfBirthMatch = false;
        }
    }    

    if(PatientAgeYears!="")
    {
        PatientAgeYearsMatch = (PatientAgeYears == dbRecord1[0][2])
    }

    GenderMatch = (Gender == dbRecord1[0][3])

    if(NhsNumber == "")
    {
        NhsNumberMatch = (null == dbRecord1[0][4])
    }
    else
    {
        NhsNumberMatch = (NhsNumber == dbRecord1[0][4])
    }
    
    if(PatientNameMatch && DateOfBirthMatch && PatientAgeYearsMatch && GenderMatch && NhsNumberMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}
/*===============================================================================
Description: This function is to validate patient's contact details for a session saved in reporting DB
Parameters:
    Address: Address
    PhoneNumber: PhoneNumber
    GpPractice: GpPractice
    GpName: GpName 
Return Value: true/false
=================================================================================*/
function ToCheckContactDetRepDB(Address,PhoneNumber,GpPractice,GpName)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetContactDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var AddressMatch=true, PhoneNumberMatch=true, GpPracticeMatch=true, GpNameMatch=true;
    
    if(Address == "")
    {
        AddressMatch = (null == dbRecord1[0][0])
    }
    else
    {
        AddressMatch = (Address == dbRecord1[0][0])
    }
    
    if(PhoneNumber == "")
    {
        PhoneNumberMatch = (null == dbRecord1[0][1])
    }
    else
    {
        PhoneNumberMatch = (PhoneNumber == dbRecord1[0][1])
    }

    if(GpPractice == "")
    {
        GpPracticeMatch = (null == dbRecord1[0][2])
    }
    else
    {
        GpPracticeMatch = (GpPractice == dbRecord1[0][2])
    }

    if(GpName == "")
    {
        GpNameMatch = (null == dbRecord1[0][3])
    }
    else
    {
        GpNameMatch = (GpName == dbRecord1[0][3])
    }
    
    if(AddressMatch && PhoneNumberMatch && GpPracticeMatch && GpNameMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate content details for a session saved in reporting DB
Parameters:
    Culture: Culture
    Location: Location
    IterationType: IterationType
    Product: Product 
    IterationVersion: IterationVersion
Return Value: true/false
=================================================================================*/
function ToCheckContentDetRepDB(Culture,Location,IterationType,Product,IterationVersion)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetContentDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var CultureMatch=true, LocationMatch=true, IterationTypeMatch=true, ProductMatch=true, IterationVersionMatch=true;
    
    if(Culture!="")
    {
        CultureMatch = (Culture == dbRecord1[0][0])
    }   
    
    if(Location!="")
    {
        LocationMatch = (Location == dbRecord1[0][1])
    }    

    if(IterationType == "")
    {
        IterationTypeMatch = (null == dbRecord1[0][2] || "" == dbRecord1[0][2])
    }
    else
    {
        IterationTypeMatch = (IterationType == dbRecord1[0][2])
    }

    if(Product!="")
    {
        ProductMatch = (Product == dbRecord1[0][3])
    }
    
    if(IterationVersion!="")
    {
        IterationVersionMatch = (IterationVersion == dbRecord1[0][4])
    }
    
    if(CultureMatch && LocationMatch && IterationTypeMatch && ProductMatch && IterationVersionMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate clinician details for a session saved in reporting DB
Parameters:
    Clinician: Clinician email ID
    PresComplaint: Presenting Complaint
    RecommUrgency: Recommended Urgency
    SelUrgency: Selected Urgency
    Outcome: Outcome
Return Value: true/false
=================================================================================*/
function ToCheckClinDetRepDB(Clinician,PresComplaint,RecommUrgency,SelUrgency,Outcome)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetClinicianDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var EmailIDMatch, PresComplaintMatch=true, RecommUrgencyMatch=true, SelUrgencyMatch=true, OutcomeMatch=true;
    
    EmailIDMatch = (Clinician == dbRecord1[0][0])
    
    PresComplaintMatch = (aqString.ToUpper(aqString.Trim(PresComplaint)) == aqString.ToUpper(aqString.Trim(dbRecord1[0][1])))   

    if(RecommUrgency == "")
    {
        RecommUrgencyMatch = (null == dbRecord1[0][2])
    }
    else
    {
        RecommUrgencyMatch = (RecommUrgency == dbRecord1[0][2])
    }

    if(SelUrgency == "")
    {
        SelUrgencyMatch = (null == dbRecord1[0][3])
    }
    else
    {
        SelUrgencyMatch = (SelUrgency == dbRecord1[0][3])
    }
    
    if(Outcome == "")
    {
        OutcomeMatch = (null == dbRecord1[0][4] || "" == dbRecord1[0][4])
    }
    else
    {
        OutcomeMatch = (Outcome == dbRecord1[0][4])
    }
        
    if(EmailIDMatch && PresComplaintMatch && RecommUrgencyMatch && SelUrgencyMatch && OutcomeMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate reception details for a session saved in reporting DB
Parameters:
    Receptionist: Receptionist email ID
    PresComplaint: Presenting Complaint
    RecommUrgency: Recommended Urgency
    SelUrgency: Selected Urgency 
    Outcome: Outcome
Return Value: true/false
=================================================================================*/
function ToCheckRecpDetRepDB(Receptionist,PresComplaint,RecommUrgency,SelUrgency,Outcome)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetReceptionDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var EmailIDMatch, PresComplaintMatch=true, RecommUrgencyMatch=true, SelUrgencyMatch=true, OutcomeMatch=true;
    
    EmailIDMatch = (Receptionist == dbRecord1[0][0])
    
    PresComplaintMatch = (aqString.ToUpper(aqString.Trim(PresComplaint)) == aqString.ToUpper(aqString.Trim(dbRecord1[0][1])))  

    if(RecommUrgency == "")
    {
        RecommUrgencyMatch = (null == dbRecord1[0][2])
    }
    else
    {
        RecommUrgencyMatch = (RecommUrgency == dbRecord1[0][2])
    }

    if(SelUrgency == "")
    {
        SelUrgencyMatch = (null == dbRecord1[0][3])
    }
    else
    {
        SelUrgencyMatch = (SelUrgency == dbRecord1[0][3])
    }
    
    if(Outcome == "")
    {
        OutcomeMatch = (null == dbRecord1[0][4] || "" == dbRecord1[0][4])
    }
    else
    {
        OutcomeMatch = (Outcome == dbRecord1[0][4])
    }
    
    if(EmailIDMatch && PresComplaintMatch && RecommUrgencyMatch && SelUrgencyMatch && OutcomeMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate call handler details for a session saved in reporting DB
Parameters:
    CallHandler: CallHandler email ID
    PresComplaint: Presenting Complaint
    RecommUrgency: Recommended Urgency
    SelUrgency: Selected Urgency 
    Outcome: Outcome
Return Value: true/false
=================================================================================*/
function ToCheckCalHandDetRepDB(CallHandler,PresComplaint,RecommUrgency,SelUrgency,Outcome)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetFirstCallDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    var EmailIDMatch, PresComplaintMatch=true, RecommUrgencyMatch=true, SelUrgencyMatch=true, OutcomeMatch=true;
    
    EmailIDMatch = (CallHandler == dbRecord1[0][0])
    
    PresComplaintMatch = (aqString.ToUpper(aqString.Trim(PresComplaint)) == aqString.ToUpper(aqString.Trim(dbRecord1[0][1])))  

    if(RecommUrgency == "")
    {
        RecommUrgencyMatch = (null == dbRecord1[0][2])
    }
    else
    {
        RecommUrgencyMatch = (RecommUrgency == dbRecord1[0][2])
    }

    if(SelUrgency == "")
    {
        SelUrgencyMatch = (null == dbRecord1[0][3])
    }
    else
    {
        SelUrgencyMatch = (SelUrgency == dbRecord1[0][3])
    }
    
    if(Outcome == "")
    {
        OutcomeMatch = (null == dbRecord1[0][4] || "" == dbRecord1[0][4])
    }
    else
    {
        OutcomeMatch = (Outcome == dbRecord1[0][4])
    }
    
    if(EmailIDMatch && PresComplaintMatch && RecommUrgencyMatch && SelUrgencyMatch && OutcomeMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}
/*===============================================================================
Description: This function is to validate signpost details for a session saved in reporting DB
Parameters:
    Module: Module Name
    SelSignpost: SelectedSignpost
    SugSignpost: SuggestedSignpost list
Return Value: true/false
=================================================================================*/
function ToCheckSignpostDetRepDB(Module,SelSignpost,SugSignpost)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetSignpostDetRepDB(SessionId)
    SugSignpost = aqString.Replace(SugSignpost, ",", "|")
    var i;
    var moduleFound = false;
    for(i=0; i<dbRecord1.length; i++)
    {
        if(aqString.ToUpper(aqString.Trim(dbRecord1[i][1])) == aqString.ToUpper(aqString.Trim(Module)))
        {
            moduleFound = true;
            break;
        }
    }
    if(moduleFound == false)
    {
        Log.Warning("Signpost entry for Module "+Module+" not found in Reporting DB")
        throw "Signpost entry for Module "+Module+" not found in Reporting DB"        
    }    
    
    var SelSignpostMatch, SugSignpostMatch=true;
    
    SelSignpostMatch = (SelSignpost == dbRecord1[i][2])
    
    if(SugSignpost!="")
    {
        SugSignpostMatch = (SugSignpost == dbRecord1[i][3])
    }    
    
    if(SelSignpostMatch && SugSignpostMatch)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate advice details for a session saved in reporting DB
Parameters:
    AdviceType: CareAdvice/WorseningAdvice/WorseningStatement/FirstAidAdvice
    DeliveredStatus: 1/0
Return Value: true/false
=================================================================================*/
function ToCheckAdviceDetRepDB(AdviceType, DeliveredStatus)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetAdviceDetRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    AdviceType = aqString.ToUpper(AdviceType)
    var adviceText, actualStatus;
    switch(AdviceType)
    {
        case "CAREADVICE":
          adviceText = dbRecord1[0][0]
          actualStatus = dbRecord1[0][1]
          break;
        case "WORSENINGADVICE":
          adviceText = dbRecord1[0][2]
          actualStatus = dbRecord1[0][3]
          break;
        case "WORSENINGSTATEMENT":
          adviceText = dbRecord1[0][4]
          actualStatus = dbRecord1[0][5]
          break;
        case "FIRSTAIDADVICE":
          adviceText = dbRecord1[0][6]
          actualStatus = dbRecord1[0][7]
          break;        
    }
    
    if(adviceText!=null && actualStatus==DeliveredStatus)
    {
        return true;
    }
    else
    {
        return false;
    }
}

/*===============================================================================
Description: This function is to validate QuestionTextType details for a session saved in reporting DB
Parameters:
    QuestionTextType: F/T/C
Return Value: true/false
=================================================================================*/
function ToCheckQuesTxtTypeRepDB(QuestionTextType)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]   
    var dbRecord1=GetQuesTxtTypeRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    QuestionTextType = aqString.ToUpper(QuestionTextType)
    if(dbRecord1[0][2]!=null)
    {
      Log.Message("Session ID :"+dbRecord1[0][0]+" is created by "+dbRecord1[0][2])
    }
    else
    {
      Log.Message("Session ID :"+dbRecord1[0][0]+" is created by "+dbRecord1[0][1])
    }
    
    if(QuestionTextType == dbRecord1[0][3])
    {
        return true;
    }
    else
    {
        Log.Message("Actual QuestionTextType in RepDB :"+dbRecord1[0][3])
        return false;
    }
}

/*===============================================================================
Description: This function is to validate CallLength details for a session saved in reporting DB
Parameters:
    CallLength: PurpleAndRed/All
Return Value: true/false
=================================================================================*/
function ToCheckFCCallLength(CallLength)
{
    var dbRecord
    dbRecord=GetLastEntryFromSession()
    var SessionId = dbRecord[0][0]
    var dbRecord1=GetQuesTxtTypeRepDB(SessionId)

    if(dbRecord1.length < 1)
    {
        Log.Warning("Session ID not saved in Session Details table in Reporting DB")
        throw "Session ID not saved in Session Details table in Reporting DB"        
    }
    
    CallLength = aqString.ToUpper(CallLength)
    if(dbRecord1[0][2]!=null)
    {
      Log.Message("Session ID :"+dbRecord1[0][0]+" is created by "+dbRecord1[0][2])
    }
    else
    {
      Log.Message("Session ID :"+dbRecord1[0][0]+" is created by "+dbRecord1[0][1])
    }
    
    if(CallLength == aqString.ToUpper(dbRecord1[0][4]))
    {
        return true;
    }
    else
    {
        Log.Message("Actual CallLength in RepDB :"+dbRecord1[0][4])
        return false;
    }
}