# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit xorg-2

DESCRIPTION="X C-language Bindings demos"
SRC_URI="http://xcb.freedesktop.org/dist/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND="x11-libs/libxcb
	x11-libs/xcb-util"
DEPEND="${RDEPEND}"
