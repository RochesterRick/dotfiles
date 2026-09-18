#!/usr/bin/env bash
set -e

REPO="https://github.com/RochesterRick/dotfiles.git"
DOT="$HOME/dotfiles"
STAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/.terminal-backup-$STAMP"

echo "Installing Rick's terminal setup..."

# Get/update repo
if [ -d "$DOT/.git" ]; then
    git -C "$DOT" pull
else
    git clone "$REPO" "$DOT"
fi

# Backup anything we're about to replace
mkdir -p "$BACKUP"

for file in \
    "$HOME/.bashrc" \
    "$HOME/.bash_profile" \
    "$HOME/.config/starship.toml" \
    "$HOME/.config/konsolerc"
do
    if [ -f "$file" ]; then
        cp --parents "$file" "$BACKUP" 2>/dev/null || true
    fi
done

# Shell
cp "$DOT/.bashrc" "$HOME/.bashrc"
cp "$DOT/.bash_profile" "$HOME/.bash_profile"

# Starship / Fastfetch
mkdir -p "$HOME/.config/fastfetch"
cp "$DOT/.config/starship.toml" "$HOME/.config/starship.toml"
cp "$DOT/.config/fastfetch/config.jsonc" \
   "$HOME/.config/fastfetch/config.jsonc"

# Konsole configuration, when Konsole is installed
if command -v konsole >/dev/null 2>&1; then
    mkdir -p "$HOME/.local/share/konsole"

    cp "$DOT/.config/konsolerc" \
       "$HOME/.config/konsolerc"

    cp "$DOT/.local/share/konsole/Profile 1.profile" \
       "$HOME/.local/share/konsole/Profile 1.profile"

    echo "Konsole configuration installed."
else
    echo "Konsole not installed; skipping Konsole configuration."
fi

echo
echo "Terminal configuration installed."
echo "Backup: $BACKUP"
echo
echo "Open a new terminal to activate it."
