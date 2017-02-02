Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Microsoft.PowerShell.Utility\Microsoft.PowerShell.Utility.psd1
Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Microsoft.PowerShell.Management\Microsoft.PowerShell.Management.psd1
Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Storage\Storage.psd1

start-transcript -path $env:temp\transcript1.txt -noclobber

Dism.exe /online /Cleanup-Image /StartComponentCleanup /ResetBase

Optimize-Volume -DriveLetter C

schtasks /delete /tn "Postinstall" /f
net start winrm