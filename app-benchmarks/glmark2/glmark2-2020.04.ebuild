# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} )
inherit waf-utils python-single-r1

REV=${PV#*_p}

DESCRIPTION="Opengl test suite"
HOMEPAGE="https://launchpad.net/glmark2"
SRC_URI="https://github.com/glmark2/glmark2/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="drm gles2 +opengl wayland X"

RDEPEND="media-libs/libpng
	media-libs/mesa[gles2?]
	X? ( x11-libs/libX11 )
	wayland? ( >=dev-libs/wayland-1.2 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="|| ( opengl gles2 )
			  || ( drm wayland X )"

PATCHES=(
	"${FILESDIR}/${PN}"-2020.04-Build-Fix-Python-3-incompatibility.patch
)

src_prepare() {
	default
	rm -rf "${S}/src/libpng"
}

src_configure() {
	: ${WAF_BINARY:="${S}/waf"}

	local myconf

	if use X; then
		use opengl && myconf+="x11-gl"
		use gles2 && myconf+=",x11-glesv2"
	fi

	if use drm; then
		use opengl && myconf+=",drm-gl"
		use gles2 && myconf+=",drm-glesv2"
	fi

	if use wayland; then
		use opengl && myconf+=",wayland-gl"
		use gles2 && myconf+=",wayland-glesv2"

	fi
	myconf=${myconf#,}

	# it does not know --libdir specification, dandy huh
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		--prefix=/usr \
		--with-flavors ${myconf} \
		configure || die "configure failed"
}
