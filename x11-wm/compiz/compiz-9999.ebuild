# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools eutils git flag-o-matic multilib

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/app/compiz"

DESCRIPTION="compiz composite manager"
HOMEPAGE="http://xorg.freedesktop.org"
LICENSE="X11"
SLOT="0"
KEYWORDS="-*"
IUSE="gnome kde svg"

DEPEND="media-libs/mesa
	x11-libs/startup-notification
	media-libs/libpng
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	>=x11-libs/libwnck-2.14
	media-libs/glew	
	gnome? (
		x11-libs/libwnck
		gnome-base/gnome-desktop
		gnome-base/control-center
	)
	kde? ( >=x11-libs/qt-4.1.0 )
	svg? ( >=gnome-base/librsvg-2.14
		>=x11-libs/cairo-1 )"

RDEPEND="!x11-plugins/compiz-plugin-opacity"

EGIT_BOOTSTRAP="eautoreconf"

src_compile() {
	use amd64 && replace-flags -O[1-9] -O0

	# Some weird stuff from the ./autogen.sh
	ln -s ../po config/po
	intltoolize --force --copy --automake
	rm config/po

	econf \
		`use_enable gnome` \
		`use_enable kde` \
		`use_enable svg librsvg` \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
