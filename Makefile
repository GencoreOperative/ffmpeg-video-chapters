# Variables
image_name=ffmpeg-video-chapters
git= $(shell git rev-parse --short HEAD)
image_version=latest

# Default target
.PHONY: build clean
all: build

# Build the Docker image
build:
	docker build -t $(image_name):$(image_version) docker
	docker build -t $(image_name):$(git) docker
	docker build -t $(image_name):latest docker

# Clean up Docker image
clean:
	docker image rm $(image_name):$(image_version)

publish:
	@echo "Pushing to DockerHub"
	@sh utils/docker-login
	docker push $(image_name):$(image-version)
	docker push $(image_name):$(git)
	docker push $(image_name):latest