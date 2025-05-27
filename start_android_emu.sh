#!/bin/bash
set -e

source common.sh
set_env

#=============================
# Set headless options if -n is passed
#=============================
EMULATOR_ARGS=""
if [[ "$1" == "-n" ]]; then
    EMULATOR_ARGS="-no-window -gpu off -no-audio"
fi

emulator -avd "${EMULATOR_NAME}" ${EMULATOR_ARGS}
