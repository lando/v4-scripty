#! /bin/lash

lando_blue "Running groupmap.sh"

map_group() {
  DEFAULT_GROUP=$1
  HOST_GID=$2
  lando_green "Mapping group $DEFAULT_GROUP to host group GID $HOST_GID."
  # @todo: ask Mike if using -o is ok.
  groupmod -o -g $HOST_GID $DEFAULT_GROUP
  # Check to see if the $DEFAULT_GROUP now has GID $HOST_GID
  if [ $(getent group $DEFAULT_GROUP | cut -d: -f3) -eq $HOST_GID ]; then
    lando_green "Group $DEFAULT_GROUP successfully mapped to host group GID $HOST_GID."
  else
    lando_red "Group $DEFAULT_GROUP was not successfully mapped to host group GID $HOST_GID."
  fi
}

verify_groupmod() {
  if [ ! -x "$(command -v groupmod)" ]; then
    lando_yellow "groupmod not found."
    return 1;
  fi

  return 0;
}

install_groupmod() {
  lando_green "Installing groupmod."
  install_dep "groupmod" verify_groupmod
}

groupmap() {
  # If verify_groupmod fails, then install groupmod
  if ! verify_groupmod; then
    install_groupmod
  fi
  map_group $1 $2
}

groupmap $1 $2
