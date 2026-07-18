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

# Create a convenient Tabby command when the AppImage exists
if [ -f "$HOME/apps/tabby.appimage" ]; then
    chmod +x "$HOME/apps/tabby.appimage"

    mkdir -p "$HOME/.local/bin"

    ln -sf "$HOME/apps/tabby.appimage" "$HOME/.local/bin/tabby"

    echo "Tabby command installed."
else
    echo "Tabby AppImage not found at $HOME/apps/tabby.appimage"
fi

echo "Done."
echo "Run: source ~/.bashrc"
