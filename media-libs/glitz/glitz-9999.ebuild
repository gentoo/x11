# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glitz/glitz-0.5.6.ebuild,v 1.9 2006/12/01 18:44:45 gustavoz Exp $

EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}"
EGIT_BOOTSTRAP="eautoreconf"
inherit git

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="virtual/opengl"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
