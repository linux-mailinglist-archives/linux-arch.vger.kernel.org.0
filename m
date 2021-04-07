Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADBE3566F1
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhDGIhr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 04:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241558AbhDGIhq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 04:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9EE561246;
        Wed,  7 Apr 2021 08:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784657;
        bh=VLHHF4FT8jy86pEu9hfAxz3hbvkycVgr55CKmTBjz90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jx9GXNJbN+qI1oL/v6izGOA9ZjafdpY+0jUB15wAIR8cGxQzsFtLuZ6StF6xNw0t5
         k7ceLTv/Zz65f9E+EACiSYOSmXPrNSctssRY5mBzSglf3UaUQlcOdQERIUYuf+GpSs
         wihX2X0/BQ29/ZGThdCD8Kg7a6yZTVfM+m1fEekA=
Date:   Wed, 7 Apr 2021 10:37:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
Message-ID: <YG1vTx5XtgMeA9kX@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <CAMuHMdWGnr1wK3yZdLovxmVQT1yc2DR+J6FwQyCLxQS-Bp29Rw@mail.gmail.com>
 <YG1jSj7BiDscHBhz@kroah.com>
 <20210407080229.GF1463@shell.armlinux.org.uk>
 <YG1oQRc1ayGEI+4G@kroah.com>
 <20210407081436.GG1463@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NnUXjuPNDGsCsqaY"
Content-Disposition: inline
In-Reply-To: <20210407081436.GG1463@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--NnUXjuPNDGsCsqaY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 07, 2021 at 09:14:36AM +0100, Russell King - ARM Linux admin wrote:
> On Wed, Apr 07, 2021 at 10:07:29AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Apr 07, 2021 at 09:02:29AM +0100, Russell King - ARM Linux admin wrote:
> > > On Wed, Apr 07, 2021 at 09:46:18AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Apr 07, 2021 at 09:18:11AM +0200, Geert Uytterhoeven wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > Thanks for your series!
> > > > > 
> > > > > On Wed, Apr 7, 2021 at 7:34 AM Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > Almost every architecture has copied the "install.sh" script that
> > > > > > originally came with i386, and modified it in very tiny ways.  This
> > > > > > patch series unifies all of these scripts into one single script to
> > > > > > allow people to understand how to correctly install a kernel, and fixes
> > > > > > up some issues regarding trying to install a kernel to a path with
> > > > > > spaces in it.
> > > > > >
> > > > > > Note that not all architectures actually seem to have any type of way to
> > > > > > install a kernel, they must rely on external scripts or tools which
> > > > > > feels odd as everything should be included here in the main repository.
> > > > > > I'll work on trying to figure out the missing architecture issues
> > > > > > afterward.
> > > > > 
> > > > > I'll bite ;-)
> > > > > 
> > > > > Does anyone actually use these scripts (outside of x86)?
> > > 
> > > Yes, every time I build a kernel. My kernel build system involves
> > > typing "kbuild <flags> <dirname> <machines...>" and the kernel gets
> > > built in ../build/<dirname>. When the build completes, it gets
> > > installed into ~/systems/<dirname>, tar'd up, and copied to the
> > > destination machines, unpacked, installed as appropriate, and
> > > the machine rebooted if requested.
> > > 
> > > The installation step is done via the ~/bin/installkernel script.
> > 
> > So you don't use install.sh at all except to invoke your local script.
> 
> It depends where the kernel is being built; it has been used in the
> past (one will notice that the arm32 version is not a direct copy of
> the x86 version, and never was - it was modified from day 1.) It's
> placement and naming of the files in /boot is still used today, which
> is slightly different from the x86 version.

The placement depends on the caller to the script, so that's not an
issue here.  The name for the output does differ from x86, but the
"common" script handles all of that (or it should, if not I messed up.)

Attached below is the common scripts/install.sh that this patch series
produces at the end of it, if you want to check to see if I missed
anything for your arch.

thanks,

greg k-h

--NnUXjuPNDGsCsqaY
Content-Type: application/x-sh
Content-Disposition: attachment; filename="install.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A# SPDX-License-Identifier: GPL-2.0=0A#=0A# Copyright (C) 1995 b=
y Linus Torvalds=0A# Copyright (C) 2021 Greg Kroah-Hartman=0A#=0A# Adapted =
=66rom code in arch/i386/boot/Makefile by H. Peter Anvin=0A# Adapted from c=
ode in arch/i386/boot/install.sh by Russell King=0A# Adapted from code in a=
rch/arm/boot/install.sh by Stuart Menefy=0A#=0A# "make install" script for =
Linux to be used by all architectures.=0A#=0A# Arguments:=0A#   $1 - kernel=
 version=0A#   $2 - kernel image file=0A#   $3 - kernel map file=0A#   $4 -=
 default install path (blank if root directory)=0A#=0A# Installs the built =
