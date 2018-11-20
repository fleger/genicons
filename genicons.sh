#! /bin/bash

# Copyright (c) 2018 Florian Léger
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

usage() {
    echo "Usage: $0 ICON_SOURCE BASE_DIR iconpath.{png|svg}"
    echo
    echo "Resizes the provided icon to the sizes present in the hicolor icon theme."
    echo "ICON_SOURCE must be an image with the same height and width."
    echo "In any case $0 will never upscale ICON_SOURCE."
    echo "If ICON_SOURCE is a SVG icon, $0 will automatically rasterize the icon."
    echo
    echo "Example:"
    echo "  Generate application icons derived from myapp.png for the hicolor iconset:"
    echo "  $0 myapp.png /usr/share/icons/hicolor apps/myapp.png"
    exit 1
}

if [[ $# != 3 ]]; then
   usage
fi

w=$(convert "$1" -print "%w" /dev/null)
h=$(convert "$1" -print "%h" /dev/null)
fmt=$(convert "$1" -print "%m" /dev/null)

if [[ "$h" != "$w" ]]; then
    echo "Only square icons are supported!"
    exit 2
fi

readonly -a SIZES=(512 384 256 192 128 96 72 64 48 36 32 24 22 16)

for s in ${SIZES[@]}; do
    if [[ "$fmt" != "SVG" ]] &&  [[ "$w" -lt "$s" ]]; then
        continue
    fi
    target_file="$2/${s}x${s}/${3}"
    echo "Generating $target_file"
    install -dm755 "$(dirname "$target_file")"
    if [[ "$fmt" != "SVG" ]]; then
        args=()
        if [[ "$w" != "$s" ]]; then
            args=(-resize ${s}x${s}\> -unsharp 1.5x1+0.7+0.02)
        fi
        convert "$1" "${args[@]}" "$target_file"
    else
        # Rasterize SVG
        rsvg-convert -w "$s" -h "$s" -f png -o "$target_file" "$1"
    fi
    optipng -o7 "$target_file"
done
