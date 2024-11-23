#!/bin/sh

# get kube config from kind and pipe it to file
kind get kubeconfig > ~/.kube/config

echo "created ~/.kube/config"