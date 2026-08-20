@echo off
setlocal EnableExtensions DisableDelayedExpansion
cd /d "%~dp0"

set "OUTPUT=remote-access-governance-merged.jar"
set "EXPECTED_SHA256=08488d81cbfa74ca22b46f8e67448dead3c399c42fe38f395e8edf00fdf7fadc"

echo Merging JAR parts...
copy /b /y "remote-access-governance.jar.part-000"+"remote-access-governance.jar.part-001"+"remote-access-governance.jar.part-002"+"remote-access-governance.jar.part-003"+"remote-access-governance.jar.part-004" "%OUTPUT%" >nul
if errorlevel 1 (
  echo Merge failed. Confirm that all five part files are in this folder.
  exit /b 1
)

set "ACTUAL_SHA256="
for /f "tokens=1" %%H in ('certutil -hashfile "%OUTPUT%" SHA256 ^| findstr /R /I "^[0-9A-F][0-9A-F]"') do set "ACTUAL_SHA256=%%H"

echo.
echo Output: %CD%\%OUTPUT%
echo SHA-256: %ACTUAL_SHA256%
if /I not "%ACTUAL_SHA256%"=="%EXPECTED_SHA256%" (
  echo Verification failed. Do not run the merged JAR.
  exit /b 1
)

echo Verification passed.
echo Run with: java -jar "%OUTPUT%"
pause
