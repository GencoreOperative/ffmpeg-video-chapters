# Introduction

A simplified way of adding new chapters to a video. This docker project will add chapters to a intimage will, given a video file and a chapters file add in the chapters to the video using FFMEPG.

# Chapters File

In order to use this tool, there needs to be a file called `chapters.txt` in the current folder. This file must be in the following format:

```
0:00:00 chapter1
0:00:33 chapter2
0:32:19 End
```

Note:
- The hours must be single digits.
- There must be an end chapter that marks the end of the video. Otherwise the last chapter will be missing from the video.

# Usage

Using the provided script is the simplest way to invoke this functionality:
```
chapters.sh <video>
```

If you prefer to invoke the Docker image directly, then use the following command:

```
docker run -v "$PWD:/data" --rm $(docker build -q .) <video>
```

# Additional Information

The approach taken in this project is based on the work by Kyle Howells from their helpful [blog post](https://ikyle.me/blog/2020/add-mp4-chapters-ffmpeg).

We take the approach of ignoring the previous chapters that might be in the video. This is most likely what the user is trying to achieve. This approach is made up of two steps. First we need to strip the CHAPTER information from the metadata. The second is we need to use the `-map_chapters` function to overwrite any chapters that might be there.

Lastly, we can validate the output of the chapters by using the following command:

```
ffprobe -i output.mp4 -print_format json -show_chapters
```

This will provide us the chapters in JSON format.