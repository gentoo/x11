# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MY_PN=${PN/progs/demos}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://anongit.freedesktop.org/${MY_PN/-//}"
EGIT_PROJECT="mesa-progs"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit base autotools toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/${MY_PN/-//}/${PV}/${MY_P}.tar.bz2"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="egl gles1 gles2"

RDEPEND="virtual/opengl"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-2_src_unpack
}

src_prepare() {
	base_src_prepare

	eautoreconf
}

src_configure() {
	# We're not using the complete buildsystem if we only want to build
	# glxinfo and glxgears.
	if use egl || use gles1 || use gles2; then
		default_src_configure
	fi
}

src_compile() {
	if ! use egl && ! use gles1 && ! use gles2; then
		tc-export CC
		emake LDLIBS='-lX11 -lGL -lm' src/xdemos/{glxgears,glxinfo}
	else
		emake -C src/xdemos glxgears glxinfo
	fi

	if use egl; then
		emake -C src/egl/eglut/ libeglut_screen.la libeglut_x11.la
		emake -C src/egl/opengl/ eglgears_screen eglgears_x11

		use gles1 && emake -C src/egl/opengles1/ es1_info gears_screen gears_x11
		use gles2 && emake -C src/egl/opengles2/ es2_info es2gears_screen es2gears_x11
	fi
}

src_install() {
	dobin src/xdemos/{glxgears,glxinfo}
	if use egl; then
		dobin src/egl/opengl/eglgears_{screen,x11}

		if use gles1; then
			dobin src/egl/opengles1/es1_info
			newbin src/egl/opengles1/gears_screen es1gears_screen
			newbin src/egl/opengles1/gears_x11 es1gears_x11
		fi

		use gles2 && dobin src/egl/opengles2/es2{_info,gears_{screen,x11}}
	fi
}
