helm repo add signoz https://charts.signoz.io
helm repo update

echo "Starting the installation of the helm chart. This window will wait until deployment is ready or timeout after 1h."
echo "Installation can take several minutes where nothing is shown in the console.."

helm install "signoz-default" signoz/signoz \
    --namespace signoz --create-namespace \
    --wait --timeout 1h