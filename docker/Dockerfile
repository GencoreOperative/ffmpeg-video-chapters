FROM python:3

# Update package lists, install ffmpeg, and clean up package cache
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD helper.py /
ADD script.sh /

ENTRYPOINT [ "/bin/bash", "/script.sh" ]