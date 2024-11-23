# Personal Dev Setup for Windows with WSL Ubuntu

This repository contains documentation and (partial) automation for my personal dev setup.

## Usage

````PowerShell
# on windows
run-install.ps1

# when complete continue inside the wsl
cd "$(wslpath "$(wslvar USERPROFILE)")/.dev-setup"
./wsl/setup-environment-in-wsl.sh 

# finalize the windows setup

````