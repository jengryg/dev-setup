<#
    .SYNOPSIS
    Runs the installation process.

    .DESCRIPTION
    This script is the main entry point for the setup process.
    Running this script will orchestrate the setup step by step and configure the system.

    .PARAMETER DeleteBeforeInstall
    If this switch is enabled, the setup will delete directories containing configurations and also unregister the
    Ubuntu distribution without making any backups. This switch is only meant to be used when developing/debugging
    this setup repository.
#>
param(
    [Switch]$DeleteBeforeInstall = $false
)

# To avoid issues with the ~ shortcut, we obtain the users home directory path and store it for later use.
$windowsUserHome = Resolve-Path ~

# By default, all scripts will work with the .dev-setup subdirectory in the $windowsUserHome directory.
$setupPath = "$windowsUserHome\.dev-setup"

# Additional directories we use for configuration purposes in the users home directory on windows.
$dotDockerPath = "$windowsUserHome\.docker"

if ($DeleteBeforeInstall)
{
    Remove-Item -Recurse -Force $setupPath
    Remove-Item -Recurse -Force $dotDockerPath
    Remove-Item -Recurse -Force "$windowsUserHome\.testcontainers.properties"
    wsl --unregister Ubuntu-24.04
}

if (Test-Path $setupPath)
{
    throw "Directory $setupPath already exists. Aborting to prevent conflicts."
}

Write-Host "Creating $setupPath directory."
[Void](New-Item -Path $setupPath -ItemType Directory)

# copy the script for the environment setup in wsl
[Void](New-Item -Path "$setupPath\wsl" -ItemType Directory)
Copy-Item -Path "$PSScriptRoot\wsl\*" -Destination "$setupPath\wsl\" -Recurse

# create the self signed certificates for the docker daemon https connections
[Void](New-Item -Path "$setupPath\docker-ssl" -ItemType Directory)
& $PSScriptRoot\ssl\localhost\generate-ssl-localhost.ps1 -out "$setupPath\docker-ssl"

# copy configuration script and files for docker daemon
[Void](New-Item -Path "$setupPath\docker" -ItemType Directory)
Copy-Item -Path "$PSScriptRoot\docker\*" -Destination "$setupPath\docker\" -Recurse

# copy the testcontainers configuration files
Copy-Item -Path "$PSScriptRoot\docker\config\.testcontainers.properties" -Destination "$windowsUserHome\.testcontainers.properties"

# copy the ssl files for docker client and rename them such that it works with testcontainers
[Void](New-Item -Path "$windowsUserHome\.docker" -ItemType Directory)
[Void](New-Item -Path "$windowsUserHome\.docker\testcontainers" -ItemType Directory)
Copy-Item -Path "$setupPath\docker-ssl\ca.pem" -Destination "$dotDockerPath\testcontainers\ca.pem"
Copy-Item -Path "$setupPath\docker-ssl\client-key.pem" -Destination "$dotDockerPath\testcontainers\key.pem"
Copy-Item -Path "$setupPath\docker-ssl\client-cert.pem" -Destination "$dotDockerPath\testcontainers\cert.pem"

# copy the configuration script and files for k8s kind cluster
[Void](New-Item -Path "$setupPath\k8s-kind" -ItemType Directory)
Copy-Item -Path "$PSScriptRoot\k8s-kind\*" -Destination "$setupPath\k8s-kind\" -Recurse

# initialzie the wsl with ubuntu and cloud init configuration.
& $PSScriptRoot\wsl\setup-wsl-cloud-init-config.ps1