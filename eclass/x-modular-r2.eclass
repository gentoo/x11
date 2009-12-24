# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/x-modular.eclass,v 1.116 2009/10/31 23:08:25 dirtyepic Exp $
#
# @ECLASS: x-modular.eclass
# @MAINTAINER:
# Donnie Berkholz <dberkholz@gentoo.org>, x11@gentoo.org
# @BLURB: Reduces code duplication in the modularized X11 ebuilds.
# @DESCRIPTION:
# This eclass makes trivial X ebuilds possible for apps, fonts, drivers,
# and more. Many things that would normally be done in various functions
# can be accessed by setting variables instead, such as patching,
# running eautoreconf, passing options to configure and installing docs.
#
# All you need to do in a basic ebuild is inherit this eclass and set
# DESCRIPTION, KEYWORDS and RDEPEND/DEPEND. If your package is hosted
# with the other X packages, you don't need to set SRC_URI. Pretty much
# everything else should be automatic.

GIT_ECLASS=""
if [[ ${PV} == *9999* ]]; then
	GIT_ECLASS="git"
	SNAPSHOT="yes"
	SRC_URI=""
fi

# If we're a font package, but not the font.alias one
FONT_ECLASS=""
if [[ ${PN} == font* \
	&& ${CATEGORY} = media-fonts \
	&& ${PN} != font-alias \
	&& ${PN} != font-util ]]; then
	# Activate font code in the rest of the eclass
	FONT="yes"
	FONT_ECLASS="font"
fi

inherit eutils libtool multilib toolchain-funcs flag-o-matic autotools \
	${FONT_ECLASS} ${GIT_ECLASS}

EXPORTED_FUNCTIONS="src_unpack src_compile src_install pkg_preinst pkg_postinst pkg_postrm"

case "${EAPI:-0}" in
	2|3) EXPORTED_FUNCTIONS="${EXPORTED_FUNCTIONS} src_prepare src_configure" ;;
	*) DEPEND="EAPI-UNSUPPORTED" ;;
esac

# exports must be ALWAYS after inherit
EXPORT_FUNCTIONS ${EXPORTED_FUNCTIONS}

# @ECLASS-VARIABLE: XDIR
# @DESCRIPTION:
# Directory prefix to use for everything. If you want to install to a
# non-default prefix (e.g., /opt/xorg), change XDIR. This has not been
# recently tested. You may need to uncomment the setting of datadir and
# mandir in x-modular_src_install() or add it back in if it's no longer
# there. You may also want to change the SLOT.
XDIR="/usr"

IUSE=""
HOMEPAGE="http://xorg.freedesktop.org/"

if [[ -z ${SNAPSHOT} ]]; then
# @ECLASS-VARIABLE: SNAPSHOT
# @DESCRIPTION:
# If set to 'yes' and configure.ac exists, eautoreconf will run. Set
# before inheriting this eclass.
	SNAPSHOT="no"
fi

# Set up SRC_URI for individual modular releases
BASE_INDIVIDUAL_URI="http://xorg.freedesktop.org/releases/individual"
# @ECLASS-VARIABLE: MODULE
# @DESCRIPTION:
# The subdirectory to download source from. Possible settings are app,
# doc, data, util, driver, font, lib, proto, xserver. Set above the
# inherit to override the default autoconfigured module.
if [[ -z ${MODULE} ]]; then
	MODULE=""
	case ${CATEGORY} in
		app-doc)             MODULE="doc"     ;;
		media-fonts)         MODULE="font"    ;;
		x11-apps|x11-wm)     MODULE="app"     ;;
		x11-misc|x11-themes) MODULE="util"    ;;
		x11-drivers)         MODULE="driver"  ;;
		x11-base)            MODULE="xserver" ;;
		x11-proto)           MODULE="proto"   ;;
		x11-libs)            MODULE="lib"     ;;
	esac
fi

if [[ -n ${GIT_ECLASS} ]]; then
	EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/${MODULE}/${PN}"
else
	SRC_URI="${SRC_URI} ${BASE_INDIVIDUAL_URI}/${MODULE}/${P}.tar.bz2"
