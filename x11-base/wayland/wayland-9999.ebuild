# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit xorg-2

DESCRIPTION="A nano display server, relying on kernel modesetting"
HOMEPAGE="http://wayland.freedesktop.org/"
EGIT_REPO_URI="git://anongit.freedesktop.org/git/${PN}"

LICENSE="CCPL-Attribution-ShareAlike-3.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# cairo opengl is automagic
RDEPEND="app-text/poppler[cairo]
	dev-libs/expat
	dev-libs/glib:2
	media-libs/mesa[gles,gallium]
	>=sys-fs/udev-136
	>=x11-libs/cairo-1.10[opengl]
	x11-libs/gtk+:2
	>=x11-libs/libdrm-2.4.23
	x11-libs/libxcb
	x11-libs/libxkbcommon
	virtual/libffi"
DEPEND="${RDEPEND}"

src_prepare() {
	# install the programs too
	# this should be fixed in makefile.am
	sed -i \
		-e "/PROGRAMS/s/noinst_/bin_/" \
		{compositor,clients}"/Makefile.am" || die

	xorg-2_src_prepare
}

src_install() {
	xorg-2_src_install

	cd "${ED}/usr/bin"
	for binary in $(echo *); do
		mv "${binary}" "wayland-${binary}" || die
	done
}
