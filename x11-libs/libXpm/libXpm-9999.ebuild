# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit xorg-2 flag-o-matic

DESCRIPTION="X.Org Xpm library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}
	sys-devel/gettext
	x11-proto/xproto"

src_compile() {
	# the gettext configure check and code in sxpm are incorrect; they assume
	# gettext being in libintl, whereas Solaris has gettext by default
	# resulting in libintl not being added to LIBS
	[[ ${CHOST} == *-solaris* ]] && append-libs -lintl
	xorg-2_src_compile
}

