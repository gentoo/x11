# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

XORG_DRI=always
inherit xorg-2

DESCRIPTION="ATI video driver"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libdrm-2.4.33[video_cards_radeon]"
DEPEND="${RDEPEND}"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		--enable-dri
		--enable-kms
		--enable-exa
	)
	xorg-2_src_configure
}
