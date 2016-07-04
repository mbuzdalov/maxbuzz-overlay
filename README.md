# maxbuzz-overlay
This is my Gentoo overlay for various ebuilds I use. Currently it includes:

* `dev-util/idea-community` - the IntelliJ IDEA Community Edition development environment.
* `media-libs/libffado` - an ebuild for FFADO library which fixes the C++11 incompatibility problem.

sudo layman -o https://raw.githubusercontent.com/mbuzdalov/maxbuzz-overlay/master/layman.xml -f -a maxbuzz-overlay
