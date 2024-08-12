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

if ($DeleteBeforeInstall)
{
    Remove-Item -Recurse -Force $setupPath
    wsl --unregister Ubuntu-24.04
}

if (Test-Path $setupPath)
{
    throw "Directory $setupPath already exists. Aborting to prevent conflicts."
}

Write-Host "Creating $setupPath directory."
[Void](New-Item -Path $setupPath -ItemType Directory)

# create the self signed certificates for the docker daemon https connections
[Void](New-Item -Path "$setupPath\docker-ssl" -ItemType Directory)
& $PSScriptRoot\ssl\localhost\generate-ssl-localhost.ps1 -out "$setupPath\docker-ssl"

# copy configuration script and files for docker daemon
[Void](New-Item -Path "$setupPath\docker" -ItemType Directory)
Copy-Item -Path "$PSScriptRoot\docker\*" -Destination "$setupPath\docker\" -Recurse

# initialzie the wsl with ubuntu and cloud init configuration.
& $PSScriptRoot\wsl-cloud-init/setup-wsl-cloud-init-config.ps1