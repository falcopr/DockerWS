# Save single image
docker save -o microsoft_iis.tar microsoft/iis
docker save -o node.tar node

# Save all images
docker save -o all_images.tar $(docker images -q)