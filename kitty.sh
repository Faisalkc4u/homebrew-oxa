#!/bin/bash
REPO_URL="https://github.com/Faisalkc4u/homebrew-kitty/releases/latest/download/kitty.sh"

case "$1" in
  version)
    echo "Kitty CLI v1.0.0"
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
