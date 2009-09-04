# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Meta package containing deps on all xorg drivers"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"

IUSE_INPUT_DEVICES="
	input_devices_acecad
	input_devices_aiptek
	input_devices_citron
	input_devices_elographics
	input_devices_evdev
	input_devices_fpit
	input_devices_hyperpen
	input_devices_joystick
	input_devices_keyboard
	input_devices_mouse
	input_devices_mutouch
	input_devices_penmount
	input_devices_tslib
	input_devices_virtualbox
	input_devices_vmmouse
	input_devices_void
	input_devices_synaptics
	input_devices_wacom
"
IUSE_VIDEO_CARDS="
	video_cards_apm
	video_cards_ark
	video_cards_ast
	video_cards_chips
	video_cards_cirrus
	video_cards_dummy
	video_cards_epson
	video_cards_fbdev
	video_cards_geode
	video_cards_glint
	video_cards_i128
	video_cards_i740
	video_cards_intel
	video_cards_impact
	video_cards_imstt
	video_cards_mach64
	video_cards_mga
	video_cards_neomagic
	video_cards_newport
	video_cards_nouveau
	video_cards_nv
	video_cards_r128
	video_cards_radeon
	video_cards_radeonhd
	video_cards_rendition
	video_cards_s3
	video_cards_s3virge
	video_cards_savage
	video_cards_siliconmotion
	video_cards_sis
	video_cards_sisusb
	video_cards_sunbw2
	video_cards_suncg14
	video_cards_suncg3
	video_cards_suncg6
	video_cards_sunffb
	video_cards_sunleo
	video_cards_suntcx
	video_cards_tdfx
	video_cards_tga
	video_cards_trident
	video_cards_tseng
	video_cards_v4l
	video_cards_vermilion
	video_cards_vesa
	video_cards_via
	video_cards_virtualbox
	video_cards_vmware
	video_cards_voodoo
	video_cards_xgi
	video_cards_fglrx
	video_cards_nvidia
"

IUSE="xorg ${IUSE_VIDEO_CARDS} ${IUSE_INPUT_DEVICES}"

