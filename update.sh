#!/bin/bash
set -e

DOT="$HOME/dotfiles"

echo "Updating dotfiles..."

# Core
cp "$HOME/.bashrc" "$DOT/"
cp "$HOME/.profile" "$DOT/" 2>/dev/null || true
cp "$HOME/.gitconfig" "$DOT/" 2>/dev/null || true

# Cinnamon settings
dconf dump / > "$DOT/dconf-settings.conf"

# Selected configs
rm -rf "$DOT/.config"
mkdir -p "$DOT/.config"

cp -r "$HOME/.config/tilix" "$DOT/.config/" 2>/dev/null || true
cp -r "$HOME/.config/cinnamon" "$DOT/.config/" 2>/dev/null || true

# Launchers
rm -rf "$DOT/.local-share-applications"
cp -r "$HOME/.local/share/applications" "$DOT/.local-share-applications" 2>/dev/null || true

# Git push
cd "$DOT"
git add .
git commit -m "Update dotfiles" || true
git push

echo "Done."
