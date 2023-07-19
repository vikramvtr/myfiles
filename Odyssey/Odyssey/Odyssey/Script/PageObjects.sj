﻿//--------------------------------------------------------------------------------------		

// Declaring global variable for objects
var projectPath = "";
var objNewBrowser;
var reportRow = 0;
var	LogResultsPath;	
var	ResultsBackUp;
var	moduleLinks = "";
var	moduleList;		
var	moduleName = "";
var	driverEndRow;		
var	driverFilePath;		
var	driverRowCount;		
var	driverStartRow;
var testStatus;
var sessionId;
var appVersion;
var selectedOutcome;
//var moduleName;
var FCQuesCount = [];

//var Standalone_3_10 = {"DBName":"OdysseyStandalone3.10ENGB","UN":"eCoverAdmin","PWD":"Ax!msm1le"}

//----TestCase Global variables------
var firstNamePerf="bd"
var lastNamePerf="ru"
var SelectedPresCompl=null;
var locationType = "AUS"
var versionlist = "7.410"
var contentFiles = "v3.17_en_AU_TeleAssess_Clinical_7.490"
var oldContentFiles = "v3.17_en_AU_TeleAssess_Clinical_7.410"
var ccusContentFiles = "v3.17_en_GB_TeleAssess_Clinical_7.490|v3.17_en_GB_FirstCall_Lay_7.490"
var nhsNumber = "0000000"
var ccusVersion = "7.500"

txt_LoginId="WPFObject(\"LoginID\")"
txt_Password="WPFObject(\"Password\")"
txt_PresentingComplaint = "WPFObject(\"TextBlock\", \"Presenting complaint currently selected: \", 1)"
txt_ApproximateAge = "WPFObject(\"ApproximateAge\")"
txt_ContactInfo="WPFObject(\"ContactInfoTextBox\")"
txt_SelectItemFrmListView ="WPFObject(\"TextBlock\", \"Search for a presenting complaint using the search window, or select an item from the list\", 1)"
txt_SearchBox ="WPFObject(\"searchTextBox\")"
txt_EmailTextBox="WPFObject(\"TextBox\", \"\", 1)"
txt_ForeNameTextBox="WPFObject(\"TextBox\", \"\", 2)"
txt_SurNameBox = "WPFObject(\"SurnameBox\")"
txt_TitleBox = "WPFObject(\"TextBox\", \"\", 4)"
txt_ContactBox = "WPFObject(\"TextBox\", \"\", 5)"
txt_DOB="WPFObject(\"dateBirth\")"
//txt_ApproxAge="WPFObject(\"ApproximateAge\")"
txt_FirstName = "WPFObject(\"firstName\")"
txt_Surname = "WPFObject(\"surname\")"
txt_NHSNumber="WPFObject(\"patientNumber\")"
txt_Contact="WPFObject(\"contact\")"
txt_Notes="WPFObject(\"notes\")"
//txt_Notes="WPFObject(\"FlowDocumentView\", \"\", 1)"
txt_AddNotes="WPFObject(\"NotesTextBox\")"
txt_Address1="WPFObject(\"address1\")"
txt_town="WPFObject(\"town\")"
txt_County="WPFObject(\"county\")"
txt_PostCode="WPFObject(\"postcode\")"
txt_PhoneNumb="WPFObject(\"phoneNumber\")"
txt_SearchPresentingCompliant="WPFObject(\"TextBoxView\", \"\", 1)"
txt_PatFirstName = "WinFormsObject(\"PatientFirstName\")"
txt_PatLastName = "WinFormsObject(\"PatientLastName\")"

