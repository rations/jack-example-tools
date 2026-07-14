#!/bin/sh
# build-from-source.sh — build and install the JACK example tools from source on Haiku.
# Build/install jack-port-haiku FIRST (this needs libjack + jack.pc).
set -e

HERE=$(cd "$(dirname "$0")" && pwd)

pkgman install -y meson ninja pkgconfig libsndfile_devel libsamplerate_devel readline_devel

export PKG_CONFIG_PATH="/boot/system/non-packaged/lib/pkgconfig:/boot/system/lib/pkgconfig:$PKG_CONFIG_PATH"

cd "$HERE"
rm -rf build
meson setup build --prefix=/boot/system/non-packaged --buildtype=release
ninja -C build
meson install -C build

echo ">> Installed jack_lsp, jack_connect, jack_transport, ... under /boot/system/non-packaged/bin"
