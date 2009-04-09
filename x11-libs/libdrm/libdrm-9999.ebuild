# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdrm/libdrm-2.3.0.ebuild,v 1.8 2007/05/20 20:47:52 jer Exp $

EAPI="1"

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit autotools x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/mesa/drm"

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="http://dri.freedesktop.org/"
SRC_URI=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE_VIDEO_CARDS="video_cards_nouveau"

IUSE="+udev ${IUSE_VIDEO_CARDS}"

DEPEND="
	dev-libs/libpthread-stubs
	udev? ( sys-fs/udev )
"
RDEPEND="${DEPEND}"


RESTRICT="test" # see bug #236845

CONFIGURE_OPTIONS="$(use_enable udev)
	$(use_enable video_cards_nouveau nouveau-experimental-api)"

pkg_postinst() {
	x-modular_pkg_postinst

	if use video_cards_nouveau ; then
		elog "You built libdrm with experimental support for nouveau video cards."
	fi
	echo
	ewarn "libdrm's ABI may have changed without change in library name"
	ewarn "Please rebuild media-libs/mesa, x11-base/xorg-server and"
	ewarn "your video drivers in x11-drivers/*."
}
