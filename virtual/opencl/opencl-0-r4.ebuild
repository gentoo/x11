# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/opencl/opencl-0-r2.ebuild,v 1.2 2012/03/24 11:56:44 ago Exp $

EAPI=5

DESCRIPTION="Virtual for OpenCL implementations"

SLOT="0"
KEYWORDS="~amd64 ~x86"
CARDS=( fglrx intel nvidia radeon nouveau )
IUSE="${CARDS[@]/#/video_cards_}"

DEPEND=""
RDEPEND="app-admin/eselect-opencl
	|| (
		video_cards_fglrx? ( >=x11-drivers/ati-drivers-12.1-r1 )
		video_cards_nvidia? ( >=x11-drivers/nvidia-drivers-290.10-r2 )
		video_cards_intel? (
			|| ( dev-util/intel-ocl-sdk dev-libs/beignet )
		)
		!video_cards_intel? ( media-libs/mesa[opencl,video_cards_nouveau?,video_cards_radeon?] )
	)"
