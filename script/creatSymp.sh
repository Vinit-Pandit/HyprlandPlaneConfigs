#!/bin/bash

# Usage: ./symlink-folders.sh /path/to/source /path/to/target

SOURCE="$HOME/My_Space/gitRepo/Config"
TARGET="$HOME/.config/"

# Validate inputs
if [ -z "$SOURCE" ] || [ -z "$TARGET" ]; then
    echo "Usage: $0 <source_folder> <target_folder>"
    exit 1
fi

if [ ! -d "$SOURCE" ]; then
    echo "Error: Source '$SOURCE' is not a directory."
    exit 1
fi

# Create target if it doesn't exist
mkdir -p "$TARGET"

# Loop over directories in source
for dir in "$SOURCE"/*/; do
    [ -d "$dir" ] || continue  # skip if no folders found

    name=$(basename "$dir")
    link_path="$TARGET/$name"

    # Skip if already exists
    if [ -e "$link_path" ] || [ -L "$link_path" ]; then
        echo "Skipping: '$name' already exists in target"
        continue
    fi

    ln -s "$dir" "$link_path"
    echo "Created: $link_path -> $dir"
done

echo "Done."