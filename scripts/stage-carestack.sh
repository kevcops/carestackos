#!/usr/bin/env bash
set -euo pipefail

# Placeholder for future theming hooks; ensure wallpaper env exists
install -d /usr/share/carestack
echo "WALLPAPER=/usr/share/backgrounds/carestack/wallpaper-default.jpg" > /usr/share/carestack/theme.env
