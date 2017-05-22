docker run --rm -it --entrypoint "/bin/bash" --name mydebian "debian/falco:0.1"
docker exec -it --entrypoint "/bin/bash" --name mydebian "debian/falco:0.1"
#docker run -d --name mydebian "debian/falco:0.1"