txt_ReasonText = "WPFObject(\"ReasonText\")"
txt_FreeForm = "WPFObject(\"Freeform\")"
txt_ReasonForUrgencyChange = "WPFObject(\"UrgencyVariationTextBox\")"
txt_WaterMarkedTtextBox = "WPFObject(\"WatermarkedTextBox\", \"\", 1)"
txt_careText = "WPFObject(\"CareText\")"
txt_ToAddContactType = "WPFObject(\"Label\", \"\", 1)"
txt_UrgenctVariationReason = "WPFObject(\"UrgencyVariationTextBox\")"
txt_Complianceof = "WPFObject(\"TextBlock\", \" Complains of \", 2)"
txt_Freeform = "WPFObject(\"Freeform\")"
txt_ServiceURL = "WinFormsObject(\"ServiceURL\")"
txt_Username = "WinFormsObject(\"Username\")"
txt_Domain = "WinFormsObject(\"Domain\")"
txt_Product = "WinFormsObject(\"Product\")"
txt_ProdType = "WinFormsObject(\"ProductType\")"
txt_ContentVersion = "WinFormsObject(\"ContentVersion\")"
txt_Culture = "WinFormsObject(\"ContentCulture\")"
txt_CurrentLocation = "WinFormsObject(\"ContentLocation\")"
txt_CallbackNumber = "WinFormsObject(\"CallbackNumber\")"
txt_Reference = "WinFormsObject(\"Reference\")"
txt_SessionIdentifier = "WinFormsObject(\"SessionIdentifier\")"
txt_AssessmentStateText ="WinFormsObject(\"AssessmentStateText\")"
txt_SessionId = "WinFormsObject(\"SessionIdText\")"
txt_ChangeOfUrgChange = "WPFObject(\"ScrollContentPresenter\", \"\", 1)"
txt_PresentingComplaintSearchInputBox = "WPFObject(\"PresentingComplaintSearchInputBox\")"
txt_ValueTextBox = "WPFObject(\"ValueTextBox\")"
txt_UrgencyVariationOverlay = "WPFObject(\"UrgencyVariationOverlay\", \"\", 1)"
txt_OutcomeText = "WinFormsObject(\"OutcomeText\")"
txt_ActionSearchTerm = "WPFObject(\"ActionSearchTerm\")"
txt_Examination="WPFObject(\"txtExaminationSuggests\")"
txt_History="WPFObject(\"txtHistorySuggests\")"  
txt_PILSSearch = "WPFObject(\"PILSSearchInputBoxControl\")" 
txt_Weight = "WPFObject(\"Weight\")"
txt_Height = "WPFObject(\"TextBox\", \"\", 6)"
txt_BMI = "WPFObject(\"TextBox\", \"\", 7)"
txt_LMD = "WPFObject(\"PregnancyDatePicker\")"
txt_EDD = "WPFObject(\"EddDatePicker\")"
txt_CareAdviceText = "WPFObject(\"CareAdviceText\")"
txt_WorseningAdviceText = "WPFObject(\"WorseningAdviceText\")"
txt_WorseningStatement = "WPFObject(\"WorseningStatement\")"
txt_PresentingComplaint = "WinFormsObject(\"PresentingComplaintText\")"
txt_Recommendation = "WinFormsObject(\"RecommendationText\")"
txt_SelectedUrgencyCode = "WinFormsObject(\"SelectedUrgencyCodeText\")"
txt_SelectedUrgency = "WinFormsObject(\"SelectedUrgencyText\")"
txt_PriorityReason = "WinFormsObject(\"PriorityReasonText\")"
txt_NumOfWeeks = "WinFormsObject(\"UpDownEdit\", \"\")"
//New InProcess TestHarness
txt_FirstName1 = "WPFObject(\"Label\", \"First name\", 1)"
txt_DOB1 = "WPFObject(\"Dt_DOB\")"
txt_SessionIdNew = "WPFObject(\"txtSessionId\")"
txt_AssessmentStateNew = "WPFObject(\"txtAssessmentState\")"
txt_PresentingComplaintNew = "WPFObject(\"txtPresentingComplaint\")"
txt_RecommendationNew = "WPFObject(\"txtOdysseyRecommendation\")"
txt_OutcomeTextNew = "WPFObject(\"txtPatientOutcome\")"
txt_SelectedUrgencyCodeNew = "WPFObject(\"txtSelectedUrgencyCode\")"
txt_SelectedUrgencyNew = "WPFObject(\"txtSelectedUrgency\")"
txt_PriorityReasonNew = "WPFObject(\"txtPriorityReason\")"
txt_ActionRequired = "WPFObject(\"txtActionRequired\")"
txt_EmailSubject = "WPFObject(\"EmailSubject\")"
txt_EmailBody = "WPFObject(\"EmailBody\")"
txt_Email = "WPFObject(\"Email\")"
txt_AdditionalInfoTextBox = "WPFObject(\"AdditionalInfoTextBox\")"
txt_rtbLog = "WPFObject(\"rtbLog\")"
txt_FirstAidAdvice = "WPFObject(\"FirstAidAdvice\")"
txt_AmbulanceTransportText = "WPFObject(\"AmbulanceTransportText\")"
txt_ReasonForDecline = "WPFObject(\"WatermarkedTextBox\", \"\", 2)"

