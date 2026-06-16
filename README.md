<p align="center">
  <h1 align="center">
    SecMachine Build for CTFs / Red Teaming
  </h1>
</p>

This repository contains Ansible tasks to automate the setup of my personal pentesting environment.

## Installation

```bash
# Install Ansible
sudo apt install ansible -y

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

Credits to [IppSec’s parrot-build](https://github.com/IppSec/parrot-build) for the original concept and structure.

## Compatibility

* Kali Linux (rolling)

## Stability
This setup is actively maintained and updated by me. If you encounter any issues when trying to run the playbook, you can try to read the error messages and fix them yourself. Otherwise, feel free to open an issue and I will try to help you out.