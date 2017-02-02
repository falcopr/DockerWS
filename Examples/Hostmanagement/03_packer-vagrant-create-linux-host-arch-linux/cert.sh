#!/bin/bash
mkdir certs
cd certs
HOSTN="mywindowscontainerhost"
# CA private key
openssl genrsa -aes256 -out ca-key.pem 4096
# CA Certificate
openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem -subj "/CN=$HOSTN/O=My Company Name LTD./C=DE"
# Server private key
openssl genrsa -out server-key.pem 4096
# Server public key (certificate signing request)
openssl req -subj "/CN=$HOSTN" -sha256 -new -key server-key.pem -out server.csr
# Certificate by signing the public key with the ca
echo "subjectAltName = DNS:$HOSTN,IP:127.0.0.1" > extfile.cnf
openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile extfile.cnf
# Client key and certificate signing request (Authentication)
openssl genrsa -out key.pem 4096
openssl req -subj '/CN=client' -new -key key.pem -out client.csr
# # Client public key signing for getting the certificate
openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out cert.pem -extfile extfile.cnf
echo "extendedKeyUsage = clientAuth" > extfile.cnf
# Client files ($Env:DOCKER_CERT_PATH)
# mkdir client
# cp ca.pem cert.pem key.pem client
# Server files (C:\ProgramData\Docker\certs.d)
# mkdir server
# cp ca.pem server-cert.pem server-key.pem server
cd ../
exit