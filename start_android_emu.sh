#!/bin/bash
set -e

#=============================
# Set home directory
#=============================
export HOME="$PWD/home"

#=============================
# Set default values
#=============================
BUILD_TOOLS="35.0.1"
ANDROID_SDK_ROOT="$PWD/opt/android"
EMULATOR_NAME="nexus"

#=============================
# Set environment variables
#=============================
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"

emulator -avd "${EMULATOR_NAME}"
