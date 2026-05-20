#!/bin/bash
set -e

echo "[1/4] Installing Xray..."
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

echo "[2/4] Verifying Xray installation..."
if command -v xray &> /dev/null; then
    echo "[OK] Xray installed: $(xray -version | head -n1)"
else
    echo "[ERROR] Xray installation failed"
    exit 1
fi

echo "[3/4] Downloading sni-spoof-rs..."
mkdir -p /opt/sni-spoof
cd /opt/sni-spoof
wget --no-check-certificate https://github.com/therealaleph/sni-spoofing-rust/releases/latest/download/sni-spoof-rs-linux-amd64 -O sni-spoof-rs
chmod +x sni-spoof-rs

echo "[4/4] Verifying sni-spoof-rs..."
if [ -f /opt/sni-spoof/sni-spoof-rs ]; then
    echo "[OK] sni-spoof-rs downloaded"
else
    echo "[ERROR] sni-spoof-rs download failed"
    exit 1
fi

echo "========== Setup Complete =========="
