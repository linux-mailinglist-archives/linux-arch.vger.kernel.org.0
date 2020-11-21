Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EB72BBBA9
	for <lists+linux-arch@lfdr.de>; Sat, 21 Nov 2020 02:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgKUBq5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Nov 2020 20:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgKUBq5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Nov 2020 20:46:57 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489DCC061A04
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 17:46:57 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id r5so6064803vsp.7
        for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2020 17:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8J7ye6KqEOqzvSxgHSVDOvhErTqxQnjIzQcu9TjNgY=;
        b=gxEj26AyhbRPRwqI4nRtVKE+oYSAVh0zKiN7CirbrkbRNHePoBQ5EYK/6EpmHgONJ6
         rDzEI9xmd2qIIpAUwbpr8Q0yverWthQEp5Gqcylo5sKUIhwtfUGoz4tRuCQbcZaqkKAW
         oOidkmqwHF6T/d09/hXg1sRnsEGdmWMfeAH42QOzSzvfH/8ZXoiPcEUHHvnMMpdidxdk
         SBLmbP4NBAr0IyhZ6Aqnke827HaJix7UCMkkb3BI4YYVtQZ/NJlRBUzgqsBFXQMQhe2Z
         Gl9SL1sbqejJ1I1r/vXI0aht45bXxB+2OmXIeoLxJEhKfDetrsMJexh+NAMprZAZTUbp
         CUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8J7ye6KqEOqzvSxgHSVDOvhErTqxQnjIzQcu9TjNgY=;
        b=CqlojA4XEVehJ83hArkWT0jfunRXpAEO/mi7hNZpC3Y1tSeLpgEtG7hQPL+GZ3fw43
         mIP0yMWiSQaUUXX40+DJbDo2GqUmAMYVa0gPOxaUP57BzQes6OWTs7evOD6GEufSC07S
         xbpXecGd5GPGd1zGbGcSQz8C6BVlbYyw2pLugdpOOx644vfYUla8XPAGpfFWYn9+0HL4
         miLI+f6xrzP3dMu52PvIS76XLlG1DDjsIhO9o1ov7FDnZWXTTd0y0NQMVCpMBLm6mW2V
         v8gAe2XGY8XLagl6xddQthEv0J+kx9+hpUNhjDVGbDa1YWTAH1DaKBjKsGLUxdWqTMzV
         oepA==
X-Gm-Message-State: AOAM530DUdO3IngHzLe3gFYcINRpUIbJTUPh2WQ7UAJoTUy/8uOp4qPl
        K3N+i+yltQm/3/l/BABylYnjY3P/+ntvF2Is6liTNg==
X-Google-Smtp-Source: ABdhPJyTZdzEFSb+AU0Lwcx6MYiAxc0oJWnFWkG3BjzA7DDhZM3ZvjUPYcoVlJfRzxNMLq+BKHVW1Pwga5taQXZN+BE=
X-Received: by 2002:a05:6102:22da:: with SMTP id a26mr15670580vsh.13.1605923216073;
 Fri, 20 Nov 2020 17:46:56 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-3-samitolvanen@google.com> <CAKwvOdnYTMzaahnBqdNYPz3KMdnkp=jZ4hxiqkTYzM5+BBdezA@mail.gmail.com>
 <CABCJKucj_jUwoiLc35R7qFe+cNKTWgT+gsCa5pPiY66+1--3Lg@mail.gmail.com>
 <202011201144.3F2BB70C@keescook> <20201120202935.GA1220359@ubuntu-m3-large-x86>
 <202011201241.B159562D7@keescook> <CABCJKucJ87wa73YJkN_dYUyE7foQT+12gdWJZw1PgZ_decFr4w@mail.gmail.com>
 <202011201556.3B910EF@keescook>
In-Reply-To: <202011201556.3B910EF@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 20 Nov 2020 17:46:44 -0800
Message-ID: <CABCJKudy5xFfjBFpFPR255-NAb1yOSuVqsL4fFUwJGGWKDnmQQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] kbuild: add support for Clang LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 20, 2020 at 3:59 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 20, 2020 at 12:58:41PM -0800, Sami Tolvanen wrote:
> > On Fri, Nov 20, 2020 at 12:43 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Nov 20, 2020 at 01:29:35PM -0700, Nathan Chancellor wrote:
> > > > On Fri, Nov 20, 2020 at 11:47:21AM -0800, Kees Cook wrote:
> > > > > On Fri, Nov 20, 2020 at 08:23:11AM -0800, Sami Tolvanen wrote:
> > > > > > Changing the ThinLTO config to a choice and moving it after the main
> > > > > > LTO config sounds like a good idea to me. I'll see if I can change
> > > > > > this in v8. Thanks!
> > > > >
> > > > > Originally, I thought this might be a bit ugly once GCC LTO is added,
> > > > > but this could be just a choice like we're done for the stack
> > > > > initialization. Something like an "LTO" choice of NONE, CLANG_FULL,
> > > > > CLANG_THIN, and in the future GCC, etc.
> > > >
> > > > Having two separate choices might be a little bit cleaner though? One
> > > > for the compiler (LTO_CLANG versus LTO_GCC) and one for the type
> > > > (THINLTO versus FULLLTO). The type one could just have a "depends on
> > > > CC_IS_CLANG" to ensure it only showed up when needed.
> > >
> > > Right, that's how the stack init choice works. Kconfigs that aren't
> > > supported by the compiler won't be shown. I.e. after Sami's future
> > > patch, the only choice for GCC will be CONFIG_LTO_NONE. But building
> > > under Clang, it would offer CONFIG_LTO_NONE, CONFIG_LTO_CLANG_FULL,
> > > CONFIG_LTO_CLANG_THIN, or something.
> > >
> > > (and I assume  CONFIG_LTO would be def_bool y, depends on !LTO_NONE)
> >
> > I'm fine with adding ThinLTO as another option to the LTO choice, but
> > it would duplicate the dependencies and a lot of the help text. I
> > suppose we could add another config for the dependencies and have both
> > LTO options depend on that instead.
>
> How about something like this? This separates the arch support, compiler
> support, and user choice into three separate Kconfig areas, which I
> think should work.

