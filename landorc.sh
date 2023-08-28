#! /bin/sh

if [ -d /etc/lando/system.d ]; then
  # Source sh scripts in /etc/lando/system.d
  for i in /etc/lando/system.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
 
  # Source the bash scripts in /etc/lando/system.d if LANDO_SHELL is bash.
  if [ "$LANDO_SHELL" = "bash" ]; then
    echo "Sourcing bash scripts in /etc/lando/system.d"
    for i in /etc/lando/system.d/*.bash; do
      if [ -r $i ]; then
        . $i
      fi
    done
    unset i
  fi
fi