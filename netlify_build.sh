#!/bin/bash
set -e


export PATH="$HOME/flutter/bin:$PATH"

# ---- Flutter web build ----
flutter channel stable
flutter upgrade
flutter config --enable-web
flutter pub get
flutter build web --release --no-wasm

# ---- Netlify SPA redirect (CRITICAL) ----
if [ -f web/_redirects ]; then
  echo "Copying _redirects to build/web"
  cp web/_redirects build/web/_redirects
else
  echo "WARNING: web/_redirects not found!"
fi
