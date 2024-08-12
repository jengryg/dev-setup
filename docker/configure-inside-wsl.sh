#!/bin/bash

# get the path to the mounted user directory from windows
windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"

# ensure the configuration directory for the daemon exists
mkdir -p /etc/docker

# copy the configuration files
cp "$setupPath/docker/config/daemon.json" "/etc/docker/daemon.json"

# ensure that the ssl directory exists
mkdir -p /etc/docker/ssl

# copy the ssl files
cp "$setupPath/docker-ssl/ca.pem" "/etc/docker/ssl/ca.pem"
cp "$setupPath/docker-ssl/server-cert.pem" "/etc/docker/ssl/server-cert.pem"
cp "$setupPath/docker-ssl/server-key.pem" "/etc/docker/ssl/server-key.pem"