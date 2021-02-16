Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5114A31D08A
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 19:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhBPSze (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 13:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231135AbhBPSza (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Feb 2021 13:55:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60A9264EC8;
        Tue, 16 Feb 2021 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613501690;
        bh=XLdhnbxpQyUDI0ibwdZi9VWVTk4/FfIbiYNNHh0bGMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PRPLQ5TwQ5HAvg963yD0IXfVeTU1PfgILSKT/zALIcuO2gE1ArT2oqoNRTFx0AvkL
         Re4t0dwNDMixZhUOBCnYlnUB4SUeeYbZA69yoB4O7I10DK7/mYSn+QaVeqptrom6ur
         fnCSuUvoYuIeNRqm1b7cMjhQbmEWOKDYRmGAXaE2A6YAKDixOHVxou7r7qbM8dQM+a
         XsHab8VVEigD8OhpAPfQ3dvi5fjwDwetEAjQjpOYTtLPusx8Jcw3h+lEbT14SByHeb
         L/rNkZjdiHrSlh0prLOEYNxbHJBSbQp2ArM+CHdx7e0ov4UxiHmUmTwsxK4TtiuCOZ
         sAORhJdGrR50Q==
Date:   Tue, 16 Feb 2021 11:54:47 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Alexander Lobakin <alobakin@pm.me>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH mips-next] vmlinux.lds.h: catch more UBSAN symbols into
 .data
Message-ID: <20210216185447.GA64303@24bbad8f3778>
References: <20210216085442.2967-1-alobakin@pm.me>
 <CAKwvOdnBgpRff6wa8u1_ogCm_pRey5d_Yro4UCa_O_=tib0FHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnBgpRff6wa8u1_ogCm_pRey5d_Yro4UCa_O_=tib0FHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 16, 2021 at 09:56:32AM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Tue, Feb 16, 2021 at 12:55 AM Alexander Lobakin <alobakin@pm.me> wrote:
> >
> > LKP triggered lots of LD orphan warnings [0]:
> 
> Thanks for the patch, just some questions.
> 
> With which linker?  Was there a particular config from the bot's
> report that triggered this?

Looks like GNU ld 2.34 (see below).

> >
> > mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data299' from
> > `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data299'
> > mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data183' from
> > `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data183'
> > mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type3' from
> > `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type3'
> > mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type2' from
> > `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type2'
> > mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type0' from
> > `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type0'
> >
> > [...]
> >
> > Seems like "unnamed data" isn't the only type of symbols that UBSAN
> > instrumentation can emit.
> > Catch these into .data with the wildcard as well.
> >
> > [0] https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.com
> >
> > Fixes: f41b233de0ae ("vmlinux.lds.h: catch UBSAN's "unnamed data" into data")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index cc659e77fcb0..83537e5ee78f 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -95,7 +95,7 @@
> >   */
> >  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> > -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_*
> > +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$Lubsan_*
> 
> Are these sections only created when
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected?  (Same with
> .data.$__unnamed_*)

Most likely, as that config is set in the problematic config. My guess
is that these are GCC's equivalent of Clang's .data.$__unnamed_...

$ crl https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.com/2-a.bin | gzip -d | rg "CONFIG_LD_DEAD_CODE|CONFIG_LD_VERSION"
CONFIG_LD_VERSION=234000000
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y

> >  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> >  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> >  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> > --
> > 2.30.1
> >
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 
