Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67DE356B12
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhDGLY1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:24:27 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22054 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbhDGLYU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:24:20 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 137BNkMm013375;
        Wed, 7 Apr 2021 20:23:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 137BNkMm013375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617794626;
        bh=xRsVc5VOBPahsGiZ0g8g+/BIjtOSuDMTESYsE15eLiU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SJAtKXW7b1M1zP74XO57uXecda87Y4e/PVxEJqeYl8/fxmmfyjB2w8eEewOSR9JLu
         EmiJEKvyWbbmKB1rksXUG5PyvWhL8b3MykcZpA1OJ+AnhjeFsKestxNY0VjG4PAK9J
         BOiUWG23/d43QUSnyzzjGxT89msxMxB6gYgUAm/jaVBgqdaBc0LxCLOaKntLTCzJpN
         GbiamSUlMXDUVvptqXlIY3d2UvIFXDA4zeRQmI/j8qmaUjZP2eBmbFwRWdfObbK4KB
         /+qatmUj90qvRtPj44S+jFQupWITYdST8+QX1+uEPlHKZHmuOelvY6w41Htv0HoSDR
         3W0CeLPYk+17A==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id z12so5102442plb.9;
        Wed, 07 Apr 2021 04:23:46 -0700 (PDT)
X-Gm-Message-State: AOAM531VBasu25l/OKt7nN+DvSWjPWoq/Iz0LPNG8KhucWgoUWS8pupQ
        c3I9y/qxMz/JkX5MjHeQ5xoXVwvAl2BqRsRJFVY=
X-Google-Smtp-Source: ABdhPJwfvlXM97/EOlS4tPq2ADHj5VuR1RjangeNyKBFR+o9ytzLscVAQqAaEeHWwJmEVBXLLFxZBIwLzQJOfrSmDKw=
X-Received: by 2002:a17:902:be10:b029:e9:78a0:dd33 with SMTP id
 r16-20020a170902be10b02900e978a0dd33mr356753pls.1.1617794625511; Wed, 07 Apr
 2021 04:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-16-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-16-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:23:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkQfwqr9-G5KwGmWDeG81Wn0eb3ZVxopJjxCq18S28=Q@mail.gmail.com>
Message-ID: <CAK7LNATkQfwqr9-G5KwGmWDeG81Wn0eb3ZVxopJjxCq18S28=Q@mail.gmail.com>
Subject: Re: [PATCH 15/20] kbuild: parisc: use common install script
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The common scripts/install.sh script will now work for parisc, all that
> is needed is to add the compressed image type to it.  So add that file
> type check, and then we can remove the two different copies of the
> parisc install.sh script that were only different by one line and have
> the arch call the common install script.
>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/parisc/Makefile        |  4 +--
>  arch/parisc/boot/Makefile   |  2 +-
>  arch/parisc/boot/install.sh | 65 ------------------------------------
>  arch/parisc/install.sh      | 66 -------------------------------------
>  scripts/install.sh          |  1 +
>  5 files changed, 4 insertions(+), 134 deletions(-)
>  delete mode 100644 arch/parisc/boot/install.sh
>  delete mode 100644 arch/parisc/install.sh
>
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 7d9f71aa829a..296d8ab8e2aa 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -164,10 +164,10 @@ vmlinuz: vmlinux
>  endif
>
>  install:
> -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
>                         $(KERNELRELEASE) vmlinux System.map "$(INSTALL_PATH)"
>  zinstall:
> -       $(CONFIG_SHELL) $(srctree)/arch/parisc/install.sh \
> +       $(CONFIG_SHELL) $(srctree)/scripts/install.sh \
>                         $(KERNELRELEASE) vmlinuz System.map "$(INSTALL_PATH)"
>
>  CLEAN_FILES    += lifimage
> diff --git a/arch/parisc/boot/Makefile b/arch/parisc/boot/Makefile
> index 61f44142cfe1..ad2611929aee 100644
> --- a/arch/parisc/boot/Makefile
> +++ b/arch/parisc/boot/Makefile
> @@ -17,5 +17,5 @@ $(obj)/compressed/vmlinux: FORCE
>         $(Q)$(MAKE) $(build)=$(obj)/compressed $@
>
>  install: $(CONFIGURE) $(obj)/bzImage
> -       sh -x  $(srctree)/$(obj)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
> +       sh -x  $(srctree)/scripts/install.sh $(KERNELRELEASE) $(obj)/bzImage \
>               System.map "$(INSTALL_PATH)"



