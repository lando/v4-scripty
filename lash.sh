#! /bin/sh

# Source /etc/lando/environment.sh
. /etc/lando/environment.sh
# @todo: Add logic so we can use /bin/lash as our triggering logic
# 1. Parse arguments to determine if -c is being used as first argument or a file
# 2. Set working directory to the directory of the file being run
# 3. Add sourcing logic to temp file (. /etc/lando/landorc.sh)
# 4. Dump the command string or file contents to a temporary file (if not using -c, check to see if the command references a file)

# If bash is the LANDO_SHELL, run the provided command
if [ "$LANDO_SHELL" = "bash" ]; then
  echo "Running bash command"
  exec bash -e $@
fi

# If sh is the LANDO_SHELL and the shell is non-interactive, run the provided command
if [ "$LANDO_SHELL" = "sh" ] && [ ! -t 0 ]; then
  echo "Running non-interactive sh command"
  . /etc/lando/landorc.sh
  exec sh -e $@
fi