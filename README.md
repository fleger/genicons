# genicons

Command line shell script to generate XDG compliant icons from a single image.

## Installation

Just copy genicons.sh in your path.

## Dependencies

* [ImageMagick](https://www.imagemagick.org/script/index.php)
* [OptiPNG](http://optipng.sourceforge.net/)

## Usage

### Syntax

genicons *iconsource* *basedir* *iconpath*

### Example

The following command will generate application icons derived from *myapp.png* for the hicolor iconset:

```shell
genicons myapp.png /usr/share/icons/hicolor apps/myapp.png
```
