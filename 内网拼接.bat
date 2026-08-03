@echo off
setlocal
cd /d "%~dp0"

copy /y /b "department-status-tracker.jar.part-a"+"department-status-tracker.jar.part-b"+"department-status-tracker.jar.part-c"+"department-status-tracker.jar.part-d" "department-status-tracker.jar" >nul

if errorlevel 1 (
  echo 拼接失败，请确认4个分片与本脚本位于同一目录。
  pause
  exit /b 1
)

echo 拼接完成：department-status-tracker.jar
echo 正确的 SHA-256 应为：
echo 5fff27544fbe259c3ceb51ee323da5a08a2f01c0a1d4b193372d8b5c04c9aa25
echo.
certutil -hashfile "department-status-tracker.jar" SHA256
pause
endlocal
