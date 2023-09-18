Cross OS Testing
================

Testing different Linux distros installing bash.

Start up tests
--------------

Run the following commands to get up and running with this example.

```bash
# Should start up successfully
cp ../../lash.sh .
cp ../../boot.sh .
cp ../../env.detect.sh .
cp ../../log.sh .
lando poweroff
lando start
```

Verification commands
---------------------

```bash
# Should have lash 
lando ssh -s debianbash -c "whereis lash" | grep "bin/lash"
lando ssh -s debian-no-bash -c "whereis lash" | grep "bin/lash"
# lando ssh -s archlinux -c "whereis lash" | grep "bin/lash"
# lando ssh -s alpine -c "whereis lash" | grep "bin/lash"
# lando ssh -s fedora -c "whereis lash" | grep "bin/lash"
# lando ssh -s centos -c "whereis lash" | grep "bin/lash"
```

```bash
# Should link lash to correct shell
lando ssh -s debianbash -c "bash --version" | grep "GNU bash"
lando ssh -s debian-no-bash -c "bash --version" | grep "executable file not found"
```

```bash
# # Should have htop on all OSs
# lando ssh -s debian -c "htop"
# lando ssh -s archlinux -c "htop"
# lando ssh -s alpine -c "htop"
# lando ssh -s fedora -c "htop"
# lando ssh -s centos -c "htop"
```

Destroy tests
-------------

Run the following commands to trash this app like nothing ever happened.

```bash
# Should be destroyed with success
lando destroy -y
lando poweroff
```