btn_WPFButton="WPFObject(\"button\")"
btn_SaveCalltoQueue = "WPFObject(\"Button\", \"Save call to queue\", *)"
btn_PresentComplaint="WPFObject(\"ListBoxItem\", \"\", *)"
btn_ButtonParntObj = "WPFObject(\"LinkLabel\",\"\",*)"
btn_ItmTextBlock = "WPFObject(\"ItemTextBlock\")"
btn_DescTxtBlock ="WPFObject(\"DescriptionTextBlock\")"
btn_BackToPreviousScreen="WPFObject(\"Button\", \"Back to previous screen\", 1)"
btn_AddreessEditControl="WPFObject(\"AddressEditorControl\")"
btn_SubSectionOneHeader = "WPFObject(\"SubSectionOneHeader\")"
btn_TeleAssessContinueBtn="WPFObject(\"TeleAssessContinueButton\")"
btn_SaveNotes= "WPFObject(\"Button\", \"Save\", *)"
btn_SearchCancel = "WPFObject(\"Button\", \"Cancel\", 1)"
btn_AddQuestionSet = "WPFObject(\"Button\", \"Add Question Set\", 2)"
btn_CloseQuestionSet = "WPFObject(\"Button\", \"Close Question Set(s)\", 2)"
btn_CloseAssessment = "WPFObject(\"Button\", \"Close Assessment\", *)"
btn_ReturnAssessment = "WPFObject(\"Button\", \"Return to Assessment\", *)"
btn_IncreaseToNow = "WPFObject(\"TextBlock\", \"Increase to Now\", 1)"
btn_SaveAndContinue = "WPFObject(\"Button\", \"Save and continue\", 2)"
btn_Return = "WPFObject(\"Button\", \"Return\", 1)"
btn_AccpetPatient = "WPFObject(\"Button\", \"Accept patient\", 4)"
btn_ChangePresentingComplbtn = "WPFObject(\"Button\", \"Change presenting complaint\", *)"
btn_ReturnToQueue = "WPFObject(\"Button\", \"Return to queue\", *)"
btn_Copy = "WPFObject(\"EditorMenuItem\", \"_Copy\", 2)"
btn_Paste = "WPFObject(\"EditorMenuItem\", \"_Paste\", 3)"
btn_CopyToNotes = "WPFObject(\"Button\", \"Copy to notes\", 1)"
btn_CallBackAdvice = "WPFObject(\"Button\", \"Call back advice\", *)"
btn_ReverseCallBackAdvice = "WPFObject(\"Button\", \"Reverse Call back advice\", *)"
btn_DeclinedAdvice = "WPFObject(\"Button\", \"Declined advice\", *)"
btn_ReverseDeclinedAdvice = "WPFObject(\"Button\", \"Reverse Declined advice\", *)"
btn_CancelNotesSave = "WPFObject(\"Button\", \"Cancel\", *)"
btn_AuditRecordClose = "WPFObject(\"Button\", \"Close\", 1)"
btn_UserAdmin = "WPFObject(\"Button\", \"User Admin\", *)"
btn_NewUser = "WPFObject(\"Button\", \"New User\", *)"
btn_BackToAdminSummary = "WPFObject(\"Button\", \"Back to Admin Summary\", 1)"
btn_DisableUser = "WPFObject(\"Button\", \"Disable User\", *)"
btn_SaveChanges = "WPFObject(\"Button\", \"Save Changes\", 1)"
btn_AutomationTest = "WPFObject(\"TextBlock\", \"Automation Test\", 1)"
btn_ConfigEditor = "WPFObject(\"Button\", \"Configuration Editors\", 3)"
btn_ContactTypes = "WPFObject(\"Expander\", \"Contact Types\", 1)"
btn_AddContactType = "WPFObject(\"addContactType\")"
btn_AddressTypes = "WPFObject(\"Expander\", \"Address Types\", 1)"
btn_AddaddressType = "WPFObject(\"addAddressTypes\")"
btn_Ethnicity = "WPFObject(\"Expander\", \"Ethnicity\", 1)"
btn_SiteSettings = "WPFObject(\"Expander\", \"Site Settings\", 1)"
btn_AddEthnicity = "WPFObject(\"addEthnicity\")"
btn_ManageAllergies = "WPFObject(\"Expander\", \"Manage Allergies\", 1)"
btn_AddManageAllergies = "WPFObject(\"addAllergy\")"
btn_EditSessionTypes = "WPFObject(\"Expander\", \"Edit Session Types\", 1)"
btn_AddSessionType = "WPFObject(\"addSessionType\")"
btn_QuesSetClosure = "WPFObject(\"Expander\", \"Question Set Closure Reasons\", 1)"
btn_AddQuesSetClosure = "WPFObject(\"addExclusionReason\")"
btn_AssessmentClosureReason = "WPFObject(\"Expander\", \"Assessment Closure Reasons\", 1)"
btn_AddAssClosureReason = "WPFObject(\"addClosureReason\")"
btn_Return = "WPFObject(\"Button\", \"Return\", 1)"
btn_SaveandContinue = "WPFObject(\"Button\", \"Save and continue\", 2)"
btn_EmailConfigurations = "WPFObject(\"Expander\", \"Email Configurations\", 1)"

