# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit x-modular-r2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/nouveau/${PN}"

DESCRIPTION="Nouveau video driver"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI=""

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.5.3[-minimal]
	>=x11-libs/libdrm-2.4.18"

DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xextproto
	x11-proto/xf86driproto
	x11-proto/xproto"

pkg_postinst() {
	if ! has_version x11-base/nouveau-drm; then
		ewarn "Nouveau DRM not detected. If you want any kind of"
		ewarn "acceleration with nouveau, emerge nouveau-drm or"
		ewarn "install the nouveau/linux-2.6 kernel."
	fi
}
