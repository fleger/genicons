# genicons

Command line shell script to generate XDG compliant icons from a single SVG or raster image.

## Installation

Just copy genicons.sh in your path.

## Dependencies

* [ImageMagick](https://www.imagemagick.org/script/index.php)
* [libRSVG](https://wiki.gnome.org/Projects/LibRsvg)
* [Efficient Compression Tool](https://github.com/fhanau/Efficient-Compression-Tool)

## Usage

### Syntax

genicons *iconsource* *basedir* *iconpath*

### Example

The following command will generate application icons derived from *myapp.png* for the hicolor iconset:

```shell
genicons myapp.png /usr/share/icons/hicolor apps/myapp.png
```
