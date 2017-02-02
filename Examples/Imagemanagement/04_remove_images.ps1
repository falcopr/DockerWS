# Deleting single image
docker rmi a3d
docker rmi a3dd2dff392b
docker rmi microsoft/iis

# Deleting all images at once
docker rmi $(docker images -a -q)