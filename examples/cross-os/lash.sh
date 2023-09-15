#! /bin/sh

# Source /etc/lando/environment.sh
. /etc/lando/environment.sh

# If bash is the LANDO_SHELL, run the provided command
if [ "$LANDO_SHELL" = "bash" ]; then
  echo "Running bash command"
  exec bash -c "$@"
fi

# If sh is the LANDO_SHELL and the shell is non-interactive, run the provided command
if [ "$LANDO_SHELL" = "sh" ] && [ ! -t 0 ]; then
  echo "Running non-interactive sh command"
  . /etc/lando/landorc.sh
  exec sh -c "$@"
fi