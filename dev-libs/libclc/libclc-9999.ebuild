# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://people.freedesktop.org/~tstellar/${PN}"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-2"
	EXPERIMENTAL="true"
fi

inherit base $GIT_ECLASS

DESCRIPTION="OpenCL C library"
HOMEPAGE="http://libclc.llvm.org/"

if [[ $PV = 9999* ]]; then
	SRC_URI="${SRC_PATCHES}"
else
	SRC_URI=""
fi

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=sys-devel/clang-3.1
	>=sys-devel/llvm-3.1"
DEPEND="${RDEPEND}"

PATCHES=(
		"${FILESDIR}/0001-configure.py-Add-an-install-rule.patch"
		"${FILESDIR}/0001-Rename-target-to-r600-amd-none.patch"
)

src_configure() {
	./configure.py \
		--with-llvm-config="${EPREFIX}/usr/bin/llvm-config" \
		--prefix="${EPREFIX}/usr"
}

src_install() {
	# it has UGY install target so we use own one
	insinto /usr/include
	doins -r generic/include/*
	insinto /usr/$(get_libdir)/clc/r600-amd-none
	doins r600-amd-none/lib/builtins.bc
}
