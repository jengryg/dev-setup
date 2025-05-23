#!/bin/sh

# get the path to the mounted user directory from windows
windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
servicesPath="$windowsUserHome/.dev-setup/docker/services"

cd "$servicesPath/registry/" || exit

mkdir -p registry-data
sudo chmod -R a+rwx registry-data

docker compose -f docker-compose.yml up --build --detach --wait