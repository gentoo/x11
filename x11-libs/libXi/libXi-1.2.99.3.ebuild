# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit x-modular

DESCRIPTION="X.Org Xi library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/libX11-1.2.99.1
	>=x11-libs/libXext-1.0.99.1"
DEPEND="${RDEPEND}
	~app-text/docbook-xml-dtd-4.3
	>=x11-proto/xproto-7.0.13
	>=x11-proto/inputproto-1.9.99"

pkg_postinst() {
	x-modular_pkg_postinst

	ewarn "Some special keys and keyboard layouts may stop working."
	ewarn "To fix them, recompile xorg-server."
}
