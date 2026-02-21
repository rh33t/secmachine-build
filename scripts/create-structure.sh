#!/bin/bash
set -uo pipefail

WORKDIR="${HACKING_LAB:-$HOME/work}"

DIRECTORIES=(
  "pentests/clients"
  "pentests/internal"
  "tools/built"
  "tools/custom"
  "tools/utils"
  "training/boxes"
  "training/labs"
  "training/challenges"
  "wordlists"
  "configs/vpn"
  "configs/ssh"
  "configs/clipboard"
  "docs/templates"
  "reports"
  "archive"
)

echo "[+] Creating lab structure in: $WORKDIR"

for dir in "${DIRECTORIES[@]}"; do
  mkdir -p "$WORKDIR/$dir"
done

echo "[+] Done: $WORKDIR"

