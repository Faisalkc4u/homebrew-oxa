#!/bin/bash

# Define the branch and repo URL
BRANCH="main"
REPO_URL="https://github.com/Faisalkc4u/homebrew-oxa.git"
INSTALL_DIR="/usr/local/oxa"

# Print message for upgrading
echo "Upgrading Oxa..."

# Remove the old installation if it exists
sudo rm -rf "$INSTALL_DIR"

# Create the installation directory
mkdir -p "$INSTALL_DIR"

# Clone the repository from the specific branch (main)
git clone --branch "$BRANCH" --single-branch "$REPO_URL" "$INSTALL_DIR"

# Make sure the scripts are executable
chmod +x "$INSTALL_DIR"/*.sh

# Get version from a file (example: oxa.json) or hardcoded
CURRENT_VERSION=$(jq -r '.version' "$INSTALL_DIR/oxa.json")

echo "Oxa upgraded successfully! 🚀 (Version: $CURRENT_VERSION)"
