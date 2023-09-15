# PoC for Lando v4 Services Scripting Framework

When containers are built for a Lando service, there are certain actions that need to be scripted into the Dockerfile build. These include...

- Detecting the OS and other basic environment details
- Setting a default shell (preferably bash)
- Sourcing the Lando logger
- Mapping user permissions (host user mapping to the container)
- Generating certs/whitelisting Lando's CA

This PoC is testing scripts to perform those actions. We'll adapt these scripts into the Lando v4 services being built into Lando v3 Core.