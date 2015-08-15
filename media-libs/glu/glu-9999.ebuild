# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/glu"

if [[ ${PV} = 9999* ]]; then
	AUTOTOOLS_AUTORECONF=1
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit autotools-multilib multilib ${GIT_ECLASS}

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="http://cgit.freedesktop.org/mesa/glu/"

if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/mesa/${PN}/${P}.tar.bz2"
fi

LICENSE="SGI-B-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs"

DEPEND="virtual/opengl"
RDEPEND="${DEPEND}
	!<media-libs/mesa-9
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-opengl-20130224 )"

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-r3_src_unpack
}

src_test() {
	:;
}
