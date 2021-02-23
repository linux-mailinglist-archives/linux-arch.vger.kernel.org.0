Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BC5322B4A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 14:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhBWNOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 08:14:40 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:21109 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhBWNOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 08:14:39 -0500
Date:   Tue, 23 Feb 2021 13:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1614086036; bh=fVREGtDZlRjjJkL9uhXE3RDAzTG8hC2fglNi1DMvQA4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=BAYhGg3SzAYoUUg1nZmClD4ia7Y7W1Nl3XHD1ohq5b+ciOFfTCwP57Ch3mubKf+cx
         AaFFP0n1bV52v+DYyCUt7EWqKKUEdl/LialUGEkIiZ8yTHbcI3sb8z1eS9T/t2bsnO
         NyCqW2LrRMsYFkoNet48VbpnvvViEz3BRZpkKmSuIsV3msyK8zusFw13lBti9puvVW
         Xxi0Km7t0CSshNUy4JGW2VhheT5mDafC4ezWFoxopa7LadRHoHeVzpPL2hdbgFaaom
         Covu3GXw/217Jc35ik8nY3IjOKFGJ5SLZTb1BnBiXsobnO2n6WCmuperKcroF/R0sQ
         4viw4pVMNVTEA==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Alexander Lobakin <alobakin@pm.me>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH mips-fixes] vmlinux.lds.h: catch even more instrumentation symbols into .data
Message-ID: <20210223131327.218285-1-alobakin@pm.me>
In-Reply-To: <20210223122144.GA7765@alpha.franken.de>
References: <20210223113600.7009-1-alobakin@pm.me> <20210223113600.7009-2-alobakin@pm.me> <20210223122144.GA7765@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Tue, 23 Feb 2021 13:21:44 +0100

> On Tue, Feb 23, 2021 at 11:36:41AM +0000, Alexander Lobakin wrote:
> > > LKP caught another bunch of orphaned instrumentation symbols [0]:
> > >
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > > `init/main.o' being placed in section `.data.$LPBX1'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > > `init/main.o' being placed in section `.data.$LPBX0'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > > `init/do_mounts.o' being placed in section `.data.$LPBX1'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > > `init/do_mounts.o' being placed in section `.data.$LPBX0'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > > `init/do_mounts_initrd.o' being placed in section `.data.$LPBX1'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > > `init/do_mounts_initrd.o' being placed in section `.data.$LPBX0'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > > `init/initramfs.o' being placed in section `.data.$LPBX1'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > > `init/initramfs.o' being placed in section `.data.$LPBX0'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > > `init/calibrate.o' being placed in section `.data.$LPBX1'
> > > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > > `init/calibrate.o' being placed in section `.data.$LPBX0'
> > >
> > > [...]
> > >
> > > Soften the wildcard to .data.$L* to grab these ones into .data too.
> > >
> > > [0] https://lore.kernel.org/lkml/202102231519.lWPLPveV-lkp@intel.com
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > > ---
> > >  include/asm-generic/vmlinux.lds.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Hi Thomas,
> >
> > This applies on top of mips-next or Linus' tree, so you may need to
> > rebase mips-fixes before taking it.
> > It's not for mips-next as it should go into this cycle as a [hot]fix.
> > I haven't added any "Fixes:" tag since these warnings is a result
> > of merging several sets and of certain build configurations that
> > almost couldn't be tested separately.
>
> no worries, mips-fixes is defunct during merge windows. I'll send another
> pull request to Linus and will add this patch to it.

Ah, thank you!

> Thomas.

Al

> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]

