#!/bin/bash

# Exit if any command fails
set -e

# Check if the correct number of arguments are passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 \"Post Title\""
    exit 1
fi

# Replace spaces in the title with dashes
FILENAME=$(echo $1 | sed -e 's/ /-/g' | tr '[:upper:]' '[:lower:]')

# Current date in the required format
DATE=$(date +%Y-%m-%d)

# Combine date and title to form the filename
FILENAME="${DATE}-${FILENAME}.md"

# Full path of the new post
POST_PATH="./_posts/${FILENAME}"

# Create a new post with the necessary front matter
echo "---" >>$POST_PATH
echo "layout: post" >>$POST_PATH
echo "title: $1" >>$POST_PATH
echo "date: $(date '+%Y-%m-%d %H:%M:%S %z')" >>$POST_PATH
echo "categories: []" >>$POST_PATH
echo "tags: []" >>$POST_PATH
echo "pin: false" >>$POST_PATH
echo "hidden: false" >>$POST_PATH
echo "---" >>$POST_PATH
echo "" >>$POST_PATH
echo "Your post content goes here." >>$POST_PATH

echo "New post created at ${POST_PATH}"
