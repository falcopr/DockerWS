# Virtual Box Installation
# Prerequisite ist Chocolatey
# https://chocolatey.org
function InstallForVBox {
    choco install virtualbox docker docker-machine docker-compose
    RefreshEnv.cmd
    docker-machine create --driver virtualbox mylinuxcontainerhost
    docker-machine env | Invoke-Expression
}

# Hyper-V Installation
# Installation von Docker für Windows
# Danach folgende Argumente eingeben
function InstallForHyperV {
    docker-machine create --driver hyperv mylinuxcontainerhost
    docker-machine env | Invoke-Expression
}

# Manuelle Installation auf einem Windows Server 2016 oder Windows 10 Enterprise Edition
# https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/configure-docker-daemon
function InstallForWindowsOnly {
    # Get latest version and install into program files
    $version = (Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/docker/docker/master/VERSION).Content.Trim()
    Invoke-WebRequest "https://master.dockerproject.org/windows/amd64/docker-$($version).zip" -OutFile "$env:TEMP\docker.zip" -UseBasicParsing
    Expand-Archive -Path "$env:TEMP\docker.zip" -DestinationPath $env:ProgramFiles

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
    Copy-Item daemon.json C:\ProgramData\docker\config
    # Start
    dockerd --register-service
    Start-Service Docker
}

function CreatingServerAndClientKeysAndCertficates {
    
    # Creating self-signed certificates
    # http://nocture.dk/2016/10/26/access-docker-registry-with-self-signed-certificate-on-windows-server-2016/
    # https://blog.kloud.com.au/2016/06/12/creating-openssl-self-signed-certs-on-windows/
    # https://msdn.microsoft.com/en-us/library/ms733813(v=vs.110).aspx

    # https://docs.docker.com/engine/security/https/
    # https://docs.docker.com/engine/security/certificates/
    # bash ... sudo apt-get install openssl    
}

function ConfigureClient {
    $HOSTN="mywindowscontainerhost"
    $Env:DOCKER_TLS_VERIFY = "1"
    $Env:DOCKER_CERT_PATH = (resolve-path .).Path + "\certs"
    # Adresse und Port, auf dem die Docker Engine lauscht
    $Env:DOCKER_HOST = "tcp://127.0.0.1:2376"
    # Setzen des Namens der Docker-Machine, zu dem sich der Docker Client verbinden soll
    $Env:DOCKER_MACHINE_NAME = "$HOSTN"
}

InstallForWindowsOnly
#CreatingServerAndClientKeysAndCertficates
#ConfigureClient