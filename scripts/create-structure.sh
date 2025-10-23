#!/bin/bash
set -euo pipefail

# Hacking Lab Directory Structure Creator
readonly SCRIPT_NAME="$(basename "$0")"
readonly WORKDIR="${HACKING_LAB:-$HOME/work}"

# Directory structure definition
readonly DIRECTORIES=(
    "pentests/clients"
    "pentests/internal"
    "tools/built"
    "tools/custom"
    "tools/utils"
    "training/boxes"
    "training/labs"
    "training/challenges"
    "wordlists"
    "configs"
    "configs/vpn"
    "configs/ssh"
    "configs/clipboard"
    "docs/templates"
    "reports"
    "archive"
)

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m'

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*" >&2
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

validate_workdir() {
    if [[ -z "$WORKDIR" ]]; then
        log_error "WORKDIR is empty"
        exit 1
    fi
    
    if [[ "$WORKDIR" == "/" ]]; then
        log_error "WORKDIR cannot be root directory"
        exit 1
    fi
}

create_directories() {
    local created=0
    local existed=0
    local failed=0
    
    for dir in "${DIRECTORIES[@]}"; do
        local full_path="$WORKDIR/$dir"
        
        if [[ -d "$full_path" ]]; then
            ((existed++))
        else
            if mkdir -p "$full_path" 2>/dev/null; then
                ((created++))
            else
                log_error "Failed to create: $full_path"
                ((failed++))
            fi
        fi
    done
    
    log_info "Structure creation complete:"
    log_info "  Created: $created directories"
    log_info "  Existed: $existed directories"
    [[ $failed -gt 0 ]] && log_error "  Failed: $failed directories"
    
    return $failed
}

main() {
    validate_workdir

    log_info "Creating lab structure in: $WORKDIR"

    if create_directories; then
        log_info "Directory structure ready at: $WORKDIR"
        exit 0
    else
        log_error "Structure creation failed"
        exit 1
    fi
}

main "$@"