Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BFBEDF8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfIZJDF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 05:03:05 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:16644 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfIZJDF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 05:03:05 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x8Q92r8Z002357;
        Thu, 26 Sep 2019 18:02:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x8Q92r8Z002357
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569488574;
        bh=RPMMLIKhdvSN9Rtma03dGx5Z7enfjavMewQMgMSrVlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uDsSL2xTh9ZRIJgTmBe7HeabKc3vA6j0D4+zJoERBMKAUMBD5S1xn2VnKCOc5N5QB
         pIanmIt8O6o6o0L6kPNHQCiQqOw5KQ/BYvopCQ2BjsFj4Rgkg7aOmd8IheFZDIR5GK
         KAFaRtOMXLloTM603aQAltsX33Hm8bigv0SYt1P5GSkGVCbsf3f1mbFOP1sHw7EA90
         2QzBwVvRKmcTvFepNB9XVyuHgk7CXzM9IgCwNAmrFgJgqQCinpgiuAJgZaCf5IKqhF
         Wcl56BmZXMMBjfKuSln9cRhkwIELELirtifCFpCXJnil49TdwrFnuVE2GgblbAiF3Z
         Lb25tDlWOxCKQ==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id p13so1114661vso.0;
        Thu, 26 Sep 2019 02:02:53 -0700 (PDT)
X-Gm-Message-State: APjAAAVTNvYpAwHhQEEDDXbZ3zgDCJ6qAFF/QMQCq0o8hOytU2jTJyXL
        mNbYNwrrcwIEURhY1p7ItN4OxlANH6qSELlBakA=
X-Google-Smtp-Source: APXvYqy5iBFOCX/WHF+jZHk7THmjhiSCV29fsWMtosGODyxAlYHRE8PdDuNjX4/CL7sw1bBrkGAzm3+RVSoQyY3RUFg=
X-Received: by 2002:a67:ec09:: with SMTP id d9mr1095111vso.215.1569488572806;
 Thu, 26 Sep 2019 02:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com> <CAMuHMdXHqQ4O-guETbi85XiJGQ+4EkPdPZf=o540N4rGJkoK4w@mail.gmail.com>
In-Reply-To: <CAMuHMdXHqQ4O-guETbi85XiJGQ+4EkPdPZf=o540N4rGJkoK4w@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 26 Sep 2019 18:02:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1eHPhf0eBNDd8bNVAUhfKrob0EvxHvAQHa8mqPnMbzw@mail.gmail.com>
Message-ID: <CAK7LNAR1eHPhf0eBNDd8bNVAUhfKrob0EvxHvAQHa8mqPnMbzw@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        noreply@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Geert,

On Thu, Sep 26, 2019 at 5:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Yamada-san,
>
> On Fri, Aug 30, 2019 at 5:44 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > Commit 9012d011660e ("compiler: allow all arches to enable
> > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > this option. A couple of build errors were reported by randconfig,
> > but all of them have been ironed out.
> >
> > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > (and it will simplify the 'inline' macro in compiler_types.h),
> > this commit changes it to always-on option. Going forward, the
> > compiler will always be allowed to not inline functions marked
> > 'inline'.
> >
> > This is not a problem for x86 since it has been long used by
> > arch/x86/configs/{x86_64,i386}_defconfig.
> >
> > I am keeping the config option just in case any problem crops up for
> > other architectures.
> >
> > The code clean-up will be done after confirming this is solid.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> This breaks compiling drivers/video/fbdev/c2p*, as the functions in
> drivers/video/fbdev/c2p_core.h are no longer inlined, leading to calls
> to the non-existent function c2p_unsupported(), as reported by KISSKB:
>
> On Thu, Sep 26, 2019 at 5:02 AM <noreply@ellerman.id.au> wrote:
> > FAILED linux-next/m68k-defconfig/m68k Thu Sep 26, 12:58
> >
> > http://kisskb.ellerman.id.au/kisskb/buildresult/13973194/
> >
> > Commit:   Add linux-next specific files for 20190925
> >           d47175169c28eedd2cc2ab8c01f38764cb0269cc
> > Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
> >
> > Possible errors
> > ---------------
> >
> > c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> > c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> > c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> > c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> > make[1]: *** [Makefile:1074: vmlinux] Error 1
> > make: *** [Makefile:179: sub-make] Error 2
>
> I managed to reproduce this with gcc version 8.3.0 (Ubuntu
> 8.3.0-6ubuntu1~18.04.1) , and bisected the failure to commit
> 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly") .
>
> Marking the functions __always_inline instead of inline fixes that.
> Shall I send a patch to do that?


Yes, please.

But you do not need to touch _transp() or comp().
Only functions that call c2p_unsupported().


BTW, c2p_unsupported() can be replaced with BUILD_BUG().
This will break the build earlier in case
it cannot be optimized out.


-- 
Best Regards
Masahiro Yamada
