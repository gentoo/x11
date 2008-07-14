# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN=${PN/-/_}
MY_P=${MY_PN}${PV/-/_}
DESCRIPTION="Supports precompressed textures with hardware decompression"
HOMEPAGE="http://homepage.hispeed.ch/rscheidegger/dri_experimental/s3tc_index.html"
SRC_URI="http://homepage.hispeed.ch/rscheidegger/dri_experimental/${MY_P}.tar.gz"
LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=""
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_PN}"

src_compile() {
	emake OPT_CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_info() {
	elog "Depending on where you live, you might need a valid license for s3tc"
	elog "in order to be legally allowed to use the external library."
	elog "Redistribution in binary form might also be problematic."
	elog "Ask your lawyer, the patent is supposedly held by VIA. It is your"
	elog "responsibility to comply with the laws of your country."
}

pkg_postinst() {
	pkg_info
}
