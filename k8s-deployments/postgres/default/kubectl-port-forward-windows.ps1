start powershell {
    $Host.UI.RawUI.WindowTitle = '5433:5432 postgres'
    kubectl -n postgres port-forward service/postgres-default 5433:5432
}