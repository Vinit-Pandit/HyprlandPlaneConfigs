#!/bin/bash

WOFI_THEME="combo"
CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/src/$WOFI_THEME/style.css"

if pgrep -x wofi >/dev/null; then
    pkill -x wofi
else
    wofi --show drun --conf "$CONFIG" --style "$STYLE"
fi