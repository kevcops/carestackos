#!/usr/bin/env bash
set -euo pipefail
# Placeholder for future theming hooks
install -Dm644 /usr/share/backgrounds/carestack/wallpaper-default.jpg /usr/share/backgrounds/carestack/wallpaper-default.jpg || true
mkdir -p /usr/share/carestack
echo "WALLPAPER=/usr/share/backgrounds/carestack/wallpaper-default.jpg" > /usr/share/carestack/theme.env
