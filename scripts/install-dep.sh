#! /bin/sh

. /etc/lando/env-detect.sh

########################
# Verify Package Manager exists
# Arguments:
#   Package Manager to check
# Returns:
#   None
#########################
check_package_manager() {
  # Use PACKAGE_MANGER env var if available, argument if not.
  PACKAGE_MANAGER=${PACKAGE_MANAGER:-$1}
  if command -v $PACKAGE_MANAGER &> /dev/null
  then
      echo "$PACKAGE_MANAGER found."
  else
      echo "Error: $PACKAGE_MANAGER could not be found."
      exit 1
  fi
}

########################
# Create an install command for the current distro's default package manager.
# Arguments:
#   Program to install.
# Returns:
#   None
#########################
create_install_cmd() {
  PROGRAM=$1
  get_distro
  echo $DISTRO $PROGRAM
  find_package_manager $DISTRO
  # @Todo: handle different package managers options
  case $PACKAGE_MANAGER in
    pacman)
      cmd='pacman -Syu && pacman --noconfirm -S "$PROGRAM"'
      ;;
    apt)
      cmd='apt update && apt install "$PROGRAM" -y'
      ;;
    apk)
      cmd='apk update && apk add --no-cache "$PROGRAM"'
      ;;
    dnf)
      cmd='dnf -y update && dnf install -y "$PROGRAM"'
      ;;
    yum)
      cmd='yum update && yum install "$PROGRAM"'
      ;;
    *)
      echo "Platform not supported!"
      ;;
  esac
  {
      check_package_manager $PACKAGE_MANAGER && eval $cmd
      echo "Ran $cmd"
  } || {
      echo "Error: $cmd could not be run."
      exit 0
  }
}

run_install() {
  INSTALL_CMD=$1
  VERIFICATION_CMD=$2
  eval $INSTALL_CMD && eval $VERIFICATION_CMD 
}

install_dep() {
  PROGRAM=$1
  VERIFICATION_CMD=$2
  create_install_cmd $PROGRAM
  run_install $INSTALL_CMD $VERIFICATION_CMD
}