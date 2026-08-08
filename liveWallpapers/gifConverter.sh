#!/bin/bash

# ============================================
# PRESETS for 2560x1600 screen
# Uncomment ONE block only
# ============================================

# --- 1. NATIVE SHARP ---
# Use only for very short clips (under 5 sec)
# FPS=12
# WIDTH=2560
# QUALITY=85

# --- 2. BALANCED (recommended) ---
# Visually nearly identical to native, ~40% smaller files
FPS=15
WIDTH=1920
QUALITY=85

# --- 3. LIGHT ---
# Good for longer loops, still crisp on laptop
# FPS=12
# WIDTH=1600
# QUALITY=80

# ============================================
# OTHER OPTIONS
# ============================================
FAST_MODE=false          # true = faster encode, slightly softer
REPEAT=0               # 0=loop forever, -1=once, N=repeat N times
# ============================================

# Check dependencies
if ! command -v gifski &> /dev/null; then
    echo "Error: gifski not found. Install it first:"
    echo "  sudo pacman -S gifski     # Arch"
    echo "  sudo apt install gifski   # Debian/Ubuntu"
    exit 1
fi

# Find mp4 files
shopt -s nullglob
mp4_files=(*.mp4)
shopt -u nullglob

if [ ${#mp4_files[@]} -eq 0 ]; then
    echo "No .mp4 files found in $(pwd)"
    exit 0
fi

echo "================================================"
echo "  GIF Converter | ${#mp4_files[@]} file(s) found"
echo "  Output: ${WIDTH}px wide | ${FPS} fps | Quality ${QUALITY}"
echo "================================================"
echo ""

# Build optional args
args=()
[ "$FAST_MODE" = true ] && args+=("--fast")
[ -n "$REPEAT" ] && args+=("--repeat" "$REPEAT")

# Convert
for file in "${mp4_files[@]}"; do
    base="${file%.mp4}"
    output="${base}.gif"

    echo "▶ Converting: $file"

    gifski \
        --fps "$FPS" \
        --width "$WIDTH" \
        --quality "$QUALITY" \
        "${args[@]}" \
        -o "$output" \
        "$file"

    if [ $? -eq 0 ] && [ -f "$output" ]; then
        size=$(du -h "$output" | cut -f1)
        echo "  ✓ Done: $output (${size})"
    else
        echo "  ✗ Failed: $file"
    fi
    echo ""
done

echo "All done."