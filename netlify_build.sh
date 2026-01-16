#!/bin/bash
set -e

FLUTTER_VERSION="3.19.6"
FLUTTER_DIR="$HOME/flutter"

if [ ! -d "$FLUTTER_DIR" ]; then
    echo "Downloading Flutter $FLUTTER_VERSION..."
    curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz
    tar xf flutter_linux_${FLUTTER_VERSION}-stable.tar.xz -C $HOME
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

# ---- Flutter web build ----
flutter channel stable
flutter upgrade
flutter config --enable-web
flutter pub get
flutter build web --release

# ---- Netlify SPA redirect (CRITICAL) ----
if [ -f web/_redirects ]; then
  echo "Copying _redirects to build/web"
  cp web/_redirects build/web/_redirects
else
  echo "WARNING: web/_redirects not found!"
fi
