# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# TODO
# make building and installing clients_programs optional
# fix systemd automagic
#	$(use_enable systemd libsystemd-login)

EAPI=5
AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
EGIT_REPO_URI="git://anongit.freedesktop.org/git/wayland/${PN}"

inherit autotools-utils linux-info
[[ ${PV} == 9999* ]] && inherit git-2

DESCRIPTION="Wayland reference compositor"
HOMEPAGE="http://wayland.freedesktop.org/"
[[ ${PV} == 9999* ]] || \
SRC_URI="http://wayland.freedesktop.org/releases/${P}.tar.xz"

LICENSE="MIT CC-BY-SA-3.0"
SLOT="0"
[[ ${PV} == 9999* ]] || \
KEYWORDS="~arm ~amd64 ~x86 ~arm-linux"
IUSE="colord +drm +egl headless fbdev rdp +resize-optimization rpi static-libs +suid systemd tablet test unwind wayland-compositor X xwayland"

REQUIRED_USE="
	drm? ( egl )
	fbdev? ( drm )
	rpi? ( !drm !egl )
	wayland-compositor? ( egl )
"

RDEPEND="
	>=dev-libs/wayland-1.1.90
	media-libs/mesa[egl?,gles2,wayland]
	media-libs/lcms:2
	media-libs/libpng:=
	media-libs/libwebp
	virtual/jpeg
	sys-libs/pam
	>=x11-libs/cairo-1.10.0
	>=x11-libs/libdrm-2.4.30
	x11-libs/libxkbcommon
	x11-libs/pixman
	fbdev? (
		>=sys-libs/mtdev-1.1.0
		>=virtual/udev-136
	)
	colord? ( >=x11-misc/colord-0.1.27 )
	drm? (
		media-libs/mesa[gbm]
		>=sys-libs/mtdev-1.1.0
		>=virtual/udev-136
	)
	egl? (
		>=x11-libs/cairo-1.11.3[opengl]
		media-libs/glu
	)
	rdp? ( >=net-misc/freerdp-1.1.0_beta1_p20130710 )
	rpi? (
		>=sys-libs/mtdev-1.1.0
		>=virtual/udev-136
	)
	systemd? (
		sys-auth/pambase[systemd]
		sys-apps/systemd[pam]
	)
	unwind? ( sys-libs/libunwind )
	X? (
		x11-libs/libxcb
		x11-libs/libX11
	)
	xwayland? (
		x11-libs/cairo[xcb]
		x11-libs/libxcb
		x11-libs/libXcursor
	)
"
DEPEND="${RDEPEND}
	gnome-base/librsvg
	virtual/pkgconfig
"

pkg_pretend() {
	if use kernel_linux && use drm; then
		CONFIG_CHECK="~DRM ~INPUT_EVDEV"
	fi
	check_extra_config
}

src_prepare() {
	# Gentoo uses "video" group for this purpose
	sed -e '/getgrnam/s/"weston-launch"/"video"/' -i src/weston-launch.c || die

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		# backends
		$(use_enable fbdev fbdev-compositor)
		$(use_enable drm drm-compositor)
		$(use_enable headless headless-compositor)
		$(use_enable rdp rdp-compositor)
		$(use_enable rpi rpi-compositor)
		$(use_enable wayland-compositor)
		$(use_enable X x11-compositor)
		# optional deps
		$(use_enable colord)
		$(use_enable egl)
		$(use_enable unwind libunwind)
		# misc
		$(use_enable resize-optimization)
		$(use_enable suid setuid-install)
		$(use_enable tablet tablet-shell)
		$(use_enable xwayland)
		$(use_enable xwayland xwayland-test)
		# required for tests
		$(use_enable test simple-clients)
		$(use_enable test simple-egl-clients)
	)
	autotools-utils_src_configure
}

src_test() {
	export XDG_RUNTIME_DIR="${T}/runtime-dir"
	mkdir "${XDG_RUNTIME_DIR}" || die
	chmod 0700 "${XDG_RUNTIME_DIR}" || die

	autotools-utils_src_test
}
