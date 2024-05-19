#!/bin/bash

timestamp=$(date +"%Y-%m-%d_%H-%M-%S") 

processed_dir="out_processed_$timestamp"
mkdir "$processed_dir"

log_file="$processed_dir/conversion.log.txt"
echo "Start of file processing at $timestamp" > "$log_file"

for input_file in in/*.jpeg; do
  if [ -f "$input_file" ]; then
    output_file="$processed_dir/$(basename "$input_file")"
    if convert "$input_file" -resize 30% "$output_file"; then
      echo "File $input_file processed successfully. New filename: $output_file" >> "$log_file"
    else
      echo "Error processing file: $input_file" >> "$log_file"
    fi
  fi
done

zip -r "processed_files_$timestamp.zip" "$processed_dir"
rm -rf "$processed_dir"
