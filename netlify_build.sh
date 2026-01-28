#!/bin/bash
set -e

echo "🚀 Starting full Flutter Web build (Netlify optimized)"

# ---- Flutter install / update (fresh each build) ----
if [ ! -d "$HOME/flutter" ]; then
  echo "Flutter not found, installing latest stable..."
  git clone https://github.com/flutter/flutter.git --branch stable --depth 1 $HOME/flutter
else
  echo "Flutter exists, updating to latest stable..."
  cd $HOME/flutter
  git fetch origin stable
  git reset --hard origin/stable
  cd -
fi

export PATH="$HOME/flutter/bin:$PATH"

# ---- Flutter setup ----
flutter channel stable
flutter upgrade
flutter config --enable-web

# ---- Clean old builds ----
flutter clean
rm -rf build/web

# ---- Get dependencies ----
flutter pub get

# ---- Build web (HTML renderer, PWA off, no cache) ----
flutter build web --release --no-web-resources-cdn

# ---- Copy SPA redirect if exists ----
if [ -f web/_redirects ]; then
  echo "Copying _redirects to build/web"
  cp web/_redirects build/web/_redirects
else
  echo "WARNING: web/_redirects not found!"
fi

echo "✅ Flutter Web build finished! (fresh install, no cache)"
