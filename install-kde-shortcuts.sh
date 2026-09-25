#!/usr/bin/env bash

FILE="$HOME/.config/kglobalshortcutsrc"

if grep -q '^\[services\]\[net.local.spectacle.desktop\]' "$FILE"; then
    sed -i '/^\[services\]\[net.local.spectacle.desktop\]/,/^\[/ {
        s/^_launch=.*/_launch=Alt+Print/
    }' "$FILE"
    echo "Alt+PrintScreen screenshot shortcut installed."
    echo "Log out and back in to activate it."
else
    echo "Custom Spectacle action not found."
    echo "Create 'Active Window Screenshot' using: spectacle -a -c -b"
fi
