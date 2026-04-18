#!/bin/bash

# $1 is the target zip name (optional)
# All other arguments are files to include

# If no arguments, exit
if [ $# -eq 0 ]; then
  echo "No files provided."
  exit 1
fi

# Use first argument as first file
first_file="$1"
shift # remove first argument from $@

# Determine archive name based on first file's base name
# Strip directory and extension
base_name=$(basename "$first_file")
archive_name="${base_name%.*}.zip"

# Add the first file back to the list
set -- "$first_file" "$@"

# Create the ZIP
7z a -tzip "$archive_name" "$@"

echo "Created $archive_name"
