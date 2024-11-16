#!/bin/bash

# Set encoding parameters
CRF=23
PRESET="medium"
AUDIO_BITRATE="128k"

# Create an output directory
OUTPUT_DIR="encoded_videos"
mkdir -p "$OUTPUT_DIR"

# Process each MP4 file in the current directory
for file in *.mp4; do
    if [[ -f "$file" ]]; then
        echo "Processing $file..."
        # Generate output file name
        OUTPUT_FILE="$OUTPUT_DIR/${file%.mp4}_encoded.mp4"

        # Run ffmpeg command
        ffmpeg -i "$file" -c:v libx264 -crf $CRF -preset $PRESET -c:a aac -b:a $AUDIO_BITRATE "$OUTPUT_FILE"

        # Check if encoding was successful
        if [[ $? -eq 0 ]]; then
            echo "Encoded $file -> $OUTPUT_FILE"
        else
            echo "Failed to encode $file"
        fi
    else
        echo "No MP4 files found in the current directory."
    fi
done
