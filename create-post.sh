#!/bin/bash

LATEST_NUM=$(ls -1 content/posts | sort -h | tail -1 | awk -F'.' '{print $1}')
POST_NUM=$(($LATEST_NUM + 1))
POST_FILE="content/posts/${POST_NUM}.md"
cp template.md content/posts/${POST_NUM}.md

if [ -f static/media/$POST_NUM.mp4 ]; then
	WIDTH=$(ffprobe -v quiet -print_format json -show_format -show_streams ./static/media/33.mp4 | jq '.streams[0] |.width')
	HEIGHT=$(ffprobe -v quiet -print_format json -show_format -show_streams ./static/media/33.mp4 | jq '.streams[0] |.height')
	sed -i "s/width:.*$/width: \"$WIDTH\"/g" $POST_FILE
	sed -i "s/height:.*$/height: \"$HEIGHT\"/g" $POST_FILE
fi

sed -i "s/cover:.*$/cover: \"$POST_NUM\"/g" $POST_FILE
