#!/bin/bash
# find usb capture card
DEVICE=$(v4l2-ctl --list-devices | grep -A1 'USB Video' | tail -n1 | tr -d '\t')
# optionally override window size
GEOMETRY=${1:-640x480}
# stream in mjpeg format to overcome 5 Hz limit
mpv --demuxer-lavf-format=video4linux2 --demuxer-lavf-o=video_size=$GEOMETRY,input_format=mjpeg --profile=low-latency av://v4l2:$DEVICE
