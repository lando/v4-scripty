1. lando-boot.sh to environment.sh
2. Set ENV/BASH_ENV to those files
3. Load all appropriate scripts for sh/bash using those files
   1. Source .sh files immediately
   2. Switch shell
   3. Source .bash files -> could use the default /etc/profile loop

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

if [ -x "$(command -v bash)" ]; then
  if [ -d /etc/profile.d ]; then
    for i in /etc/profile.d/*.bash; do
      if [ -r $i ]; then
        . $i
      fi
    done
    unset i
  fi
fi



