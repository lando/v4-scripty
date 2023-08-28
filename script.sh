
# Path to the os-release file
OS_RELEASE_FILE="/etc/os-release"

# Check if the os-release file exists
if [ ! -f "$OS_RELEASE_FILE" ]; then
    echo "Error: $OS_RELEASE_FILE not found."
    exit 1
fi

# Parse specific values from os-release
DISTRO=$(grep -E '^ID=' $OS_RELEASE_FILE | cut -d '=' -f 2 | tr -d '"')
BASE_DISTRO=$(grep -E '^ID_LIKE=' $OS_RELEASE_FILE | cut -d '=' -f 2 | tr -d '"')


# Find correct package manger based on DISTRO
case $DISTRO in
  manjaro|arch)
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

# Export values as environment variables
export BASE_DISTRO="$BASE_DISTRO"
export DISTRO="$DISTRO"
export PACKAGE_MANAGER="$PACKAGE_MANAGER"
export FUN="ontheranch"