fi

SLOT="0"

# Set the license for the package. This can be overridden by setting
# LICENSE after the inherit. Nearly all FreeDesktop-hosted X packages
# are under the MIT license. (This is what Red Hat does in their rpms)
LICENSE="MIT"

# Set up shared dependencies
if [[ -n ${SNAPSHOT} ]]; then
	DEPEND+="
		>=sys-devel/libtool-2.2.6a
		sys-devel/m4"
	# These 2 versions MUST BE STABLE
	[[ ${PN} = "util-macros" ]] && DEPEND+=" >=x11-misc/util-macros-1.3.0"
	[[ ${PN} = "font-util" ]] && DEPEND+=" >=media-fonts/font-util-1.1.1-r1"
	WANT_AUTOCONF="latest"
	WANT_AUTOMAKE="latest"
fi

if [[ -n "${FONT}" ]]; then
	DEPEND+=" >=media-fonts/font-util-1.1.1-r1"
	RDEPEND+=" media-fonts/encodings
		x11-apps/mkfontscale
		x11-apps/mkfontdir"
	PDEPEND+=" media-fonts/font-alias"
	# Wrap in `if` so ebuilds can set it too
	if [[ -z ${FONT_DIR} ]]; then
# @ECLASS-VARIABLE: FONT_DIR
# @DESCRIPTION:
# If you're creating a font package and the suffix of PN is not equal to
# the subdirectory of /usr/share/fonts/ it should install into, set
# FONT_DIR to that directory or directories. Set before inheriting this
# eclass.
		FONT_DIR=${PN##*-}
	fi

	# Fix case of font directories
	FONT_DIR=${FONT_DIR/ttf/TTF}
	FONT_DIR=${FONT_DIR/otf/OTF}
	FONT_DIR=${FONT_DIR/type1/Type1}
	FONT_DIR=${FONT_DIR/speedo/Speedo}

	# Set up configure options, wrapped so ebuilds can override if need be
	if [[ -z ${FONT_OPTIONS} ]]; then
		FONT_OPTIONS="--with-fontdir=\"/usr/share/fonts/${FONT_DIR}\""
	fi

	if [[ -n ${FONT} ]]; then
		if [[ ${PN##*-} = misc || ${PN##*-} = 75dpi || ${PN##*-} = 100dpi || ${PN##*-} = cyrillic ]]; then
			IUSE+=" nls"
		fi
	fi
fi

# If we're a driver package, then enable DRIVER case
[[ ${PN} == xf86-video-* || ${PN} == xf86-input-* ]] && DRIVER="yes"
fi

# Debugging -- ignore packages that can't be built with debugging
if [[ -z ${FONT} \
		&& ${CATEGORY} != app-doc \
		&& ${CATEGORY} != x11-proto \
		&& ${PN} != util-macros \
		&& ${PN} != xbitmaps \
		&& ${PN} != xorg-cf-files \
		&& ${PN/xcursor} = ${PN} ]]; then
	DEBUGGABLE="yes"
	IUSE+=" debug"
fi

DEPEND+=" >=dev-util/pkgconfig-0.23"

# Check deps on xorg-server
if has dri ${IUSE//+}; then
	DEPEND+=" dri? ( >=x11-base/xorg-server-1.6.3.901-r2[-minimal] )"
fi

[[ -n "${DRIVER}" ]] && DEPEND+=" x11-base/xorg-server[xorg]"
# @FUNCTION: x-modular_specs_check
# @USAGE:
# @DESCRIPTION:
# Make any necessary changes related to gcc specs (generally hardened)
x-modular_specs_check() {
	if [[ ${PN} = xorg-server || -n ${DRIVER} ]]; then
		append-ldflags -Wl,-z,lazy
		# (#116698) breaks loading
		filter-ldflags -Wl,-z,now
	fi
}

# @FUNCTION: x-modular_unpack_source
# @USAGE:
# @DESCRIPTION:
# Simply unpack source code. Nothing else.
x-modular_unpack_source() {
	if [[ -n ${GIT_ECLASS} ]]; then
		git_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"

	if [[ -n ${FONT_OPTIONS} ]]; then
		einfo "Detected font directory: ${FONT_DIR}"
	fi
}

# @FUNCTION: x-modular_patch_source
# @USAGE:
# @DESCRIPTION:
# Apply all patches
x-modular_patch_source() {
	# Use standardized names and locations with bulk patching
	# Patch directory is ${WORKDIR}/patch
	# See epatch() in eutils.eclass for more documentation
	if [[ -z "${EPATCH_SUFFIX}" ]] ; then
		EPATCH_SUFFIX="patch"
	fi

# @VARIABLE: PATCHES
# @DESCRIPTION:
# If you have any patches to apply, set PATCHES to their locations and epatch
# will apply them. It also handles epatch-style bulk patches, if you know how to
# use them and set the correct variables. If you don't, read eutils.eclass.
	if [[ ${#PATCHES[@]} -gt 1 ]]; then
		for x in "${PATCHES[@]}"; do
			epatch "${x}"
		done
	elif [[ -n "${PATCHES}" ]]; then
		for x in ${PATCHES}; do
			epatch "${x}"
		done
	# For non-default directory bulk patching
	elif [[ -n "${PATCH_LOC}" ]] ; then
		epatch ${PATCH_LOC}
	# For standard bulk patching
	elif [[ -d "${EPATCH_SOURCE}" ]] ; then
		epatch
	fi
}

# @FUNCTION: x-modular_reconf_source
# @USAGE:
# @DESCRIPTION:
# Run eautoreconf if necessary, and run elibtoolize.
x-modular_reconf_source() {
	[[ "${SNAPSHOT}" = "yes" && -e "./configure.ac" ]] && eautoreconf

	# Fix shared lib issues on MIPS, FBSD, etc etc
	elibtoolize
}

# @FUNCTION: x-modular_src_prepare
# @USAGE:
# @DESCRIPTION:
# Prepare a package after unpacking, performing all X-related tasks.
x-modular_src_prepare() {
	git_src_prepare
	x-modular_patch_source
	x-modular_reconf_source
}

# @FUNCTION: x-modular_src_unpack
# @USAGE:
# @DESCRIPTION:
# Unpack a package, performing all X-related tasks.
x-modular_src_unpack() {
	x-modular_specs_check
	x-modular_unpack_source
}

# @FUNCTION: x-modular_font_configure
# @USAGE:
# @DESCRIPTION:
# If a font package, perform any necessary configuration steps
x-modular_font_configure() {
	if [[ -n "${FONT}" ]]; then
		if has nls ${IUSE//+} && ! use nls; then
			FONT_OPTIONS+="
				--disable-iso8859-2
				--disable-iso8859-3
				--disable-iso8859-4
				--disable-iso8859-5
				--disable-iso8859-6
				--disable-iso8859-7
				--disable-iso8859-8
				--disable-iso8859-9
				--disable-iso8859-10
				--disable-iso8859-11
				--disable-iso8859-12
				--disable-iso8859-13
				--disable-iso8859-14
				--disable-iso8859-15
				--disable-iso8859-16
				--disable-jisx0201
				--disable-koi8-r"
		fi
	fi
}

# @FUNCTION: x-modular_debug_setup
# @USAGE:
# @DESCRIPTION:
# Set up CFLAGS for a debug build
x-modular_debug_setup() {
	if [[ -n ${DEBUGGABLE} ]]; then
		if use debug; then
			strip-flags
			append-flags -g
		fi
	fi
}

# @FUNCTION: x-modular_src_configure
# @USAGE:
# @DESCRIPTION:
# Perform any necessary pre-configuration steps, then run configure
x-modular_src_configure() {
	x-modular_font_configure
	x-modular_debug_setup

# @VARIABLE: CONFIGURE_OPTIONS
# @DESCRIPTION:
# Any options to pass to configure
[[ -n ${CONFIGURE_OPTIONS} ]]

	# If prefix isn't set here, .pc files cause problems
	if [[ -x ${ECONF_SOURCE:-.}/configure ]]; then
		econf --prefix=${XDIR} \
			--datadir=${XDIR}/share \
			${FONT_OPTIONS} \
			${DRIVER_OPTIONS} \
			${CONFIGURE_OPTIONS}
	fi
}

# @FUNCTION: x-modular_src_make
# @USAGE:
# @DESCRIPTION:
# Run make.
x-modular_src_make() {
	emake || die "emake failed"
}

# @FUNCTION: x-modular_src_compile
# @USAGE:
# @DESCRIPTION:
# Compile a package, performing all X-related tasks.
x-modular_src_compile() {
	x-modular_src_make
}

# @FUNCTION: x-modular_src_install
# @USAGE:
# @DESCRIPTION:
# Install a built package to ${D}, performing any necessary steps.
# Creates a ChangeLog from git if using live ebuilds.
x-modular_src_install() {
	# Install everything to ${XDIR}
	if [[ ${CATEGORY} = x11-proto ]]; then
		emake \
			${PN/proto/}docdir=/usr/share/doc/${PF} \
			DESTDIR="${D}" \
			install \
			|| die
	else
		emake \
			docdir=/usr/share/doc/${PF} \
			DESTDIR="${D}" \
			install \
			|| die
	fi

	if [[ -n ${GIT_ECLASS} ]]; then
		pushd "${EGIT_STORE_DIR}/${EGIT_CLONE_DIR}"
		git log ${GIT_TREE} > "${S}"/ChangeLog
		popd
	fi

	if [[ -e ${S}/ChangeLog ]]; then
		dodoc "${S}"/ChangeLog
	fi
# @VARIABLE: DOCS
# @DESCRIPTION:
# Any documentation to install
	if [[ -n ${DOCS} ]]; then
		dodoc ${DOCS} || die "dodoc failed"
	fi

	# Don't install libtool archives for server modules
	if [[ -e "${D}/usr/$(get_libdir)/xorg/modules" ]]; then
		find "${D}"/usr/$(get_libdir)/xorg/modules -name '*.la' \
			| xargs rm -f
	fi

	[[ -n ${FONT} ]] && remove_font_metadata

	[[ -n "${DRIVER}" ]] && install_driver_hwdata
}

# @FUNCTION: x-modular_pkg_postinst
# @USAGE:
# @DESCRIPTION:
# Run X-specific post-installation tasks on the live filesystem. The
# only task right now is some setup for font packages.
x-modular_pkg_postinst() {
	if [[ -n "${FONT}" ]]; then
		setup_fonts
	fi
}

# @FUNCTION: x-modular_pkg_postrm
# @USAGE:
# @DESCRIPTION:
# Run X-specific post-removal tasks on the live filesystem. The only
# task right now is some cleanup for font packages.
x-modular_pkg_postrm() {
	if [[ -n "${FONT}" ]]; then
		cleanup_fonts
		font_pkg_postrm
	fi
}

# @FUNCTION: cleanup_fonts
# @USAGE:
# @DESCRIPTION:
# Get rid of font directories that only contain generated files
cleanup_fonts() {
	local ALLOWED_FILES="encodings.dir fonts.alias fonts.cache-1 fonts.dir fonts.scale"
	for DIR in ${FONT_DIR}; do
		unset KEEP_FONTDIR
		REAL_DIR=${ROOT}usr/share/fonts/${DIR}

		ebegin "Checking ${REAL_DIR} for useless files"
		pushd ${REAL_DIR} &> /dev/null
		for FILE in *; do
			unset MATCH
			for ALLOWED_FILE in ${ALLOWED_FILES}; do
				if [[ ${FILE} = ${ALLOWED_FILE} ]]; then
					# If it's allowed, then move on to the next file
					MATCH="yes"
					break
				fi
			done
			# If we found a match in allowed files, move on to the next file
			if [[ -n ${MATCH} ]]; then
				continue
			fi
			# If we get this far, there wasn't a match in the allowed files
			KEEP_FONTDIR="yes"
			# We don't need to check more files if we're already keeping it
			break
		done
		popd &> /dev/null
		# If there are no files worth keeping, then get rid of the dir
		if [[ -z "${KEEP_FONTDIR}" ]]; then
			rm -rf ${REAL_DIR}
		fi
		eend 0
	done
}

# @FUNCTION: setup_fonts
# @USAGE:
# @DESCRIPTION:
# Generates needed files for fonts and fixes font permissions
setup_fonts() {
	if [[ ! -n "${FONT_DIR}" ]]; then
		msg="FONT_DIR is empty. The ebuild should set it to at least one subdir of /usr/share/fonts."
		eerror "${msg}"
		die "${msg}"
	fi

	create_fonts_scale
	create_fonts_dir
	create_font_cache
}

# @FUNCTION: remove_font_metadata
# @USAGE:
# @DESCRIPTION:
# Don't let the package install generated font files that may overlap
# with other packages. Instead, they're generated in pkg_postinst().
remove_font_metadata() {
	local DIR
	for DIR in ${FONT_DIR}; do
		if [[ "${DIR}" != "Speedo" ]] && \
			[[ "${DIR}" != "CID" ]] ; then
			# Delete font metadata files
			# fonts.scale, fonts.dir, fonts.cache-1
			rm -f "${D}"/usr/share/fonts/${DIR}/fonts.{scale,dir,cache-1}
		fi
	done
}

# @FUNCTION: install_driver_hwdata
# @USAGE:
# @DESCRIPTION:
# Installs device-to-driver mappings for system-config-display and
# anything else that uses hwdata.
install_driver_hwdata() {
	insinto /usr/share/hwdata/videoaliases
	for i in "${FILESDIR}"/*.xinf; do
		# We need this for the case when none exist,
		# so *.xinf doesn't expand
		if [[ -e $i ]]; then
			doins $i
		fi
	done
}

# @FUNCTION: discover_font_dirs
# @USAGE:
# @DESCRIPTION:
# Deprecated. Sets up the now-unused FONT_DIRS variable.
discover_font_dirs() {
	FONT_DIRS="${FONT_DIR}"
}

# @FUNCTION: create_fonts_scale
# @USAGE:
# @DESCRIPTION:
# Create fonts.scale file, used by the old server-side fonts subsystem.
create_fonts_scale() {
	ebegin "Creating fonts.scale files"
		local x
		for DIR in ${FONT_DIR}; do
			x=${ROOT}/usr/share/fonts/${DIR}
			[[ -z "$(ls ${x}/)" ]] && continue
			[[ "$(ls ${x}/)" = "fonts.cache-1" ]] && continue

			# Only generate .scale files if truetype, opentype or type1
			# fonts are present ...

			# NOTE: There is no way to regenerate Speedo/CID fonts.scale
			# <dberkholz@gentoo.org> 2 August 2004
			if [[ "${x/encodings}" = "${x}" ]] \
				&& [[ -n "$(find ${x} -iname '*.[pot][ft][abcf]' -print)" ]]; then
				mkfontscale \
					-a "${ROOT}"/usr/share/fonts/encodings/encodings.dir \
					-- ${x}
			fi
		done
	eend 0
}

# @FUNCTION: create_fonts_dir
# @USAGE:
# @DESCRIPTION:
# Create fonts.dir file, used by the old server-side fonts subsystem.
create_fonts_dir() {
	ebegin "Generating fonts.dir files"
		for DIR in ${FONT_DIR}; do
			x=${ROOT}/usr/share/fonts/${DIR}
			[[ -z "$(ls ${x}/)" ]] && continue
			[[ "$(ls ${x}/)" = "fonts.cache-1" ]] && continue

			if [[ "${x/encodings}" = "${x}" ]]; then
				mkfontdir \
					-e "${ROOT}"/usr/share/fonts/encodings \
					-e "${ROOT}"/usr/share/fonts/encodings/large \
					-- ${x}
			fi
		done
	eend 0
}

# @FUNCTION: create_font_cache
# @USAGE:
# @DESCRIPTION:
# Create fonts.cache-1 files, used by the new client-side fonts
# subsystem.
create_font_cache() {
	font_pkg_postinst
}
