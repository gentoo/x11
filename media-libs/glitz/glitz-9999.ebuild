# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz/glitz-0.5.6.ebuild,v 1.9 2006/12/01 18:44:45 gustavoz Exp $

inherit autotools cvs

ECVS_SERVER="anoncvs.freedesktop.org:/cvs/cairo"
ECVS_MODULE="glitz"

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc-macos ppc64 sh x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/opengl"

src_compile() {
	eautoreconf || die "autoreconf failed"
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
