#!/bin/sh

windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
kubePath="$windowsUserHome/.kube/"

# ensure that the directory exists
mkdir -p "$kubePath"

# copy the config to the windows user directory to make the cluster directly available in windows too
sudo cp ~/.kube/config "$kubePath"