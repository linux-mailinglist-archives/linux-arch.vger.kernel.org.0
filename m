Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64D9261755
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbgIHRbY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 13:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731955AbgIHRao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Sep 2020 13:30:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E3C061756
        for <linux-arch@vger.kernel.org>; Tue,  8 Sep 2020 10:30:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so20010pgm.11
        for <linux-arch@vger.kernel.org>; Tue, 08 Sep 2020 10:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/5WUqOjLHPAdLAI0MKh9zhuMyV7IC1nlysZjintZ/W0=;
        b=AzIN32ulFSn0Cg8a7U6pqoMQp2nPeaRLHJAx4wWGA8CJaevtEmegxP/Z/uIxm/mEpu
         QVOrS/Ir/CxKvGymkWaSrXUyeKbbg65sx4q09ssmoAXIt6bm8jV1LH45TsyB5/QvO6Qe
         pSg9MqH9AVTpVpXvwoaCFmKjx/m6VIWugbAKBCS/XL0KnFFDPP0JrCP80TKO4jQk1l8S
         wZd7N9m2+fYup3wy0GHLd7qSFjvCk9cqS0RN9Ik5g/nfu3wKrjCUUWhivmYZDrkqWnnn
         OxFDZvlGFT0EA/qrpHwZR1QXKjTo0BlWMq5+aAWrCKqvUbyJyaxDNVHcgxbFAvzgGEAS
         e78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5WUqOjLHPAdLAI0MKh9zhuMyV7IC1nlysZjintZ/W0=;
        b=CpHr6b8lUNvNYHv7Hhy70q11m2yj0rCllBoNu3DmEPYKZMztPb3eFKUQUM/j4oyV5Q
         eODGfHMCSFaDV7CtR+ZYESkQSu7H1uTN+6iF823klgcDSIwwN4SaayfNAqGBnpLC/G2Q
         ix/pg1MWhVH/8V3zREIhGlDfx/gD0UK7HiMeIOPWumaRV4qUpUt69hAj1zAGjvYi5j4B
         bsJxvmZUTykVlYdFKM/kEyK/tiqNK/z2XDjxw6rovtPZMdPNsTrC6eyvGs/s1/Ho7RO+
         KpzW29S1wDt+yyazTg6HFsbpQW+jOIqe+JCoy4z6TpbCoFrk3CtEPd3WxxznHJU5uGd8
         jqDA==
X-Gm-Message-State: AOAM532ZtgAxjaTDvu0CpsNwvppKAmtXa836I17IYo1p2Zz9rVBvw6BL
        o4ph3ld+9U3zqy4/VdGpFPuQfQ==
X-Google-Smtp-Source: ABdhPJzOBlE39s5MhGzUGu96iQjHpMxBRxzAFujrD+zw10TmjrKYdMPOuT7bZ60x6uln4rayX4+T8w==
X-Received: by 2002:a63:ca0c:: with SMTP id n12mr18009749pgi.209.1599586243396;
        Tue, 08 Sep 2020 10:30:43 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id w185sm60365pfc.36.2020.09.08.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:30:42 -0700 (PDT)
Date:   Tue, 8 Sep 2020 10:30:36 -0700
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
Message-ID: <20200908173036.GD2743468@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-10-samitolvanen@google.com>
 <CAK7LNAR7SbBPz06s5Gf2d+zry+Px1=jcUrC9c=_zQiCJLttY3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR7SbBPz06s5Gf2d+zry+Px1=jcUrC9c=_zQiCJLttY3A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 08, 2020 at 12:30:14AM +0900, Masahiro Yamada wrote:
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
> 
> 
> 
> >  #define TEXT_MAIN .text
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 6ecf30c70ced..a5f4b5d407e6 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -111,7 +111,7 @@ endif
> >  # ---------------------------------------------------------------------------
> >
> >  quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
> > -      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
> > +      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
> >
> >  $(obj)/%.s: $(src)/%.c FORCE
> >         $(call if_changed_dep,cc_s_c)
> > @@ -428,8 +428,15 @@ $(obj)/lib.a: $(lib-y) FORCE
> >  # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
> >  # module is turned into a multi object module, $^ will contain header file
> >  # dependencies recorded in the .*.cmd file.
> > +ifdef CONFIG_LTO_CLANG
> > +quiet_cmd_link_multi-m = AR [M]  $@
> > +cmd_link_multi-m =                                             \
> > +       rm -f $@;                                               \
> > +       $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)
> 
> 
> KBUILD_ARFLAGS no longer exists in the mainline.
> (commit 13dc8c029cabf52ba95f60c56eb104d4d95d5889)

Thanks, I'll drop this in the next version.

> > +ifdef CONFIG_LTO_CLANG
> > +# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode,
> 
> or, .o files might be even thin archives.

Right, and with LTO the thin archive might also point to a mix of bitcode
and ELF to further complicate things.

> For example,
> 
> $ file net/ipv6/netfilter/nf_defrag_ipv6.o
> net/ipv6/netfilter/nf_defrag_ipv6.o: thin archive with 6 symbol entries
> 
> 
> Now we have 3 possibilities for .o files:
> 
>   - ELF  (real .o)
>   - LLVM bitcode (.bc)
>   - Thin archive (.a)
> 
> 
> Let me discuss how to proceed with this...

Did you have something in mind to make this cleaner?

Sami
