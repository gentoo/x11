# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-ati/xf86-video-ati-6.6.192.ebuild,v 1.1 2007/05/21 05:25:33 dberkholz Exp $

EAPI="2"

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="ATI video driver"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
SRC_URI=""
IUSE="+radeon-kms"

RDEPEND=">=x11-base/xorg-server-1.2"
DEPEND="${RDEPEND}
	>=x11-libs/libdrm-2[radeon-kms?]
	>=x11-misc/util-macros-1.1.3
	x11-proto/fontsproto
	x11-proto/glproto
	x11-proto/randrproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xf86driproto
	x11-proto/xf86miscproto
	x11-proto/xproto
	radeon-kms? ( x11-libs/libpciaccess )
"

CONFIGURE_OPTIONS="--enable-dri"

pkg_setup() {
	if use radeon-kms; then
		EGIT_REPO_URI="git://people.freedesktop.org/~glisse/${PN}"
		EGIT_BRANCH="radeon-gem-cs3"
		EGIT_TREE="radeon-gem-cs3"
	fi
}
