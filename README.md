# Personal Dev Setup for Windows with WSL Ubuntu

This repository contains documentation and (partial) automation for my personal dev setup.

## Credentials

The following credential data must be created before the setup script can be run.

````shell
# create the credentials for the docker container registry
docker/services/registry/auth/create-account.sh
# create the credentials file for the postgres database container
docker/services/postgres/.ignore.env
````

## Installation

````PowerShell
# on windows
run-install.ps1

# when complete continue inside the wsl
cd "$( wslpath "$( wslvar USERPROFILE )" )/.dev-setup"
./wsl/setup-environment-in-wsl.sh
````

### Configure Portainer

Use https://localhost:9443 to go to the portainer instance in your browser on Windows to check if it works.
Follow the setup of portainer to complete it. If not completed shortly after setup, a security mechanism will trigger,
and you have to restart portainer in docker to be able to set it up.

### Configure Docker in IntelliJ

Use IntelliJ docker configuration and point the docker integration to the wsl installation using the WSL option with the
corresponding distribution.
See https://www.jetbrains.com/help/idea/docker.html#connect_to_docker for more information.

Alternatively, but recommended anymore: Use the TCP socket with https.

* Connection Type: `TCP SOCKET`
* Host: `https://localhost:2376`
* Certificates: `<WINDOWS USER HOME>\.docker\testcontainers`

Note: The certificates were generated and stored in the directory during the setup. The docker daemon is configured
with the corresponding certificates automatically.

## Recommended Developer Tools on Windows

Create a directory, e.g. `<WINDOWS USER HOME>\.dev-tools` and add this directory to your PATH variable.
Download the Windows binary and place it in the directory. Remember to rename them to the tool name if the binaries have
additional components in their name for the specific OS and Architecture.

* kubectl https://kubernetes.io/releases/download/
* helm https://github.com/helm/helm/releases
* jq https://github.com/jqlang/jq/releases/
* yq https://github.com/mikefarah/yq/releases
* oras https://github.com/oras-project/oras/releases

## Further recommended Tools

* inkscape https://inkscape.org/release
* ghostscript https://www.ghostscript.com/releases/gsdnld.html

## Docker Services

The `docker/services` directory provides simple docker compose definitions for local services that are usually needed.
Run the included docker-compose-up.sh scripts inside their corresponding directory in the wsl.