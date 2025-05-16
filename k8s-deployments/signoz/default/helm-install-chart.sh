helm repo add signoz https://charts.signoz.io
helm -n signoz --create-namespace install "signoz-default" signoz/signoz