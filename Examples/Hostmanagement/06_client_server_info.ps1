# Server und Client version
docker version

# Formatieren als JSON
docker version --format '{{json .}}'

# Server version
docker version --format '{{.Server.Version}}'

# Client version
docker -v
