#! /bin/lash

lando_blue "Running usermap.sh"
# Verify usermod exists
verify_usermod() {
  if [ ! -x "$(command -v usermod)" ]; then
    lando_yellow "usermod not found."
    return 1;
  fi

  return 0;
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
  # Check to see if $DEFAULT_USER now has UID $HOST_UID
  if [ $(id -u $DEFAULT_USER) -eq $HOST_UID ]; then
    lando_green "User $DEFAULT_USER successfully mapped to host user UID $HOST_UID."
  else
    lando_red "User $DEFAULT_USER was not successfully mapped to host user UID $HOST_UID."
  fi
}

usermap() {
  # If verify_usermod fails, then install usermod
  if ! verify_usermod; then
    install_usermod
  fi
  map_user $1 $2
}

usermap $1 $2

