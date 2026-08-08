#!/bin/bash

SOURCE="$HOME/My_Space/gitRepo/Config"
TARGET="$HOME/.config/"

# Validate source
if [ ! -d "$SOURCE" ]; then
    echo "Error: Source '$SOURCE' is not a directory."
    exit 1
fi

# Create target if it doesn't exist
mkdir -p "$TARGET"

# Loop over directories in source
for dir in "$SOURCE"/*/; do
    [ -d "$dir" ] || continue

    name=$(basename "$dir")
    link_path="$TARGET/$name"
    real_source=$(realpath "$dir")

    # If it's already a symlink pointing to the same source, skip
    if [ -L "$link_path" ]; then
        current_target=$(readlink -f "$link_path" 2>/dev/null)
        if [ "$current_target" = "$real_source" ]; then
            echo "Skipping: '$name' already linked to source"
            continue
        fi
    fi

    # If something exists (folder or symlink to elsewhere), rename it
    if [ -e "$link_path" ] || [ -L "$link_path" ]; then
        n=1
        while [ -e "$TARGET/${name}.${n}" ] || [ -L "$TARGET/${name}.${n}" ]; do
            ((n++))
        done
        mv "$link_path" "$TARGET/${name}.${n}"
        echo "Renamed existing '$name' -> '${name}.${n}'"
    fi

    # Create the symlink
    ln -s "$real_source" "$link_path"
    echo "Created: $link_path -> $real_source"

done

echo "Done."