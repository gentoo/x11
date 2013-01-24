# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-2

DESCRIPTION="Utility to view your Radeon GPU utilization"
HOMEPAGE="https://github.com/clbr/radeontop/"
LICENSE="GPL-3"
EGIT_REPO_URI="https://github.com/clbr/${PN}.git"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-libs/ncurses
	x11-libs/libpciaccess"
DEPEND="${RDEPEND}"
