Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD85D2639B7
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 04:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgIJCAz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Sep 2020 22:00:55 -0400
Received: from condef-04.nifty.com ([202.248.20.69]:62436 "EHLO
        condef-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgIJBse (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Sep 2020 21:48:34 -0400
X-Greylist: delayed 791 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 21:48:33 EDT
Received: from conssluserg-04.nifty.com ([10.126.8.83])by condef-04.nifty.com with ESMTP id 08A1J0mu023902;
        Thu, 10 Sep 2020 10:19:00 +0900
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 08A1IhTb013561;
        Thu, 10 Sep 2020 10:18:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 08A1IhTb013561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599700724;
        bh=x2qUAAqVWiePSrCzfI1IEP4eafAB9yee8r8ckQho/u8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WGjr5LVsquWsgfjbUw8zsVNV+eA8G4HhcuX7mJ53BwE1QXEJLWsiBBR8lguwcOerT
         d71o9nfLv7ija30NHqQedE2CfJD68H7zHtYLQdmNLNYavfgBOdGEVAam0QzLlPx5Q2
         6EJvPCcYrNNyDZNKB0TNqWiS2LuxTF6IL0ttSnkDcBELKjgx7TEBTYnWbGAc/tZbYZ
         ZMn59+M37cpTDQVmqeXbYfFIZ/VUmlVU6FP4rP8nFvJoOjs3HFc/LbGKo4YdWIQOK6
         KSbHxjj2F61Imz4LpNo5mWBjeXerF0bjYZRmNxbsHsNpkA4wxyCBw0p6bFOn5d+i5j
         eYvVVaetEFYKg==
X-Nifty-SrcIP: [209.85.215.169]
Received: by mail-pg1-f169.google.com with SMTP id g29so3356898pgl.2;
        Wed, 09 Sep 2020 18:18:43 -0700 (PDT)
X-Gm-Message-State: AOAM530F73TwB0Fmzr4rQbsyBv8w417djTI0Bd+yBGyIznSW6IwvbMEQ
        aqn88/qrsnbMbTZ6JBfWJ29DykE++eZe+uEIKeE=
X-Google-Smtp-Source: ABdhPJw3+uiV59rG6EDJ8QWqM7TRK95TtkCpF/iAWICblIOjIFopt/zBNTTyCv+Bm880c1rm+ZI8WQaujb2+mHAsSEI=
X-Received: by 2002:a63:f546:: with SMTP id e6mr2466312pgk.7.1599700722672;
 Wed, 09 Sep 2020 18:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <CAK7LNASDUkyJMDD0a5K_HT=1q5NEc6dcN4=FUb330yK0BCKcTw@mail.gmail.com>
 <20200908234643.GF1060586@google.com>
In-Reply-To: <20200908234643.GF1060586@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Sep 2020 10:18:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR9zzP0ZU3b__PZv8gRtKrwz6-8GE1zG5UyFx1wDpOBzQ@mail.gmail.com>
Message-ID: <CAK7LNAR9zzP0ZU3b__PZv8gRtKrwz6-8GE1zG5UyFx1wDpOBzQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 9, 2020 at 8:46 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Sun, Sep 06, 2020 at 09:24:38AM +0900, Masahiro Yamada wrote:
> > On Fri, Sep 4, 2020 at 5:30 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> > >
> > > This patch series adds support for building x86_64 and arm64 kernels
> > > with Clang's Link Time Optimization (LTO).
> > >
> > > In addition to performance, the primary motivation for LTO is
> > > to allow Clang's Control-Flow Integrity (CFI) to be used in the
> > > kernel. Google has shipped millions of Pixel devices running three
> > > major kernel versions with LTO+CFI since 2018.
> > >
> > > Most of the patches are build system changes for handling LLVM
> > > bitcode, which Clang produces with LTO instead of ELF object files,
> > > postponing ELF processing until a later stage, and ensuring initcall
> > > ordering.
> > >
> > > Note that patches 1-4 are not directly related to LTO, but are
> > > needed to compile LTO kernels with ToT Clang, so I'm including them
> > > in the series for your convenience:
> > >
> > >  - Patches 1-3 are required for building the kernel with ToT Clang,
> > >    and IAS, and patch 4 is needed to build allmodconfig with LTO.
> > >
> > >  - Patches 3-4 are already in linux-next, but not yet in 5.9-rc.
> > >
> >
> >
> > I still do not understand how this patch set works.
> > (only me?)
> >
> > Please let me ask fundamental questions.
> >
> >
> >
> > I applied this series on top of Linus' tree,
> > and compiled for ARCH=arm64.
> >
> > I compared the kernel size with/without LTO.
> >
> >
> >
> > [1] No LTO  (arm64 defconfig, CONFIG_LTO_NONE)
> >
> > $ llvm-size   vmlinux
> >    text    data     bss     dec     hex filename
> > 15848692 10099449 493060 26441201 19375f1 vmlinux
> >
> >
> >
> > [2] Clang LTO  (arm64 defconfig + CONFIG_LTO_CLANG)
> >
> > $ llvm-size   vmlinux
> >    text    data     bss     dec     hex filename
> > 15906864 10197445 490804 26595113 195cf29 vmlinux
> >
> >
> > I compared the size of raw binary, arch/arm64/boot/Image.
> > Its size increased too.
> >
> >
> >
> > So, in my experiment, enabling CONFIG_LTO_CLANG
> > increases the kernel size.
> > Is this correct?
>
> Yes. LTO does produce larger binaries, mostly due to function
> inlining between translation units, I believe. The compiler people
> can probably give you a more detailed answer here. Without -mllvm
> -import-instr-limit, the binaries would be even larger.
>
> > One more thing, could you teach me
> > how Clang LTO optimizes the code against
> > relocatable objects?
> >
> >
> >
> > When I learned Clang LTO first, I read this document:
> > https://llvm.org/docs/LinkTimeOptimization.html
> >
> > It is easy to confirm the final executable
> > does not contain foo2, foo3...
> >
> >
> >
> > In contrast to userspace programs,
> > kernel modules are basically relocatable objects.
> >
> > Does Clang drop unused symbols from relocatable objects?
> > If so, how?
>
> I don't think the compiler can legally drop global symbols from
> relocatable objects, but it can rename and possibly even drop static
> functions.


Compilers can drop static functions without LTO.
Rather, it is a compiler warning
(-Wunused-function), so the code should be cleaned up.



> This is why we need global wrappers for initcalls, for
> example, to have stable symbol names.
>
> Sami



At first, I thought the motivation of LTO
was to remove unused global symbols, and
to perform further optimization.


It is true for userspace programs.
In fact, the example of
https://llvm.org/docs/LinkTimeOptimization.html
produces a smaller binary.


In contrast, this patch set produces a bigger kernel
because LTO cannot remove any unused symbol.

So, I do not understand what the benefit is.


Is inlining beneficial?
I am not sure.


Documentation/process/coding-style.rst
"15) The inline disease"
mentions that inlining is not always
a good thing.


As a whole, I still do not understand
the motivation of this patch set.


-- 
Best Regards
Masahiro Yamada
