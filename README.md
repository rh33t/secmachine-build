## Why this playbook?

I regularly use disposable pentesting VMs. This playbook automates the setup I would otherwise repeat manually: tools, desktop configuration, terminal environment, and dotfiles.

> [!WARNING]
> Run this only on a brand-new Kali Linux or Parrot Security 7.x HTB Edition VM.
> The playbook changes system packages and personal configuration. Take a VM
> snapshot before running it so you can easily roll back.

Kali rolling and Parrot Security 7.x HTB Edition are supported with XFCE or
MATE. The distribution and desktop session are detected automatically.

An i3 session is available as an opt-in alternative: it installs i3, polybar,
dunst, i3lock and maim, deploys the matching configs, and writes the GTK theme
to `~/.config/gtk-3.0/settings.ini` since i3 runs no xsettings daemon. A fresh
VM has no i3 to detect, so it has to be requested explicitly, either in
`group_vars/all.yml` or for one run:

```bash
ansible-playbook playbook.yml -e desktop_environment=i3 --ask-become-pass
```

Log out and pick the i3 session at the login screen. The i3 and polybar
keybindings mirror the XFCE ones, except that workspaces move to `Super+1..0`
and `Super+Shift+1..0`.

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
`dotfiles`, `docker`, `golang`, `nvim`, `xfce`, `mate`, and `i3`.

Common options are in `group_vars/all.yml`. Desktop detection can be overridden
for one run:

```bash
ansible-playbook playbook.yml -e desktop_environment=mate --ask-become-pass
```

Inspired by [IppSec's parrot-build](https://github.com/IppSec/parrot-build). The
i3 window rules and the polybar launcher follow
[Arszilla's i3-dotfiles](https://gitlab.com/arszilla/i3-dotfiles) (MIT).
