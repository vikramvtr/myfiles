@Echo Off
REM ************************************************
REM Import GP and Practice Data
REM 	Set parameters below
REM ************************************************

set "ServerName=BLR-PG00UXHM-L"
set "sql_login=eCoverAdmin"
set "sql_passwd=Ax!msm1le"

echo Please ensure target database has been backed up.
pause

echo Importing, please wait...
echo.

bcp [OdysseyStandalone3.10ENGB].[dbo].[GP] in Data\GPData.dat -f FormatFiles\GPFormat.xml -S"%ServerName%" -U"%sql_login%" -P"%sql_passwd%" -h TABLOCK -E -o GPImportReport.txt
bcp [OdysseyStandalone3.10ENGB].[dbo].[Practice] in Data\PracticeData.dat -f FormatFiles\PracticeFormat.xml -S"%ServerName%" -U"%sql_login%" -P"%sql_passwd%" -h TABLOCK -E -o PracticeImportReport.txt


echo Data imported. Please check the Output file for results.
pause


