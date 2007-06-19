# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xproto/xproto-7.0.5.ebuild,v 1.1 2006/04/29 04:23:28 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit git x-modular

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xcb"

DESCRIPTION="X C-language Bindings utilities"
SRC_URI=""
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
RDEPEND=">=x11-libs/libxcb-9999"
DEPEND="${RDEPEND}
	dev-util/gperf"

# git.eclass uses $S so we need a different var
MY_S="${WORKDIR}/${P}/${PN}"

src_unpack() {
	git_src_unpack
	cd ${MY_S}
	x-modular_patch_source
	x-modular_reconf_source
}

src_compile() {
	cd ${MY_S}
	x-modular_src_compile
}

src_install() {
	cd ${MY_S}
	x-modular_src_install
}
