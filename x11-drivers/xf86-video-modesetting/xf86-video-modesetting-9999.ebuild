# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_DRI="dri"
inherit xorg-2

DESCRIPTION="Unaccelerated generic driver for kernel modesetting"

KEYWORDS="~amd64 ~x86"
IUSE="dri"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS="$(use_enable dri)"
}
