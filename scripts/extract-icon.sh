#!/bin/bash
# ── extract-icon.sh ───────────────────────────────────────────────────────────
# Download a macOS app (DMG or ZIP), extract its icon, and save as a
# resized PNG ready to embed in the README.
#
# Usage:
#   ./scripts/extract-icon.sh <url> <output-name> [size]
#
# Arguments:
#   url          Direct download link (.dmg or .zip)
#   output-name  Filename slug saved to resources/icons/ (e.g. istat-menus)
#   size         Output size in px, default 64
#
# Examples:
#   ./scripts/extract-icon.sh "https://example.com/App.dmg" "my-app"
#   ./scripts/extract-icon.sh "https://example.com/App.zip" "my-app" 128
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

URL="${1:-}"
NAME="${2:-}"
SIZE="${3:-128}"

ICONS_DIR="resources/icons"
TMP=$(mktemp -d)
MOUNT_POINT=""

# ── Cleanup on exit ───────────────────────────────────────────────────────────
cleanup() {
  if [[ -n "$MOUNT_POINT" && -d "$MOUNT_POINT" ]]; then
    hdiutil detach "$MOUNT_POINT" -quiet -force 2>/dev/null || true
  fi
  rm -rf "$TMP"
}
trap cleanup EXIT

# ── Helpers ───────────────────────────────────────────────────────────────────
err()  { echo "✗ $*" >&2; exit 1; }
info() { echo "  $*"; }
step() { echo "→ $*"; }

# ── Validate args ─────────────────────────────────────────────────────────────
[[ -z "$URL"  ]] && err "Missing url argument.\nUsage: $0 <url> <output-name> [size]"
[[ -z "$NAME" ]] && err "Missing output-name argument.\nUsage: $0 <url> <output-name> [size]"

mkdir -p "$ICONS_DIR"

# ── 1. Download ───────────────────────────────────────────────────────────────
DOWNLOAD="$TMP/download"
step "Downloading $(basename "$URL") …"
curl -L --silent --show-error --fail \
     --retry 3 --retry-delay 2 \
     -o "$DOWNLOAD" "$URL" || err "Download failed: $URL"

# ── 2. Detect format and extract .app ────────────────────────────────────────
APP_PATH=""

is_dmg() {
  hdiutil imageinfo "$1" &>/dev/null
}

is_zip() {
  unzip -t "$1" &>/dev/null
}

if is_dmg "$DOWNLOAD"; then
  step "Mounting DMG …"
  MOUNT_POINT="$TMP/mount"
  mkdir -p "$MOUNT_POINT"
  hdiutil attach "$DOWNLOAD" \
    -mountpoint "$MOUNT_POINT" \
    -nobrowse -quiet -readonly \
    -noverify || err "Could not mount DMG."
  APP_PATH=$(find "$MOUNT_POINT" -maxdepth 4 -name "*.app" -type d 2>/dev/null | head -1)

elif is_zip "$DOWNLOAD"; then
  step "Extracting ZIP …"
  unzip -q "$DOWNLOAD" -d "$TMP/zip" || err "Could not extract ZIP."
  APP_PATH=$(find "$TMP/zip" -maxdepth 5 -name "*.app" -type d 2>/dev/null | head -1)

else
  err "Unsupported format. Please provide a direct link to a .dmg or .zip file."
fi

[[ -z "$APP_PATH" ]] && err "No .app bundle found inside the downloaded file."
info "Found: $(basename "$APP_PATH")"

# ── 3. Find the .icns icon file ───────────────────────────────────────────────
PLIST="$APP_PATH/Contents/Info.plist"
ICNS_PATH=""

# Read icon name from Info.plist
if [[ -f "$PLIST" ]]; then
  ICON_KEY=$(defaults read "$PLIST" CFBundleIconFile 2>/dev/null || true)
  # Add .icns if missing
  [[ -n "$ICON_KEY" && "$ICON_KEY" != *.icns ]] && ICON_KEY="${ICON_KEY}.icns"
  [[ -n "$ICON_KEY" ]] && ICNS_PATH="$APP_PATH/Contents/Resources/$ICON_KEY"
fi

# Fallback: pick largest .icns in Resources
if [[ -z "$ICNS_PATH" || ! -f "$ICNS_PATH" ]]; then
  info "Searching for .icns in Resources …"
  ICNS_PATH=$(find "$APP_PATH/Contents/Resources" -name "*.icns" 2>/dev/null \
              | xargs ls -S 2>/dev/null | head -1 || true)
fi

[[ -z "$ICNS_PATH" || ! -f "$ICNS_PATH" ]] \
  && err "No .icns icon found inside $(basename "$APP_PATH")."

info "Icon: $(basename "$ICNS_PATH")"

# ── 4. Convert & resize to PNG ────────────────────────────────────────────────
OUT="$ICONS_DIR/${NAME}.png"
step "Converting to ${SIZE}×${SIZE} PNG …"

sips \
  --setProperty format png \
  --resampleHeightWidth "$SIZE" "$SIZE" \
  "$ICNS_PATH" \
  --out "$TMP/icon.png"

cp "$TMP/icon.png" "$OUT"
echo "✓ Saved → $OUT"