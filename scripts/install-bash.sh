#!/bin/sh

# @todo: try to install bash...will need to run /etc/lando/env-detect.sh
. /etc/lando/install-dep.sh
echo $PACKAGE_MANAGER
# @todo: break out run_install into a separate script.
# 1. Check for prerequisites (package manager exists)
# 2. Install bash
# 3. Verify installation
{
  install_dep "bash" && echo "Bash installed."
} || {
  echo "Could not install bash, will continue using sh"
  exit 0
}

# Verify bash command exists and runs
{
  # print location of bash
  bash -c "echo 'Bash is working'"
} || {
  echo "Bash is not working, will continue using sh"
  exit 0
}

# @todo: do we really want the bash at the top of PATH?
BASH_LOCATION=$(which bash)
# Make bash default by copying over sh
cp $BASH_LOCATION /bin/lash
export LANDO_SHELL="bash"
export LANDO_SHELL_PATH=$BASH_LOCATION

echo "Ran bash-install.sh"