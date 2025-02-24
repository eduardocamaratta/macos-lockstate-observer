#!/bin/bash

# Build
swift build -c release;

# Copy the binary
mkdir -p ~/Library/EduardoCamaratta;
BINARY_PATH=$(swift build -c release --show-bin-path);
BINARY_NAME=$(swift package dump-package | jq -r '.targets[0].name');
cp $BINARY_PATH/$BINARY_NAME ~/Library/EduardoCamaratta;
BINARY_DESTINATION=$(ls ~/Library/EduardoCamaratta/$BINARY_NAME | sed 's/\//\\\//g');

# Edit and copy the plist
PLIST_NAME=com.eduardocamaratta.locklogsserver.plist
PLIST_LOCATION=plists/$PLIST_NAME
cat $PLIST_LOCATION | sed "s/\$BINARY_ABSOLUTE_PATH/$BINARY_DESTINATION/g" > ~/Library/LaunchAgents/$PLIST_NAME