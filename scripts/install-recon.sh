#!/usr/bin/env bash

set -euo pipefail

echo "[+] Checking Go installation..."
if ! command -v go &>/dev/null; then
  echo "Go is not installed."
  exit 1
fi

echo "[+] Installing ProjectDiscovery tools..."
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
go install -v github.com/projectdiscovery/katana/cmd/katana@latest

echo "[+] Installing URL discovery tools..."
go install -v github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/tomnomnom/waybackurls@latest

echo "[+] Installing fuzzing & helpers..."
go install -v github.com/ffuf/ffuf/v2@latest
go install -v github.com/tomnomnom/anew@latest
go install -v github.com/tomnomnom/gf@latest

echo "[+] Updating nuclei templates..."
nuclei -update-templates || true

echo "[+] Installation complete."
