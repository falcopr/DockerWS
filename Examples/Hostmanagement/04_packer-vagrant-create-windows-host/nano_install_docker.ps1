# Manuelle Installation auf einem Windows Server 2016 oder Windows 10 Enterprise Edition
# https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon
function CleanUp {
    Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Microsoft.PowerShell.Utility\Microsoft.PowerShell.Utility.psd1
    Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Microsoft.PowerShell.Management\Microsoft.PowerShell.Management.psd1
    Import-Module C:\windows\system32\windowspowershell\v1.0\Modules\Storage\Storage.psd1

    # Compressing unused space by writing zeros
    $FilePath="c:\zero.tmp"
    $Volume= Get-Volume -DriveLetter C
    $ArraySize= 64kb
    $SpaceToLeave= $Volume.Size * 0.05
    $FileSize= $Volume.SizeRemaining - $SpacetoLeave
    $ZeroArray= new-object byte[]($ArraySize)
    
    $Stream= [io.File]::OpenWrite($FilePath)
    try {
    $CurFileSize = 0
        while($CurFileSize -lt $FileSize) {
            $Stream.Write($ZeroArray,0, $ZeroArray.Length)
            $CurFileSize +=$ZeroArray.Length
        }
    } finally {
        if($Stream) {
            $Stream.Close()
        }
    }
    
    Remove-Item $FilePath
}

function InstallForWindowsOnly {
    # Extract zip into program files for installation
    Expand-Archive -Path "c:\Windows\setup\docker\docker.zip" -DestinationPath $env:ProgramFiles

    # Add path to this PowerShell session immediately
    $dockerinstallpath = "$env:ProgramFiles\Docker"
    $env:path += ";$dockerinstallpath"

    # For persistent use after a reboot
    $existingMachinePath = [Environment]::GetEnvironmentVariable("Path",[System.EnvironmentVariableTarget]::Machine)
    [Environment]::SetEnvironmentVariable("Path", $existingMachinePath + ";$env:ProgramFiles\Docker", [EnvironmentVariableTarget]::Machine)

    # Registering Docker as a Windows Service
    mkdir c:\ProgramData\docker -ErrorAction Ignore
    mkdir c:\ProgramData\docker\config -ErrorAction Ignore
    mkdir c:\ProgramData\docker\certs.d -ErrorAction Ignore

    # Configurating
    # Move-Item c:\windows\setup\config\nano_daemon.json C:\ProgramData\docker\config\daemon.json
    # Move-Item c:\windows\setup\docker\tls\* c:\ProgramData\docker\certs.d

    # Firewall
    New-NetFirewallRule -DisplayName 'Docker Secure Port 2376' -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 2376

    # Start
    dockerd --register-service
    Start-Service Docker
}

InstallForWindowsOnly
CleanUp