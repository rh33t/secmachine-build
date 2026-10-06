#!/bin/bash
set -uo pipefail

WORKDIR="${HACKING_LAB:-$HOME/work}"

DIRECTORIES=(
  "engagements"
  "projects"
  "tools/bin"
  "tools/vendor"
  "tools/arsenal"
  "training/boxes"
  "training/labs"
  "training/challenges"
  "resources/wordlists"
  "resources/docs"
  "configs/vpn"
  "configs/burpsuite"
  "configs/clipboard"
  "configs/secrets/ssh"
  "configs/secrets/tls"
  "configs/secrets/android"
  "configs/secrets/licenses"
  "archive"
)

echo "[+] Creating lab structure in: $WORKDIR"

for dir in "${DIRECTORIES[@]}"; do
  mkdir -p "$WORKDIR/$dir"
done

echo "[+] Done: $WORKDIR"
