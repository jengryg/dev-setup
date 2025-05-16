start powershell {
    $Host.UI.RawUI.WindowTitle = '8080:8080 signoz UI'
    kubectl -n signoz port-forward service/signoz-default 8080:8080
}

start powershell {
    $Host.UI.RawUI.WindowTitle = '4317:4317 otel collector'
    kubectl -n signoz port-forward service/signoz-default-otel-collector 4317:4317
}

start powershell {
    $Host.UI.RawUI.WindowTitle = '4318:4318 otel collector'
    kubectl -n signoz port-forward service/signoz-default-otel-collector 4318:4318
}