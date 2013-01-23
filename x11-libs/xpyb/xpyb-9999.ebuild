# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/xpyb"
#SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
DESCRIPTION="XCB-based Python bindings for the X Window System"
HOMEPAGE="http://xcb.freedesktop.org/"

KEYWORDS="~amd64 ~x86"
IUSE="selinux"

RDEPEND=">=x11-libs/libxcb-1.1
	>=dev-lang/python-2.5
	>=x11-proto/xcb-proto-1.2"
DEPEND="${RDEPEND}"

DOCS=( NEWS README )

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable selinux xselinux)
	)
	xorg-2_src_configure
}
