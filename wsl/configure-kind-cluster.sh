#!/bin/sh

windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"

for bashScript in "$setupPath/k8s-kind/add-own-ca-as-trusted.sh" \
                  "$setupPath/k8s-kind/registry-auth-setup.sh"
do
  dos2unix "$bashScript"
  # no sudo here, we need the kubeconfig from the user in wsl
  "$bashScript"
done
