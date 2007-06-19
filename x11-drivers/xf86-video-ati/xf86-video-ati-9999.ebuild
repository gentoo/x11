# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.6.192.ebuild,v 1.1 2007/05/21 05:25:33 dberkholz Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"
XDPVER=4

inherit x-modular git

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/driver/${PN}"

DESCRIPTION="ATI video driver"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
SRC_URI=""
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86miscproto
	x11-proto/xproto
	dri? ( x11-proto/glproto
			x11-proto/xf86driproto
			>=x11-libs/libdrm-2 )"

CONFIGURE_OPTIONS="$(use_enable dri)"

pkg_setup() {
	if use dri && ! built_with_use x11-base/xorg-server dri; then
		die "Build x11-base/xorg-server with USE=dri."
	fi
}

src_unpack() {
	x-modular_specs_check
	x-modular_server_supports_drivers_check
	x-modular_dri_check
	git_src_unpack
	cd ${S}
	x-modular_patch_source
	x-modular_reconf_source
}
