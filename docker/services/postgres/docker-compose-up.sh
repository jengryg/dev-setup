#!/bin/sh

mkdir -p pg-data
sudo chmod -R a+rwx pg-data

# shellcheck disable=SC2046
docker compose -f docker-compose.yml up --build --detach