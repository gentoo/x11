# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="http://dri.freedesktop.org/${PN}/${P}.tar.bz2"
fi

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
VIDEO_CARDS="intel nouveau radeon vmware"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}"
RESTRICT="test" # see bug #236845

RDEPEND="dev-libs/libpthread-stubs"
DEPEND="${RDEPEND}"

pkg_setup() {
	CONFIGURE_OPTIONS="--enable-udev
			$(use_enable video_cards_intel intel)
			$(use_enable video_cards_nouveau nouveau-experimental-api)
			$(use_enable video_cards_radeon radeon)
			$(use_enable video_cards_vmware vmwgfx-experimental-api)
			$(use_enable kernel_linux libkms)"

	xorg-2_pkg_setup
}

pkg_postinst() {
	xorg-2_pkg_postinst

	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}
