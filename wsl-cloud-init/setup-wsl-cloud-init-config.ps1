$cloudInitConfigDir = "$PSScriptRoot\.cloud-init"

# ensure the ~\.cloud-init directory exists
If(Test-Path "~\.cloud-init") {
    Write-Host "Found .cloud-init dir in users home directory."
} else {
    Write-Host "Create .cloud-init dir in users home directory."
    [Void](New-Item -Path "~\.cloud-init" -ItemType directory)
}

# copy the cloud init config to the users home directory
Write-Host "Copying .cloud-init config from $cloudInitConfigDir to users home directory."
Copy-Item -Path "$cloudInitConfigDir\*" -Destination "~\.cloud-init\" -Recurse

# ensure that Ubuntu-24.04 is available, use web-download instead of microsoft store and prevent direct launch
Write-Host "Running Ubuntu web download no launch install."
wsl --install --web-download --no-launch -d Ubuntu-24.04

# use distro launcher but do not create a user, use root instead, cloud-init creates our user
Write-Host "Installing Ubuntu."
ubuntu2404.exe install --root

Write-Host "Waiting for cloud-init to finish."
# watch cloud-init setup
ubuntu2404.exe run cloud-init status --wait --long

# terminate the running instance
Write-Host "Installation complete. Shutting down Ubuntu."
wsl -t Ubuntu-24.04

# restart the instance
ubuntu2404.exe