#!/bin/bash
source /home/fearreece/Desktop/automation/.env

DockerFileName="/home/fearreece/Desktop/automation/$DOCKERFILENAME"


if [[ -f $DockerFileName ]]
then
    echo "Dockerfile exists"
else
    ##create the file
    sleep 2
    echo "Creating Dockerfile..."
    sleep 2
    touch $DockerFileName
    echo $DockerFileName "File created..."

    ##write to the file
    echo "Writing to the Dockerfile..."
    sleep 2
    echo "FROM nginx:1-alpine-slim" >> $DockerFileName
    echo "COPY . /usr/share/nginx/html" >> $DockerFileName
    echo "WORKDIR /usr/share/nginx/html" >> $DockerFileName
    # echo "RUN addgroup -S appgroup && adduser -S appuser -G appgroup" >> $DockerFileName
    # echo "RUN chown -R appuser:appgroup /usr/share/nginx/html" >> $DockerFileName
    # echo "USER appuser" >> $DockerFileName
    echo "EXPOSE 80" >> $DockerFileName
    echo "Building image...."
    
fi

docker build -t $APP_NAME:$BUILD_VERSION .

# docker build --provenance=true --sbom=true -t $APP_NAME:$BUILD_VERSION .

## remove previously running Docker container
echo "Stopping any previuosly running container ... Please wait..."
sleep 2
docker stop $DOCKERCONTAINER_NAME

echo "Running basic cleanups ..."
sleep 2
docker rm -f $DOCKERCONTAINER_NAME

echo "Running your container ... ---------------------------"
docker run -d -p $APP_PORT:80 --name $DOCKERCONTAINER_NAME $APP_NAME:$BUILD_VERSION 

docker push fearreece/simple-web-app:$BUILD_VERSION