//btn_CloseAssessment1 = "WPFObject(\"Button\", \"Close Assessment\", 1)"
btn_ReturnToAssessment = "WPFObject(\"Button\", \"Return to Assessment\", 2)"
btn_PresComplButton = "WinFormsObject(\"PresentingComplaintButton\")"
btn_Start = "WinFormsObject(\"StartAssessmentButton\")"
btn_AbandonAssessment = "WinFormsObject(\"AbandonAssessment\")"
btn_DropControlButton = "WinFormsObject(\"DropControlButton\")"
btn_RefG = "WinFormsObject(\"GenerateRandomReferenceButton\")"
btn_Emergency = "WPFObject(\"Button\", \"Emergency\", 1)"
btn_No = "WPFObject(\"Button\", \"No\", 1)"
btn_Yes = "WPFObject(\"Button\", \"Yes\", 2)"
btn_FemaleListBox = "WPFObject(\"ListBoxItem\", \"Female\", *)"
btn_AgeRange = "WPFObject(\"ListBoxItem\", \"\", 2)"
btn_Chest = "WPFObject(\"ListBoxItem\", \"\", 4)"
btn_DropControlBtn = "WinFormsObject(\"DropControlButton\")"
btn_AcceptPatient = "WPFObject(\"Button\", \"Accept patient\", 2)"
btn_PassToClinician = "WPFObject(\"Button\", \"Pass to Clinician\", *)"
btn_Continue = "WPFObject(\"Button\", \"Continue\", *)"
btn_Complete = "WPFObject(\"Button\", \"Complete\", *)"
btn_ContinueLabel = "WPFObject(\"ProceedToEndCallLabel\")"
btn_GoBackLabel = "WPFObject(\"GoBackLabel\")"
btn_ReviewAssessment = "WPFObject(\"Button\", \"Review Assessment\", *)"
btn_QuestionSetOnLHS = "WPFObject(\"ListBoxItem\", \"\", *)"
btn_Login = "WPFObject(\"Button\", \"Login\", 1)"
btn_Logout = "WPFObject(\"Button\", \"Logout\", *)"
btn_UseAnonymousPatient = "WPFObject(\"Button\", \"Use anonymous patient\", *)"
btn_GPLetter = "WPFObject(\"Button\", \"GP Letter\", *)"
btn_ChangeUrgency = "WPFObject(\"Button\", \"Change Urgency\", *)"
btn_Refreshqueue = "WPFObject(\"Button\", \"Refresh queue\", *)"
btn_Examination = "WPFObject(\"TabItem\", \"Examination\", *)"
btn_SwitchView = "WPFObject(\"Button\", \"Switch View\", *)"
btn_TreatmentPlan = "WPFObject(\"TabItem\", \"Treatment Plan\", *)"
btn_Outcome = "WPFObject(\"TabItem\", \"Outcome\", *)"
btn_AddExamination = "WPFObject(\"Button\", \"Add Examination\", *)"
btn_Add = "WPFObject(\"Button\", \"Add\", *)"
btn_Closeconsultation = "WPFObject(\"Button\", \"Close consultation\", *)"
btn_discard = "WPFObject(\"DiscardButton\")"
//Came from 3.11
btn_GoBack = "WPFObject(\"GoBack\")"
obj_EmergencyProtScreen="WPFObject(\"EmergencyProtocols\", \"\", *)" 
btn_ReturnToCall = "WPFObject(\"Button\", \"Return to call\", *)"
btn_EndCall = "WPFObject(\"Button\", \"End Call\", *)"
btn_FirstCallConfig = "WPFObject(\"Expander\", \"FirstCall Configuration\", 1)"
btn_AddMessage = "WPFObject(\"AddMessage\")"
btn_ChangePresComplAcceptPatient = "WPFObject(\"Button\", \"Change presenting complaint\", *)"
btn_Cancel = "WPFObject(\"Button\", \"Cancel\", *)"
btn_QuestionSetContinue = "WPFObject(\"QuestionSetContinue\")"
btn_EmergencyProtocol="WPFObject(\"ListBoxItem\", \"\", *)" 
btn_MaleListBox  = "WPFObject(\"ListBoxItem\", \"Male\", *)"
btn_UnknownListBox = "WPFObject(\"ListBoxItem\", \"Unknown\", *)"
btn_ShowFindings = "WPFObject(\"Button\", \"Show Findings\", *)" 
btn_ClinicianSummary = "WPFObject(\"Button\", \"Summary\", *)"
btn_GPLetter = "WPFObject(\"Button\", \"GP Letter\", *)"
btn_Close = "WPFObject(\"Button\", \"Close\", *)"
btn_OK = "WPFObject(\"Button\", \"OK\", *)"
btn_Replace = "WPFObject(\"Button\", \"Replace\", *)"
btn_UsePatient = "WPFObject(\"UsePatient\")"
btn_FTFContinueButton = "WPFObject(\"FaceToFaceContinueButton\")"
btn_RadTabItem = "WPFObject(\"RadTabItem\", \"\", *)"
btn_History = "WPFObject(\"TabItem\", \"History\", *)"
btn_SearchLinkLabel = "WPFObject(\"SearchLinkLabel\")"
btn_AddTreatment = "WPFObject(\"Button\", \"Add Treatment\", 1)"
btn_CopytoTreatmentPlan = "WPFObject(\"Button\", \"Copy to Treatment Plan\", 1)"
btn_RemoveQuestionSet = "WPFObject(\"Button\", \"Remove Question Set\", *)"
btn_CloseAppYes = "Window(\"Button\", \"&Yes\", *)"
btn_CloseAppNo = "Window(\"Button\", \"&No\", *)"
btn_Lock = "WPFObject(\"Button\", \"Lock\", *)"
btn_NotDoneFTF = "WPFObject(\"NotDoneToggleButton\")"
btn_UnrecordableFTF = "WPFObject(\"UnrecordableToggleButton\")"
btn_ShowMethodology = "WPFObject(\"Button\", \"Show Methodology\", 1)"
btn_PatientOutcomes = "WPFObject(\"Expander\", \"Patient Outcomes\", 1)"
btn_addOutcome = "WPFObject(\"addOutcome\")"
btn_ClinicalSummary = "WPFObject(\"Button\", \"Clinical Summary\", *)"
btn_FullAssessment = "WPFObject(\"Button\", \"Full Assessment\", *)"
btn_Pauseconsultation = "WPFObject(\"Button\", \"Pause consultation\", *)"
btn_Calculate = "WPFObject(\"Button\", \"Calculate\", *)"
btn_Hide = "WPFObject(\"Button\", \"Hide\", *)"
btn_WorseningStatementAccept = "WPFObject(\"WorseningStatementAccept\")"
btn_WorseningStatementDecline = "WPFObject(\"WorseningStatementDecline\")"
btn_CareAdviceAccept = "WPFObject(\"CareAdviceAccept\")"
btn_CareAdviceDecline = "WPFObject(\"CareAdviceDecline\")"
btn_WorseningAdviceAccept = "WPFObject(\"WorseningAdviceAccept\")"
btn_WorseningAdviceDecline = "WPFObject(\"WorseningAdviceDecline\")" 
btn_RelationTypes = "WPFObject(\"Expander\", \"Relationship Types\", 1)"
btn_AddRelationType = "WPFObject(\"addRelationshipType\")"
btn_SessionBannerExpander="WPFObject(\"SessionBannerExpander\")"
btn_ViewHistory = "WPFObject(\"ViewHistory\")"
btn_SaveAndGoBack = "WPFObject(\"Button\", \"Save and go back\", *)"
btn_ChangeYourSearchCriteria = "WPFObject(\"Button\", \"_Change your search criteria\", *)"
btn_NewSearch = "WPFObject(\"Button\", \"_New search\", *)"
btn_ChangeComplaint="WPFObject(\"Button\", \"Change complaint\", *)"
btn_SummaryReport = "WPFObject(\"Button\", \"Summary Report\", *)"
//New InProcess TestHarness
btn_StartAssessment = "WPFObject(\"Button\", \"Start Assessment\", *)"
btn_Ok1 = "WPFObject(\"Button\", \"Ok\", *)"
btn_DropControl = "WPFObject(\"Button\", \"Drop Control\", *)"
btn_AbandonAssessmentNew = "WPFObject(\"Button\", \"Abandon Assessment\", 1)"
btn_ThirdPartyIntegration = "WPFObject(\"Expander\", \"Third Party Integration Configuration\", *)"
btn_GetVersion = "WPFObject(\"GetVersionButton\")"
btn_Download = "WPFObject(\"DownloadButton\")"
btn_ViewSummary ="WPFObject(\"Button\", \"View Summary\", *)"
btn_CallHandlerTabControl = "WPFObject(\"CallHandlerTabControl\")"
btn_PickUp = "WPFObject(\"Button\", \"Pick Up\", *)"
btn_Continuetosummaryscreen = "WPFObject(\"Button\", \"Continue to summary screen\", *)"
btn_PatientInformationLeaflets = "WPFObject(\"TabItem\", \"Patient Information Leaflets\", *)"
btn_EmailAdvice = "WPFObject(\"Button\", \"Email Advice\", *)"
btn_SendEmail = "WPFObject(\"Button\", \"Send Email\", *)"
btn_CareAdvice = "WPFObject(\"TabItem\", \"Care Advice\", 1)"
btn_RemoveClaim = "WPFObject(\"Button\", \"<\", *)"
btn_NoLabel = "WPFObject(\"NoLabel\")"
btn_YesLabel = "WPFObject(\"YesLabel\")"
btn_UrgencyAdmin = "WPFObject(\"Button\", \"Urgency Admin\", *)"
btn_Immediate = "WPFObject(\"TextBlock\", \"Immediate\", 1)"
btn_Signposting = "WPFObject(\"Expander\", \"Signposting\", *)"
btn_ManageEmailServerSettings = "WPFObject(\"Expander\", \"Manage Email Server Settings\", *)"
btn_LightNoLabel= "WPFObject(\"LightNoLabel\")"
btn_Saveselectpresentingcomplaint = "WPFObject(\"Button\", \"Save and select a presenting complaint\", *)"
btn_PreviousEncounters = "WPFObject(\"Expander\", \"Previous Encounters\", *)"
btn_ShowPreviousEncounters = "WPFObject(\"Button\", \"Show Previous Encounters\", *)"
btn_Accept = "WPFObject(\"Button\", \"Accept\", *)"
btn_Returntoassessmentscreen = "WPFObject(\"Button\", \"Return to assessment screen\", *)"
btn_FirstAidAdviceAccept = "WPFObject(\"FirstAidAdviceAccept\")"
btn_FirstAidAdviceDecline = "WPFObject(\"FirstAidAdviceDecline\")"
btn_EditAssessment = "WPFObject(\"Button\", \"Edit Assessment\", *)"
btn_ManageClinicalContent = "WPFObject(\"Expander\", \"Manage Clinical Content\", *)"
btn_FindAddresses = "WPFObject(\"Button\", \"Find Addresses\", *)"
btn_SaveasPDF = "WPFObject(\"Button\", \"Save as PDF\", *)"
btn_Search = "WPFObject(\"Button\", \"Search\", *)"
btn_Reject = "WPFObject(\"Button\", \"Reject\", *)"
btn_UrgencyVariationText = "WPFObject(\"Expander\", \"Urgency Variation Text\", *)"

