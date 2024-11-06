#!/bin/bash

script_dir=$(dirname "$0")

version_file="$script_dir/../VERSION"

version=$(cat "$version_file") #takes the contents of VERSION file and assigns them to version variable
echo "Old version $version"

IFS='.' read -r major minor patch <<< "$version"

minor=$((minor+1))

echo "$major.$minor.$patch" > "$version_file"
echo "New version: $major.$minor.$patch"