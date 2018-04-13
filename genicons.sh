#! /bin/bash

# Copyright (c) 2018 Florian Léger
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

if [[ $# != 3 ]]; then
	echo "Usage: $0 iconsource basedir iconpath.png"
	echo
	echo "Note: iconsource must be an image with the same height and width"
	echo
	echo "Example:"
	echo "Generate application icons derived from myapp.png for the hicolor iconset:"
	echo "$0 myapp.png /usr/share/icons/hicolor apps/myapp.png"
	exit 1
fi

w=$(convert "$1" -print "%w" /dev/null)
h=$(convert "$1" -print "%h" /dev/null)

if [[ "$h" != "$w" ]]; then
	echo "Only square icons are supported!"
	exit 2
fi

readonly -a SIZES=(512 384 256 192 128 96 72 64 48 36 32 24 22 16)

for s in ${SIZES[@]}; do
	if [[ "$w" -lt "$s" ]]; then
		continue
	fi
	args=()
	if [[ "$w" != "$s" ]]; then
		args=(-resize ${s}x${s}\> -unsharp 1.5x1+0.7+0.02)
	fi
	echo "Generating $2/${s}x${s}/${3}"
	install -dm755 "$(dirname "$2/${s}x${s}/${3}")"
	convert "$1" "${args[@]}" "$2/${s}x${s}/${3}"
	optipng -o7 "$2/${s}x${s}/${3}"
done
