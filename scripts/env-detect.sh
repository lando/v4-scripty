#! /bin/sh

# Path to the os-release file
OS_RELEASE_FILE="/etc/os-release"

# Check if the os-release file exists
if [ ! -f "$OS_RELEASE_FILE" ]; then
    echo "Error: $OS_RELEASE_FILE not found."
    exit 1
fi

# Parse specific values from os-release
get_distro(){
  DISTRO=$(grep -E '^ID=' $OS_RELEASE_FILE | cut -d '=' -f 2 | tr -d '"')
}

get_base_distro(){
  BASE_DISTRO=$(grep -E '^ID_LIKE=' $OS_RELEASE_FILE | cut -d '=' -f 2 | tr -d '"')
}

# Find correct package manger based on DISTRO
find_package_manager() {
  DISTRO=$1
  case $DISTRO in
    manjaro|arch|archarm)
      PACKAGE_MANAGER="pacman"
      ;;
    debian|ubuntu)
      PACKAGE_MANAGER="apt"
      ;;
    alpine)
      PACKAGE_MANAGER="apk"
      ;;
    fedora)
      PACKAGE_MANAGER="dnf"
      ;;
    centos)
      PACKAGE_MANAGER="yum"
      ;;
    *)
      echo "Platform not supported!"
      ;;
  esac
}

get_distro
get_base_distro
find_package_manager $DISTRO

# Export values as environment variables
export BASE_DISTRO="$BASE_DISTRO"
export DISTRO="$DISTRO"
export PACKAGE_MANAGER="$PACKAGE_MANAGER"

echo "Ran env-detect.sh"