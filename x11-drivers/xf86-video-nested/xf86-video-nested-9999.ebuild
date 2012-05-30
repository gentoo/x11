# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="driver to run Xorg on top of Xorg or something else"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}"