lbl_QueueIsEmpty = "WPFObject(\"Label\", \"The queue is empty\", 2)"
lbl_QueueCount="WPFObject(\"Label\", \"* item* in the queue\", 2)"
lbl_NoMatchesFound = "No matches for Family name = Automation"
lbl_MatchFound = "1 matches for Family name = Automation"
lbl_ContactofOther="WPFObject(\"ListBoxItem\", \"\", 1)"
lbl_CurrSelctdPresComplaint="WPFObject(\"PCBox\")"
lbl_NameDisplay="WPFObject(\"NameLabel\")"
lbl_DOBValue="WPFObject(\"DOBValue\")"
lbl_DOBLabel="WPFObject(\"DOBLabel\")"
lbl_GenderLabel = "WPFObject(\"GenderLabel\")"
lbl_GenderValue="WPFObject(\"GenderValue\")"
lbl_NHSNumberLabel="WPFObject(\"IdentifierLabel\")"
lbl_NHSNumberValue="WPFObject(\"IdentifierValue\")"
lbl_AdditionalText = "Additional sets of questions need consideration, please select from the list above"
lbl_GPName = "WPFObject(\"Label\", \"Patrick\", 1)"
lbl_AdminSummary = "WPFObject(\"TextBlock\", \"Admin Summary\", 1)"
lbl_TestAutoReason = "WPFObject(\"Run\", \"Test automation reason\", 1)"
lbl_URLService = "qa.odyssey.local/3.10/OdysseyServices"
lbl_BindableRichTextBox = "WPFObject(\"BindableRichTextBox\", \"\", 1)"
lbl_NotesSaved = "WPFObject(\"RichTextBoxWithChangeTracking\", \"\", 1)"
lbl_Decreasetoselfcare = "WPFObject(\"TextBlock\", \"Decrease to self care\", 1)"
lbl_Decreasetoroutineappointment = "WPFObject(\"TextBlock\", \"Decrease to routine appointment\", 1)"
lbl_PresentingCompText = "Search for a presenting complaint using the search window, or select an item from the list"
lbl_SessionContactLabel = "WPFObject(\"SessionContactLabel\")"
lbl_ExaminationResponse = "WPFObject(\"ListBoxItem\", \"\", *)"
lbl_FTFWarning = "Not all mandatory exams have been answered, are you sure you wish to continue?"
//merged from 3.11
lbl_DecreaseToNow = "WPFObject(\"TextBlock\", \"Decrease to Now\", 1)"
lbl_IncreasetoNow = "WPFObject(\"TextBlock\", \"Increase to Now\", 1)"
lbl_Active = "WPFObject(\"Label\", \"Active\", 1)"

