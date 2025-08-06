#!/bin/sh
echo "Enter version in SemVer format with leading v to install."
read -r VERSION
URL="https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64"
echo "Installing argocd cli client $VERSION from $URL"
curl -sSL -o argocd-linux-amd64 "$URL"
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64