#!/bin/bash

INPUT="$1"
OUTPUT="chapters-$INPUT"

touch "$OUTPUT"
docker run -v "$PWD:/data" --rm -ti gencore/ffmpeg-video-chapters:latest "$INPUT"