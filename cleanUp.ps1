# cleanUp.ps1

# < SYPNOSIS > 
# This script was created to attempt to speed windows by rebuilding search index, deleting temp/prefetch files, and disabling super fetch service (SysMain). 
# Created by: Nelson Orellana
# Created on: Nov 8th, 2022

# Note:
# Important You may need to restart your device after running.

#write2log func
Start-Transcript -Append proc_$env:computername.log
# Display current free space.
Get-CimInstance -ClassName Win32_LogicalDisk | where caption -eq "C:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) GB Total, $('{0:N2}' -f ($_.FreeSpace/1gb)) GB free "}

#Auto delete any and all temp files.
cleanmgr /sagerun

# stop, and disable SysMain, or otherwise known as SuperFetch
sc config "SysMain" start= disabled
sc stop "SysMain"

# reset online sync with oneDrive
%localappdata%\Microsoft\OneDrive\onedrive.exe /reset 
# after this script is done running, via the bat file the windows search index will be rebuilt and delete all prefetch files.
Stop-Transcript
