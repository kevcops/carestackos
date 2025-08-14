#!/usr/bin/env bash
set -euo pipefail
APP_NAME="CareStack"
APP_URL="${CARESTACK_URL:-https://app.carestack.com}"
LAUNCHER="/usr/share/applications/CareStack.desktop"
ICON="/usr/share/icons/hicolor/512x512/apps/carestack.png"

sudo tee "$LAUNCHER" >/dev/null <<EOF
[Desktop Entry]
Name=${APP_NAME}
Comment=Launch ${APP_NAME} in app mode
Exec=/usr/libexec/carestack/launch-carestack.sh
Terminal=false
Type=Application
Icon=carestack
Categories=Office;Network;Medical;
StartupWMClass=CareStack
EOF

# Install launcher script
sudo install -Dm755 /dev/stdin /usr/libexec/carestack/launch-carestack.sh <<'EOS'
#!/usr/bin/env bash
set -euo pipefail
APP_URL="${CARESTACK_URL:-https://app.carestack.com}"
PROFILE_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/carestack-chromium-profile"
mkdir -p "$PROFILE_DIR"
if flatpak info org.chromium.Chromium >/dev/null 2>&1; then
  exec flatpak run --branch=stable org.chromium.Chromium     --class=CareStack --name=CareStack --app="$APP_URL"     --user-data-dir="$PROFILE_DIR" --no-first-run --disable-features=Translate
fi
for c in chromium chromium-browser brave google-chrome-stable; do
  if command -v "$c" >/dev/null 2>&1; then
    exec "$c" --class=CareStack --name=CareStack --app="$APP_URL"       --user-data-dir="$PROFILE_DIR" --no-first-run --disable-features=Translate
  fi
done
echo "No Chromium-based browser found. Please install org.chromium.Chromium from Flathub."
exit 1
EOS

# Icon fallback
if [ ! -f "$ICON" ] && [ -f /usr/share/pixmaps/carestack.png ]; then
  sudo install -Dm644 /usr/share/pixmaps/carestack.png "$ICON" || true
fi

echo "CareStack Chromium wrapper installed."