kernel image and map and symbol file in the specified=0A# install location.=
  If no install path is selected, the files will be placed=0A# in the root =
directory.=0A#=0A# The name of the kernel image will be "vmlinux-VERSION" f=
or uncompressed=0A# kernels or "vmlinuz-VERSION' for compressed kernels.=0A=
#=0A# The kernel map file will be named "System.map-VERSION"=0A#=0A# Note, =
not all architectures seem to like putting the VERSION number in the=0A# fi=
le name, see below in the script for a list of those that do not.  For=0A# =
those that do not the "-VERSION" will not be present in the file name.=0A#=
=0A# If there is currently a kernel image or kernel map file present with t=
he name=0A# of the file to be copied to the location, it will be renamed to=
 contain a=0A# ".old" suffix.=0A#=0A# If ~/bin/${INSTALLKERNEL} or /sbin/${=
INSTALLKERNEL} is executable, execution=0A# will be passed to that program =
instead of this one to allow for distro or=0A# system specific installation=
 scripts to be used.=0A=0Averify () {=0A	if [ ! -f "$1" ]; then=0A		echo ""=
                                                   1>&2=0A		echo " *** Miss=
ing file: $1"                              1>&2=0A		echo ' *** You need to =
run "make" before "make install".' 1>&2=0A		echo ""                        =
                           1>&2=0A		exit 1=0A 	fi=0A}=0A=0Ainstall () {=0A	=
install_source=3D${1}=0A	install_target=3D${2}=0A=0A	echo "installing '${in=
stall_source}' to '${install_target}'"=0A=0A	# if the target is already pre=
sent, move it to a .old filename=0A	if [ -f "${install_target}" ]; then=0A	=
	mv "${install_target}" "${install_target}".old=0A	fi=0A	cat "${install_sou=
rce}" > "${install_target}"=0A}=0A=0A# Make sure the files actually exist=
=0Averify "$2"=0Averify "$3"=0A=0A# User may have a custom install script=
=0Aif [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "=
$@"; fi=0Aif [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKER=
NEL}" "$@"; fi=0A=0Abase=3D$(basename "$2")=0Aif [ "$base" =3D "bzImage" ] =
||=0A   [ "$base" =3D "Image.gz" ] ||=0A   [ "$base" =3D "vmlinux.gz" ] ||=
=0A   [ "$base" =3D "vmlinuz" ] ||=0A   [ "$base" =3D "zImage" ] ; then=0A	=
# Compressed install=0A	echo "Installing compressed kernel"=0A	base=3Dvmlin=
uz=0Aelse=0A	# Normal install=0A	echo "Installing normal kernel"=0A	base=3D=
vmlinux=0Afi=0A=0A# Some architectures name their files based on version nu=
mber, and=0A# others do not.  Call out the ones that do not to make it obvi=
ous.=0Acase "${ARCH}" in=0A	ia64 | m68k | nios2 | powerpc | sparc | x86)=0A=
		version=3D""=0A		;;=0A	*)=0A		version=3D"-${1}"=0A		;;=0Aesac=0A=0Ainstal=
l "$2" "$4"/"$base""$version"=0Ainstall "$3" "$4"/System.map"$version"=0Asy=
nc=0A=0A# Some architectures like to call specific bootloader "helper" prog=
rams:=0Acase "${ARCH}" in=0A	arm)=0A		if [ -x /sbin/loadmap ]; then=0A			/s=
bin/loadmap=0A		else=0A			echo "You have to install it yourself"=0A		fi=0A	=
	;;=0A	ia64)=0A		if [ -x /usr/sbin/elilo ]; then=0A			/usr/sbin/elilo=0A		f=
i=0A		;;=0A	powerpc)=0A		# powerpc installation can list other boot targets=
 after the=0A		# install path that should be copied to the correct location=
=0A		path=3D$4=0A		shift 4=0A		while [ $# -ne 0 ]; do=0A			image_name=3D$(b=
asename "$1")=0A			install "$1" "$path"/"$image_name"=0A			shift=0A		done;=
=0A		sync=0A		;;=0A	x86)=0A		if [ -x /sbin/lilo ]; then=0A			/sbin/lilo=0A	=
	elif [ -x /etc/lilo/install ]; then=0A			/etc/lilo/install=0A		else=0A			e=
cho "Cannot find LILO, ensure your bootloader knows of the new kernel image=
=2E"=0A		fi=0A		;;=0Aesac=0A
--NnUXjuPNDGsCsqaY--
