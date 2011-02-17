# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit base multilib toolchain-funcs versionator

MY_PV=$(get_version_component_range $(get_version_component_count))
MY_P=${PN}${MY_PV#pre}

DESCRIPTION="Helper library for	S3TC texture (de)compression"
HOMEPAGE="http://people.freedesktop.org/~cbrill/libtxc_dxtn/"
SRC_URI="${HOMEPAGE}${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}
RESTRICT="bindist fetch"

pkg_nofetch() {
	eerror "Due to unclear patent situation, you have to download the package"
	eerror "yourself. Grab it from:"
	eerror "	${SRC_URI}"
	eerror "and place in your distfiles directory:"
	eerror "	${DISTDIR}"
	eerror
	eerror "Please notice that depending on where you live, you might need"
	eerror "a valid license for s3tc in order to be legally allowed to use"
	eerror "the external library."
}

src_compile() {
	local ABI

	tc-export CC
	for ABI in $(get_all_abis); do
		einfo "Building for ${ABI} ..."
		multilib_toolchain_setup ${ABI}
		mkdir ${ABI} || die
		emake || die
		mv ${PN}.so *.o ${ABI}/ || die
	done
}

src_install() {
	local ABI

	for ABI in $(get_all_abis); do
		dolib ${ABI}/${PN}.so || die
	done
}

pkg_postinst() {
	ewarn "Depending on where you live, you might need a valid license for s3tc"
	ewarn "in order to be legally allowed to use the external library."
	ewarn "Redistribution in binary form might also be problematic."
	ewarn
	ewarn "You have been warned. Have a nice day."
}
