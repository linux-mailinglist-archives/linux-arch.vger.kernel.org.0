Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990C1BEE6A
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbfIZJ06 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 05:26:58 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42137 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfIZJ06 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 05:26:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so1462846oif.9;
        Thu, 26 Sep 2019 02:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igPjA35ZmLEPbqljRL7Ddj7a9tyDEasITq8WKXbH8wc=;
        b=sKbFvtjcmh02XM4JWty8zTFcdBXal/tQMJaN4DXaeVUEZXlA+JNWi8IzanA4fDHUMk
         7mSWb7KvCaXKxc9jJI2OLLqL41YU5xT8vmI0Szozrj5TW9Yo21e6OYS/LuPCXcwhYwuk
         ZG8KbM+B0SNdh0iv/2Sonw9HrqELVNYjEGX+kXmLY0D+JOOquLPfLjLdDVSj7okFZ3RK
         r0U3MaHgYnWNdvUvp/Hk+FtwDxY7GrvsBwTlu0OCZ2OWv7j9xEAmzFXxxd6Iw/Mg25Ih
         CpbI4XEkRPTJ7WY9WYBHscBRdmrv8dYL4DD51NyG6AoI+YhfhNkAM2RQfybhfkyQ4POB
         5MbQ==
X-Gm-Message-State: APjAAAXSoul7qYgSLEm1SRcqRHy89CefU0TBRMnVBw+ckokB1Jp5bAmU
        /Sp8e87RPoiAHKwb50C8Jh+L/IKHwidC50NwphU=
X-Google-Smtp-Source: APXvYqy8+cqYzKeBWGjpfU1XHjPCrv7DgWaC7Y7xU3SbVDO5QZ1sc73XgPRB0sbTaZ38h856Kh8vet9ANcuwtcDizQY=
X-Received: by 2002:aca:dad4:: with SMTP id r203mr1908355oig.102.1569490017367;
 Thu, 26 Sep 2019 02:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <CAMuHMdXHqQ4O-guETbi85XiJGQ+4EkPdPZf=o540N4rGJkoK4w@mail.gmail.com> <CAK7LNAR1eHPhf0eBNDd8bNVAUhfKrob0EvxHvAQHa8mqPnMbzw@mail.gmail.com>
In-Reply-To: <CAK7LNAR1eHPhf0eBNDd8bNVAUhfKrob0EvxHvAQHa8mqPnMbzw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 11:26:46 +0200
Message-ID: <CAMuHMdV3VWCP35dOMWaSePz5mhzJp_Y5OViVUqTn7Ocdhn81Og@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

Hi Yamada-san,

On Thu, Sep 26, 2019 at 11:03 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Sep 26, 2019 at 5:54 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Aug 30, 2019 at 5:44 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > Commit 9012d011660e ("compiler: allow all arches to enable
> > > CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> > > this option. A couple of build errors were reported by randconfig,
> > > but all of them have been ironed out.
> > >
> > > Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> > > (and it will simplify the 'inline' macro in compiler_types.h),
> > > this commit changes it to always-on option. Going forward, the
> > > compiler will always be allowed to not inline functions marked
> > > 'inline'.
> > >
> > > This is not a problem for x86 since it has been long used by
> > > arch/x86/configs/{x86_64,i386}_defconfig.
> > >
> > > I am keeping the config option just in case any problem crops up for
> > > other architectures.
> > >
> > > The code clean-up will be done after confirming this is solid.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > This breaks compiling drivers/video/fbdev/c2p*, as the functions in
> > drivers/video/fbdev/c2p_core.h are no longer inlined, leading to calls
> > to the non-existent function c2p_unsupported(), as reported by KISSKB:
> >
> > On Thu, Sep 26, 2019 at 5:02 AM <noreply@ellerman.id.au> wrote:
> > > FAILED linux-next/m68k-defconfig/m68k Thu Sep 26, 12:58
> > >
> > > http://kisskb.ellerman.id.au/kisskb/buildresult/13973194/
> > >
> > > Commit:   Add linux-next specific files for 20190925
> > >           d47175169c28eedd2cc2ab8c01f38764cb0269cc
> > > Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
> > >
> > > Possible errors
> > > ---------------
> > >
> > > c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> > > c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> > > c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> > > c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> > > make[1]: *** [Makefile:1074: vmlinux] Error 1
> > > make: *** [Makefile:179: sub-make] Error 2
> >
> > I managed to reproduce this with gcc version 8.3.0 (Ubuntu
> > 8.3.0-6ubuntu1~18.04.1) , and bisected the failure to commit
> > 025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly") .
> >
> > Marking the functions __always_inline instead of inline fixes that.
> > Shall I send a patch to do that?
>
>
> Yes, please.

OK, will do.

> But you do not need to touch _transp() or comp().
> Only functions that call c2p_unsupported().

However, the inlining of these functions is very performance-sensitive too.
So perhaps I should mark all of them __always_inline?

> BTW, c2p_unsupported() can be replaced with BUILD_BUG().
> This will break the build earlier in case
> it cannot be optimized out.

Right. Will do, too.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