lbl_DeclineAdviceNotes = "Patient declined the treatment/advice offered, and was requested to make contact again if condition failed to resolve"
lbl_RecommendedLabel = "WPFObject(\"RecommendedLabel\")"
lbl_CloseAppWarningMssg = "Window(\"Static\", \"You may lose any unsaved data. Are you sure you want to close Odyssey?\", *)"
lbl_PatientOutcome = "WPFObject(\"TextBlock\", \"Patient Outcome\", *)"
lbl_PatientOutcomeLabel = "WPFObject(\"PatientOutcomeLabel\")"
lbl_TransferToClinician = "Recommend transferring this call to a clinician now"
//lbl_TransferToAmbServ = "Recommended an Ambulance is Dispatched as soon as possible"
lbl_TransferToAmbServ = "Call an emergency ambulance NOW."
lbl_SignPost = "WPFObject(\"TextBlock\", \"Signposts:\", 1)"
lbl_ActionReqEmer = "Transfer to Emergency Ambulance Service"
lbl_EmerActReq = "Current Suggested Action: Transfer to Emergency Ambulance Service"
lbl_NowActReq = "Current Suggested Action: 20 minute clinician call back"
lbl_1HrActReq = "Current Suggested Action: 1 hour clinician appointment"

//Call Handler Actions
lbl_ColdTransfertoClinician1 = "Cold transfer to Clinician, priority 1"
lbl_ColdTransfertoClinician2 = "Cold transfer to Clinician, priority 2"
lbl_CallHandlerAdvice = "Call Handler Advice"
lbl_WarmTransferClinician = "Warm transfer to clinician"
lbl_CHTransferToAmbulance = "Transfer to Emergency Ambulance Service"
lbl_CHRoutineAppointment = "Routine GP appointment"

lbl_20MinGPCallBack = "20 minute clinician call back"
lbl_1HrGPCallBack = "1 hour clinician appointment"
lbl_F2FApp6Hrs = "Clinician appointment <6 hours"
lbl_F2FApp24Hrs = "Clinician appointment within the next day <24 hours"
lbl_RoutGPAppoint = "Routine appointment"

lbl_ServiceURL = "WPFObject(\"Label\", \"Service URL\", 1)"
lbl_Domain = "WPFObject(\"Label\", \"Domain\", 2)"
lbl_Product = "WPFObject(\"Label\", \"Product\", 1)"
lbl_OrganisationName = "WPFObject(\"Label\", \"Organisation Name\", *)"
lbl_AssessmentState = "WPFObject(\"Label\", \"Assessment State\", *)"
lbl_PILSLabel = "WPFObject(\"PILSLabel\")"
lbl_PauseAssmentSet = "Display \"Pause Assessment\" Button"
lbl_BasicDemographicInfo = "WPFObject(\"Label\", \"Basic Demographic Information\", *)"
lbl_GPDetails = "Patrick Jane|Medi Claim|mediclaim@live.in|9798435"
lbl_FirstAidAdvice = "WPFObject(\"TextBlock\", \"First Aid Advice\", 1)"
lbl_TurnPurpQuesOn = "WPFObject(\"Label\", \"Turn Purple Coloured Questions on\", *)"
lbl_AmbulanceTranspTxt = "WPFObject(\"Label\", \"Show Ambulance Transport Text for Emergency\", *)"
lbl_ReasonForChange = "WPFObject(\"Label\", \"Reason For Change\", *)"
// For ENGB lbl_NHSNUMBERLABELToolTip = "A ten-digit number used to identify a person uniquely within the NHS in England and Wales"
lbl_NHSNUMBERLABELToolTip = "7 character Medical Record Number"
//For ENNZ lbl_NHSNUMBERLABELToolTip = "National Health Index number"
lbl_Address="Work: No 1 Narrow Street, SYDNEY, NSW, 2001"
// For ENGB lbl_Address="Work: No 1 Narrow Street, New Town, 35001"
lbl_Address1 = "No 1 Narrow StreetSYDNEYNSW2001"
// For ENGB lbl_Address1 = "No 1 Narrow StreetNew Town35001"
lbl_AddressRepDB = "No 1 Narrow Street   NSW 2001 SYDNEY "
// For ENGB lbl_AddressRepDB = "No 1 Narrow Street    35001 New Town "

