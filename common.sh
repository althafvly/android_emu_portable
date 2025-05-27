#!/bin/bash
set -e

#=============================
# Set default values
#=============================
ARCH="x86_64"
TARGET="default"
API_LEVEL="35"
BUILD_TOOLS="35.0.1"
ANDROID_API_LEVEL="android-${API_LEVEL}"
ANDROID_APIS="${TARGET};${ARCH}"
EMULATOR_PACKAGE="system-images;${ANDROID_API_LEVEL};${ANDROID_APIS}"
PLATFORM_VERSION="platforms;${ANDROID_API_LEVEL}"
BUILD_TOOL="build-tools;${BUILD_TOOLS}"
ANDROID_CMD="commandlinetools-linux-13114758_latest.zip"
ANDROID_SDK_PACKAGES="${EMULATOR_PACKAGE} ${PLATFORM_VERSION} ${BUILD_TOOL} platform-tools emulator"
ANDROID_SDK_ROOT="$PWD/opt/android"

#=============================
# Set home directory
#=============================
export HOME="$PWD/home"

set_env() {
  #=============================
  # Set environment variables
  #=============================
  export ANDROID_SDK_ROOT
  export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"
}
