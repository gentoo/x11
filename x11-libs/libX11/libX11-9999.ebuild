# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit x-modular toolchain-funcs flag-o-matic

# Xorg in general prefers automake-1.11
# libX11 master currently will build /only/ with automake-1.11
# but autotools uses 10.2 when WANT_AUTOMAKE="latest", so:
export WANT_AUTOMAKE="1.11"

DESCRIPTION="X.Org X11 library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 +xcb"

RDEPEND=">=x11-libs/xtrans-1.0.1
	x11-proto/kbproto
	>=x11-proto/xproto-9999
	xcb? ( >=x11-libs/libxcb-9999 )
	!xcb? (
		x11-libs/libXau
		x11-libs/libXdmcp
	)"
DEPEND="${RDEPEND}
	xcb? (
		x11-proto/bigreqsproto
		x11-proto/xcmiscproto
		x11-proto/xf86bigfontproto
	)
	x11-proto/inputproto
	x11-proto/xextproto
	>=x11-misc/util-macros-1.2.1"

pkg_setup() {
	CONFIGURE_OPTIONS="$(use_enable ipv6)
		$(use_with xcb)"
	# xorg really doesn't like xlocale disabled.
	# $(use_enable nls xlocale)
}

src_compile() {
	x-modular_src_configure
	# [Cross-Compile Love] Disable {C,LD}FLAGS and redefine CC= for 'makekeys'
	( filter-flags -m* ; cd src/util && make CC=$(tc-getBUILD_CC) CFLAGS="${CFLAGS}" LDFLAGS="" clean all)
	x-modular_src_make
}
