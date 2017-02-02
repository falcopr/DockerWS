# Listing all images in the local repository
docker images

# Listing of directly used images with filter keyword
docker images | findstr iis

# Listing of all images including intermediate once
docker images -a

# Listing of all images only with GUIDs
docker images -a -q