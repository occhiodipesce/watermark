#!/bin/bash

# Directory containing images
IMAGES_DIR="."

# Path to the SVG watermark file
WATERMARK="./watermark.svg"

# Dimension & offset percentage (between 0 and 1)
PERCENT_DIMENSION=0.07
PERCENT_OFFSET=0.01

# Loop through all JPEG images in the directory
for img in "$IMAGES_DIR"/*.jpg; do

  # Get widht and height of the image
  IMG_WIDTH=$(identify -format "%w" "$img")
  IMG_HEIGHT=$(identify -format "%h" "$img")

  # Calculate watermark dimension based on image format
  # If the width is greater than the height, the watermark dimension is relative to image width
  if [[ $IMG_WIDTH -ge $IMG_HEIGHT ]]; then
    WATERMARK_WIDTH=$(echo "$IMG_WIDTH * $PERCENT_DIMENSION * 0.8" | bc) # the dimension and the offset are scaled down by 0.8. Change to preference
    WATERMARK_OFFSET=$(echo "$IMG_WIDTH * $PERCENT_OFFSET * 0.8" | bc)
  else # is relative to image height
    WATERMARK_WIDTH=$(echo "$IMG_HEIGHT * $PERCENT_DIMENSION" | bc)
    WATERMARK_OFFSET=$(echo "$IMG_HEIGHT * $PERCENT_OFFSET" | bc)
  fi

  # Extract filename without extension
  BASE_NAME=$(basename -- "$img")
  BASE_NAME="${BASE_NAME%.*}"

  # Create output path for processed image
  OUTPUT_PATH="$IMAGES_DIR/${BASE_NAME}_watermark.jpg"

  # Use ImageMagick to add the watermark
  composite -compose atop -geometry x"$WATERMARK_WIDTH"+"$WATERMARK_OFFSET" -gravity southeast -background none "$WATERMARK" "$img" "$OUTPUT_PATH"

  echo "Watermark added to: $OUTPUT_PATH"
done
