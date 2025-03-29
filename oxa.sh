#!/bin/bash

# Updated to download from a branch instead of a release
REPO_URL="https://raw.githubusercontent.com/Faisalkc4u/homebrew-oxa/main/oxa.sh"
API_URL="https://api.github.com/repos/Faisalkc4u/homebrew-oxa/releases/latest"
VERSION_FILE="oxa.json"  # Updated file name

# Fetch the current version from oxa.json
CURRENT_VERSION=$(jq -r '.version' "$VERSION_FILE")

# Fetch the latest release version from GitHub AP#!/bin/bash

REPO_URL="https://github.com/Faisalkc4u/homebrew-oxa/archive/refs/heads/main.zip"
INSTALL_DIR="$(dirname "$(realpath "$0")")"

LATEST_VERSION=$(curl -s $API_URL | jq -r '.tag_name')

case "$1" in
  version)
    echo "Current version: $(jq -r '.version' "$INSTALL_DIR/oxa.json")"
    ;;
  greet)
    echo "Hello, $USER! 🦊"
    ;;
  upgrade)
     # Call the upgrade.sh script
    bash "$INSTALL_DIR/upgrade.sh"
    ;;
  *)
    echo "Usage: oxa [version|greet|upgrade]"
    ;;
esac
