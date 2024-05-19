#!/bin/bash

video_folder="./video"

cd "$video_folder" || exit 1

wget -i '../video_urls.txt'

target_video_bitrate='500k'
segment_duration=600

for video_file in *.avi; do
    video_file_basename=$(basename "$video_file" .avi)

    duration=$(ffprobe -i "$video_file" -show_entries format=duration -v quiet -of csv="p=0")
    
    num_segments=$(echo "($duration + $segment_duration - 1) / $segment_duration" | bc)

    for (( i=0; i<num_segments; i++ )); do
        start_time=$(echo "$i * $segment_duration" | bc)
        end_time=$(echo "$start_time + $segment_duration - 1" | bc)

        if (( $(echo "$end_time > $duration" | bc -l) )); then
            end_time=$duration
        fi

        segment_file="${video_file_basename}_${start_time}-${end_time}.avi"

        ffmpeg -i "$video_file" -ss "$start_time" -to "$end_time" -c copy "$segment_file"

        if (( i == num_segments - 1 )); then
            output_file="${segment_file%.*}.webm"
            ffmpeg -i "$segment_file" -c:v libvpx-vp9 -preset veryfast -quality good -b:v "$target_video_bitrate" -c:a libopus "$output_file"
        fi

        rm "$segment_file"
    done
done
