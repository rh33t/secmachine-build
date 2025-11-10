# Parrot Machine Build

This repository contains Ansible tasks to automate the setup of my pentesting environment on Parrot OS.

## Installation
```bash
# Install Ansible from pip because Parrot's apt version is outdated
sudo apt remove ansible pipx -y
sudo python3 -m pip install pipx ansible --break-system-packages

# Install ansible community.general collection
ansible-galaxy collection install community.general

# Run setup
make setup

# Run specific tags
ansible-playbook playbook.yml --tags <tag_name> --ask-become-pass
```

**Requirements:** Minimum 1GB free in `/tmp` for builds