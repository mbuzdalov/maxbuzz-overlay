# maxbuzz-overlay
This is my Gentoo overlay for various ebuilds I use. Currently it includes:

* `media-libs/libffado` - an ebuild for FFADO library which fixes the C++11 incompatibility problem.

sudo layman -o https://raw.githubusercontent.com/mbuzdalov/maxbuzz-overlay/master/layman.xml -f -a maxbuzz-overlay
