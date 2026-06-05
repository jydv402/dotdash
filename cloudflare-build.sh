#!/bin/bash
# Exit immediately if a command exits with a non-zero status
set -e

# Define Flutter version/branch
FLUTTER_BRANCH="stable"

echo "=== Cloudflare Pages Flutter Build ==="

# Check if flutter already exists (for caching, if applicable)
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter ($FLUTTER_BRANCH) repository..."
  git clone https://github.com/flutter/flutter.git -b $FLUTTER_BRANCH --depth 1
else
  echo "Flutter directory already exists, skipping clone."
fi

# Add Flutter to path
export PATH="$PATH:$(pwd)/flutter/bin"

echo "Verifying Flutter toolchain..."
flutter doctor -v

echo "Enabling web platform..."
flutter config --enable-web

echo "Building web application in WASM release mode..."
flutter build web --release --wasm

echo "=== Build Completed Successfully ==="
