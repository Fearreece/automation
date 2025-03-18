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

echo "Stopping any running container..."
sleep 1.5
docker stop $APP_NAME
docker rm $APP_NAME

docker run -d -p $APP_PORT:80 $APP_NAME:$BUILD_VERSION

# then
#     echo "image build successful"
# else
#     echo "image build failed"
# fi
