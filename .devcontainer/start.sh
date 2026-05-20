#!/bin/bash

echo "[g2ray] Starting SNI Spoofer + Xray..."

# اجرای sniffer
echo "[g2ray] Starting SNI Spoofer on port 40443..."
/opt/sni-spoof/sni-spoof-rs /etc/xray/sniffer-config.json &
SNIFFER_PID=$!
echo "[g2ray] SNI Spoofer PID: $SNIFFER_PID"

sleep 3

# اجرای Xray
echo "[g2ray] Starting Xray on port 443..."
/usr/local/bin/xray run -c /etc/xray/g2ray.json &
XRAY_PID=$!
echo "[g2ray] Xray PID: $XRAY_PID"

# نمایش لینک
sleep 2
show-link.sh

# نگهداری پروسه‌ها
wait
