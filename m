Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDEEBEEB3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfIZJrS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 05:47:18 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:46779 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfIZJrR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 05:47:17 -0400
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x8Q9lBbA004362;
        Thu, 26 Sep 2019 18:47:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8Q9lBbA004362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569491232;
        bh=4I6vObNO+Eec4OPIBIfi7DxQxYeb1r9KDS6T3ha1JhQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QXaq+H8NdpNfz7HoyLS7jiEWMU4kRC+NDd1DuLdZ86FjIQnCPKmEJfOnUdy6zxYzc
         n9t/x7watAYCvu/nvrMfXobCOs2poNgZoHxJ7uogYSmPnJ6gtjamN1jwGu2uDar15y
         5uqvx2tkLoZDsnsbJUIypvAK5AQiNRYxsWn486DxYIKjiWw8epcwhp+gnQMm+ezf4H
         8vsA/LHfHTR5l71eFQVhtVlxtZQWZv4QXQCUdN20ccDcXKqoQm7AMwv9vavXsdvIGW
         hcbRzh0JogNYSscuJQSKnQIBly7aOAGusb5qdjqypQgi5r9zmGPEx3NH/XzI/+4Fkg
         87HzqMkhCrcsQ==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id s72so302059vkh.5;
        Thu, 26 Sep 2019 02:47:11 -0700 (PDT)
X-Gm-Message-State: APjAAAUAakcCxdrHv72vSnkvbLdsK9on4TQ7JOkWFy211+TYWy3Z9Wrw
        AA+E4mQXxYC7xwxKrFRXy4hOLWMfVFvuI/3vH9w=
X-Google-Smtp-Source: APXvYqyALxN3MXOZ9gjh215X6+7cTCv/FnCQfnzXbnxFt7YR6cqPudDCpB6PVPX+wPxhXorK2dDKa50+xtZWQHRAFZg=
X-Received: by 2002:ac5:cc63:: with SMTP id w3mr1147443vkm.34.1569491230937;
 Thu, 26 Sep 2019 02:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <CAMuHMdXHqQ4O-guETbi85XiJGQ+4EkPdPZf=o540N4rGJkoK4w@mail.gmail.com>
 <CAK7LNAR1eHPhf0eBNDd8bNVAUhfKrob0EvxHvAQHa8mqPnMbzw@mail.gmail.com> <CAMuHMdV3VWCP35dOMWaSePz5mhzJp_Y5OViVUqTn7Ocdhn81Og@mail.gmail.com>
In-Reply-To: <CAMuHMdV3VWCP35dOMWaSePz5mhzJp_Y5OViVUqTn7Ocdhn81Og@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 18:46:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_Ugy=K6UrpVm3hHt3BQnCcCtQuvsWLs3E-JskaiMbOQ@mail.gmail.com>
Message-ID: <CAK7LNAS_Ugy=K6UrpVm3hHt3BQnCcCtQuvsWLs3E-JskaiMbOQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On Thu, Sep 26, 2019 at 6:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san,
>
> On Thu, Sep 26, 2019 at 11:03 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Thu, Sep 26, 2019 at 5:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Aug 30, 2019 at 5:44 AM Masahiro Yamada
> > > <yamada.masahiro@socionext.com> wrote:
> > > > Commit 9012d011660e ("compiler: allow all arches to enable
> > > > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > > > this option. A couple of build errors were reported by randconfig,
> > > > but all of them have been ironed out.
> > > >
> > > > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > > > (and it will simplify the 'inline' macro in compiler_types.h),
> > > > this commit changes it to always-on option. Going forward, the
> > > > compiler will always be allowed to not inline functions marked
> > > > 'inline'.
> > > >
> > > > This is not a problem for x86 since it has been long used by
> > > > arch/x86/configs/{x86_64,i386}_defconfig.
> > > >
> > > > I am keeping the config option just in case any problem crops up for
> > > > other architectures.
> > > >
> > > > The code clean-up will be done after confirming this is solid.
> > > >
> > > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >
> > > This breaks compiling drivers/video/fbdev/c2p*, as the functions in
> > > drivers/video/fbdev/c2p_core.h are no longer inlined, leading to calls
> > > to the non-existent function c2p_unsupported(), as reported by KISSKB:
> > >
> > > On Thu, Sep 26, 2019 at 5:02 AM <noreply@ellerman.id.au> wrote:
> > > > FAILED linux-next/m68k-defconfig/m68k Thu Sep 26, 12:58
> > > >
> > > > http://kisskb.ellerman.id.au/kisskb/buildresult/13973194/
> > > >
> > > > Commit:   Add linux-next specific files for 20190925
> > > >           d47175169c28eedd2cc2ab8c01f38764cb0269cc
> > > > Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
> > > >
> > > > Possible errors
> > > > ---------------
> > > >
> > > > c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> > > > c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> > > > c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> > > > c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> > > > make[1]: *** [Makefile:1074: vmlinux] Error 1
> > > > make: *** [Makefile:179: sub-make] Error 2
> > >
> > > I managed to reproduce this with gcc version 8.3.0 (Ubuntu
> > > 8.3.0-6ubuntu1~18.04.1) , and bisected the failure to commit
> > > 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly") .
> > >
> > > Marking the functions __always_inline instead of inline fixes that.
> > > Shall I send a patch to do that?
> >
> >
> > Yes, please.
>
> OK, will do.
>
> > But you do not need to touch _transp() or comp().
> > Only functions that call c2p_unsupported().
>
> However, the inlining of these functions is very performance-sensitive too.
> So perhaps I should mark all of them __always_inline?


I want to leave as much compiler's freedom as possible,
and the optimization criteria depends on CONFIG option.

When CONFIG_CC_OPTIMIZE_FOR_SIZE is chosen,
the optimization should respect the code size over performance,
and the compiler may prefer not inlining it.


So, the basic idea is, use __always_inline
only when otherwise the builds would be broken.


Masahiro Yamada




> > BTW, c2p_unsupported() can be replaced with BUILD_BUG().
> > This will break the build earlier in case
> > it cannot be optimized out.
>
> Right. Will do, too.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds



-- 
Best Regards
Masahiro Yamada
