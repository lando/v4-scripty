#! /bin/bash

#. /etc/lando/lash.d/001-log.sh
lando_blue "Running usermap.sh"
# Verify usermod exists
verify_usermod() {
  if [ ! -x "$(command -v usermod)" ]; then
    lando_yellow "usermod not found."
  fi
}

# Install usermod if necessary
install_usermod() {
  lando_green "Installing usermod."
  install_dep "usermod" verify_usermod
}

# Map default container user to host user
map_user() {
  DEFAULT_USER=$1
  HOST_UID=$2
  lando_green "Mapping user $DEFAULT_USER to host user UID $HOST_UID."
  usermod -u $HOST_UID $DEFAULT_USER
}

map_user $1 $2