#!/bin/bash
set -e

#=============================
# Set custom home directory
#=============================
ACTUAL_HOME=$HOME
export HOME="$PWD/home"
mkdir -p "$HOME/.android/avd/"

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
EMULATOR_NAME="nexus"
EMULATOR_DEVICE="Nexus 6"

#=============================
# Install system dependencies
#=============================
sudo apt update
sudo apt install -y curl sudo wget unzip bzip2 libdrm-dev libxkbcommon-dev \
    libgbm-dev libasound-dev libnss3 libxcursor1 libpulse-dev libxshmfence-dev \
    xauth xvfb x11vnc fluxbox wmctrl libdbus-glib-1-2

#=============================
# Download and install Android SDK
#=============================
sudo mkdir -p "$ANDROID_SDK_ROOT"
sudo chown -R $(whoami):$(whoami) "$ANDROID_SDK_ROOT"

if [ ! -f "$ANDROID_CMD" ]; then
  wget -O $ANDROID_CMD https://dl.google.com/android/repository/$ANDROID_CMD
  unzip -d "$ANDROID_SDK_ROOT" $ANDROID_CMD
  mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools/tools"
  mv "$ANDROID_SDK_ROOT/cmdline-tools/"{bin,lib,NOTICE.txt,source.properties} "$ANDROID_SDK_ROOT/cmdline-tools/tools/" || true
fi

#=============================
# Set environment variables
#=============================
export ANDROID_SDK_ROOT
export PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/tools:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/build-tools/${BUILD_TOOLS}"

#=============================
# Accept licenses and install packages
#=============================
yes | sdkmanager --licenses
yes | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES}

#=============================
# Create emulator
#=============================
echo "no" | avdmanager --verbose create avd --force --name "$EMULATOR_NAME" --device "$EMULATOR_DEVICE" --package "$EMULATOR_PACKAGE"

cp -r $ACTUAL_HOME/.android/avd/"$EMULATOR_NAME".* $HOME/.android/avd/

echo -e "\n✅ Android emulator setup complete!"
