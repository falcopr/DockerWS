# Konfiguration des Docker Clients
# Authentifizierung eines Servers über ein Zertifikat 
$Env:DOCKER_TLS_VERIFY = "1"
$Env:DOCKER_CERT_PATH = "C:\Users\PrescherFa\.docker\machine\machines\default"
# Adresse und Port, auf dem die Docker Engine lauscht
$Env:DOCKER_HOST = "tcp://192.168.99.100:2376"
# Setzen des Namens der Docker-Machine, zu dem sich der Docker Client verbinden soll
$Env:DOCKER_MACHINE_NAME = "mylinuxcontainerhost"
