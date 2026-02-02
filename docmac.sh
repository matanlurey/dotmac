#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting macOS setup..."

# 1. Require Apple Silicon
ARCH=$(uname -m)
if [ "$ARCH" != "arm64" ]; then
  echo "❌ Error: Only Apple Silicon (arm64) is supported. Detected: $ARCH"
  exit 1
fi

# 2. Check for Homebrew, install if not found
if ! command -v brew &> /dev/null; then
  echo "🍺 Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> /Users/matan/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> /Users/matan/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi
echo "✨ Done!"

# 3. Use brewfile.
echo "🍺 Running brew bundle to install applications"
brew bundle
brew bundle cleanup --force
 
