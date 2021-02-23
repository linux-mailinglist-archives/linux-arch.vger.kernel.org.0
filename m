Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223B9322AE5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 13:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhBWM5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 07:57:53 -0500
Received: from elvis.franken.de ([193.175.24.41]:49459 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232611AbhBWM5v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Feb 2021 07:57:51 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lEXFU-0002LK-00; Tue, 23 Feb 2021 13:57:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 986DDC07AD; Tue, 23 Feb 2021 13:21:44 +0100 (CET)
Date:   Tue, 23 Feb 2021 13:21:44 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH mips-fixes] vmlinux.lds.h: catch even more
 instrumentation symbols into .data
Message-ID: <20210223122144.GA7765@alpha.franken.de>
References: <20210223113600.7009-1-alobakin@pm.me>
 <20210223113600.7009-2-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223113600.7009-2-alobakin@pm.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 23, 2021 at 11:36:41AM +0000, Alexander Lobakin wrote:
> > LKP caught another bunch of orphaned instrumentation symbols [0]:
> >
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > `init/main.o' being placed in section `.data.$LPBX1'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > `init/main.o' being placed in section `.data.$LPBX0'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > `init/do_mounts.o' being placed in section `.data.$LPBX1'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > `init/do_mounts.o' being placed in section `.data.$LPBX0'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > `init/do_mounts_initrd.o' being placed in section `.data.$LPBX1'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > `init/do_mounts_initrd.o' being placed in section `.data.$LPBX0'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > `init/initramfs.o' being placed in section `.data.$LPBX1'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > `init/initramfs.o' being placed in section `.data.$LPBX0'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> > `init/calibrate.o' being placed in section `.data.$LPBX1'
> > mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> > `init/calibrate.o' being placed in section `.data.$LPBX0'
> >
> > [...]
> >
> > Soften the wildcard to .data.$L* to grab these ones into .data too.
> >
> > [0] https://lore.kernel.org/lkml/202102231519.lWPLPveV-lkp@intel.com
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Hi Thomas,
> 
> This applies on top of mips-next or Linus' tree, so you may need to
> rebase mips-fixes before taking it.
> It's not for mips-next as it should go into this cycle as a [hot]fix.
> I haven't added any "Fixes:" tag since these warnings is a result
> of merging several sets and of certain build configurations that
> almost couldn't be tested separately.

no worries, mips-fixes is defunct during merge windows. I'll send another
pull request to Linus and will add this patch to it.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
