# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit linux-info linux-mod

DESCRIPTION="Nouveau DRM Kernel Modules for X11"
HOMEPAGE="http://nouveau.freedesktop.org/"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="virtual/linux-sources"
DEPEND="${RDEPEND}
	dev-vcs/git"

S=${WORKDIR}/master

CONFIG_CHECK="~ACPI_VIDEO ~BACKLIGHT_CLASS_DEVICE ~DEBUG_FS !DRM ~FB_CFB_FILLRECT ~FB_CFB_COPYAREA ~FB_CFB_IMAGEBLIT ~FRAMEBUFFER_CONSOLE ~!FB_NVIDIA ~!FB_RIVA ~!FB_UVESA ~!FB_VGA16 ~I2C_ALGOBIT ~MXM_WMI ~VGA_ARB"

pkg_setup() {
	linux-mod_pkg_setup
	if kernel_is le 3 4; then
		eerror "You need kernel 3.5 for nouveau-drm"
		die "Incompatible kernel version"
	fi
	elog "Use in-kernel nouveau drm if you experience build issues."
}

src_unpack() {
	wget "http://people.freedesktop.org/~pq/nouveau-drm/master.tar.gz" || die "wget failed"
	tar xfz master.tar.gz -C "${WORKDIR}" || die "untar failed"
	mkdir "${S}"/nouveau || die "mkdir failed"
	wget -O "${S}"/nouveau/Makefile "http://cgit.freedesktop.org/nouveau/linux-2.6/plain/nouveau/Makefile?h=master-compat" || die "wget failed"
}

src_compile() {
	cd nouveau || die "cd failed"
	set_arch_to_kernel
	emake \
		LINUXDIR="${KERNEL_DIR}" \
		GIT_REVISION="$(zcat ${WORKDIR}/master.tar.gz | git get-tar-commit-id)"
}

src_install() {
	insinto /lib/modules/${KV_FULL}/${PN}
	doins drivers/gpu/drm/{*/,}*.ko
}
