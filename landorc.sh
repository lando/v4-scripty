#! /bin/sh

# Source /etc/lando/lash.d/001-env-detect.sh

if [ -d /etc/lando/lash.d ]; then
  # Source sh scripts in /etc/lando/lash.d
  for i in /etc/lando/lash.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
 
  # Source the bash scripts in /etc/lando/lash.d if LANDO_SHELL is bash.
  if [ "$LANDO_SHELL" = "bash" ]; then
    echo "Sourcing bash scripts in /etc/lando/lash.d"
    for i in /etc/lando/lash.d/*.bash; do
      if [ -r $i ]; then
        . $i
      fi
    done
    unset i
  fi
fi

echo "Ran landorc.sh"