# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools cvs

ECVS_SERVER="anoncvs.freedesktop.org:/cvs/cairo"
ECVS_MODULE="glitz"
#ECVS_CO_DATE=${PV##*p}
#ECVS_UP_OPTS="-D ${ECVS_CO_DATE} -dP"
#ECVS_CO_OPTS="-D ${ECVS_CO_DATE}"

S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/opengl"

src_compile() {
	eautoreconf || die "autoreconf failed"
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
}
