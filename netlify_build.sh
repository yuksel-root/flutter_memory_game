#!/bin/bash
set -e

# ---- Flutter install / update ----
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
flutter upgrade --force
flutter config --enable-web

# ---- Clean old builds ----
flutter clean
rm -rf build/web

# ---- Build web (no PWA, no cache) ----
flutter pub get
flutter build web --release --pwa-strategy=none

# ---- Hash JS/CSS files to prevent old assets ----
cd build/web
for file in main.dart.js flutter.js; do
  if [ -f "$file" ]; then
    HASH=$(md5sum "$file" | cut -d' ' -f1)
    NEWNAME="${file%.js}.$HASH.js"
    mv "$file" "$NEWNAME"
    # update index.html
    sed -i "s|$file|$NEWNAME|g" index.html
  fi
done
cd -

# ---- SPA redirect ----
if [ -f web/_redirects ]; then
  echo "Copying _redirects to build/web"
  cp web/_redirects build/web/_redirects
else
  echo "WARNING: web/_redirects not found!"
fi

echo "✅ Flutter Web build with hashed assets finished!"
