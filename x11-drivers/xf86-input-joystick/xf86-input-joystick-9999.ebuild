# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit x-modular

DESCRIPTION="X.Org driver for joystick input devices"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-base/xorg-server-1.7.0"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-2.0
	x11-proto/randrproto
	x11-proto/xproto"
