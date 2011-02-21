# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/virtualx.eclass,v 1.35 2010/05/15 05:40:46 dirtyepic Exp $

# Original author: Martin Schlemmer <azarah@gentoo.org>

# @ECLASS: virtualx.eclass
# @MAINTAINER:
# x11@gentoo.org
# @BLURB: This eclass can be used for packages that needs a working X environment to build.

# @ECLASS-VARIABLE: VIRTUALX_REQUIRED
# @DESCRIPTION:
# Is a dependency on xorg-server and xhost needed?
# Valid values are "always", "optional", and "manual".
# "tests" is a synonym for "optional".
: ${VIRTUALX_REQUIRED:=optional}

# @ECLASS-VARIABLE: VIRTUALX_USE
# @DESCRIPTION:
# If VIRTUALX_REQUIRED=optional, what USE flag should control
# the dependency?
: ${VIRTUALX_USE:=test}

# @ECLASS-VARIABLE: VIRTUALX_DEPEND
# @DESCRIPTION:
# Dep string available for use outside of eclass, in case a more
# complicated dep is needed.
VIRTUALX_DEPEND="
	!prefix? ( x11-base/xorg-server[-minimal] )
	x11-apps/xhost
"

# @ECLASS-VARIABLE: VIRTUALX_COMMAND
# @DESCRIPTION:
# Command (or eclass function call) to be run in the X11 environment
: ${VIRTUALX_COMMAND:="emake"}

has "${EAPI:-0}" 0 1 && die "virtualx eclass require EAPI=2 or newer."

case ${VIRTUALX_REQUIRED} in
	always)
		DEPEND="${VIRTUALX_DEPEND}"
		RDEPEND=""
		;;
	optional|tests)
		DEPEND="${VIRTUALX_USE}? ( ${VIRTUALX_DEPEND} )"
		RDEPEND=""
		IUSE="${VIRTUALX_USE}"
		;;
	manual)
		;;
	*)
		eerror "Invalid value (${VIRTUALX_REQUIRED}) for VIRTUALX_REQUIRED"
		eerror "Valid values are:"
		eerror "  always"
		eerror "  optional (default if unset)"
		eerror "  manual"
		die "Invalid value (${VIRTUALX_REQUIRED}) for VIRTUALX_REQUIRED"
		;;
esac

# @FUNCTION: virtualmake
# @DESCRIPTION: 
# Function which attach to running X session or start new Xvfb session
# where the VIRTUALX_COMMAND variable content gets executed.
virtualmake() {
	debug-print-function ${FUNCNAME} "$@"

	local i=0
	local retval=0
	local OLD_SANDBOX_ON="${SANDBOX_ON}"
	local XVFB=$(type -p Xvfb)
	local XHOST=$(type -p xhost)
	local xvfbargs="-screen 0 800x600x24"

	# backcompat for maketype
	if [[ -n ${maketype} ]]; then
		ewarn "QA: ebuild is exporting \$maketype=${maketype}"
		ewarn "QA: Ebuild should be migrated to use VIRTUALX_COMMAND=${maketype} instead."
		ewarn "QA: Setting VIRTUALX_COMMAND to \$maketype conveniently for now."
		VIRTUALX_COMMAND=${maketype}
	fi

	# If $DISPLAY is not set, or xhost cannot connect to an X
	# display, then do the Xvfb hack.
	if [[ -n ${XVFB} && -n ${XHOST} ]] && \
			( [[ -z ${DISPLAY} ]] || ! (${XHOST} &>/dev/null) ) ; then
		debug-print "${FUNCNAME}: running Xvfb hack"
		export XAUTHORITY=
		# The following is derived from Mandrake's hack to allow
		# compiling without the X display

		einfo "Scanning for an open DISPLAY to start Xvfb ..."
		# If we are in a chrooted environment, and there is already a
		# X server started outside of the chroot, Xvfb will fail to start
		# on the same display (most cases this is :0 ), so make sure
		# Xvfb is started, else bump the display number
		#
		# Azarah - 5 May 2002
		XDISPLAY=$(i=0; while [[ -f /tmp/.X${i}-lock ]] ; do ((i++));done; echo ${i})
		debug-print "${FUNCNAME}: XDISPLAY=${XDISPLAY}"

		# We really do not want SANDBOX enabled here
		export SANDBOX_ON="0"

		debug-print "${FUNCNAME}: ${XVFB} :${XDISPLAY} ${xvfbargs}"
		${XVFB} :${XDISPLAY} ${xvfbargs} &>/dev/null &
		sleep 2

		local start=${XDISPLAY}
		while [[ ! -f /tmp/.X${XDISPLAY}-lock ]]; do
			# Stop trying after 15 tries
			if ((XDISPLAY - start > 15)) ; then
				eerror "'${XVFB} :${XDISPLAY} ${xvfbargs}' returns:"
				echo
				${XVFB} :${XDISPLAY} ${xvfbargs}
				echo
				eerror "If possible, correct the above error and try your emerge again."
				die "Unable to start Xvfb"
			fi

			((XDISPLAY++))
			debug-print "${FUNCNAME}: ${XVFB} :${XDISPLAY} ${xvfbargs}"
			${XVFB} :${XDISPLAY} ${xvfbargs} &>/dev/null &
			sleep 2
		done

		# Now enable SANDBOX again if needed.
		export SANDBOX_ON="${OLD_SANDBOX_ON}"

		einfo "Starting Xvfb on \$DISPLAY=${XDISPLAY} ..."

		export DISPLAY=:${XDISPLAY}
		# Do not break on error, but setup $retval, as we need
		# to kill Xvfb
		${VIRTUALX_COMMAND} "$@"
		retval=$?

		# Now kill Xvfb
		kill $(cat /tmp/.X${XDISPLAY}-lock)
	else
		debug-print "${FUNCNAME}: attaching to running X display"
		# Normal make if we can connect to an X display
		${VIRTUALX_COMMAND} "$@"
		retval=$?
	fi

	return ${retval}
}

# @FUNCTION: Xmake
# @DESCRIPTION: 
# Same as "make", but set up the Xvfb hack if needed.
# Deprecated call.
Xmake() {
	debug-print-function ${FUNCNAME} "$@"

	ewarn "QA: you should not execute make directly"
	ewarn "QA: rather execute Xemake -j1 if you have issues with parallel make"
	VIRTUALX_COMMAND="emake" virtualmake "$@"
}

# @FUNCTION: Xemake
# @DESCRIPTION: 
# Same as "emake", but set up the Xvfb hack if needed.
Xemake() {
	debug-print-function ${FUNCNAME} "$@"

	VIRTUALX_COMMAND="make" virtualmake "$@"
}

# @FUNCTION: Xeconf
# @DESCRIPTION: 
#  Same as "econf", but set up the Xvfb hack if needed.
Xeconf() {
	debug-print-function ${FUNCNAME} "$@"

	VIRTUALX_COMMAND="econf" virtualmake "$@"
}
