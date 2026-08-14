#!/bin/bash

WOFI_THEME="macchiato"
CONFIG="$HOME/.config/wofi/config/config"
STYLE="$HOME/.config/wofi/src/$WOFI_THEME/style.css"

if pgrep -x wofi >/dev/null; then
    pkill -x wofi
else
    wofi --conf "$CONFIG" --style "$STYLE" "$@"
fi