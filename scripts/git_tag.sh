#!/bin/bash

VERSION_FILE="../VERSION"

VERSION=$(cat "$VERSION_FILE")

git tag "v.$VERSION"

echo "Created tag: v.$VERSION"
