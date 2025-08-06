start powershell {
    $Host.UI.RawUI.WindowTitle = '9000:443 argocd'
    kubectl  -n argocd port-forward svc/argocd-server 9000:443
}