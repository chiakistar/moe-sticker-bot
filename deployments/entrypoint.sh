#!/bin/bash
# Skript bei Fehlern abbrechen
set -e
DBNAME="/data/moestickerbot.sqlite"
DATADIR="/data"

test -d $DATADIR || mkdir $DATADIR

# Beispiel 1: Prüfen, ob eine erforderliche Umgebungsvariable gesetzt ist
if [ -z "$BOT_TOKEN" ]; then
  echo "Fehler: Die Umgebungsvariable BOT_TOKEN ist nicht definiert."
  exit 1
fi
exec /app/moe-sticker-bot -bot_token $BOT_TOKEN -db_file $DBNAME -data_dir $DATADIR "$@"