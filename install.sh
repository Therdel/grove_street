#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

already_exists() {
    local path="$1"
    [[ -e "$path" || -L "$path" ]]  # -L catches broken symlinks that -e misses
}

backup_and_link() {
    local link="${1/#\~/$HOME}"
    local dotfile="$2"

    if already_exists "$link"; then
        echo "backing up $link to ${link}.bak"
        mv "$link" "${link}.bak"
    fi

    echo "creating symlink $link -> $dotfile"
    ln -s "$dotfile" "$link"
}

backup_and_link ~/.bashrc "$SCRIPT_DIR/.bashrc"
backup_and_link ~/.vimrc "$SCRIPT_DIR/.vimrc"
