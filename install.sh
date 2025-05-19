#!/bin/bash
set -e

PATCHED_DIR="patched"
HEATERS_FILE="$PATCHED_DIR/heaters.py"
HEATER_BED_FILE="$PATCHED_DIR/heater_bed.py"

TARGET_DIR=~/klipper/klippy/extras

echo "🔍 Prüfe, ob gepatchte Dateien vorhanden sind..."

if [[ ! -f "$HEATERS_FILE" ]]; then
  echo "❌ Fehler: $HEATERS_FILE fehlt!"
  exit 1
fi

if [[ ! -f "$HEATER_BED_FILE" ]]; then
  echo "❌ Fehler: $HEATER_BED_FILE fehlt!"
  exit 1
fi

echo "✅ Alle Patch-Dateien gefunden."

echo "🔄 Backup bestehender Dateien..."
cp "$TARGET_DIR/heaters.py" "$TARGET_DIR/heaters.bak" || true
cp "$TARGET_DIR/heater_bed.py" "$TARGET_DIR/heater_bed.bak" || true

echo "🧹 Entferne alte Zieldateien..."
rm -f "$TARGET_DIR/heaters.py"
rm -f "$TARGET_DIR/heater_bed.py"

echo "📥 Installiere gepatchte Dateien..."
cp "$HEATERS_FILE" "$TARGET_DIR/heaters.py"
cp "$HEATER_BED_FILE" "$TARGET_DIR/heater_bed.py"

echo "🔁 Starte Klipper neu..."
sudo systemctl restart klipper

echo "✅ Patch erfolgreich installiert und Klipper neu gestartet."
