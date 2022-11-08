# Display current free space.
Start-Transcript -Append proc_$env:computername.log
Get-CimInstance -ClassName Win32_LogicalDisk | where caption -eq "C:" | foreach-object {write " $($_.caption) $('{0:N2}' -f ($_.Size/1gb)) GB Total, $('{0:N2}' -f ($_.FreeSpace/1gb)) GB free "}
Stop-Transcript
