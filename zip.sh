#!/bin/bash

# zip_story.sh - Script to package the story folder into a zip archive

OUTPUT_ZIP="cat.zip"
STORY_DIR="story"

if [ -d "$STORY_DIR" ]; then
    echo "Zipping '$STORY_DIR' folder into '$OUTPUT_ZIP'..."
    zip -r "$OUTPUT_ZIP" "$STORY_DIR"
    echo "Done! Created $OUTPUT_ZIP"
else
    echo "Error: '$STORY_DIR' directory does not exist."
    exit 1
fi
