# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libX11/libX11-1.0.0-r2.ebuild,v 1.4 2006/03/31 19:35:56 flameeyes Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/lib/libX11"

inherit x-modular git

DESCRIPTION="X.Org X11 library"
SRC_URI=""
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="ipv6 xcb"
RDEPEND="x11-libs/xtrans
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-proto/kbproto
	x11-proto/inputproto
	>=x11-proto/xproto-7.0.6
	xcb? ( x11-libs/libxcb )"
DEPEND="${RDEPEND}
	x11-proto/xf86bigfontproto
	x11-proto/bigreqsproto
	x11-proto/xextproto
	x11-proto/xcmiscproto
	>=x11-misc/util-macros-0.99.0_p20051007"

CONFIGURE_OPTIONS="$(use_enable ipv6)
	$(use_with xcb)"
# xorg really doesn't like xlocale disabled.
# $(use_enable nls xlocale)

src_unpack() {
	x-modular_specs_check
	x-modular_dri_check
	git_src_unpack
	cd ${S}
	x-modular_patch_source
	x-modular_reconf_source
}

src_install() {
	x-modular_src_install

	local ENVD="10libx11"
	echo "LDPATH=\"/usr/lib\"" > ${T}/${ENVD}
	doenvd ${T}/${ENVD}
}
