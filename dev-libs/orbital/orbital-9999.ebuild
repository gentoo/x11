# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils git-r3

if [ ${PV} == 9999 ]; then
	EGIT_REPO_URI="https://github.com/giucam/orbital.git"
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A Wayland shell client"
HOMEPAGE="https://github.com/giucam/orbital"

LICENSE="GPL-3"
SLOT="0"
IUSE="alsa logind solid"

DEPEND="
	dev-libs/nuclear
	dev-qt/qtwayland
	dev-qt/linguist-tools:5
	alsa? ( media-libs/alsa-lib )
	logind? ( sys-apps/systemd )
	solid? ( kde-frameworks/solid )
"
RDEPEND="${DEPEND}
	dev-qt/qtquickcontrols:5
	dev-qt/qtgraphicaleffects:5
	"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package alsa)
		$(cmake-utils_use_find_package logind)
		$(cmake-utils_use_find_package solid)
	)
	cmake-utils_src_configure
}