Sure, this looks good to me, I'll use this in v8. The only minor
concern I have is that ThinLTO cannot be set as the default LTO mode,
but I assume anyone who selects LTO is also capable of deciding which
mode is better for them.

> diff --git a/Makefile b/Makefile
> index e397c4caec1b..af902718e882 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -897,7 +897,7 @@ export CC_FLAGS_SCS
>  endif
>
>  ifdef CONFIG_LTO_CLANG
> -ifdef CONFIG_THINLTO
> +ifdef CONFIG_LTO_CLANG_THIN
>  CC_FLAGS_LTO   += -flto=thin -fsplit-lto-unit
>  KBUILD_LDFLAGS += --thinlto-cache-dir=$(extmod-prefix).thinlto-cache
>  else
> diff --git a/arch/Kconfig b/arch/Kconfig
> index cdd29b5fdb56..5c22e10e4c12 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -600,6 +600,14 @@ config SHADOW_CALL_STACK
>
>  config LTO
>         bool
> +       help
> +         Selected if the kernel will be built using the compiler's LTO feature.
> +
> +config LTO_CLANG
> +       bool
> +       select LTO
> +       help
> +         Selected if the kernel will be built using Clang's LTO feature.
>
>  config ARCH_SUPPORTS_LTO_CLANG
>         bool
> @@ -609,28 +617,25 @@ config ARCH_SUPPORTS_LTO_CLANG
>           - compiling inline assembly with Clang's integrated assembler,
>           - and linking with LLD.
>
> -config ARCH_SUPPORTS_THINLTO
> +config ARCH_SUPPORTS_LTO_CLANG_THIN
>         bool
>         help
> -         An architecture should select this option if it supports Clang's
> -         ThinLTO.
> +         An architecture should select this option if it can supports Clang's
> +         ThinLTO mode.
>
> -config THINLTO
> -       bool "Clang ThinLTO"
> -       depends on LTO_CLANG && ARCH_SUPPORTS_THINLTO
> -       default y
> +config HAS_LTO_CLANG
> +       def_bool y
> +       # Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
> +       depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
> +       depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> +       depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> +       depends on ARCH_SUPPORTS_LTO_CLANG
> +       depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> +       depends on !KASAN
> +       depends on !GCOV_KERNEL
>         help
> -         This option enables Clang's ThinLTO, which allows for parallel
> -         optimization and faster incremental compiles. More information
> -         can be found from Clang's documentation:
> -
> -           https://clang.llvm.org/docs/ThinLTO.html
> -
> -         If you say N here, the compiler will use full LTO, which may
> -         produce faster code, but building the kernel will be significantly
> -         slower as the linker won't efficiently utilize multiple threads.
> -
> -         If unsure, say Y.
> +         The compiler and Kconfig options support building with Clang's
> +         LTO.
>
>  choice
>         prompt "Link Time Optimization (LTO)"
> @@ -644,20 +649,14 @@ choice
>
>  config LTO_NONE
>         bool "None"
> +       help
> +         Build the kernel normally, without Link Time Optimization (LTO).
>
> -config LTO_CLANG
> -       bool "Clang's Link Time Optimization (EXPERIMENTAL)"
> -       # Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
> -       depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
> -       depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> -       depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> -       depends on ARCH_SUPPORTS_LTO_CLANG
> -       depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> -       depends on !KASAN
> -       depends on !GCOV_KERNEL
> -       select LTO
> +config LTO_CLANG_FULL
> +       bool "Clang Full LTO (EXPERIMENTAL)"
> +       select LTO_CLANG
>         help
> -          This option enables Clang's Link Time Optimization (LTO), which
> +          This option enables Clang's full Link Time Optimization (LTO), which
>            allows the compiler to optimize the kernel globally. If you enable
>            this option, the compiler generates LLVM bitcode instead of ELF
>            object files, and the actual compilation from bitcode happens at
> @@ -667,9 +666,22 @@ config LTO_CLANG
>
>             https://llvm.org/docs/LinkTimeOptimization.html
>
> -         To select this option, you also need to use LLVM tools to handle
> -         the bitcode by passing LLVM=1 to make.
> +         During link time, this option can use a large amount of RAM, and
> +         may take much longer than the ThinLTO option.
>
> +config LTO_CLANG_THIN
> +       bool "Clang ThinLTO (EXPERIMENTAL)"
> +       depends on ARCH_SUPPORTS_LTO_CLANG_THIN
> +       select LTO_CLANG
> +       help
> +         This option enables Clang's ThinLTO, which allows for parallel
> +         optimization and faster incremental compiles compared to the
> +         CONFIG_LTO_CLANG_FULL option. More information can be found
> +         from Clang's documentation:
> +
> +           https://clang.llvm.org/docs/ThinLTO.html
> +
> +         If unsure, say Y.
>  endchoice

The two LTO_CLANG_* options need to depend on HAS_LTO_CLANG, of course.

Sami
