Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1963F9A8F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Aug 2021 16:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbhH0ODs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Aug 2021 10:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244821AbhH0ODp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Aug 2021 10:03:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A91060F25;
        Fri, 27 Aug 2021 14:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630072976;
        bh=OyaTCDm5vZvhy4U/W+GLWVTstNRbyz9YgcJskrj8wkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2TtPPCf+LNZnOsmLvAt9fUc5OzpV+f1ui/mrVuQC5Y7ImvGFnotOSUyq4gY/q8pre
         GiBds2poXTHLvcaBEqnwYawae2sBQ7JnFOeI00lMERtULkhi7E5728cVkdRxH1yxEt
         j2icDYo7tnhEa7qnCC+ZSLgzFmUwZdEFtT4D4JL8=
Date:   Fri, 27 Aug 2021 16:02:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Subject: Re: [PATCH 18/20] kbuild: sh: remove unused install script
Message-ID: <YSjwiQu1kz7CJCrq@kroah.com>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-19-gregkh@linuxfoundation.org>
 <CAK7LNAQ07ycpjJQGwbtq1ii3k9rh2CZVN6MVxkfMb=+Vgs9zqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ07ycpjJQGwbtq1ii3k9rh2CZVN6MVxkfMb=+Vgs9zqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 25, 2021 at 12:22:03AM +0900, Masahiro Yamada wrote:
> On Wed, Apr 7, 2021 at 2:35 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The sh arch has a install.sh script, but no Makefile actually calls it.
> > Remove it to keep anyone from accidentally calling it in the future.
> >
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: linux-sh@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/sh/boot/compressed/install.sh | 56 ------------------------------
> >  1 file changed, 56 deletions(-)
> >  delete mode 100644 arch/sh/boot/compressed/install.sh
> >
> > diff --git a/arch/sh/boot/compressed/install.sh b/arch/sh/boot/compressed/install.sh
> > deleted file mode 100644
> > index f9f41818b17e..000000000000
> > --- a/arch/sh/boot/compressed/install.sh
> > +++ /dev/null
> > @@ -1,56 +0,0 @@
> > -#!/bin/sh
> > -#
> > -# arch/sh/boot/install.sh
> > -#
> > -# This file is subject to the terms and conditions of the GNU General Public
> > -# License.  See the file "COPYING" in the main directory of this archive
> > -# for more details.
> > -#
> > -# Copyright (C) 1995 by Linus Torvalds
> > -#
> > -# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
> > -# Adapted from code in arch/i386/boot/install.sh by Russell King
> > -# Adapted from code in arch/arm/boot/install.sh by Stuart Menefy
> > -#
> > -# "make install" script for sh architecture
> > -#
> > -# Arguments:
> > -#   $1 - kernel version
> > -#   $2 - kernel image file
> > -#   $3 - kernel map file
> > -#   $4 - default install path (blank if root directory)
> > -#
> > -
> > -# User may have a custom install script
> > -
> > -if [ -x /sbin/${INSTALLKERNEL} ]; then
> > -  exec /sbin/${INSTALLKERNEL} "$@"
> > -fi
> > -
> > -if [ "$2" = "zImage" ]; then
> > -# Compressed install
> > -  echo "Installing compressed kernel"
> > -  if [ -f $4/vmlinuz-$1 ]; then
> > -    mv $4/vmlinuz-$1 $4/vmlinuz.old
> > -  fi
> > -
> > -  if [ -f $4/System.map-$1 ]; then
> > -    mv $4/System.map-$1 $4/System.old
> > -  fi
> > -
> > -  cat $2 > $4/vmlinuz-$1
> > -  cp $3 $4/System.map-$1
> > -else
> > -# Normal install
> > -  echo "Installing normal kernel"
> > -  if [ -f $4/vmlinux-$1 ]; then
> > -    mv $4/vmlinux-$1 $4/vmlinux.old
> > -  fi
> > -
> > -  if [ -f $4/System.map ]; then
> > -    mv $4/System.map $4/System.old
> > -  fi
> > -
> > -  cat $2 > $4/vmlinux-$1
> > -  cp $3 $4/System.map
> > -fi
> > --
> > 2.31.1
> >
> 
> 
> This one is applicable independently.
> 
> Applied to linux-kbuild. Thanks.

Hey, nice, thanks!

I'll work on the rest of the patches in this series after the next merge
window is over...

greg k-h
