#! /bin/sh
echo "ran landorc.sh"

if [ -d /etc/lando/lash.d ]; then
  # Source sh scripts in /etc/lando/lash.d
  for i in /etc/lando/lash.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i

 
  # Source the bash scripts in /etc/lando/lash.d if LANDO_SHELL is bash.
  if [ -x "$(command -v bash)" ]; then
    for i in /etc/lando/lash.d/*.bash; do
      if [ -r $i ]; then
        . $i
      fi
    done
    unset i
  fi
fi

