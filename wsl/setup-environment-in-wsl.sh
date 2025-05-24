#!/bin/sh

windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"

for bashScript in "$setupPath/docker/install-docker.sh" \
                  "$setupPath/docker/run-portainer-in-docker.sh" \
                  "$setupPath/docker/services/postgres/docker-compose-up.sh" \
                  "$setupPath/docker/services/registry/docker-compose-up.sh" \
                  "$setupPath/k8s-kind/install-kubectl-from-binaries.sh" \
                  "$setupPath/k8s-kind/install-kind-from-binaries.sh" \
                  "$setupPath/k8s-kind/k8s-kind-with-registry.sh" \
                  "$setupPath/k8s-kind/create-kube-config.sh" \
                  "$setupPath/k8s-kind/expose-kind-on-windows.sh"
do
  dos2unix "$bashScript"
  sudo "$bashScript"
done