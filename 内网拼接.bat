@echo off
setlocal
pushd "%~dp0"

if not exist department-status-tracker.jar.part-a goto missing
if not exist department-status-tracker.jar.part-b goto missing
if not exist department-status-tracker.jar.part-c goto missing
if not exist department-status-tracker.jar.part-d goto missing

copy /b /y department-status-tracker.jar.part-a+department-status-tracker.jar.part-b+department-status-tracker.jar.part-c+department-status-tracker.jar.part-d department-status-tracker.jar >nul
if errorlevel 1 goto failed

echo Reassembly completed: department-status-tracker.jar
echo.
echo Expected SHA-256:
echo 5fff27544fbe259c3ceb51ee323da5a08a2f01c0a1d4b193372d8b5c04c9aa25
echo.
echo Actual SHA-256:
certutil -hashfile department-status-tracker.jar SHA256
echo.
echo If both values match, run:
echo java -jar department-status-tracker.jar
goto success

:missing
echo ERROR: One or more part files are missing.
echo Keep this script and all four part files in the same folder.
goto error

:failed
echo ERROR: Reassembly failed.
goto error

:success
popd
pause
exit /b 0

:error
popd
pause
exit /b 1
