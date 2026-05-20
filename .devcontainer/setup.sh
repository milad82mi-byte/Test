#!/bin/sh
set -e

# نصب Xray
echo "[g2ray] Installing Xray..."
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# نصب geoip و geosite
echo "[g2ray] Downloading GeoIP and GeoSite..."
mkdir -p /usr/local/share/xray
curl -sL "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" -o /usr/local/share/xray/geoip.dat
curl -sL "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" -o /usr/local/share/xray/geosite.dat

echo "[g2ray] Setup completed."
echo "[g2ray] Xray version: $(xray -version 2>/dev/null | head -n1)"
