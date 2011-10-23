# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="Unaccelerated generic driver for kernel modesetting"
SRC_URI=""

KEYWORDS="~amd64 ~x86"
IUSE="dri"

RDEPEND="x11-libs/libdrm
	x11-libs/libXvMC"
DEPEND="${RDEPEND}"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS="$(use_enable dri)"
}
