# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
XORG_DOC="doc"

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://github.com/xkbcommon/${PN}"
else
	SRC_URI="http://xkbcommon.org/download/${P}.tar.xz"
fi

inherit xorg-2 ${GIT_ECLASS}

DESCRIPTION="X.Org xkbcommon library"
KEYWORDS="~amd64 ~arm ~x86"

DEPEND="sys-devel/bison
	sys-devel/flex
	x11-proto/xproto
	>=x11-proto/kbproto-1.0.5"
RDEPEND=""

XORG_CONFIGURE_OPTIONS=(
	--with-xkb-config-root="${EPREFIX}/usr/share/X11/xkb" $(use_with doc doxygen)
)
