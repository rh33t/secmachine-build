# Security machine build

Automates my pentesting environment on Kali.

## What it does

- System configuration (locales, timezones, etc.)
- My Essential pentesting tools
- Go security tools - disabled by default
- Workflow tools (Neovim, Tmux, Python)
- Custom scripts for common tasks
- Automatic Burpsuite certificate installation (Firefox)
- Firefox configuration (extensions, policies)
- Dotfiles and appearance (copy mode by default, symlinks available)

## Usage

```bash
# Run full setup
make setup              
# Create directories
make create-structure   
# Check syntax
make check             
```