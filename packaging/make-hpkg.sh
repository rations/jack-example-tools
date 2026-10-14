#!/bin/sh
# make-hpkg.sh — build the `jack_tools` .hpkg on a running Haiku (x86_64).
# Requires jack (libjack + its jack.pc) to be installed first — build/install
# jack-port-haiku before running this.
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(cd "$HERE/.." && pwd)
VERSION=4
REVISION=2
STAGE="$HERE/stage"

pkgman install -y meson ninja pkgconfig libsndfile_devel libsamplerate_devel readline_devel || true

# Find jack's pkg-config whether it was installed packaged or non-packaged.
export PKG_CONFIG_PATH="/boot/system/non-packaged/lib/pkgconfig:/boot/system/lib/pkgconfig:$PKG_CONFIG_PATH"

rm -rf "$STAGE" "$ROOT/build"
cd "$ROOT"
meson setup build --prefix=/boot/system --buildtype=release
ninja -C build
DESTDIR="$STAGE" meson install -C build

PKGROOT="$STAGE/boot/system"
cp "$HERE/jack_tools.PackageInfo" "$PKGROOT/.PackageInfo"
OUT="$HERE/jack_tools-$VERSION-$REVISION-x86_64.hpkg"
package create -C "$PKGROOT" "$OUT"
echo ">> built $OUT"
