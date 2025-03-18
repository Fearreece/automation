#!/bin/bash
source .env

DockerFileName=$DOCKERFILENAME


if [[ -f $DockerFileName ]]
then
    echo "Dockerfile exists"
else
    ##create the file
    sleep 2
    echo "Creating Dockerfile..."
    sleep 2
    touch $DockerFileName
    echo "Dockerfile created"
    echo $DockerFileName "File created..."

    ##write to the file
    echo "Writing to the Dockerfile..."
    sleep 2
    echo "FROM nginx:alpine" >> $DockerFileName
    echo "COPY . /usr/share/nginx/html" >> $DockerFileName
    echo "WORKDIR /usr/share/nginx/html" >> $DockerFileName
    echo "EXPOSE 80" >> $DockerFileName
    echo "Building image...."
    
fi

docker build -t $APP_NAME:$BUILD_VERSION .

## remove previously running Docker container
echo "Stopping any previuosly running container ... Please wait..."
sleep 2
docker stop $APP_NAME 

echo "Running basic cleanups ..."
sleep 2
docker rm -f $APP_NAME

echo "Running your container ... ---------------------------"
docker run -d -p $APP_PORT:80 --name $APP_NAME $APP_NAME:$BUILD_VERSION 

# then
#     echo "image build successful"
# else
#     echo "image build failed"
# fi
