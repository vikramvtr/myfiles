//USEUNIT CommonFunctions
//USEUNIT PageObjects

/*===============================================================================
Description: This function to create Temp file
Parameters: 
            fileName1:
            fileName2:
Return Value: 
=================================================================================*/
//function test()
//{
////  CreateTempFile("ActualFile.html","ExpextedFile.html")
//  CompareFiles("ActualFile.html","ExpextedFile.html")
//} 

function CreateTempFile(fileName1,fileName2)
{
     var actRepFilePath = Project.Variables.actRepFilePath
     var expRepFilePath = Project.Variables.expRepFilePath
     var fso, file1, file2, regEx
     var fileText1, fileText2, newText1, newText2
     var ForReading = 1
     
     aqFile.Delete(expRepFilePath+"Temp\\ExptempFile.txt")   
     aqFile.Delete(actRepFilePath+"Temp\\ActtempFile.txt") 
     
     aqFile.Create(expRepFilePath+"Temp\\ExptempFile.txt")
     aqFile.Create(actRepFilePath+"Temp\\ActtempFile.txt")
     
  
//      Specifies the pattern for the time mask
        var patt =/\d{1,2}-(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)-\d{4}\s\d{2}:\d{2}/g
     
//    Creates the FileSystemObject object
      fso = Sys.OleObject("Scripting.FileSystemObject");
     
//     Reads the first text file
      file1 = fso.OpenTextFile(actRepFilePath + fileName1, ForReading)
   
     do  
     {
     fileText1 = file1.ReadLine()
     //     Replaces the text matching the specified date/time format with <ignore>
            var res = patt.exec(fileText1);
            if (res!=null)
            {
           newText1 = fileText1.replace(res[0], "<ignore>")
                   
           }
           else
           {
            newText1=fileText1
           } 
           newText1 = aqString.ToLower(newText1)
           if (aqString.GetLength(aqString.Trim(newText1))> 0)  
           {
                  aqFile.WriteToTextFile(actRepFilePath + "Temp\\ActtempFile.txt", newText1, aqFile.ctANSI, false)
                  aqFile.WriteToTextFile(actRepFilePath + "Temp\\ActtempFile.txt", "\n", aqFile.ctANSI, false)
                 
                  
           }
     }
     while (!file1.AtEndOfStream );
            
 //     ' Reads the second text file
      file2 = fso.OpenTextFile(expRepFilePath + fileName2, ForReading)
     
     do
     {
      fileText2 = file2.ReadLine()
           
//           ' Replaces the text matching the specified date/time format with <ignore>
           var res = patt.exec(fileText2);
            if (res!=null)
            {
           newText2 = fileText2.replace(res[0], "<ignore>")
                   
           }
            else
           {
            newText2=fileText2
           } 
           newText2 = aqString.ToLower(newText2)
           
           if (aqString.GetLength(aqString.Trim(newText2))> 0)  
           {
                  aqFile.WriteToTextFile(expRepFilePath + "Temp\\ExptempFile.txt", newText2, aqFile.ctANSI, false)
                  aqFile.WriteToTextFile(expRepFilePath + "Temp\\ExptempFile.txt","\n" , aqFile.ctANSI, false)
           }
     }
     while (!file2.AtEndOfStream );
        
      regEx = null
      fso = null
      file1 = null
      file2 = null
     
}


/*===============================================================================
Description: This function to compare files
Parameters: 
            fileName1:
            fileName2:
Return Value: 
=================================================================================*/

//'Compares the two text files
function CompareFiles(fileName1,fileName2)
{
      var fso, file1, file2, regEx
      var fileText1, fileText2, newText1, newText2
      var ForReading = 1
      fileMatched = true
      var expRepFilePath = Project.Variables.expRepFilePath
      var actRepFilePath = Project.Variables.actRepFilePath
      
//      'Creating the Temp file
      CreateTempFile(fileName1,fileName2)
      
      fso = Sys.OleObject("Scripting.FileSystemObject")
      objFile1 = fso.OpenTextFile(expRepFilePath + "Temp\\ExptempFile.txt", ForReading)
      objFile2 = fso.OpenTextFile(actRepFilePath + "Temp\\ActtempFile.txt", ForReading)

//      Checking if files are empty
       objFSO = Sys.OleObject("Scripting.FileSystemObject")
       objF1 = objFSO.GetFile(expRepFilePath + "Temp\\ExptempFile.txt")
       objF2 = objFSO.GetFile(actRepFilePath + "Temp\\ActtempFile.txt")
      
      var exitMainLoop = false
      if ((objF1.Size  != 0) && (objF2.Size  != 0))
      {
      do
      { 
            objFile1Line = objFile1.ReadLine()
            
            do
            {  
                  objFile2Line = objFile2.ReadLine()
                  if (aqString.Compare(objFile1Line,objFile2Line,false) == 0) 
                  {
                        break
                  }
                   else 
                  {
                      Log.Message("exp file:"+objFile1Line)
                      Log.Message("act file:"+objFile2Line)
                      fileMatched = false
                      break
                              
                   }
                
                  
            }while(!objFile2.AtEndOfStream)
            
            
      }while(!objFile1.AtEndOfStream)

  }
  
      if (fileMatched)
      {
        Log.Message("File is Matching")
        return true
      }
      else
      {
        Log.Message("File is not Matching")
        return false
      }
      
       fso = null
       exitMainLoop = null
       fileMatched  = null
       objFSO = null
       objF1 = null
       objF2 = null
}
