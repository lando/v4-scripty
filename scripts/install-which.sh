#! /bin/sh

install_which() {
  . /etc/lando/env-detect.sh
  # @todo: break out run_install into a separate script.
  # 1. Check for prerequisites (package manager exists)
  # 2. Install bash
  # 3. Verify installation
  {
    run_install "which" && echo "which installed."
  } || {
    echo "Could not install which."
    exit 0
  }

  # Verify bash command exists and runs
  {
    # print location of bash
    which "which" | grep "which"
  } || {
    echo "which is not working."
    exit 0
  }
}

