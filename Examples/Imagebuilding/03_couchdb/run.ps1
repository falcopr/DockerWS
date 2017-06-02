param([String]$command="start:container")

# $imageName = "falco/couchdb:latest"
$imageName = "falco/couchdb:latest"
$containerName = "couchdb_container"
$port=8082
$containerPortMapping="${port}:5984"

switch ($command) {
    "create:image" {
        docker build -t $imageName -f ./Dockerfile ./
    }
    "start:temp:container:interactive" {
        docker run --rm -it -p $containerPortMapping --entrypoint "/bin/sh" --name $containerName $imageName
    }
    "restart:container" {
        docker run -d -p $containerPortMapping --name $containerName $imageName
    }
    "stop:all:containers" {
        docker stop $(docker ps -a -q)
    }
    "clean:all:containers" {
        docker rm $(docker ps -a -q)
    }
    "remove:all:images" {
        docker rmi $(docker images -q)
    }
    "remove:image" {
        docker rmi $imageName
    }
    "remove:container" {
        docker rm $containerName
    }
    "stop:container" {
        docker stop $containerName
    }
    "deploy:docker" {
        ./run.ps1 "create:image"
        if($?) {
            ./run.ps1 "start:container"
        }
    }
    "start:container" {
        docker run -d -p $containerPortMapping --name $containerName -v "./data:/opt/couchdb/data" $imageName
    }
    Default {
        docker run -d -p $containerPortMapping --name $containerName -v "./data:/opt/couchdb/data" $imageName
    }
}