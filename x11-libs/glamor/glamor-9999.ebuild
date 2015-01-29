# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

XORG_DRI=always
XORG_EAUTORECONF=yes
XORG_MODULE_REBUILD=yes

inherit xorg-2

DESCRIPTION="OpenGL based 2D rendering acceleration library"
if [[ ${PV} == 9999* ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/driver/glamor"
else
	SRC_URI="mirror://gentoo/${P}.tar.gz"
fi

KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="gles xv"

RDEPEND=">=x11-base/xorg-server-1.10
	>=media-libs/mesa-10[egl,gbm]
	gles? (
		|| ( media-libs/mesa[gles2] media-libs/mesa[gles] )
	)
	>=x11-libs/pixman-0.21.8"
DEPEND="${RDEPEND}"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable gles glamor-gles2)
		$(use_enable xv)
	)
	xorg-2_src_configure
}
