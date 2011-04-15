# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit xorg-2

DESCRIPTION="Library providing generic access to the PCI bus and devices"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="minimal"

DEPEND="!<x11-base/xorg-server-1.5"
RDEPEND="${DEPEND}"

XORG_CONFIGURE_OPTIONS=(
	--with-pciids-path=/usr/share/misc
)

src_install() {
	xorg-2_src_install
	if ! use minimal; then
		dobin "${AUTOTOOLS_BUILD_DIR}"/scanpci/scanpci
	fi
}
