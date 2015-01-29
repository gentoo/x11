# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils git-r3

if [ ${PV} == 9999 ]; then
	EGIT_REPO_URI="https://github.com/nuclide/nuclear.git"
	KEYWORDS=""
else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A Shell plugin for Weston"
HOMEPAGE="https://github.com/nuclide/nuclear"

LICENSE="LGPL-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/weston-1.4.0"
RDEPEND="${DEPEND}"
