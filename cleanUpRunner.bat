powershell -command "& {Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force}"
powershell -command "& {Unblock-File -Path cleanUp.ps1}"
powershell -File cleanUp.ps1
@echo off
>proc_$env:computername.log (
del C:\Windows\prefetch\*.*/s /q 
net stop wsearch
del "%ProgramData%\Microsoft\Search\Data\Applications\Windows\Windows.edb"
:wsearch
net start wsearch
IF NOT %ERRORLEVEL%==0 (goto :wsearch) ELSE goto :END
:END
powershell -command "& {Unblock-File -Path finalHard.ps1}"
powershell -File finalHard.ps1
)
