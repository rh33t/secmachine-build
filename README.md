## Quick Start

Automate the setup of my personal pentesting environment with Ansible.

```bash
sudo apt install ansible -y
ansible-galaxy collection install community.general
make setup
sudo reboot
````

Run specific tags:

```bash
ansible-playbook playbook.yml --tags <tag_name> --ask-become-pass
```

## Requirements

* Kali Linux (rolling)
* 1 GB+ free in `/tmp`

Inspired by [IppSec's parrot-build](https://github.com/IppSec/parrot-build).