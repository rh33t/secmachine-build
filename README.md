## Why this playbook?

I regularly use disposable pentesting VMs. This playbook automates the setup I would otherwise repeat manually: tools, desktop configuration, terminal environment, and dotfiles.

> [!WARNING]
> Run this only on a brand-new Kali Linux or Parrot Security 7.x HTB Edition VM.
> The playbook changes system packages and personal configuration. Take a VM
> snapshot before running it so you can easily roll back.

Kali rolling and Parrot Security 7.x HTB Edition are supported with XFCE or
MATE. The distribution and desktop session are detected automatically.

## Setup

```bash
sudo apt install -y ansible
ansible-galaxy collection install community.general
make setup
sudo reboot
```

To run only part of the setup, use an Ansible tag:

```bash
ansible-playbook playbook.yml --tags terminal --ask-become-pass
```

Useful tags include `system`, `tools`, `terminal`, `desktop`, `applications`,
`dotfiles`, `docker`, `golang`, `nvim`, `xfce`, and `mate`.

Common options are in `group_vars/all.yml`. Desktop detection can be overridden
for one run:

```bash
ansible-playbook playbook.yml -e desktop_environment=mate --ask-become-pass
```

Inspired by [IppSec's parrot-build](https://github.com/IppSec/parrot-build).
