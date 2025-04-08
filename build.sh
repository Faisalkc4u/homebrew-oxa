#!/bin/bash

# Function to build Flutter app
build_firebase() {
    flutter build ipa --release --export-method=ad-hoc
}

 