rbtn_years="WPFObject(\"ListBoxItem\", \"\", *)"
rbtn_StartWith="WPFObject(\"ListBoxItem\", \"Starts with\", 1)"
rbtn_Contains="WPFObject(\"ListBoxItem\", \"Contains\", 2)"
rbtn_CareAdvice = "WPFObject(\"ListBoxItem\", \"Care Advice\", 1)"
rbtn_FirstAid = "WPFObject(\"ListBoxItem\", \"First Aid\", 2)"
rbtn_Information = "WPFObject(\"ListBoxItem\", \"Information\", *)"
rbtn_reception = "WPFObject(\"Label\", \"Reception\", 1)"
rbtn_Clinician = "WPFObject(\"Label\", \"Restricted Clinician\", 1)"
rbtn_AdvancedClinician = "WPFObject(\"Label\", \"Clinician\", 1)"
rbtn_AdviceNotGiven = "WPFObject(\"RadioButton\", \"Advice Not given\", 2)"
rbtn_AdviceGiven = "WPFObject(\"RadioButton\", \"Advice given\", 1)"
rbtn_CallHandler = "WPFObject(\"Label\", \"Call Handler\", 1)"

chkBx_Phonetic="WPFObject(\"CheckBox\", \"Phonetic\", 1)"
chkBx_Active="WPFObject(\"CheckBox\", \"Active\", 1)"
chkBx_IncPatBan = "WinFormsObject(\"IncludePatientBanner\")"
chkBx_ShowInDialog = "WinFormsObject(\"ShowInDialog\")"
chkBx_CheckBoxAction = "WPFObject(\"CheckBoxAction\")"
chkBx_ShowAllExamsCheckBox = "WPFObject(\"ShowAllExamsCheckBox\")"
chkBx_ConsenttoExam = "WPFObject(\"CheckBox\", \"Consent to Examination\", *)"
chkBx_IncInactiveUsers="WPFObject(\"CheckBox\")"
chkBx_IncludePatientBanner = "WPFObject(\"CheckBox\", \"Include Patient Banner\", 1)"
chkBx_ShowFullText = "WPFObject(\"ShowFullText\")"
chkBx_SelectAll = "WPFObject(\"ckbxSelectAll\")"
chkBx_ckbxPilsSelectAll = "WPFObject(\"ckbxPilsSelectAll\")"
chkBx_ConfirmationCheckBox = "WPFObject(\"ConfirmationCheckBox\")"
chkBx_ActiveCheckBox = "WPFObject(\"ActiveCheckBox\")"
chkBx_EmailConfigurationList = "WPFObject(\"EmailConfigurationList\")"
chkBx_ConsenttoGP = "WPFObject(\"CheckBox\", \"Consent to GP contact\", *)"
chkBx_RequireNote="WPFObject(\"CheckBox\", \"\", 1)"
chkBx_Accept = "WPFObject(\"RadioButton\", \"Accept\", *)"
chkBx_Decline = "WPFObject(\"RadioButton\", \"Decline\", *)"
chkBx_TrainingCompleted = "WPFObject(\"CheckBox\", \"Training Completed\", *)"


list_MessgList = "WPFObject(\"MessageList\")"
list_SignpostServiceList = "WPFObject(\"SignpostServiceList\")"
list_CareAdviceList = "WPFObject(\"CareAdviceList\")"
list_PILSList = "WPFObject(\"PILSList\")"

grid_Urgency = "WPFObject(\"GridViewGroupRow\", \"\", *)"
grid_DiagnosisGrid = "WPFObject(\"DiagnosisGrid\")"

Wnd_MainWindow = "WPFObject(\"HwndSource: MainWindow\")"
Wnd_TestHarnessNew = "WPFObject(\"MainWindow\")"  //For New TestHarness
Wnd_TestHarness = "WinFormsObject(\"Master\")"  //For Old InProcess

cmb_ContactTypes="WPFObject(\"ContactTypes\")"
cmb_Description="WPFObject(\"Description\")"
cmb_CallType="WPFObject(\"ComboBox\", \"\", 1)"
cmb_CallType1 = "WPFObject(\"SessionTypeComboBox\")"
cmb_ChekableCmbBox="WPFObject(\"CheckableCombo\")"
cmb_SelectHeader="WPFObject(\"SelectedHeader\")"
cmb_Ethinicity = "WPFObject(\"ethnicity\")"
cmb_CloseAssessment = "WPFObject(\"Reasons\")"
cmb_GenderControl = "WPFObject(\"GenderControl\")"
cmb_AnswerList = "WPFObject(\"AnswerList\")"
cmb_SelectedUrgency = "WPFObject(\"TextBlock\", \"Within * minutes*\", *)"
cmb_SelectedUrgencyAssessNow = "WPFObject(\"TextBlock\", \"Assess now\", 1)"
cmb_Role = "WinFormsObject(\"roleList\")"
cmb_PresCompl = "WinFormsObject(\"PresentingComplaints\")"
cmb_DatePicker = "WinFormsObject(\"DoBDatePicker\")"
cmb_Gender = "WinFormsObject(\"Gender\")"
cmb_AvailableActions = "WPFObject(\"AvailableActions\")"
cmb_Culture1 = "WPFObject(\"ComboBox\", \"\", 1)"
cmb_Culture2 = "WPFObject(\"ComboBox\", \"\", 2)"
cmb_UrgencyChangeReasons = "WPFObject(\"UrgencyChangeReasons\")"
cmb_changeUrgencyReason = "WPFObject(\"changeUrgencyReasonComboBox\")"

