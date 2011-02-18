# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit waf-utils

DESCRIPTION="Opengl test suite"
HOMEPAGE="https://launchpad.net/glmark2"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="media-libs/mesa[gallium]"
RDEPEND="${DEPEND}"

src_configure() {
	: ${WAF_BINARY:="${S}/waf"}

	# it does not know --libdir specification, dandy huh
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		--prefix=/usr \
		--enable-gl \
		--enable-glesv2 \
		configure || die "configure failed"
}
