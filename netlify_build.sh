#!/bin/bash
set -e

if [ ! -d "$HOME/flutter" ]; then
  echo "Flutter not found.."
  git clone https://github.com/flutter/flutter.git --branch stable --depth 1 $HOME/flutter
else
  echo "flutter is already exist"
fi

export PATH="$HOME/flutter/bin:$PATH"


flutter channel stable
flutter upgrade --force
flutter config --enable-web

flutter pub get
flutter build web --release

# SPA redirect 
if [ -f web/_redirects ]; then
  echo "Copying _redirects to build/web"
  cp web/_redirects build/web/_redirects
else
  echo "WARNING: web/_redirects not found!"
fi
