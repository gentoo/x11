# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mesa/mesa-7.0.2.ebuild,v 1.6 2007/11/16 18:16:30 dberkholz Exp $

EGIT_REPO_URI="git://anongit.freedesktop.org/mesa/mesa"

inherit autotools multilib flag-o-matic git

OPENGL_DIR="xorg-x11"

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV//_}"
MY_SRC_P="${MY_PN}Lib-${PV//_}"
DESCRIPTION="The GLcore module for OpenGL use under X"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ $PV = *_rc* ]]; then
	SRC_URI="http://www.mesa3d.org/beta/${MY_SRC_P}.tar.gz"
elif [[ $PV = 9999 ]]; then
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/mesa3d/${MY_SRC_P}.tar.bz2"
fi
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug pic kernel_FreeBSD"

RDEPEND=">=x11-base/xorg-server-9999"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-misc/makedepend
	x11-libs/libX11
	x11-proto/xextproto
	>=x11-proto/glproto-1.4.8"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf

	if use debug; then
		strip-flags
		append-flags -g
	fi

	# gcc 4.2 has buggy ivopts
	if [[ $(gcc-version) = "4.2" ]]; then
		append-flags -fno-ivopts
	fi

	# FreeBSD 6.* doesn't have posix_memalign().
	[[ ${CHOST} == *-freebsd6.* ]] && sed -i -e "s/-DHAVE_POSIX_MEMALIGN//" configure.ac

	eautoreconf

	# This is where we might later change to build xlib/osmesa
	myconf="${myconf} --with-driver=dri"

	# Overloaded dri-driverdir flag for GLcore installation location
	myconf="${myconf} --with-dri-driverdir=/usr/$(get_libdir)/xorg/modules/extensions"

	# Deactivate assembly code for pic build
	myconf="${myconf} $(use_enable pic asm)"

	# Sparc assembly code is not working
	myconf="${myconf} $(use_enable sparc asm)"

	econf ${myconf} || die
	pushd src/mesa 2>/dev/null
	emake libmesa.a || die
	popd 2>/dev/null
	emake glcore || die
}

src_install() {
#	dodir /usr
	emake \
		DESTDIR="${D}" \
		glcore-install || die "Installation failed"
}
