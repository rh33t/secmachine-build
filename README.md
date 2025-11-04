# Parrot Machine Build

This repository contains Ansible tasks to automate the setup of my pentesting environment on Parrot OS.

## Installation
```bash
# Install Ansible from pip because Parrot's apt version is outdated
sudo apt remove ansible pipx -y
sudo python3 -m pip install pipx ansible --break-system-packages

# Run setup
make setup
# Run specific tags
ansible-playbook playbook.yml --tags <tag_name> --ask-become-pass
```
## Troubleshooting

**GDB conflicts:** Use backports to install GDB from debian bookworm-backports
```bash
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update && sudo apt install -t bookworm-backports gdb
```

**Requirements:** Minimum 1GB free in `/tmp` for builds