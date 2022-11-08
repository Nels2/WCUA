sfc /scannow
DISM.exe /Online /Cleanup-image /Scanhealth && DISM.exe /Online /Cleanup-image /Restorehealth
sfc /scannow
powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force}"
powershell -command "& {Unblock-File -Path C:\WCUA\cleanUp.ps1}"
powershell -File C:\WCUA\cleanUp.ps1
@echo off
call :tempDel >> C:\WCUA\%ComputerName%.log
call :wSearchRebuild >> C:\WCUA\%ComputerName%.log
call :wsearch >> C:\WCUA\%ComputerName%.log

GOTO :END

:tempDel
del C:\Windows\prefetch\*.*/s /q
%localappdata%\Microsoft\OneDrive\onedrive.exe /reset 
EXIT /B

:wSearchRebuild
echo "Stopping wsearch..."
net stop wsearch 
echo "Deleting Windows.edb so we can re-launch wsearch..."
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
EXIT /B

:wsearch
echo "Starting wsearch..."
net start wsearch
EXIT /B

:END
powershell -command "& {Unblock-File -Path C:\WCUA\finalHard.ps1}" 
powershell -File C:\WCUA\finalHard.ps1 
