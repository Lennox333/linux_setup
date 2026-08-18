#!/bin/bash

# $1 is the target zip name (optional)
# All other arguments are files to include

# Show help if requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  echo "Usage: zip_selected [output.zip] file1 [file2 ...]"
  echo ""
  echo "Create a ZIP archive from selected files using 7z."
  echo ""
  echo "Arguments:"
  echo "  output.zip    Optional custom archive name (default: derived from first file)"
  echo "  file1 ...     Files to include in the archive"
  echo ""
  echo "Options:"
  echo "  -h, --help    Show this help message"
  exit 0
fi

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
