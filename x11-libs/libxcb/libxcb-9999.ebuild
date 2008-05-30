# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/libxcb"
PATCHES="${FILESDIR}/xcb-*.patch"

DESCRIPTION="X C-language Bindings library"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND="x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=x11-proto/xcb-proto-9999
	>=dev-lang/python-2.5"
