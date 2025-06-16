#!/bin/bash

# get the path to the mounted user directory from windows
windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"
caFile="$setupPath/docker-ssl/ca.pem"

# add the ca certificate to system truststore as dev-setup-ca.crt
# we just change the file extension via rename here, no further conversion from pem needed
sudo cp "$caFile" "/usr/local/share/ca-certificates/dev-setup-ca.crt"
sudo update-ca-certificates

echo "Verify that this script added our certificate, should display dev-setup-ca.pem as search result."

sudo ls /etc/ssl/certs/ | grep dev-setup

echo "Search for first line of encoded certificate of $caFile in /etc/ssl/certs/ca-certificates.crt"
echo ""

searchFor=$(sed -n 2,2p "$caFile")

echo "Should display the line of the certificate starting with M:"
sudo fgrep "$searchFor" /etc/ssl/certs/ca-certificates.crt
echo "Should display the count of occurrences, we expect 1 here:"
sudo fgrep -c "$searchFor" /etc/ssl/certs/ca-certificates.crt