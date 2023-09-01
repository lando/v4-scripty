#! /bin/sh

# Default sh shell information
SH_LOCATION=$(which sh)
cp $SH_LOCATION /bin/lash
export LANDO_SHELL="sh"
export LANDO_SHELL_PATH=$SH_LOCATION

# See if bash exists
if [ -x "$(command -v bash)" ]; then
    echo "Bash found."
    # @todo: do we really want the bash at the top of PATH?
    BASH_LOCATION=$(which bash)
    # Make bash default by copying over sh
    cp $BASH_LOCATION /bin/lash
    export LANDO_SHELL="bash"
    export LANDO_SHELL_PATH=$BASH_LOCATION
  else
    echo "Bash not found, trying to install."
    exec /etc/lando/bash-install.sh
fi

# Run /etc/lando/boot.d scripts
if [ -d /etc/lando/boot.d ]; then
  # Execute sh scripts in /etc/lando/boot.d
  for i in /etc/lando/boot.d/*.sh; do
    if [ -r $i ]; then
        exec $i
    fi
  done
  unset i
 
  # Execute the bash scripts in /etc/lando/boot.d if LANDO_SHELL is bash.
  if [ "$LANDO_SHELL" = "bash" ]; then
    echo "Sourcing bash scripts in /etc/lando/boot.d"
    for i in /etc/lando/boot.d/*.bash; do
      if [ -r $i ]; then
        exec $i
      fi
    done
    unset i
  fi
fi

echo "Ran boot.sh"