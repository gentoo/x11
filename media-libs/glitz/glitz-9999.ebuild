# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}"
EGIT_BOOTSTRAP="eautoreconf"
inherit git

DESCRIPTION="An OpenGL image compositing library"
HOMEPAGE="http://www.freedesktop.org/Software/glitz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/opengl"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO
}
