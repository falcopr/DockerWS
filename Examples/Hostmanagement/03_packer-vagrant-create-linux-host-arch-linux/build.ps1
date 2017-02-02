# Building a arch linux machine
# https://github.com/kaorimatz/packer-templates

# Packer Windows Inbound Firewall
# https://github.com/taliesins/packer-baseboxes/issues/1
# https://github.com/taliesins/packer-baseboxes/issues/2
# Get-NetFirewallRule -name *pack* | Set-NetFirewallRule -Profile Private, Public, Domain -Enabled True -Action Allow

# Hyper-V-Setup
# Erstellen eines Switches namens "internal_switch" für Internes Netzwerk
# Erstellung eines beliebigen externen Switches
# Sharing der Internet Connection vom externen Switch zum "internal_switch" (danach ist das http-Problem behoben)
# http://www.thomasmaurer.ch/2015/11/hyper-v-virtual-switch-using-nat-configuration/
# http://www.hurryupandwait.io/blog/creating-windows-base-images-for-virtualbox-and-hyper-v-using-packer-boxstarter-and-vagrant

$HOSTNAME = "myarchlinuxcontainerhost"
$HOSTDIR = "myarchlinuxhost"


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
}

function Build {
    $sw = [Diagnostics.Stopwatch]::StartNew()
    packer build -only virtualbox-iso template.json
	# packer build -parallel=false template.json -only hyperv-iso
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
    vagrant box add .\archlinux-x86_64-virtualbox.box --name $HOSTNAME
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