#!/bin/bash

windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"

# The pem file of CA cert to import.
caCert="$setupPath/docker-ssl/ca.pem"

# Print the content of the pem file to check that the cert is there.
echo "CA certificate for import is:"
cat "$caCert"
echo; echo;

# Find all cacerts keystores in the jvm directory (there should be one for each java distribution installed here)
# Import the certificate into each one of them. Note: This will first delete
sudo find /usr/lib/jvm -name 'cacerts' -exec bash -c '
  echo "Trying to import the CA cert from $1 into the keystore: $2";
  echo;
  cd $(dirname $2);
  echo "Delete the alias, this may report and error if the alias does not exist...";
  sudo keytool -delete -cacerts -storepass changeit -alias custom_root_ca_for_local_development;
  echo;
  echo "Import certificate...";
  sudo keytool -import -trustcacerts -cacerts -storepass changeit -noprompt -alias custom_root_ca_for_local_development -file "$1";
  echo; echo;
' _ "$caCert" {} \;