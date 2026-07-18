#!/bin/bash
set -e

REPO="https://github.com/RochesterRick/dotfiles.git"
DOT="$HOME/dotfiles"

echo "Installing Rick's dotfiles..."

if [ -d "$DOT/.git" ]; then
    cd "$DOT"
    git pull
else
    git clone "$REPO" "$DOT"
fi

cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$(date +%Y%m%d-%H%M%S)" 2>/dev/null || true

cp "$DOT/.bashrc" "$HOME/"
cp "$DOT/.profile" "$HOME/" 2>/dev/null || true
cp "$DOT/.gitconfig" "$HOME/" 2>/dev/null || true

mkdir -p "$HOME/.config"
cp -r "$DOT/.config/"* "$HOME/.config/" 2>/dev/null || true

if command -v dconf >/dev/null && [ -f "$DOT/dconf-settings.conf" ]; then
    dconf load / < "$DOT/dconf-settings.conf"
fi

mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/share/applications"
cp -a "$DOT/.local-share-applications/." "$HOME/.local/share/applications/" 2>/dev/null || true

echo "Done."
echo "Run: source ~/.bashrc"
