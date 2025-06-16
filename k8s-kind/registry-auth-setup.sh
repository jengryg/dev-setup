#!/bin/bash

# obtain username and password from user
read -r -s -p "Username: " username
read -r -s -p "Password: " password

# obtain the namespace to create the secret in
read -r -p "Namespace: " -i "default" namespace

# create a docker-registry secret for each of the host names may used
# Note: The registry is referenced internally via different aliases due to localhost restrictions in the node/host.

kubectl create secret docker-registry own-registry-1 \
    -n "$namespace" \
    --docker-server="localhost:5001" \
    --docker-username="$username" \
    --docker-password="$password" \
    --docker-email="$username@localhost"

kubectl create secret docker-registry own-registry-2 \
    -n "$namespace" \
    --docker-server="127.0.0.1:5001" \
    --docker-username="$username" \
    --docker-password="$password" \
    --docker-email="$username@localhost"

kubectl create secret docker-registry own-registry-3 \
    -n "$namespace" \
    --docker-server="localhost:5000" \
    --docker-username="$username" \
    --docker-password="$password" \
    --docker-email="$username@localhost"

kubectl create secret docker-registry own-registry-4 \
    -n "$namespace" \
    --docker-server="kind-registry:5000" \
    --docker-username="$username" \
    --docker-password="$password" \
    --docker-email="$username@localhost"