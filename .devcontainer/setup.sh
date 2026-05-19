#!/bin/sh
set -e

# گرفتن آخرین نسخه Xray به جای نسخه قدیمی
RELEASE_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
TMPDIR="$(mktemp -d)"

echo "[g2ray] Downloading latest Xray..."
curl -sL "$RELEASE_URL" -o "$TMPDIR/xray.zip"
unzip -q "$TMPDIR/xray.zip" -d "$TMPDIR"
install -m 755 "$TMPDIR/xray" /usr/local/bin/xray

echo "[g2ray] Downloading latest GeoIP and GeoSite..."
curl -sL "https://github.com/v2fly/geoip/releases/latest/download/geoip.dat" -o /usr/local/share/xray/geoip.dat
curl -sL "https://github.com/v2fly/domain-list-community/releases/latest/download/dlc.dat" -o /usr/local/share/xray/geosite.dat

# ایجاد پوشه لاگ
mkdir -p /var/log/xray

rm -rf "$TMPDIR"
echo "[g2ray] Xray $(/usr/local/bin/xray -version | head -n1) installed successfully."
