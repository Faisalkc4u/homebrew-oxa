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
    # Increment version functionality
    if [ -z "$2" ]; then
      echo "Error: You must specify --patch or --feat to increment."
      exit 1
    fi
    if [ "$2" == "--patch" ]; then
      increment_type="patch"
    elif [ "$2" == "--feat" ]; then
      increment_type="feat"
    else
      echo "Invalid option. Use --patch or --feat."
      exit 1
    fi
    
    current_version=$(grep 'version: ' pubspec.yaml | sed 's/version: //')
    major=$(echo $current_version | cut -d'.' -f1)
    minor=$(echo $current_version | cut -d'.' -f2)
    patch=$(echo $current_version | cut -d'.' -f3 | cut -d'+' -f1)
    build=$(echo $current_version | cut -d'+' -f2)
    
    if [ "$increment_type" == "patch" ]; then
      patch=$((patch + 1))
    elif [ "$increment_type" == "feat" ]; then
      minor=$((minor + 1))
      patch=0  # Reset patch version when incrementing minor
    fi
    
    new_version="$major.$minor.$patch+$build"
    
    # Update pubspec.yaml with the new version
    perl -i -pe "s/^(version:\s+\d+\.\d+\.)\d+(\+\d+)$/$1$patch$2/" pubspec.yaml
    
    # Commit and tag the change
    message=$(git log $(git describe --tags --abbrev=0)..HEAD --pretty=format:"%s")
    git log --pretty=format:%s $(git tag --sort=-committerdate | head -1)...$(git tag --sort=-committerdate | head -2 | awk '{split($0, tags, "\n")} END {print tags[1]}') > change_log.txt
    git add .
    git commit -m "Bump version to $new_version" -m "$message"
    git tag $new_version
    git push --tags
    ;;
  *)
    echo "Usage: oxa [version|greet|upgrade|inc]"
    ;;
esac
