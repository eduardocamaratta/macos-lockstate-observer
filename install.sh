#!/usr/bin/env zsh

# Build
swift build -c release;

# Copy the binary
BIN_PATH=$(swift build -c release --show-bin-path);
BIN_NAME=$(swift package dump-package  | sed -n '/targets/,/name/p' | grep name | sed -E 's/^.*"name"\ :\ "([^"]+)",?/\1/');
BIN_TARGET_PATH=$HOME/Library/EduardoCamaratta;
mkdir -p $BIN_TARGET_PATH;
BIN_TARGET_FULL_PATH="$BIN_TARGET_PATH/$BIN_NAME";
cp $BIN_PATH/$BIN_NAME $BIN_TARGET_FULL_PATH;

# Edit the plist and copy it to the LaunchAgents
PLIST_NAME=com.eduardocamaratta.lockstateobserver.plist;
PLIST_FULL_PATH=plists/$PLIST_NAME;
sed "s@\$BINARY_ABSOLUTE_PATH@$BIN_TARGET_FULL_PATH@" $PLIST_FULL_PATH > $HOME/Library/LaunchAgents/$PLIST_NAME;