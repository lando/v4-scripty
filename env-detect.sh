
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
}

# See if the detected package manager is operational
check_package_manager() {
  PACKAGE_MANAGER=$1
  echo $PACKAGE_MANAGER
  if command -v $PACKAGE_MANAGER &> /dev/null
  then
      echo "$PACKAGE_MANAGER found."
  else
      echo "Error: $PACKAGE_MANAGER could not be found."
      exit 1
  fi
}

# Run appropriate install command depending on package manager.
run_install() {
  PROGRAM=$1
  get_distro
  echo $DISTRO $PROGRAM
  find_package_manager $DISTRO
  # @Todo: handle different package managers options
  cmd='"$PACKAGE_MANAGER" update && "$PACKAGE_MANAGER" -y install "$PROGRAM"'
  check_package_manager $PACKAGE_MANAGER && eval $cmd
}

DISTRO=get_distro
BASE_DISTRO=get_base_distro
PACKAGE_MANAGER=find_package_manager $DISTRO

# Export values as environment variables
export BASE_DISTRO="$BASE_DISTRO"
export DISTRO="$DISTRO"
export PACKAGE_MANAGER="$PACKAGE_MANAGER"
export FUN="ontheranch"

echo "Ran env-detect.sh"