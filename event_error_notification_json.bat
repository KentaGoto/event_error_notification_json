@echo off

setlocal

rem Exporting system event errors to json
wmic ntevent where "(logfile='system' and timegenerated >= '%DATE:/=%' and (EventType='1' or EventType='2'))" list /format:"%~dp0json.xsl" > "%~dp0%COMPUTERNAME%_%DATE:/=%_sys.json"

rem Exporting application event errors to json
wmic ntevent where "(logfile='application' and timegenerated >= '%DATE:/=%' and (EventType='1' or EventType='2'))" list /format:"%~dp0json.xsl" > "%~dp0%COMPUTERNAME%_%DATE:/=%_app.json"

echo Complete!
echo Each log is written to %~dp0%

endlocal
