#!/bin/bash

# To use something besides `emerge` to install packages, set INSTALL to 
# that binary.

. /etc/init.d/functions.sh

case ${1} in
	'') ;;
	*)
		einfo 'Rebuilds broken packages from the XCB library renaming'
		einfo
		einfo 'To use something besides `emerge`, set the INSTALL variable to their binary.'
		exit 1
		;;
esac

if ! type -p qfile >/dev/null; then
	einfo "Please install app-portage/portage-utils."
	exit 1
fi

ebegin "Scanning for libraries requiring libxcb-xlib.so"
while read line; do
	if [[ -d ${line} ]]; then
		# Libraries (.so)
		XCB_LIBS=$(
			for i in "${line}"/*.so; do
				scanelf -n $i \
				| grep -q xcb-xlib \
				&& echo $i
			done
		)
		# Python C modules
		XCB_LIBS="${XCB_LIBS} $(
			for i in $(find /usr/lib*/python* -name '*.so'); do
				scanelf -n $i \
				| grep -q xcb-xlib \
				&& echo $i
			done
		)"
		# Libtool archives (.la)
		sed -i \
			-e "s:[^[:space:]]*libxcb-xlib.la::g" \
			"${line}"/*.la 2>/dev/null
	fi
done < /etc/ld.so.conf
eend 0

if [[ -n ${XCB_LIBS} ]]; then
	einfo "Broken libraries:"
	for lib in ${XCB_LIBS}; do
		echo "  ${lib}"
	done
	ebegin "Scanning for packages installing broken libraries"
	XCB_PACKAGES=$(qfile -qC ${XCB_LIBS} | sort | uniq)
	eend 0
else
	einfo "No broken libraries detected"
	exit 0
fi


einfo "Broken packages:"
for pkg in ${XCB_PACKAGES}; do
	echo "  ${pkg}"
done

ebegin "Rebuilding broken packages"
${INSTALL:-emerge} -1 ${XCB_PACKAGES}
eend $?
