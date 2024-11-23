#!/bin/sh
# See https://kind.sigs.k8s.io/docs/user/quick-start/

# For AMD64 / x86_64
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.23.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind