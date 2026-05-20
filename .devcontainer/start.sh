#!/bin/bash

echo "========== Starting Services =========="

# Check if Xray exists
if ! command -v xray &> /dev/null; then
    echo "[ERROR] xray not found! Setup may have failed."
    exit 1
fi

# Check if sni-spoof-rs exists
if [ ! -f /opt/sni-spoof/sni-spoof-rs ]; then
    echo "[ERROR] sni-spoof-rs not found! Setup may have failed."
    exit 1
fi

# Start SNI Spoofer
echo "[1/2] Starting SNI Spoofer on port 40443..."
/opt/sni-spoof/sni-spoof-rs /etc/sniffer/config.json &
SNIFFER_PID=$!
echo "[OK] SNI Spoofer PID: $SNIFFER_PID"

sleep 3

# Start Xray
echo "[2/2] Starting Xray on port 443..."
xray run -c /etc/xray/config.json &
XRAY_PID=$!
echo "[OK] Xray PID: $XRAY_PID"

echo "========== All Services Running =========="
echo "✅ SNI Spoofer: port 40443"
echo "✅ Xray: port 443"
echo ""
echo "📱 Client Link:"
echo "vless://d41b3be1-820d-4ab8-93d7-b2fa504c1e6f@104.19.229.21:40443?encryption=none&security=none&type=tcp#G2Ray-Final"
echo ""

wait
