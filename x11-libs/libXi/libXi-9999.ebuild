# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit x-modular

DESCRIPTION="X.Org Xi library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

RDEPEND=">=x11-libs/libX11-9999
	>=x11-libs/libXext-9999"
DEPEND="${RDEPEND}
	>=x11-proto/xproto-9999
	>=x11-proto/inputproto-9999"

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "Some special keys and keyboard layouts may stop working."
	ewarn "To fix them, recompile xorg-server."
}
