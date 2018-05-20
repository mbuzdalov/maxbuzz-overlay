# maxbuzz-overlay
This is my Gentoo overlay for various ebuilds I use. Currently it includes:

* `dev-util/idea-community` - IntelliJ IDEA Community Edition, the ebuilds for the up-to-date versions.
* `media-gfx/blender` - a modified ebuild for Blender which can link against recent ffmpeg.
* `media-sound/tapiir` - Tapiir, a fast, simple and precise sound looping software. This ebuild can build with jack2.

sudo layman -o https://raw.githubusercontent.com/mbuzdalov/maxbuzz-overlay/master/layman.xml -f -a maxbuzz-overlay
