# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}/${PN}"

inherit autotools-utils toolchain-funcs
[[ ${PV} == *9999* ]] && inherit git-2

DESCRIPTION="Wayland protocol libraries"
HOMEPAGE="http://wayland.freedesktop.org/"
[[ ${PV} == *9999* ]] || \
SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
[[ ${PV} == *9999* ]] || \
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	dev-libs/expat
	virtual/libffi
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	local myeconfargs=(
		$(use_enable doc documentation)
	)
	if tc-is-cross-compiler ; then
		myeconfargs+=( --disable-scanner )
	fi
	autotools-utils_src_configure
}

src_test() {
	export XDG_RUNTIME_DIR="${T}/runtime-dir"
	mkdir "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	autotools-utils_src_test
}
