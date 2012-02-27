EAPI=4

XORG_DRI=always
inherit xorg-2

EGIT_REPO_URI="git://anongit.freedesktop.org/xorg/driver/glamor"
DESCRIPTION="OpenGL based 2D rendering acceleration library"

KEYWORDS="~amd64 ~x86"
IUSE="gles"

RDEPEND=">=x11-base/xorg-server-1.10
	media-libs/mesa[egl]
	gles? (
		|| ( media-libs/mesa[gles2] media-libs/mesa[gles] )
	)
	>=x11-libs/pixman-0.21.8"
DEPEND="${RDEPEND}"

pkg_setup() {
	xorg-2_pkg_setup
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable gles glamor-gles2)
	)
}
