Viele Wege führen nach Rom.
Viele Möglichkeiten hat man, um Docker auf Windows und Linux zu installieren.

1. Installation einer Linux-VM in HyperV und VirtualBox
2. Installation einer nativen Docker Engine und manuelles Verdrahten des Clients
3. Benutzung von docker-machine

Known Issues
* Der normale Shutdown funktioniert nicht. Stattdessen muss man vagrant halt --force aufrufen.
https://github.com/mitchellh/vagrant/issues/778
* floppy_dir and floppy_files can not hold bigger files in Windows Nano Server and end up in being corrupt.
* Installation of updates is mandatory
* Increase boot_time to 18m + so the provisioner of packer can be used
* Certificates are created by OpenSSL
* License key must be entered in the Autounattend.xml