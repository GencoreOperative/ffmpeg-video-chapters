# Variables
image_name=ffmpeg-video-chapters
image_version=latest

# Default target
.PHONY: build clean
all: build

# Build the Docker image
build:
	docker build -t $(image_name):$(image_version) docker

# Clean up Docker image
clean:
	docker image rm $(image_name):$(image_version)