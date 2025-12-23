<p align="center">
  <h1 align="center">
    SecMachine Build for CTFs / Red Teaming
  </h1>
</p>

This repository contains Ansible tasks to automate the setup of my personal pentesting environment.

## Installation

```bash
# Remove distro Ansible and pipx
sudo apt remove ansible pipx -y

# Install latest Ansible via pipx
sudo python3 -m pip install pipx ansible --break-system-packages

# Install required Ansible collection
ansible-galaxy collection install community.general

# Run full setup
make setup
# and then reboot
systemctl reboot

# Run specific tags
ansible-playbook playbook.yml --tags <tag_name> --ask-become-pass
```

**Requirements:** At least 1 GB of free space in `/tmp` (used during builds).

This project is inspired by [IppSec’s parrot-build](https://github.com/IppSec/parrot-build), which provided the original concept and structure.

## Compatibility

* Initially used on Parrot OS (6.4)
* Currently used as my main setup on Kali Linux (rolling)

## Stability
This setup is actively maintained and updated by me. If you encounter any issues when trying to run the playbook, you can try to read the error messages and fix them yourself. Otherwise, feel free to open an issue and I will try to help you out.