# Installieren eines boot2docker Images als Container Host
# https://github.com/mitchellh/boot2docker-vagrant-box
# https://github.com/segmentio/boot2docker

$HOSTNAME = "mylinuxcontainerhost"
$HOSTDIR = "mylinuxhost"

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
}

function Build {
    $sw = [Diagnostics.Stopwatch]::StartNew()
    packer build -parallel=false packer_template.json
    $sw.Stop()
    $sw.Elapsed
}

function SetupClient {
    # Authentifizierung eines Servers über ein Zertifikat 
    $Env:DOCKER_TLS_VERIFY = "1"
    $Env:DOCKER_CERT_PATH = (resolve-path .).Path + "\tls"
    # Adresse und Port, auf dem die Docker Engine lauscht
    $Env:DOCKER_HOST = "tcp://127.0.0.1:2376"
    # Setzen des Namens der Docker-Machine, zu dem sich der Docker Client verbinden soll
    $Env:DOCKER_MACHINE_NAME = "$HOSTNAME"
}

function RegisterAndStart {
    vagrant box add .\boot2docker_virtualbox.box --name $HOSTNAME
    mkdir $HOSTDIR
    Set-Location $HOSTDIR
    vagrant init $HOSTNAME
    mkdir tls
    Copy-Item ../Vagrantfile .
    vagrant up
}


Clean
Build
RegisterAndStart
SetupClient