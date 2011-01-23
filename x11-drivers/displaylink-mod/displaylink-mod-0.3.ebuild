# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit linux-mod

DESCRIPTION="kernel driver for DisplayLink devices"
HOMEPAGE="http://libdlo.freedesktop.org/wiki/displaylink-mod"
SRC_URI="http://projects.unbit.it/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BUILD_TARGETS="all"
MODULE_NAMES="displaylink(misc:)"

S="${WORKDIR}/displaylink"

pkg_setup() {
	linux-mod_pkg_setup
	if [[ ${KV_FULL} != $(uname -r) ]]; then
		eerror "Due to build system limitations, the eselected kernel must"
		eerror "be the same version as the currently running one."
		die "eselect kernel ${KV_FULL} and uname -r $(uname -r) don't match"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-kernel-2.6.31.patch
}
