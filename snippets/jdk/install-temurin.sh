# This script installs temurin jdk on ubuntu.

# Add the Eclipse Adoptium GPG key
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo apt-key add -

# Add the Eclipse Adoptium apt repository
echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list

sudo apt update -y

# install the jdk versions
sudo apt install temurin-17-jdk
sudo apt install temurin-21-jdk

# optional: configure the default version
# sudo update-alternatives --config java