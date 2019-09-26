Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D236ABEDE3
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfIZIyX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 04:54:23 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39579 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfIZIyW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 04:54:22 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so1312480otr.6;
        Thu, 26 Sep 2019 01:54:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cjlxpgT/LN99sVEVUZhsfhg857PlKuAAdnRfujapLi0=;
        b=Os5tD0tSYU+EaIgV6ulBm+zqivtd2LjMgxvqziRTT5gO1fHncoKZvrV0Cua//jjux/
         q9EtfoqrUrxxM9i1JpqobE47EYK1i5RHwqR+5FBaa0ju2A28OYaXsvU4KiWybMe7xnj4
         8mNePAiSTb3iUpXf6qDkvBl3zm97s4QjtZlB6oEN7Wsf5CI9J+CR3zp9a7ilINjQgMyc
         ng0/7AAj5j+H7cE940dyUjYzrx5I2Ybmk5cXmILYbNzluCOb9Vu1Q2AmmzGdrdMJ4rja
         l0QhDYLh+FrSSpCTrcUpZrI3GPG0MvqqkxputBxAKQiSUt5bbhPagqSQHeEVW725xR3R
         810g==
X-Gm-Message-State: APjAAAUtGk1rR8ufz3TnjegE9NSQjWaKWm6h2ppmaT27Qro5LK5+uGhw
        C/XPaxY1ZBQlPjI9muNjeFdvYmc/0wyBNqzHvwY=
X-Google-Smtp-Source: APXvYqzn4vcS7CrDY9TzBNZJFD1bzukT9QFSwGtPTrf+5CWcXy6Lye1hKI8tkf0IG/x3AmgA9GHQHmKAZXJG9NYJAg0=
X-Received: by 2002:a9d:730d:: with SMTP id e13mr1738076otk.145.1569488061265;
 Thu, 26 Sep 2019 01:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190830034304.24259-1-yamada.masahiro@socionext.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Sep 2019 10:54:10 +0200
Message-ID: <CAMuHMdXHqQ4O-guETbi85XiJGQ+4EkPdPZf=o540N4rGJkoK4w@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
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

Hi Yamada-san,

On Fri, Aug 30, 2019 at 5:44 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Commit 9012d011660e ("compiler: allow all arches to enable
> CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
> this option. A couple of build errors were reported by randconfig,
> but all of them have been ironed out.
>
> Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
> (and it will simplify the 'inline' macro in compiler_types.h),
> this commit changes it to always-on option. Going forward, the
> compiler will always be allowed to not inline functions marked
> 'inline'.
>
> This is not a problem for x86 since it has been long used by
> arch/x86/configs/{x86_64,i386}_defconfig.
>
> I am keeping the config option just in case any problem crops up for
> other architectures.
>
> The code clean-up will be done after confirming this is solid.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This breaks compiling drivers/video/fbdev/c2p*, as the functions in
drivers/video/fbdev/c2p_core.h are no longer inlined, leading to calls
to the non-existent function c2p_unsupported(), as reported by KISSKB:

On Thu, Sep 26, 2019 at 5:02 AM <noreply@ellerman.id.au> wrote:
> FAILED linux-next/m68k-defconfig/m68k Thu Sep 26, 12:58
>
> http://kisskb.ellerman.id.au/kisskb/buildresult/13973194/
>
> Commit:   Add linux-next specific files for 20190925
>           d47175169c28eedd2cc2ab8c01f38764cb0269cc
> Compiler: m68k-linux-gcc (GCC) 4.6.3 / GNU ld (GNU Binutils) 2.22
>
> Possible errors
> ---------------
>
> c2p_planar.c:(.text+0xd6): undefined reference to `c2p_unsupported'
> c2p_planar.c:(.text+0x1dc): undefined reference to `c2p_unsupported'
> c2p_iplan2.c:(.text+0xc4): undefined reference to `c2p_unsupported'
> c2p_iplan2.c:(.text+0x150): undefined reference to `c2p_unsupported'
> make[1]: *** [Makefile:1074: vmlinux] Error 1
> make: *** [Makefile:179: sub-make] Error 2

I managed to reproduce this with gcc version 8.3.0 (Ubuntu
8.3.0-6ubuntu1~18.04.1) , and bisected the failure to commit
025f072e5823947c ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly") .

Marking the functions __always_inline instead of inline fixes that.
Shall I send a patch to do that?

Thanks!

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -327,7 +327,7 @@ config HEADERS_CHECK
>           relevant for userspace, say 'Y'.
>
>  config OPTIMIZE_INLINING
> -       bool "Allow compiler to uninline functions marked 'inline'"
> +       def_bool y
>         help
>           This option determines if the kernel forces gcc to inline the functions
>           developers have marked 'inline'. Doing so takes away freedom from gcc to
> @@ -338,8 +338,6 @@ config OPTIMIZE_INLINING
>           decision will become the default in the future. Until then this option
>           is there to test gcc for this.
>
> -         If unsure, say N.
> -
>  config DEBUG_SECTION_MISMATCH
>         bool "Enable full Section mismatch analysis"
>         help

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
