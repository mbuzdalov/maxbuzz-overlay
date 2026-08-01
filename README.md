# maxbuzz-overlay
This is my Gentoo overlay for various ebuilds I use. Currently it includes:

* `media-gfx/prusaslicer` - A mesh slicer to generate G-code for fused-filament-fabrication (3D printers). This version can build without webkit.
* `media-sound/tapiir` - Tapiir, a fast, simple and precise sound looping software. This ebuild can build with jack2.

sudo layman -o https://raw.githubusercontent.com/mbuzdalov/maxbuzz-overlay/master/layman.xml -f -a maxbuzz-overlay
