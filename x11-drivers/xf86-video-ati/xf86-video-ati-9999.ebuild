# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.6.3[-minimal]"
DEPEND="${RDEPEND}
	>=x11-libs/libdrm-2.4.17[video_cards_radeon]
	x11-proto/fontsproto
	x11-proto/glproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86driproto
	x11-proto/xf86miscproto
	x11-proto/xproto"

pkg_setup() {
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="
		--enable-dri
		--enable-kms
	"
}
