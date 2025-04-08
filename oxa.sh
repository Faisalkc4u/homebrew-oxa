#!/bin/bash

# Updated to download from a branch instead of a release
REPO_URL="https://raw.githubusercontent.com/Faisalkc4u/homebrew-oxa/main/oxa.sh"
API_URL="https://api.github.com/repos/Faisalkc4u/homebrew-oxa/releases/latest"
VERSION_FILE="oxa.json"  # Updated file name

# Fetch the current version from oxa.json
CURRENT_VERSION=$(jq -r '.version' "$VERSION_FILE")

# Fetch the latest release version from GitHub API
LATEST_VERSION=$(curl -s $API_URL | jq -r '.tag_name')

INSTALL_DIR="$(dirname "$(realpath "$0")")"

case "$1" in
  build_firebase)
 
    # Call the build function with the provided argument
    ./build.sh "$2"
    ;;
  version)
    echo "Current version: $CURRENT_VERSION"
    ;;
  greet)
    echo "Hello, $USER! 🦊"
    ;;
  upgrade)
    # If a new version is available, upgrade the tool
    if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
      echo "Upgrading to the latest version ($LATEST_VERSION)..."
      # Download and update the script
      curl -L "$REPO_URL" -o "$INSTALL_DIR/oxa.sh"
      # Update the version in oxa.json
      jq ".version = \"$LATEST_VERSION\"" "$INSTALL_DIR/oxa.json" > "$INSTALL_DIR/temp.json" && mv "$INSTALL_DIR/temp.json" "$INSTALL_DIR/oxa.json"
      echo "Upgrade complete! Please run the tool again."
    else
      echo "You are already on the latest version ($CURRENT_VERSION)."
    fi
    ;;
  inc)
    # Increment the version number
    inc_ver
    ;;
   
esac
