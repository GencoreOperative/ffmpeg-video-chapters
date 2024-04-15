#!/bin/bash

set -e

cd /data

# Validate that the user has prepared a chapters.txt file
CHAPTERS=chapters.txt
if [ ! -f "$CHAPTERS" ]; then
	echo "Error: Please create the chapters.txt file. An example has been created."
	echo "Keep chapter names short, with no spaces."
	echo "0:00:00 Introduction" > $CHAPTERS
	echo "0:00:33 Announcements" >> $CHAPTERS
	echo "0:01:00 End" >> $CHAPTERS
	exit 1
fi

# Validate that the user has provided an input video
INPUT="$1"
[ ! -f "$INPUT" ] && echo "Error: No input video provided" && exit 1

# Validate that the chapters file does not contain a blank line at the end
if tail -1 "$CHAPTERS" | grep -q '^$'; then
    echo "Error: $CHAPTERS file contains a blank line at the end"
    exit 1
fi

# Validate that ffmpeg is on the path
RESULT=$(type ffmpeg)
if [ $? -eq 1 ]; then
    echo "Error: ffmpeg was not found on the path"
fi

META=FFMETADATAFILE

# Generate the metadata from the file, minus any chapters
ffmpeg -i "$INPUT" -f ffmetadata - | awk '/\[CHAPTER\]/{exit} 1' > $META

# Generate the chapters using the python helper script
python3 ../helper.py

# Re-apply the metadata to the video
ffmpeg -y -i "$INPUT" -i $META -map_metadata 1 -map_chapters 1 -codec copy "chapters-$INPUT"

rm $META