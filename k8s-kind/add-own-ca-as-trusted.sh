#!/bin/bash

# get the path to the mounted user directory from windows
windowsUserHome="$(wslpath "$(wslvar USERPROFILE)")"
setupPath="$windowsUserHome/.dev-setup"
caFile="$setupPath/docker-ssl/ca.pem"

# based on https://stackoverflow.com/a/62981618 and https://stackoverflow.com/a/72216347

# create a secret containing the certificate
kubectl create secret generic registry-ca \
    --namespace kube-system \
    --from-file=registry-ca="$caFile"

# use a DaemonSet to mount the certificate as file, copy it to the destination,
# update the truststore and restart containerd
kubectl create -f "$setupPath/k8s-kind/add-own-ca-as-trusted.yaml"