As far as I understood, there is no way to invoke this 'install' target
in arch/parisc/boot/Makefile since everything is done
by arch/parisc/Makefile.



Can we remove this 'install' rule entirely?










> diff --git a/arch/parisc/boot/install.sh b/arch/parisc/boot/install.sh
> deleted file mode 100644
> index 8f7c365fad83..000000000000
> --- a/arch/parisc/boot/install.sh
> +++ /dev/null
> @@ -1,65 +0,0 @@
> -#!/bin/sh
> -#
> -# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
> -#
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "COPYING" in the main directory of this archive
> -# for more details.
> -#
> -# Copyright (C) 1995 by Linus Torvalds
> -#
> -# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> -#
> -# "make install" script for i386 architecture
> -#
> -# Arguments:
> -#   $1 - kernel version
> -#   $2 - kernel image file
> -#   $3 - kernel map file
> -#   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -       if [ ! -f "$1" ]; then
> -               echo ""                                                   1>&2
> -               echo " *** Missing file: $1"                              1>&2
> -               echo ' *** You need to run "make" before "make install".' 1>&2
> -               echo ""                                                   1>&2
> -               exit 1
> -       fi
> -}
> -
> -# Make sure the files actually exist
> -
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -
> -if [ -n "${INSTALLKERNEL}" ]; then
> -  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -fi
> -
> -# Default install
> -
> -if [ "$(basename $2)" = "zImage" ]; then
> -# Compressed install
> -  echo "Installing compressed kernel"
> -  base=vmlinuz
> -else
> -# Normal install
> -  echo "Installing normal kernel"
> -  base=vmlinux
> -fi
> -
> -if [ -f $4/$base-$1 ]; then
> -  mv $4/$base-$1 $4/$base-$1.old
> -fi
> -cat $2 > $4/$base-$1
> -
> -# Install system map file
> -if [ -f $4/System.map-$1 ]; then
> -  mv $4/System.map-$1 $4/System.map-$1.old
> -fi
> -cp $3 $4/System.map-$1
> diff --git a/arch/parisc/install.sh b/arch/parisc/install.sh
> deleted file mode 100644
> index 056d588befdd..000000000000
> --- a/arch/parisc/install.sh
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -#!/bin/sh
> -#
> -# arch/parisc/install.sh, derived from arch/i386/boot/install.sh
> -#
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "COPYING" in the main directory of this archive
> -# for more details.
> -#
> -# Copyright (C) 1995 by Linus Torvalds
> -#
> -# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> -#
> -# "make install" script for i386 architecture
> -#
> -# Arguments:
> -#   $1 - kernel version
> -#   $2 - kernel image file
> -#   $3 - kernel map file
> -#   $4 - default install path (blank if root directory)
> -#
> -
> -verify () {
> -       if [ ! -f "$1" ]; then
> -               echo ""                                                   1>&2
> -               echo " *** Missing file: $1"                              1>&2
> -               echo ' *** You need to run "make" before "make install".' 1>&2
> -               echo ""                                                   1>&2
> -               exit 1
> -       fi
> -}
> -
> -# Make sure the files actually exist
> -
> -verify "$2"
> -verify "$3"
> -
> -# User may have a custom install script
> -
> -if [ -n "${INSTALLKERNEL}" ]; then
> -  if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; fi
> -  if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; fi
> -fi
> -
> -# Default install
> -
> -if [ "$(basename $2)" = "vmlinuz" ]; then
> -# Compressed install
> -  echo "Installing compressed kernel"
> -  base=vmlinuz
> -else
> -# Normal install
> -  echo "Installing normal kernel"
> -  base=vmlinux
> -fi
> -
> -if [ -f $4/$base-$1 ]; then
> -  mv $4/$base-$1 $4/$base-$1.old
> -fi
> -cat $2 > $4/$base-$1
> -
> -# Install system map file
> -if [ -f $4/System.map-$1 ]; then
> -  mv $4/System.map-$1 $4/System.map-$1.old
> -fi
> -cp $3 $4/System.map-$1
> -
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 407ffa65062c..e0ffb95737d4 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -53,6 +53,7 @@ base=$(basename "$2")
>  if [ "$base" = "bzImage" ] ||
>     [ "$base" = "Image.gz" ] ||
>     [ "$base" = "vmlinux.gz" ] ||
> +   [ "$base" = "vmlinuz" ] ||
>     [ "$base" = "zImage" ] ; then
>         # Compressed install
>         echo "Installing compressed kernel"
> --
> 2.31.1
>


--
Best Regards
Masahiro Yamada
