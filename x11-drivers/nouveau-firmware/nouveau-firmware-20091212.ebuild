# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="firmware for nouveau"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI="http://people.freedesktop.org/~pq/nouveau-drm/${P}.tar.gz"

LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="bindist mirror"

src_install() {
	insinto /lib/firmware
	doins -r nouveau || die "doins failed"
}
