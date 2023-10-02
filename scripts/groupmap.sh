#! /bin/lash

loginfo "Running groupmap.sh"

map_group() {
  DEFAULT_GROUP=$1
  HOST_GID=$2
  logsuccess "Mapping group $DEFAULT_GROUP to host group GID $HOST_GID."
  # @todo: ask Mike if using -o is ok.
  groupmod -o -g $HOST_GID $DEFAULT_GROUP
  # Check to see if the $DEFAULT_GROUP now has GID $HOST_GID
  if [ $(getent group $DEFAULT_GROUP | cut -d: -f3) -eq $HOST_GID ]; then
    logsuccess "Group $DEFAULT_GROUP successfully mapped to host group GID $HOST_GID."
  else
    logexit "Group $DEFAULT_GROUP was not successfully mapped to host group GID $HOST_GID."
  fi
}

verify_groupmod() {
  if [ ! -x "$(command -v groupmod)" ]; then
    logwarning "groupmod not found."
    return 1;
  fi

  return 0;
}

install_groupmod() {
  logsuccess "Installing groupmod."
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
