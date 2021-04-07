Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA249356B7F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhDGLqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:46:48 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:33620 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhDGLqs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:46:48 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 137BkH4S014490;
        Wed, 7 Apr 2021 20:46:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 137BkH4S014490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617795977;
        bh=e90N5wkF1hteFP0jbF58SprpJVKj/n+S9wgTEG6K0FU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0/7TaLTG1n5REF91X1AZOuKj23ztlPWXi/d4KOqPSn8CMB4/bu4RWfGmP6czoTmPF
         t8Iq/BtgvvKa/kvEYw7RzS9wt2TEeC97wBXLHcj73Xp351QncwWQlI1dl9UveOp2wM
         PDGOPdSNPCiBcKHQNhQXvElB+LsZAq0J8K9be5Vxd/s+sqUW1H7bHAz/ex00K7y9yc
         pWqhfgO78jmUa0mSDtMZkB0/ZR/4TnlmS6h7SKW6MKx5w2/czrmOOvo53B30Val2AP
         9sWxJARxEDyAWNQra2YrB2bP5nK9VBf0+v1hXBxvznovCQP0157jKE8ZOXOPOkERH/
         6XgnBuUeG3IWg==
X-Nifty-SrcIP: [209.85.214.178]
Received: by mail-pl1-f178.google.com with SMTP id p10so4063117pld.0;
        Wed, 07 Apr 2021 04:46:17 -0700 (PDT)
X-Gm-Message-State: AOAM533UGs3G8zY/r6CMandWEeoZpG/0UGP0pQFi5pZDH/ZRRJce0zEU
        hBT+f1X1xJ+WVciDPFMJHiF6Ql5P3jhNwNPaB1g=
X-Google-Smtp-Source: ABdhPJwJoOhh0r/oUL4pdVvHWI3QqGMXW6MConrvV8ZSEojaWe52StwsenE49C8CUiAxSf0ixYjEthzutaEsSxsE9iU=
X-Received: by 2002:a17:90a:1056:: with SMTP id y22mr2724939pjd.153.1617795976615;
 Wed, 07 Apr 2021 04:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-21-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-21-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Apr 2021 20:45:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHEETPwBr1C6PwZwohH2QeSJtAZgAMwXHASw=dg3kCpA@mail.gmail.com>
Message-ID: <CAK7LNASHEETPwBr1C6PwZwohH2QeSJtAZgAMwXHASw=dg3kCpA@mail.gmail.com>
Subject: Re: [PATCH 20/20] kbuild: scripts/install.sh: update documentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Add a proper SPDX line and document the install.sh file a lot better,
> explaining exactly what it does, and update the copyright notice and
> provide a better message about the lack of LILO being present or not as
> really, no one should be using that anymore...
>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  scripts/install.sh | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/scripts/install.sh b/scripts/install.sh
> index 225b19bbbfa6..dd86fb9971e9 100644
> --- a/scripts/install.sh
> +++ b/scripts/install.sh
> @@ -1,14 +1,14 @@
>  #!/bin/sh
> -#
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "COPYING" in the main directory of this archive
> -# for more details.
> +# SPDX-License-Identifier: GPL-2.0
>  #
>  # Copyright (C) 1995 by Linus Torvalds
> +# Copyright (C) 2021 Greg Kroah-Hartman
>  #
>  # Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> +# Adapted from code in arch/i386/boot/install.sh by Russell King

Perhaps, this line can go to
"10/20 kbuild: arm: use common install script"  ?




> +# Adapted from code in arch/arm/boot/install.sh by Stuart Menefy

I think this line came from 18/20,
but do we need to keep it?

You removed arch/sh/boot/compressed/install.sh entirely.



>  #
> -# "make install" script for i386 architecture
> +# "make install" script for Linux to be used by all architectures.
>  #
>  # Arguments:
>  #   $1 - kernel version
> @@ -16,6 +16,26 @@
>  #   $3 - kernel map file
>  #   $4 - default install path (blank if root directory)
>  #
> +# Installs the built kernel image and map and symbol file in the specified
> +# install location.  If no install path is selected, the files will be placed
> +# in the root directory.
> +#
> +# The name of the kernel image will be "vmlinux-VERSION" for uncompressed
> +# kernels or "vmlinuz-VERSION' for compressed kernels.
> +#
> +# The kernel map file will be named "System.map-VERSION"
> +#
> +# Note, not all architectures seem to like putting the VERSION number in the
> +# file name, see below in the script for a list of those that do not.  For
> +# those that do not the "-VERSION" will not be present in the file name.
> +#
> +# If there is currently a kernel image or kernel map file present with the name
> +# of the file to be copied to the location, it will be renamed to contain a
> +# ".old" suffix.
> +#
> +# If ~/bin/${INSTALLKERNEL} or /sbin/${INSTALLKERNEL} is executable, execution
> +# will be passed to that program instead of this one to allow for distro or
> +# system specific installation scripts to be used.
>
>  verify () {
>         if [ ! -f "$1" ]; then
> @@ -45,7 +65,6 @@ verify "$2"
>  verify "$3"
>
>  # User may have a custom install script
> -
>  if [ -x ~/bin/"${INSTALLKERNEL}" ]; then exec ~/bin/"${INSTALLKERNEL}" "$@"; fi
>  if [ -x /sbin/"${INSTALLKERNEL}" ]; then exec /sbin/"${INSTALLKERNEL}" "$@"; fi
>
> @@ -111,7 +130,7 @@ case "${ARCH}" in
>                 elif [ -x /etc/lilo/install ]; then
>                         /etc/lilo/install
>                 else
> -                       echo "Cannot find LILO."
> +                       echo "Cannot find LILO, ensure your bootloader knows of the new kernel image."


Since you soften the message, I guess this is not a warning message.
I assume it is intentional to put it in stdout instead of stderr.


>                 fi
>                 ;;
>  esac
> --
> 2.31.1
>


-- 
Best Regards
Masahiro Yamada
