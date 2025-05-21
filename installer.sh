#!/bin/bash
set -e

REPO_URL="https://github.com/JHFexafuse/Klipper-Multibed-Support"
ZIP_URL="$REPO_URL/archive/refs/heads/main.zip"
TMP_DIR="/tmp/kmspatch"

echo "📦 Lade Repo..."
wget -q -O "$TMP_DIR.zip" "$ZIP_URL"

echo "📂 Entpacke..."
rm -rf "$TMP_DIR"
unzip -o -q "$TMP_DIR.zip" -d "$TMP_DIR"

cd "$TMP_DIR/Klipper-Multibed-Support-main"
chmod +x install.sh

echo "🔧 Starte Patch-Installation..."
./install.sh

echo "📁 Kopiere heater_bed.cfg in printer config..."
cp patched/heater_bed.cfg ~/printer_data/config/heater_bed.cfg

echo "✅ Fertig! Patch + Konfig installiert."
