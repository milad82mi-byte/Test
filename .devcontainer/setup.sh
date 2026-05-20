#!/bin/sh
set -e

# نصب Xray
RELEASE_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
TMPDIR="$(mktemp -d)"

echo "[g2ray] Downloading latest Xray..."
curl -sL "$RELEASE_URL" -o "$TMPDIR/xray.zip"
unzip -q "$TMPDIR/xray.zip" -d "$TMPDIR"
install -m 755 "$TMPDIR/xray" /usr/local/bin/xray

# نصب GeoIP و GeoSite
mkdir -p /usr/local/share/xray
curl -sL "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" -o /usr/local/share/xray/geoip.dat
curl -sL "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" -o /usr/local/share/xray/geosite.dat

# دانلود sni-spoof-rs
echo "[g2ray] Downloading sni-spoof-rs..."
mkdir -p /opt/sni-spoof
cd /opt/sni-spoof
wget https://github.com/therealaleph/sni-spoofing-rust/releases/latest/download/sni-spoof-rs-linux-amd64 -O sni-spoof-rs
chmod +x sni-spoof-rs

mkdir -p /var/log/xray
rm -rf "$TMPDIR"
echo "[g2ray] Setup completed."
