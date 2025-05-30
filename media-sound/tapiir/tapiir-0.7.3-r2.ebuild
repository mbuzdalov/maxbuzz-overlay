# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Slightly modified by MaxBuzz to depend on virtual/jack and to fix includes

EAPI=8

inherit autotools

DESCRIPTION="A flexible audio effects processor, inspired by classical tape delay systems"
HOMEPAGE="http://www.resorama.com/maarten/tapiir/"
SRC_URI="http://www.resorama.com/maarten/files/tapiir-0.7.3.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

RDEPEND="
	virtual/jack
	media-libs/alsa-lib
	x11-libs/fltk:1
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${PN}-0.7.2-ldflags.patch
          "${FILESDIR}/"${PN}-0.7.3-file-chooser.patch )

src_prepare() {
	default
	mv configure.{in,ac} || die
	cp "${FILESDIR}"/${P}-acinclude.m4 acinclude.m4 || die
	eautoreconf
}

src_install() {
	local HTML_DOCS=( doc/{*.html,images/*.png} )
	default

	doman doc/${PN}.1
	dodoc doc/${PN}.txt

	insinto /usr/share/${PN}/examples
	doins doc/examples/*.mtd
}
