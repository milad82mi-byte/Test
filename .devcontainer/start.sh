#!/bin/bash

echo "[g2ray auto-restart] Started..."

# بررسی وجود sudo
if command -v sudo &> /dev/null; then
    XRAY_CMD="sudo /usr/local/bin/xray"
    echo "[g2ray] sudo detected, using it"
else
    XRAY_CMD="/usr/local/bin/xray"
    echo "[g2ray] sudo not found, running directly"
fi

while true; do
  $XRAY_CMD run -c /etc/xray/g2ray.json &>/tmp/xray.log &
  PID=$!

  sleep 2
  show-link.sh

  echo "[g2ray] Running with PID $PID"

  # Keepalive every 3 minutes for 3h40m
  for ((i=0; i<73; i++)); do
    sleep 180
    echo "1"
  done

  echo "[g2ray] Stopping..."
  kill $PID

  sleep 5

  echo "[g2ray] Restarting..."
done
