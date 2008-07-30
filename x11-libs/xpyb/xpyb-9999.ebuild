# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXi/libXi-1.1.3.ebuild,v 1.8 2008/01/13 09:23:20 vapier Exp $

inherit x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb/xpyb"

DESCRIPTION="XCB-based Python bindings for the X Window System"
HOMEPAGE="http://xcb.freedesktop.org/"
LICENSE="X11"
KEYWORDS="~amd64 ~x86"
IUSE="selinux"
RDEPEND=">=x11-libs/libxcb-1.1
	>=dev-lang/python-2.5"
DEPEND="${RDEPEND}
	>=x11-proto/xcb-proto-1.2"
CONFIGURE_OPTIONS="$(use_enable selinux)"
DOCS="NEWS README"
