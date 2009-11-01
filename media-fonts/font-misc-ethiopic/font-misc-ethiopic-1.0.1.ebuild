# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-misc-ethiopic/font-misc-ethiopic-1.0.0-r1.ebuild,v 1.7 2009/10/26 19:15:03 jer Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

FONT_DIR="TTF OTF"

inherit x-modular

DESCRIPTION="Miscellaneous Ethiopic fonts"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/bdftopcf
	>=media-fonts/font-util-1.1.1-r1
	>=x11-misc/util-macros-1.3.0"

FONT_OPTIONS="--with-ttf-fontdir=/usr/share/fonts/TTF --with-otf-fontdir=/usr/share/fonts/OTF"
