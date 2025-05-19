#!/bin/bash
set -e

echo "🔄 Backup bestehender Dateien..."
cp ~/klipper/klippy/heaters.py ~/klipper/klippy/heaters.py.bak || true
cp ~/klipper/klippy/extras/heater_bed.py ~/klipper/klippy/extras/heater_bed.py.bak || true

echo "📥 Installiere gepatchte Dateien..."
cp patched/heaters.py ~/klipper/klippy/heaters.py
cp patched/heater_bed.py ~/klipper/klippy/extras/heater_bed.py

echo "🔁 Starte Klipper neu..."
sudo systemctl restart klipper

echo "✅ Installation abgeschlossen!"
