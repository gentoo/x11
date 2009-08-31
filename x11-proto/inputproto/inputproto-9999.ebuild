# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit x-modular

DESCRIPTION="X.Org Input protocol headers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=""
DEPEND="${RDEPEND}
!<x11-libs/libXi-1.2.99
>=x11-misc/util-macros-1.2"
