#!/bin/bash
# Skript bei Fehlern abbrechen
set -e
DBNAME="moestickerbot"
# Beispiel 1: Prüfen, ob eine erforderliche Umgebungsvariable gesetzt ist
if [ -z "$BOT_TOKEN" ]; then
  echo "Fehler: Die Umgebungsvariable BOT_TOKEN ist nicht definiert."
  exit 1
fi
# Das '$@' leitet alle Argumente, die dem Container beim 'docker run'-Befehl übergeben wurden, weiter
exec /app/moe-sticker-bot -bot_token $BOT_TOKEN -db_file $DBNAME "$@"
