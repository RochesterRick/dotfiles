#!/usr/bin/env bash
set -e

DOT="$(cd "$(dirname "$0")" && pwd)"

echo "Updating Rick's terminal backup..."

# Shell
cp "$HOME/.bashrc" "$DOT/.bashrc"
cp "$HOME/.bash_profile" "$DOT/.bash_profile"

# Starship / Fastfetch
mkdir -p "$DOT/.config/fastfetch"
cp "$HOME/.config/starship.toml" "$DOT/.config/starship.toml"
cp "$HOME/.config/fastfetch/config.jsonc" \
   "$DOT/.config/fastfetch/config.jsonc"

# Konsole
if [ -f "$HOME/.config/konsolerc" ]; then
    cp "$HOME/.config/konsolerc" "$DOT/.config/konsolerc"
fi

if [ -f "$HOME/.local/share/konsole/Profile 1.profile" ]; then
    mkdir -p "$DOT/.local/share/konsole"
    cp "$HOME/.local/share/konsole/Profile 1.profile" \
       "$DOT/.local/share/konsole/Profile 1.profile"
fi

echo
git -C "$DOT" status --short
echo
echo "Terminal backup updated."
