# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2 toolchain-funcs flag-o-matic

DESCRIPTION="X.Org X11 library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc ipv6 test"

RDEPEND=">=x11-libs/libxcb-1.1.92
	x11-libs/xtrans
	>=x11-proto/xproto-7.0.13
	x11-proto/xf86bigfontproto
	x11-proto/inputproto
	x11-proto/kbproto
	x11-proto/xextproto"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto )
	test? ( dev-lang/perl )"

pkg_setup() {
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="
		$(use_with doc xmlto)
		$(use_enable doc specs)
		$(use_enable ipv6)
		--without-fop
	"
}

src_compile() {
	# [Cross-Compile Love] Disable {C,LD}FLAGS and redefine CC= for 'makekeys'
	( filter-flags -m* ; cd src/util && make CC=$(tc-getBUILD_CC) CFLAGS="${CFLAGS}" LDFLAGS="" clean all)
	xorg-2_src_compile
}
