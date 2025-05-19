#!/bin/bash
set -e

PATCHED_DIR="patched"
HEATERS_FILE="$PATCHED_DIR/heaters.py"
HEATER_BED_FILE="$PATCHED_DIR/heater_bed.py"

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
cp ~/klipper/klippy/heaters.py ~/klipper/klippy/heaters.py.bak || true
cp ~/klipper/klippy/extras/heater_bed.py ~/klipper/klippy/extras/heater_bed.py.bak || true

echo "📥 Installiere gepatchte Dateien..."
cp "$HEATERS_FILE" ~/klipper/klippy/heaters.py
cp "$HEATER_BED_FILE" ~/klipper/klippy/extras/heater_bed.py

echo "🔁 Starte Klipper neu..."
sudo systemctl restart klipper

echo "✅ Patch erfolgreich installiert und Klipper neu gestartet."
