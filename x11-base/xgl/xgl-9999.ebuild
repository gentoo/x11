# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# Must be before x-modular eclass is inherited
# Hack to make sure autoreconf gets run
SNAPSHOT="yes"

EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/xserver"
EGIT_BRANCH="xgl-0-0-1"

inherit flag-o-matic x-modular multilib cvs git

MESA_PN="Mesa"
unset SRC_URI

DESCRIPTION="XGL X server"
HOMEPAGE="http://xorg.freedesktop.org/"
LICENSE="X11"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="ipv6"
DEPEND=">=media-libs/glitz-0.5.4_alpha1
	>=media-libs/mesa-6.4.2-r1
	x11-proto/xf86driproto
	x11-proto/randrproto
	x11-proto/renderproto
	>=x11-proto/fixesproto-4.0
	x11-proto/damageproto
	x11-proto/xf86miscproto
	x11-proto/scrnsaverproto
	x11-proto/resourceproto
	x11-proto/fontsproto
	x11-proto/xf86dgaproto
	x11-proto/videoproto
	>=x11-proto/compositeproto-0.3
	x11-proto/trapproto
	x11-proto/recordproto
	x11-proto/xineramaproto
	x11-proto/evieext
	x11-libs/libXfont
	x11-libs/libxkbfile
	x11-libs/libxkbui
	x11-libs/libXxf86misc"

CONFIGURE_OPTIONS="
	$(use_enable ipv6)
	--enable-xgl
	--enable-xglx
	--enable-glx
	--enable-dri
	--disable-xorg
	--disable-aiglx
	--disable-dmx
	--disable-xvfb
	--disable-xnest
	--disable-xprint
	--with-mesa-source=${WORKDIR}/${MESA_PN}
	--with-dri-driver-path=/usr/lib/xorg/modules/dri
	--sysconfdir=/etc/X11
	--localstatedir=/var
	--enable-install-setuid
	--with-font-dir=/usr/share/fonts
	--with-default-font-path=/usr/share/fonts/misc,/usr/share/fonts/75dpi,/usr/share/fonts/100dpi,/usr/share/fonts/TTF,/usr/share/fonts/Type1"

pkg_setup() {
	# (#121394) Causes window corruption
	filter-flags -fweb
}

src_unpack() {
	git_src_unpack

	einfo "Getting Mesa from cvs..."
	ECVS_SERVER="anoncvs.freedesktop.org:/cvs/mesa" \
	ECVS_MODULE="Mesa" \
	ECVS_BRANCH="" \
	ECVS_LOCALNAME="${MESA_PN}" \
	cvs_src_unpack

	cd "${S}"

	x-modular_patch_source
	x-modular_reconf_source
	elibtoolize
}

src_install() {
	x-modular_src_install

	rm "${D}/usr/share/aclocal/xorg-server.m4" \
		"${D}/usr/lib/xserver/SecurityPolicy" \
		"${D}/usr/lib/pkgconfig/xorg-server.pc" \
		"${D}/usr/share/man/man1/Xserver.1x"
}
