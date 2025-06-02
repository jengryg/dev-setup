# run the docker daemon in the wsl
start powershell {
    $Host.UI.RawUI.WindowTitle = 'dockerd in wsl'
    wsl sudo dockerd
}