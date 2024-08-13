#!/bin/bash

# create the volume for the portainer database
docker volume create portainer_data

# download and install the portainer container with docker
docker run -d -p 8000:8000 \
              -p 9443:9443 \
              --name portainer \
              --restart=always \
              -v /var/run/docker.sock:/var/run/docker.sock \
              -v portainer_data:/data \
              portainer/portainer-ce:latest