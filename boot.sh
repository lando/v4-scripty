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
    echo "Bash not found."
fi

