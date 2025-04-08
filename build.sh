#!/bin/bash

# Function to build Flutter app
build_flutter() {
    if [ "$1" == "adhoc" ]; then
        echo "Building Flutter app for AdHoc distribution..."
        flutter build ipa --export-options-plist=ExportOptionsAdHoc.plist
    elif [ "$1" == "appstore" ]; then
        echo "Building Flutter app for App Store distribution..."
        flutter build ipa --export-options-plist=ExportOptionsAppStore.plist
    else
        echo "Invalid argument. Use 'adhoc' or 'appstore'."
        exit 1
    fi
}

# Example usage
# Uncomment the line below to test the function
# build_flutter adhoc
# build_flutter appstore