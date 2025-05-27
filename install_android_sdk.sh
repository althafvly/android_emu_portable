#!/bin/bash
set -e

source common.sh

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

set_env

#=============================
# Accept licenses and install packages
#=============================
yes | sdkmanager --licenses
yes | sdkmanager --verbose --no_https ${ANDROID_SDK_PACKAGES}

echo -e "\n✅ Android emulator setup complete!"
