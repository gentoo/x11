# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dri"

RDEPEND="dri? ( x11-libs/libdrm[video_cards_radeon] )"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="
		$(use_enable dri)
		$(use_enable dri kms)
		--enable-exa
	"
}
