# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="Library providing generic access to the PCI bus and devices"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="minimal zlib"

DEPEND="!<x11-base/xorg-server-1.5
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	sys-apps/hwids"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		"$(use_with zlib)"
		"--with-pciids-path=${EPREFIX}/usr/share/misc"
	)
	xorg-2_src_configure
}

src_install() {
	xorg-2_src_install

	if ! use minimal; then
		scanpci_install() {
			${BASH} "${AUTOTOOLS_BUILD_DIR:-${S}}/libtool" \
				--mode=install "$(type -P install)" -c \
				"${AUTOTOOLS_BUILD_DIR:-${S}}/scanpci/scanpci" \
				"${ED}"/usr/bin || die
		}

		dodir /usr/bin || die
		multilib_foreach_impl scanpci_install
	fi
}
