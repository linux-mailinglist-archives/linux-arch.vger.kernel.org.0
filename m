Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF43573D7
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 20:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbhDGSDD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 14:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhDGSDD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 14:03:03 -0400
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B032FC06175F;
        Wed,  7 Apr 2021 11:02:53 -0700 (PDT)
Date:   Wed, 7 Apr 2021 19:02:47 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH 11/20] kbuild: ia64: use common install script
Message-ID: <20210407190247.64a4ac46@sf>
In-Reply-To: <20210407053419.449796-12-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
        <20210407053419.449796-12-gregkh@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed,  7 Apr 2021 07:34:10 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> The common scripts/install.sh script will now work for ia64, all that
> is needed is to add the compressed image type to it.  So add that file
> type check and the ability to call /usr/sbin/elilo after copying the
> kernel.  With that we can remove the ia64-only version of the file.
> 
> Cc: linux-ia64@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Sergei Trofimovich <slyfox@gentoo.org>

> ---
>  arch/ia64/Makefile   |  2 +-
>  arch/ia64/install.sh | 40 ----------------------------------------
>  scripts/install.sh   |  8 +++++++-
>  3 files changed, 8 insertions(+), 42 deletions(-)
>  delete mode 100644 arch/ia64/install.sh
> 
> diff --git a/arch/ia64/Makefile b/arch/ia64/Makefile
> index 467b7e7f967c..19e20e99f487 100644
> --- a/arch/ia64/Makefile
> +++ b/arch/ia64/Makefile
> @@ -77,7 +77,7 @@ archheaders:
>  CLEAN_FILES += vmlinux.gz
>  
>  install: vmlinux.gz
> -	sh $(srctree)/arch/ia64/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
> +	sh $(srctree)/scripts/install.sh $(KERNELRELEASE) $< System.map "$(INSTALL_PATH)"
>  
>  define archhelp
>    echo '* compressed	- Build compressed kernel image'
> diff --git a/arch/ia64/install.sh b/arch/ia64/install.sh
> deleted file mode 100644
> index 0e932f5dcd1a..000000000000
> --- a/arch/ia64/install.sh
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -#!/bin/sh
> -#
> -# arch/ia64/install.sh
> -#
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "COPYING" in the main directory of this archive
> -# for more details.
> -#
> -# Copyright (C) 1995 by Linus Torvalds
> -#
> -# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> -#
> -# "make install" script for ia64 architecture
> -#
> -# Arguments:
> -#   $1 - kernel version
> -#   $2 - kernel image file
> -#   $3 - kernel map file
> -#   $4 - default install path (blank if root directory)
> -#
> -
> -# User may have a custom install script
> -
> -if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -
> -# Default install - same as make zlilo
> -
> -if [ -f $4/vmlinuz ]; then
> -	mv $4/vmlinuz $4/vmlinuz.old
> -fi
> -
> -if [ -f $4/System.map ]; then
> -	mv $4/System.map $4/System.old
> -fi
> -
> -cat $2 > $4/vmlinuz
> -cp $3 $4/System.map
> -
> -test -x /usr/sbin/elilo && /usr/sbin/elilo
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 73067b535ea0..b6ca2a0f0983 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -52,6 +52,7 @@ if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>  base=$(basename "$2")
>  if [ "$base" = "bzImage" ] ||
>     [ "$base" = "Image.gz" ] ||
> +   [ "$base" = "vmlinux.gz" ] ||
>     [ "$base" = "zImage" ] ; then
>  	# Compressed install
>  	echo "Installing compressed kernel"
> @@ -65,7 +66,7 @@ fi
>  # Some architectures name their files based on version number, and
>  # others do not.  Call out the ones that do not to make it obvious.
>  case "${ARCH}" in
> -	x86)
> +	ia64 | x86)
>  		version=""
>  		;;
>  	*)
> @@ -86,6 +87,11 @@ case "${ARCH}" in
>  			echo "You have to install it yourself"
>  		fi
>  		;;
> +	ia64)
> +		if [ -x /usr/sbin/elilo ]; then
> +			/usr/sbin/elilo
> +		fi
> +		;;
>  	x86)
>  		if [ -x /sbin/lilo ]; then
>  			/sbin/lilo
> -- 
> 2.31.1
> 


-- 

  Sergei
