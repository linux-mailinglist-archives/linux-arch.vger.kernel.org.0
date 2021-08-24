Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F043F617B
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhHXPYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 11:24:02 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:23222 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhHXPYB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Aug 2021 11:24:01 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 17OFMfa6016562;
        Wed, 25 Aug 2021 00:22:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 17OFMfa6016562
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629818562;
        bh=S+OncbYervpFyf36q1qMQ/cK2RuBY42Jax+g4KEinBk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZcH8Mol3zFOfA82L2ktXpSfndCTVIm8sSN5WhvCF0nkR7lfzciGFhUJXETjlXjtPX
         zJh+MUJ/Ewjk16dZQ1gny5f5e7a9UEa8Y4ew4QsRa2f8+XDPL4zy7TRkyQPCCGuQBR
         HtPcktDDii+gXrd9c6Y/+n2IDAqMdutuYAV8w4MCt5+cnVSpw8AKUX2Ib7Ibo6FD2q
         Ohh6UGM+07Qonx5uLAq8xTeCFAPzEUUH7JfX0G/OTHgFnWD/VUkraTi5Z03rF1LVlI
         S9HUYx9frUuL/nuZq9/KuCBWLzyvJI5ic9YGRufpg399QFVGzpWMzh0y6+RyOdbiCs
         U/uVLdyiGdKjg==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id e7so20084678pgk.2;
        Tue, 24 Aug 2021 08:22:41 -0700 (PDT)
X-Gm-Message-State: AOAM532kurLktu58pwqpHuXIw8lHovCfniN5blvX1moEtQVIcV7LHn01
        PUcoRr6FGo3YJvxRRhzqkBZgYNDXJOe0Ioj8nm8=
X-Google-Smtp-Source: ABdhPJxOp9dnA/3wndoHqVeBS+wD5iSN8I9DS95FoFt5pEdVV9c/uEMA3l6IFAOsje6soli60G91Ls2TkIcdXGUYgjE=
X-Received: by 2002:aa7:8e56:0:b029:3cd:c2ec:6c1c with SMTP id
 d22-20020aa78e560000b02903cdc2ec6c1cmr39028324pfr.80.1629818561184; Tue, 24
 Aug 2021 08:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210407053419.449796-1-gregkh@linuxfoundation.org> <20210407053419.449796-19-gregkh@linuxfoundation.org>
In-Reply-To: <20210407053419.449796-19-gregkh@linuxfoundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 25 Aug 2021 00:22:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ07ycpjJQGwbtq1ii3k9rh2CZVN6MVxkfMb=+Vgs9zqw@mail.gmail.com>
Message-ID: <CAK7LNAQ07ycpjJQGwbtq1ii3k9rh2CZVN6MVxkfMb=+Vgs9zqw@mail.gmail.com>
Subject: Re: [PATCH 18/20] kbuild: sh: remove unused install script
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The sh arch has a install.sh script, but no Makefile actually calls it.
> Remove it to keep anyone from accidentally calling it in the future.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/sh/boot/compressed/install.sh | 56 ------------------------------
>  1 file changed, 56 deletions(-)
>  delete mode 100644 arch/sh/boot/compressed/install.sh
>
> diff --git a/arch/sh/boot/compressed/install.sh b/arch/sh/boot/compressed/install.sh
> deleted file mode 100644
> index f9f41818b17e..000000000000
> --- a/arch/sh/boot/compressed/install.sh
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -#!/bin/sh
> -#
> -# arch/sh/boot/install.sh
> -#
> -# This file is subject to the terms and conditions of the GNU General Public
> -# License.  See the file "COPYING" in the main directory of this archive
> -# for more details.
> -#
> -# Copyright (C) 1995 by Linus Torvalds
> -#
> -# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> -# Adapted from code in arch/i386/boot/install.sh by Russell King
> -# Adapted from code in arch/arm/boot/install.sh by Stuart Menefy
> -#
> -# "make install" script for sh architecture
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
> -if [ -x /sbin/${INSTALLKERNEL} ]; then
> -  exec /sbin/${INSTALLKERNEL} "$@"
> -fi
> -
> -if [ "$2" = "zImage" ]; then
> -# Compressed install
> -  echo "Installing compressed kernel"
> -  if [ -f $4/vmlinuz-$1 ]; then
> -    mv $4/vmlinuz-$1 $4/vmlinuz.old
> -  fi
> -
> -  if [ -f $4/System.map-$1 ]; then
> -    mv $4/System.map-$1 $4/System.old
> -  fi
> -
> -  cat $2 > $4/vmlinuz-$1
> -  cp $3 $4/System.map-$1
> -else
> -# Normal install
> -  echo "Installing normal kernel"
> -  if [ -f $4/vmlinux-$1 ]; then
> -    mv $4/vmlinux-$1 $4/vmlinux.old
> -  fi
> -
> -  if [ -f $4/System.map ]; then
> -    mv $4/System.map $4/System.old
> -  fi
> -
> -  cat $2 > $4/vmlinux-$1
> -  cp $3 $4/System.map
> -fi
> --
> 2.31.1
>


This one is applicable independently.

Applied to linux-kbuild. Thanks.



-- 
Best Regards
Masahiro Yamada
