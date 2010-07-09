# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/demos"

if [[ ${PV} = 9999* ]]; then
	    GIT_ECLASS="git"
fi

inherit toolchain-funcs ${GIT_ECLASS}

MY_PN="${PN/m/M}"
MY_PN="${MY_PN/-progs}"
MY_P="${MY_PN}-${PV}"
LIB_P="${MY_PN}Lib-${PV}"
PROG_P="${MY_PN}Demos-${PV}"

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/mesa/${PV}/${LIB_P}.tar.bz2
		ftp://ftp.freedesktop.org/pub/mesa/${PV}/${PROG_P}.tar.bz2"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile() {
	tc-export CC
	emake LDLIBS='-lGL -lm' src/xdemos/{glxgears,glxinfo} || die
}

src_install() {
	dobin src/xdemos/{glxgears,glxinfo} || die
}
