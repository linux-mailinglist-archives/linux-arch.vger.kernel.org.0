Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BC231D0A0
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 20:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhBPTEW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 14:04:22 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:55725 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBPTEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2021 14:04:22 -0500
Date:   Tue, 16 Feb 2021 19:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1613502214; bh=dHbB+EP2VglqDnAFBAuYo6DPJMDc0d9R10alpdW3CXY=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ggve0TTkzHlRopJd/p+ejxlP5JynMzd0RhjjBFl+nYojik9OVxndHZ6pKlFeAM9oc
         46mNabgo0uopK+tV2l7KDNJG7bFVv6Fn7v/jms3TbPUwNxJpPVK2/m2dPYo5xLoK88
         /YrtLVgcqZTbAFa+0zCi2kDCGmYTA1xSBeC+MKAJwjWG6NVvlkTFuKEEvy9aD45a2W
         7RDvwJ4EuW+pNTz+oVJg4x0DQ2YFfY/wpYN3ixPy4klcugvT1exw/1Dh3TAyUlQkoj
         0LGkUFVNiXzGQ4L4vD1auZchLQE8UgkbMB6HEIL0BxR5sb/cHt6p7soJpxuxGwSt4F
         t0WFQJkXVCtPQ==
To:     Nick Desaulniers <ndesaulniers@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
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
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH mips-next] vmlinux.lds.h: catch more UBSAN symbols into .data
Message-ID: <20210216190212.1668-1-alobakin@pm.me>
In-Reply-To: <CAKwvOdnBgpRff6wa8u1_ogCm_pRey5d_Yro4UCa_O_=tib0FHQ@mail.gmail.com>
References: <20210216085442.2967-1-alobakin@pm.me> <CAKwvOdnBgpRff6wa8u1_ogCm_pRey5d_Yro4UCa_O_=tib0FHQ@mail.gmail.com>
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

From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 16 Feb 2021 09:56:32 -0800

> On Tue, Feb 16, 2021 at 12:55 AM Alexander Lobakin <alobakin@pm.me> wrote=
:
> >
> > LKP triggered lots of LD orphan warnings [0]:
>=20
> Thanks for the patch, just some questions.
>=20
> With which linker?  Was there a particular config from the bot's
> report that triggered this?

All the info can be found by going through the link from the commit
message. Compiler was GCC 9.3, so I suppose BFD was used as a linker.
I mentioned CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy in the attached
dotconfig, the warnings and the fix are relevant only for this case.

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
> > [0] https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.co=
m
> >
> > Fixes: f41b233de0ae ("vmlinux.lds.h: catch UBSAN's "unnamed data" into =
data")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> > ---
> >  include/asm-generic/vmlinux.lds.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index cc659e77fcb0..83537e5ee78f 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -95,7 +95,7 @@
> >   */
> >  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> > -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundl=
iteral* .data.$__unnamed_*
> > +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundl=
iteral* .data.$__unnamed_* .data.$Lubsan_*
>=20
> Are these sections only created when
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is selected?  (Same with
> .data.$__unnamed_*)
>=20
> >  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> >  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> >  #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> > --
> > 2.30.1
> >
> >
>=20
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

Al