PDEPEND="
	xorg? (
		input_devices_acecad? ( >=x11-drivers/xf86-input-acecad-1.2.2 )
		input_devices_aiptek? ( >=x11-drivers/xf86-input-aiptek-1.1.1 )
		input_devices_citron? ( >=x11-drivers/xf86-input-citron-2.2.1 )
		input_devices_elographics? ( >=x11-drivers/xf86-input-elographics-1.2.2 )
		input_devices_evdev? ( >=x11-drivers/xf86-input-evdev-2.1.0 )
		input_devices_fpit? ( >=x11-drivers/xf86-input-fpit-1.2.0 )
		input_devices_hyperpen? ( >=x11-drivers/xf86-input-hyperpen-1.2.0 )
		input_devices_joystick? ( >=x11-drivers/xf86-input-joystick-1.3.2 )
		input_devices_keyboard? ( >=x11-drivers/xf86-input-keyboard-9999 )
		input_devices_mouse? ( >=x11-drivers/xf86-input-mouse-9999 )
		input_devices_mutouch? ( >=x11-drivers/xf86-input-mutouch-1.2.1 )
		input_devices_penmount? ( >=x11-drivers/xf86-input-penmount-1.3.0 )
		input_devices_tslib? ( x11-drivers/xf86-input-tslib )
		input_devices_virtualbox? ( x11-drivers/xf86-input-virtualbox )
		input_devices_vmmouse? ( >=x11-drivers/xf86-input-vmmouse-12.5.0 )
		input_devices_void? ( >=x11-drivers/xf86-input-void-1.1.1 )
		input_devices_synaptics? ( >=x11-drivers/xf86-input-synaptics-0.15.0 )
		input_devices_wacom? ( x11-drivers/linuxwacom )

		video_cards_apm? ( >=x11-drivers/xf86-video-apm-1.2.0  )
		video_cards_ark? ( >=x11-drivers/xf86-video-ark-0.7.0 )
		video_cards_ast? ( >=x11-drivers/xf86-video-ast-0.85.0 )
		video_cards_chips? ( >=x11-drivers/xf86-video-chips-1.2.0 )
		video_cards_cirrus? ( >=x11-drivers/xf86-video-cirrus-1.2.1 )
		video_cards_dummy? ( >=x11-drivers/xf86-video-dummy-0.3.0 )
		video_cards_fbdev? ( >=x11-drivers/xf86-video-fbdev-0.4.0 )
		video_cards_geode? ( >=x11-drivers/xf86-video-geode-2.11.0  )
		video_cards_glint? ( >=x11-drivers/xf86-video-glint-1.2.1 )
		video_cards_i128? ( >=x11-drivers/xf86-video-i128-1.3.1 )
		video_cards_i740? ( >=x11-drivers/xf86-video-i740-1.2.0 )
		video_cards_intel? ( >=x11-drivers/xf86-video-intel-2.4.2-r1 )
		video_cards_mach64? ( >=x11-drivers/xf86-video-mach64-6.8.0 )
		video_cards_mga? ( >=x11-drivers/xf86-video-mga-1.4.9 )
		video_cards_neomagic? ( >=x11-drivers/xf86-video-neomagic-1.2.1 )
		video_cards_newport? ( >=x11-drivers/xf86-video-newport-0.2.2 )
		video_cards_nouveau? ( x11-drivers/xf86-video-nouveau )
		video_cards_nv? ( >=x11-drivers/xf86-video-nv-2.1.12 )
		video_cards_nvidia? ( x11-drivers/nvidia-drivers )
		video_cards_fglrx? ( >=x11-drivers/ati-drivers-9.6 )
		video_cards_r128? ( >=x11-drivers/xf86-video-r128-6.8.0 )
		video_cards_radeon? ( >=x11-drivers/xf86-video-ati-6.9.0 )
		video_cards_radeonhd? ( >=x11-drivers/xf86-video-radeonhd-1.2.1 )
		video_cards_rendition? ( >=x11-drivers/xf86-video-rendition-4.2.0 )
		video_cards_s3? ( >=x11-drivers/xf86-video-s3-0.6.0 )
		video_cards_s3virge? ( >=x11-drivers/xf86-video-s3virge-1.10.1 )
		video_cards_savage? ( >=x11-drivers/xf86-video-savage-2.2.1 )
		video_cards_siliconmotion? ( >=x11-drivers/xf86-video-siliconmotion-1.6.0 )
		video_cards_sis? ( >=x11-drivers/xf86-video-sis-0.10.0 )
		video_cards_sisusb? ( >=x11-drivers/xf86-video-sisusb-0.9.0 )
		video_cards_sunffb? ( >=x11-drivers/xf86-video-sunffb-1.2.0 )
		video_cards_sunleo? ( >=x11-drivers/xf86-video-sunleo-1.2.0 )
		video_cards_tdfx? ( >=x11-drivers/xf86-video-tdfx-1.4.0 )
		video_cards_tga? ( >=x11-drivers/xf86-video-tga-1.2.0 )
		video_cards_trident? ( >=x11-drivers/xf86-video-trident-1.3.0 )
		video_cards_tseng? ( >=x11-drivers/xf86-video-tseng-1.2.0 )
		video_cards_v4l? ( >=x11-drivers/xf86-video-v4l-0.2.0 )
		video_cards_vesa? ( >=x11-drivers/xf86-video-vesa-2.0.0 )
		video_cards_via? ( >=x11-drivers/xf86-video-openchrome-0.2.903 )
		video_cards_virtualbox? ( x11-drivers/xf86-video-virtualbox )
		video_cards_vmware? ( >=x11-drivers/xf86-video-vmware-10.16.5 )
		video_cards_voodoo? ( >=x11-drivers/xf86-video-voodoo-1.2.0 )
		video_cards_xgi? ( >=x11-drivers/xf86-video-xgi-1.5.0 )

		!x11-drivers/xf86-video-impact
		!x11-drivers/xf86-video-imstt
		!x11-drivers/xf86-video-sunbw2
		!x11-drivers/xf86-video-suncg14
		!x11-drivers/xf86-video-suncg3
		!x11-drivers/xf86-video-suncg6
		!x11-drivers/xf86-video-suntcx
		!x11-drivers/xf86-video-vermilion

		!x11-drivers/xf86-video-cyrix
		!x11-drivers/xf86-video-nsc
		!x11-drivers/xf86-video-vga
	)"