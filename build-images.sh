#!/bin/bash

# Function to build Docker image
build_image() {
    local service_dir=$1
    local tag_name=$2
    local dockerfile_name=$3

    echo "Building Docker image for ${service_dir} with tag ${tag_name}..."

    docker build -t ${tag_name} -f ${service_dir}/${dockerfile_name} ${service_dir}

    if [ $? -eq 0 ]; then
        echo "Successfully built ${tag_name} image."
    else
        echo "Failed to build ${tag_name} image."
        exit 1
    fi
}

echo "Building images..."

build_image "config-server" "config-server-swarm" "Dockerfile"

build_image "discovery" "discovery-swarm" "Dockerfile"

build_image "api-gateway" "api-gateway-swarm" "Dockerfile-swarm"

build_image "travel-service" "travel-swarm" "Dockerfile-swarm"

build_image "user-service" "user-swarm" "Dockerfile-swarm"

echo "Finished building images"
