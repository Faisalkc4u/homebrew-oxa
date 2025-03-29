#!/bin/bash

# Updated to download from a branch instead of a release
REPO_URL="https://raw.githubusercontent.com/Faisalkc4u/homebrew-oxa/main/oxa.sh"
API_URL="https://api.github.com/repos/Faisalkc4u/homebrew-oxa/releases/latest"
VERSION_FILE="oxa.json"  # Updated file name

# Fetch the current version from oxa.json
CURRENT_VERSION=$(jq -r '.version' "$VERSION_FILE")

# Fetch the latest release version from GitHub API
LATEST_VERSION=$(curl -s $API_URL | jq -r '.tag_name')

case "$1" in
  version)
    echo "Current version: $CURRENT_VERSION"
    
    if [[ "$CURRENT_VERSION" != "$LATEST_VERSION" ]]; then
      echo "A new version ($LATEST_VERSION) is available! Run 'oxa upgrade' to update."
    else
      echo "You are using the latest version!"
    fi
    ;;
  greet)
    echo "Hello, $USER! 🦊"
    ;;
  upgrade)
    echo "Upgrading Oxa..."
    curl -sSLo /usr/local/bin/oxa "$REPO_URL"
    chmod +x /usr/local/bin/oxa
    echo "Oxa upgraded successfully! 🚀"
    
    # Update the current version in oxa.json after upgrade
    jq ".version = \"$LATEST_VERSION\"" "$VERSION_FILE" > tmp.$$.json && mv tmp.$$.json "$VERSION_FILE"
    ;;
  *)
    echo "Usage: oxa [version|greet|upgrade]"
    ;;
esac