icon_AddContact="WPFObject(\"addContact\")"
icon_DeleteContact="WPFObject(\"deleteContact\")"
icon_AddAddress="WPFObject(\"addAddress\")"
icon_deleteAddress="WPFObject(\"deleteAddress\")"
icon_AdvSearchOpt="WPFObject(\"advancedSearch\")"
icon_Tick = "WPFObject(\"Image\", \"\", *)"
icon_WarningIcon = "WPFObject(\"WarningIcon\")"

PopUpMsg = "WPFObject(\"WCParent\")"
PopUpMsg_AssessmentScreen = "The current urgency indicates that the patient should be treated immediately."
PopUpMsg_IntPatientDet = "WPFObject(\"IntegrationPatientDetails\", \"\", 1)"
PopUpMsg_IMLT = "Call an emergency ambulance - LIFE THREATENING."
PopUpMsg_EMER = "Call an emergency ambulance NOW."
PopUpMsg_IMM1 = "Recommend transferring this call to a clinician now"
PopUp_MainMessage = "WPFObject(\"MainMessage\")"

obj_Addressheader="WPFObject(\"addressHeader\")"
obj_patientEditControl="WPFObject(\"patientEditorControl\")"
obj_Control = "WPFObject(\"ThisControl\")"
obj_InternetExpl = "Window(\"Internet Explorer_Server\", \"\", *)"
obj_CallHandlerAssScrn = "WPFObject(\"CallHandlerAssessment\", \"\", 1)"
obj_SearchText = "WPFObject(\"SearchText\")"
obj_CloseAppOverlay = "Window(*, \"Warning!\", *)"
obj_ParentObj = "WPFObject(\"ThisControl\")"
obj_AddExaminationDialog = "WPFObject(\"AddExaminationDialog\")"
obj_Overlay = "WPFObject(\"Overlay\", \"\", *)"
obj_AddActionDialog = "WPFObject(\"AddActionDialog\")"
obj_CareAdviceOverlay = "WPFObject(\"CareAdviceOverlay\", \"\", *)"
obj_AssessmentSummaryOverlay = "WPFObject(\"AssessmentSummaryOverlay\", \"\", *)"
obj_ClinicalWarningOverlay = "WPFObject(\"ClinicalWarningOverlay\", \"\", *)"
obj_Protocols = "WPFObject(\"Protocols\")"
obj_ClinicalWarning = "WPFObject(\"ClinicalWarning\", \"\", *)"
obj_EmailAdviceOverlay = "WPFObject(\"EmailAdviceOverlay\", \"\", 1)"
obj_CloseQuestionSetOverlay = "WPFObject(\"CloseQuestionSetOverlay\", \"\", *)"

ExpVal_PatientNameDisplayValue="PATIENT 54 YEARS FEMALE, Anonymous"
ExpVal_PatientNameDisplayValue1="AUTOMATION, Test"
ExpVal_patientNameDisplayValue2 = "MOORE, Ted"

lnk_AddressLink="WPFObject(\"ViewAllAddressLink\")"
lnk_ContactLink="WPFObject(\"ViewContactDetailsLink\")"
lnk_Allergies="WPFObject(\"ViewAllergyRecordLink\")"
lnk_PatientInfoLeaflets = "WPFObject(\"TextBlock\", \"*\", 1)"
lnk_AdvSearchOption = "WPFObject(\"advancedSearch\")"
lnk_ViewGPLink = "WPFObject(\"ViewGPLink\")"

TxtBlock_AnimalFur="WPFObject(\"TextBlock\", \"animal fur\", 1)"

img_Allergy="WPFObject(\"AllergiesImage\")"

scroll_TestHarness = "WPFObject(\"ScrollBar\", \"\", 1)"

obj_CloseAssessOverlaySumm="WPFObject(\"CloseAssessment\", \"\", *)"

btn_QuestionSetOnLHS = "WPFObject(\"ListBoxItem\", \"\", *)"

//lbl_Ques1 = "Compared to patient's usual condition, are there any immediate concerns about a very serious illness or injury?"
lbl_Ques1 = "Apart from the stated problem, is there anything that makes you think this is a very serious or life-threatening illness or injury?"
lbl_SearchText = "Search for a presenting complaint using the search window, or select an item from the list"
lbl_RoleofThree = "Based on the answers completed Odyssey recommends face to face assessment within 24 hours - This score has been upgraded because the patient has made contact twice in 48 hours with routine outcomes."
lbl_InprocessClinician = "Abhinav.Kumar (Clinician)"
lbl_InprocessCallHandler = "Abhinav.Kumar (Call Handler)"
lbl_InprocessReceptionist = "Abhinav.Kumar (Receptionist)"
lbl_UnansweredPQWarning = "There are unanswered questions that might result in a need for an emergency ambulance response"
lbl_ConfigEditWarning = "One or more fields in FirstCall Configuration section are empty."
lbl_AmbulanceTransport = "PREPARATION FOR AMBULANCE TRANSPORT"
lbl_DeclineContentWarning = "Warning: Declining a Clinical Content update involves risk. This version will be available in \"Current Selected Clinical Content Version\"."
lbl_NoUrgentQuesMssg = "Note the reason why the patient is calling in the Notes box and offer clinical contact if requested - or return to the main Search page and enter a different presenting complaint."

//DomainCreationTool
wnd_DomainEditor = "WPFObject(\"HwndSource: DomainEditor\", \"Odyssey Domain Editor\")"
btn_Savecontinue = "WPFObject(\"Button\", \"Save & continue\", *)"