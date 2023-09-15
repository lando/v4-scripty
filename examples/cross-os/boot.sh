#! /bin/sh

# Default sh shell information
SH_LOCATION=$(which sh)
export LANDO_SHELL="sh"
export LANDO_SHELL_PATH=$SH_LOCATION

# See if bash exists
if [ -x "$(command -v bash)" ]; then
    echo "Bash found."
    # @todo: do we really want the bash at the top of PATH?
    BASH_LOCATION=$(which bash)
    export LANDO_SHELL="bash"
    export LANDO_SHELL_PATH=$BASH_LOCATION
  else
    echo "Bash not found, trying to install."
    #exec /etc/lando/bash-install.sh
fi

# Run /etc/lando/boot.d scripts
if [ -d /etc/lando/boot.d ]; then
  echo "Running /etc/lando/boot.d scripts"
  # Execute sh scripts in /etc/lando/boot.d
  for i in /etc/lando/boot.d/*.sh; do
    if [ -r $i ]; then
        . $i
    fi
  done
  unset i
 
  # Execute the bash scripts in /etc/lando/boot.d if LANDO_SHELL is bash.
  echo "LANDO_SHELL: $LANDO_SHELL"
  if [ "$LANDO_SHELL" = "bash" ]; then
    echo "Sourcing bash scripts in /etc/lando/boot.d"
    for i in /etc/lando/boot.d/*.bash; do
      if [ -r $i ]; then
        . $i
      fi
    done
    unset i
  fi
fi

# Add LANDO_SHELL to the environment
echo "export LANDO_SHELL=\"$LANDO_SHELL\"" >> /etc/lando/environment.sh
echo "Ran boot.sh"