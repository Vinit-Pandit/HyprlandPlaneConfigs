#!/bin/bash

LOG_FILE="./debug.log"

log() {
    local SCRIPT_NAME="$1"
    local MESSAGE="$2"

    printf '[%s] [%s] %s\n' \
        "$(date '+%Y-%m-%d %H:%M:%S')" \
        "$SCRIPT_NAME" \
        "$MESSAGE" >> "$LOG_FILE"
}