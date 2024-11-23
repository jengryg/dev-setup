#!/bin/sh

windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
kubePath="$windowsUserHome/.kube"

# move the config to the windows user directory to make the cluster directly available in windows
sudo mv ~/.kube/config "$kubePath"