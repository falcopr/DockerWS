# Regenerate certificates for host and client
docker-machine regenerate-certs linuxhost

# Start, stop & restart server
docker-machine start linuxhost
docker-machine stop linuxhost
docker-machine restart linuxhost

# Setting up docker client
docker-machine env linuxhost | Invoke-Expression