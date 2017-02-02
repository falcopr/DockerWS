# Packer-Skript zur Erstellung eines Windows Nano Servers
# https://github.com/mwrock/packer-templates/blob/master/vbox-nano.json
# Fertige Virtual Machine mit Vagrant nutzbar
# https://atlas.hashicorp.com/mwrock/boxes/WindowsNano/
# Skripte zur Installation von Docker auf einem Windows Nano Server
# https://github.com/StefanScherer/docker-windows-box
# Installieren eines Windows Server Container Host

$HOSTNAME = "mywindowsservercontainerhost"
$HOSTDIR = "mywindowshost"

function Clean {
    if (Test-Path $HOSTDIR) {
        Set-Location $HOSTDIR
        vagrant destroy --force
        Set-Location ..
        Remove-Item $HOSTDIR -Force -Recurse
    }
    vagrant box remove $HOSTNAME
    Get-ChildItem *.iso | Remove-Item -Force -Recurse
    Get-ChildItem *.box | Remove-Item -Force -Recurse
    Remove-Item ./certs/* -Recurse
    Remove-Item output-virtualbox-iso -Recurse
}

function Prepare {
    bash.exe -c ./cert.sh
    if (!(Test-Path nano_docker.zip)) {
        $version = (Invoke-WebRequest -UseBasicParsing https://raw.githubusercontent.com/docker/docker/master/VERSION).Content.Trim()
        Invoke-WebRequest "https://master.dockerproject.org/windows/amd64/docker-$($version).zip" -OutFile ".\nano_docker.zip" -UseBasicParsing
    }
}

function Build {
    $sw = [Diagnostics.Stopwatch]::StartNew()
    packer build -parallel=false -only virtualbox-iso template.json 
	# packer build -parallel=false -only hyperv-iso template.json 
    $sw.Stop()
    $sw.Elapsed
}

function SetupClient {
    # Authentifizierung eines Servers über ein Zertifikat 
    $Env:DOCKER_TLS_VERIFY = "1"
    $Env:DOCKER_CERT_PATH = (resolve-path ./..).Path + "\certs"
    # Adresse und Port, auf dem die Docker Engine lauscht
    $Env:DOCKER_HOST = "tcp://127.0.0.1:2376"
    # Setzen des Namens der Docker-Machine, zu dem sich der Docker Client verbinden soll
    $Env:DOCKER_MACHINE_NAME = "$HOSTNAME"
}

function RegisterAndStart {
    vagrant box add .\WindowsServer2016Nano-virtualbox.box --name $HOSTNAME
    mkdir $HOSTDIR
    Set-Location $HOSTDIR
    vagrant init $HOSTNAME
    Copy-Item ../Vagrantfile .
    vagrant up
}

Clean
Prepare
Build
RegisterAndStart
SetupClient