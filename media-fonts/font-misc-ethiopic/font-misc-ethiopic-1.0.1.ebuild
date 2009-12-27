# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

FONT_DIR="TTF OTF"

EAPI=2
inherit x-modular-r2

DESCRIPTION="Miscellaneous Ethiopic fonts"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf"

FONT_OPTIONS="--with-ttf-fontdir=/usr/share/fonts/TTF --with-otf-fontdir=/usr/share/fonts/OTF"
