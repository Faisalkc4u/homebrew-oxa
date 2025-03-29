#!/bin/bash

inc_ver() {
    # Determine whether it's a patch or feature increment
    if [ "$1" == "--patch" ]; then
        increment_type="patch"
    elif [ "$1" == "--feat" ]; then
        increment_type="feat"
    else
        echo "Invalid option. Use --patch or --feat."
        return 1
    fi

    # Find the current version in pubspec.yaml
    current_version=$(grep 'version: ' pubspec.yaml | sed 's/version: //')
    major=$(echo $current_version | cut -d'.' -f1)
    minor=$(echo $current_version | cut -d'.' -f2)
    patch=$(echo $current_version | cut -d'.' -f3 | cut -d'+' -f1)
    build=$(echo $current_version | cut -d'+' -f2)

    # Increment the version based on the type
    if [ "$increment_type" == "patch" ]; then
        patch=$((patch + 1))
    elif [ "$increment_type" == "feat" ]; then
        minor=$((minor + 1))
        patch=0  # Reset patch version when incrementing minor
    fi

    # Construct the new version
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
}
