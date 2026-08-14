#!/bin/bash

SCRIPT_DIR="$HOME/.config/hypr/scripts"
source "$SCRIPT_DIR/debug.sh"

SCRIPT_NAME="screenshot"

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
FILE="$SCREENSHOT_DIR/$TIMESTAMP.png"

log "$SCRIPT_NAME" "Screenshot requested: $1"

case "$1" in
    full)
        log "$SCRIPT_NAME" "Taking full-screen screenshot"

        if grim "$FILE"; then
            log "$SCRIPT_NAME" "Screenshot saved: $FILE"
        else
            log "$SCRIPT_NAME" "ERROR: Failed to take full-screen screenshot"
            exit 1
        fi
        ;;

    area)
        log "$SCRIPT_NAME" "Area selection started"

        if grim -g "$(slurp)" "$FILE"; then
            log "$SCRIPT_NAME" "Area screenshot saved: $FILE"
        else
            log "$SCRIPT_NAME" "ERROR: Area screenshot failed or selection cancelled"
            exit 1
        fi
        ;;

    *)
        log "$SCRIPT_NAME" "ERROR: Invalid argument: $1"
        echo "Usage: $0 {full|area}"
        exit 1
        ;;
esac

log "$SCRIPT_NAME" "Copying screenshot to Wayland clipboard"

if wl-copy --type image/png < "$FILE"; then
    log "$SCRIPT_NAME" "Screenshot copied to clipboard"
else
    log "$SCRIPT_NAME" "ERROR: Failed to copy screenshot to clipboard"
    exit 1
fi

notify-send "Screenshot Saved" "$FILE"

log "$SCRIPT_NAME" "Screenshot workflow completed successfully"