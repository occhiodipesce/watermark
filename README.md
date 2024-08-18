# watermark

Bash script to batch watermark photos using ImageMagick.

## Requirements

- [ImageMagick](https://imagemagick.org/index.php)
- [bc](https://www.gnu.org/software/bc/)

## Usage

Place the script and watermark in the folder with the images or change the `IMAGES_DIR` and `WATERMARK` paths to point to the script and the desired file respectively.

Edit the watermark.svg file or use another image (remember to change the `WATERMARK` path).

Adjust `PERCENT_DIMENSION` and `PERCENT_OFFSET` if necessary. `1` means the watermark uses 100% of the main size of the photo.

Also, if needed, change the `.jpg` extension in the _for loop_ to whatever you need.
