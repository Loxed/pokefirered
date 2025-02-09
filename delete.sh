#!/bin/zsh

# Specify the directory (modify this or use as an argument)
TARGET_DIR="${1:-$(pwd)}"


# Verify the directory exists
if [ ! -d "$TARGET_DIR" ]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Delete files and folders that start with '._' recursively
echo "Scanning and deleting all files and folders starting with '._' in: $TARGET_DIR"
find "$TARGET_DIR" -depth -name "._*" -print -exec rm -rf {} +

echo "Deletion complete."
