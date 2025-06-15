#!/bin/sh
echo "Enter version in SemVer format to install."
read -r VERSION
URL="https://github.com/oras-project/oras/releases/download/v${VERSION}/oras_${VERSION}_linux_amd64.tar.gz"
echo "Installing oras registry client $VERSION from $URL"
curl -LO "$URL"
mkdir -p oras-install/
tar -zxf oras_"${VERSION}"_*.tar.gz -C oras-install/
sudo mv oras-install/oras /usr/local/bin/
rm -rf oras_"${VERSION}"_*.tar.gz oras-install/