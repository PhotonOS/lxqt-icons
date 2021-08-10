#!/bin/bash

if [ -n convert ]
then
    echo "ImageMagick detected. Here we go..."
else
    echo "Please install the ImageMagick CLI and try again."
    echo "http://www.imagemagick.org/"
    exit 1
fi

OUTFOLDER="dist"
ASSETSFOLDER="assets"

# Create Distilled Folder
if [ ! -d $OUTFOLDER ]
then
    mkdir -p $OUTFOLDER
else
    rm -rf $OUTFOLDER
fi

declare -A sizes

sizes[8x8]=8x8
sizes[16x16]=16x16
sizes[32x32]=16x16@2x
sizes[18x18]=18x18
sizes[36x36]=18x18@2x
sizes[20x20]=20x20
sizes[40x40]=20x20@2x
sizes[22x22]=22x22
sizes[44x44]=22x22@2x
sizes[24x24]=24x24
sizes[48x48]=24x24@2x
sizes[32x32]=32x32
sizes[64x64]=32x32@2x
sizes[48x48]=48x48
sizes[96x96]=48x48@2x
sizes[64x64]=64x64
sizes[128x128]=64x64@2x
sizes[96x96]=96x96
sizes[192x192]=96x96@2x

for directory in $ASSETSFOLDER/*; do
    for filename in $directory/*; do

        directory=${directory##*/}
        filename=${filename##*/}

        if [ "$filename" == "*" ]; then continue; fi;

        echo "... generating ${directory} ${filename}"

        for size in "${!sizes[@]}"
        do
            mkdir -p $OUTFOLDER/${sizes[$size]}/${directory}
            convert $ASSETSFOLDER/$directory/$filename -resize $size! $OUTFOLDER/${sizes[$size]}/${directory}/${filename}
        done
    done
done

cp -r {LICENSE,AUTHORS,cursors,index.theme,preview.png} $OUTFOLDER

echo "Done! Icon Pack generated to $OUTFOLDER/"
