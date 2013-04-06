# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} )
inherit python-single-r1 xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/xpyb"
#SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
DESCRIPTION="XCB-based Python bindings for the X Window System"
HOMEPAGE="http://xcb.freedesktop.org/"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="selinux"

RDEPEND=">=x11-libs/libxcb-1.7
	>=x11-proto/xcb-proto-1.7.1[${PYTHON_USEDEP}]
	${PYTHON_DEPS}"
DEPEND="${RDEPEND}"

DOCS=( NEWS README )

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable selinux xselinux)
	)
	xorg-2_src_configure
}
