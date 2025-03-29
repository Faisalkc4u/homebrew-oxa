#!/bin/bash

KITTY_VERSION="1.0"
REPO_URL="https://github.com/Faisalkc4u/cli_kitty"

case "$1" in
  version)
    echo "Kitty CLI v$KITTY_VERSION"
    ;;
  
  greet)
    echo "Hello, $USER! 🐱"
    ;;
  
  upgrade)
    echo "Upgrading Kitty..."
    curl -sSLo /usr/local/bin/kitty "$REPO_URL"
    chmod +x /usr/local/bin/kitty
    echo "Kitty upgraded successfully! 🎉"
    ;;
  
  *)
    echo "Usage: kitty [version|greet|upgrade]"
    ;;
esac
