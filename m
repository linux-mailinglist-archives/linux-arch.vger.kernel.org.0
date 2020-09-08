Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA7261695
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 19:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgIHROf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 13:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgIHROS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 13:14:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3125C061756
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 10:14:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o16so56487pjr.2
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 10:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gCc+KLpNK9ExlVMZwWTulckz89Pa9STYRhLISVmRXE=;
        b=l8TFfPPi8zCMxO4dQ+cL2mPjwdbrYknGcvJ3S7KeMVYr2Q/H76gUGB/4DPzblBc4wL
         Z/kVUs7HQzPp6jHkL4co16aB0o/g9Ki0Ci0aIB0eJoVFKyQw8ebfadzXTbu4V+oR00+P
         Y0GX8EGtn/TLhA7swJKiiBEOKxyP30iGgiknVXfiRggge5Bv6Ynx3A+1F897oXDNaoVR
         kVH5X1H8mEjwr96L9W1aE7R55Kb7ZR5yUxkKFHGYbtAPNMDgXY7WU4juuRBrpC4IgkSf
         Q6Y88UZSHorH9uaE9yPAgcDEGg9XIEKFsGjNzLTMMT0/0Jx0dHHH+2sXVL5BjPJrknNp
         m0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gCc+KLpNK9ExlVMZwWTulckz89Pa9STYRhLISVmRXE=;
        b=KcuYAXJ7vlSGSE405neEIGrVnr/GQFCz60TJTzPRlFR8vYmkdEVAvu6g8y8bW31sTZ
         t2WitNyDmTUtZ5pgwNRZfv4kDTnlnkLMNmB374hVPUnWg208V58V244FetTLaic9Nx0L
         J7aHQKmcKNXoReNpNBRZLYC1HOpUzJIR2+hvk4KZKi46swfjRpfFcIrCLKszJePUY9yG
         RbHccK1V5ExtdUaMur4UVYic4SLTvFKins8F2FQY/YyLopmJCDxRAuouVqv5wzZRUjHd
         zdnwyb27k5Ug3bM7KMTe1IubRQH1AKkHZEXvM1qTLo5ShP6KiKc/N6bqFTtuRKw/tzTn
         SnIQ==
X-Gm-Message-State: AOAM531vCNTiyonPu0RU+3FE/oBAAHzWfe/Y8R08ZnfvYeYTvnyn65mH
        flYc2Q4zrbl7Xj8eGTkwVxcrjg==
X-Google-Smtp-Source: ABdhPJwIjKawnMHTj/rRnXjnjsmCJjseMt/B3KoD/9OR2ojGQkPMO3BFzGgdcfjb98S269z1QHdN5g==
X-Received: by 2002:a17:90a:ea0c:: with SMTP id w12mr105528pjy.65.1599585257422;
        Tue, 08 Sep 2020 10:14:17 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id z18sm9322pfn.186.2020.09.08.10.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:14:16 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:14:11 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
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
Subject: Re: [PATCH v2 09/28] kbuild: add support for Clang LTO
Message-ID: <20200908171411.GC2743468@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-10-samitolvanen@google.com>
 <CAK7LNASTtxJ7OCMM_KxmaoSL3CDfTY-65Pu=-MYkMo7iz-_NOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASTtxJ7OCMM_KxmaoSL3CDfTY-65Pu=-MYkMo7iz-_NOQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 06, 2020 at 05:17:32AM +0900, Masahiro Yamada wrote:
> On Fri, Sep 4, 2020 at 5:31 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This change adds build system support for Clang's Link Time
> > Optimization (LTO). With -flto, instead of ELF object files, Clang
> > produces LLVM bitcode, which is compiled into native code at link
> > time, allowing the final binary to be optimized globally. For more
> > details, see:
> >
> >   https://llvm.org/docs/LinkTimeOptimization.html
> >
> > The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> > which defaults to LTO being disabled. To use LTO, the architecture
> > must select ARCH_SUPPORTS_LTO_CLANG and support:
> >
> >   - compiling with Clang,
> >   - compiling inline assembly with Clang's integrated assembler,
> >   - and linking with LLD.
> >
> > While using full LTO results in the best runtime performance, the
> > compilation is not scalable in time or memory. CONFIG_THINLTO
> > enables ThinLTO, which allows parallel optimization and faster
> > incremental builds. ThinLTO is used by default if the architecture
> > also selects ARCH_SUPPORTS_THINLTO:
> >
> >   https://clang.llvm.org/docs/ThinLTO.html
> >
> > To enable LTO, LLVM tools must be used to handle bitcode files. The
> > easiest way is to pass the LLVM=1 option to make:
> >
> >   $ make LLVM=1 defconfig
> >   $ scripts/config -e LTO_CLANG
> >   $ make LLVM=1
> >
> > Alternatively, at least the following LLVM tools must be used:
> >
> >   CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
> >
> > To prepare for LTO support with other compilers, common parts are
> > gated behind the CONFIG_LTO option, and LTO can be disabled for
> > specific files by filtering out CC_FLAGS_LTO.
> >
> > Note that support for DYNAMIC_FTRACE and MODVERSIONS are added in
> > follow-up patches.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  Makefile                          | 18 +++++++-
> >  arch/Kconfig                      | 68 +++++++++++++++++++++++++++++++
> >  include/asm-generic/vmlinux.lds.h | 11 +++--
> >  scripts/Makefile.build            |  9 +++-
> >  scripts/Makefile.modfinal         |  9 +++-
> >  scripts/Makefile.modpost          | 24 ++++++++++-
> >  scripts/link-vmlinux.sh           | 32 +++++++++++----
> >  7 files changed, 154 insertions(+), 17 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index a9dae26c93b5..dd49eaea7c25 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -909,6 +909,22 @@ KBUILD_CFLAGS      += $(CC_FLAGS_SCS)
> >  export CC_FLAGS_SCS
> >  endif
> >
> > +ifdef CONFIG_LTO_CLANG
> > +ifdef CONFIG_THINLTO
> > +CC_FLAGS_LTO_CLANG := -flto=thin -fsplit-lto-unit
> > +KBUILD_LDFLAGS += --thinlto-cache-dir=.thinlto-cache
> > +else
> > +CC_FLAGS_LTO_CLANG := -flto
> > +endif
> > +CC_FLAGS_LTO_CLANG += -fvisibility=default
> > +endif
> > +
> > +ifdef CONFIG_LTO
> > +CC_FLAGS_LTO   := $(CC_FLAGS_LTO_CLANG)
> 
> 
> $(CC_FLAGS_LTO_CLANG) is not used elsewhere.
> 
> Why didn't you add the flags to CC_FLAGS_LTO
> directly?
> 
> Will it be useful if LTO_GCC is supported ?

The idea was to allow compiler-specific LTO flags to be filtered out
separately if needed, but you're right, this is not really necessary
right now. I'll drop CC_FLAGS_LTO_CLANG in v3.

Sami
