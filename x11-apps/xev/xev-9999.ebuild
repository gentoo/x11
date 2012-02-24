# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit xorg-2

DESCRIPTION="print contents of X events"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-interix ~x86-linux ~x86-winnt"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"
