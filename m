Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342CC25EA58
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgIEUSa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 16:18:30 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52079 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIEUSZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 16:18:25 -0400
X-Greylist: delayed 110455 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Sep 2020 16:18:23 EDT
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 085KIAXe008998;
        Sun, 6 Sep 2020 05:18:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 085KIAXe008998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599337091;
        bh=AM99QzFxxKGBKlEOzZ//FGYuWqlVjObjhMrW0TXZ1vI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2mT3GBG1wE8G/yhfLSiGJrSIlfMwrbNAUJKfC8gZ3etoILU0Zt8SumIhqPwfSULnc
         NiTXPP6y+jVKTSdF52qblNj8+Erwe44OAi3+JvNj3bnz1xnxKFq7ODs67zco8o0vN/
         3TsC6sQGntZygvez3VSOoQd+9TJdtVBzKLn31Tii+GMykpZKux2BYRxCt7WzqItnhf
         gQF8087kfcTGYy6+HQH8Nm7HxU9Soano2FeVeXwfbVYa1sktzUe5OKbi1/IDSFfoRv
         AQGmR5q2uh4wolJFo7NXbJsHPQOtZZYon5wxO3OEc6anfYAFK6QTSLvUTvWKMtN4DG
         SLh9BXK/ERc5Q==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id k15so6467835pfc.12;
        Sat, 05 Sep 2020 13:18:11 -0700 (PDT)
X-Gm-Message-State: AOAM533M+KOq3mFmd0jb1/ESVUCxpW0tDyvpKFOIZgBluRINYk59EXaY
        RAVvkRAEokIuKgEPToF2gs+W40wYJInEP73EgFA=
X-Google-Smtp-Source: ABdhPJyNsnmMbyAG66fOWmKiovR25YJyERnRLtPM25a82Zl3RS3nL26piTxmNQ2uNI60/yqc3rOaDVz5VEX2fwwCiOI=
X-Received: by 2002:a62:8007:0:b029:13c:1611:6533 with SMTP id
 j7-20020a6280070000b029013c16116533mr12182097pfd.5.1599337089871; Sat, 05 Sep
 2020 13:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-10-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-10-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Sep 2020 05:17:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNASTtxJ7OCMM_KxmaoSL3CDfTY-65Pu=-MYkMo7iz-_NOQ@mail.gmail.com>
Message-ID: <CAK7LNASTtxJ7OCMM_KxmaoSL3CDfTY-65Pu=-MYkMo7iz-_NOQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] kbuild: add support for Clang LTO
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

On Fri, Sep 4, 2020 at 5:31 AM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> This change adds build system support for Clang's Link Time
> Optimization (LTO). With -flto, instead of ELF object files, Clang
> produces LLVM bitcode, which is compiled into native code at link
> time, allowing the final binary to be optimized globally. For more
> details, see:
>
>   https://llvm.org/docs/LinkTimeOptimization.html
>
> The Kconfig option CONFIG_LTO_CLANG is implemented as a choice,
> which defaults to LTO being disabled. To use LTO, the architecture
> must select ARCH_SUPPORTS_LTO_CLANG and support:
>
>   - compiling with Clang,
>   - compiling inline assembly with Clang's integrated assembler,
>   - and linking with LLD.
>
> While using full LTO results in the best runtime performance, the
> compilation is not scalable in time or memory. CONFIG_THINLTO
> enables ThinLTO, which allows parallel optimization and faster
> incremental builds. ThinLTO is used by default if the architecture
> also selects ARCH_SUPPORTS_THINLTO:
>
>   https://clang.llvm.org/docs/ThinLTO.html
>
> To enable LTO, LLVM tools must be used to handle bitcode files. The
> easiest way is to pass the LLVM=1 option to make:
>
>   $ make LLVM=1 defconfig
>   $ scripts/config -e LTO_CLANG
>   $ make LLVM=1
>
> Alternatively, at least the following LLVM tools must be used:
>
>   CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm
>
> To prepare for LTO support with other compilers, common parts are
> gated behind the CONFIG_LTO option, and LTO can be disabled for
> specific files by filtering out CC_FLAGS_LTO.
>
> Note that support for DYNAMIC_FTRACE and MODVERSIONS are added in
> follow-up patches.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  Makefile                          | 18 +++++++-
>  arch/Kconfig                      | 68 +++++++++++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 11 +++--
>  scripts/Makefile.build            |  9 +++-
>  scripts/Makefile.modfinal         |  9 +++-
>  scripts/Makefile.modpost          | 24 ++++++++++-
>  scripts/link-vmlinux.sh           | 32 +++++++++++----
>  7 files changed, 154 insertions(+), 17 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index a9dae26c93b5..dd49eaea7c25 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -909,6 +909,22 @@ KBUILD_CFLAGS      += $(CC_FLAGS_SCS)
>  export CC_FLAGS_SCS
>  endif
>
> +ifdef CONFIG_LTO_CLANG
> +ifdef CONFIG_THINLTO
> +CC_FLAGS_LTO_CLANG := -flto=thin -fsplit-lto-unit
> +KBUILD_LDFLAGS += --thinlto-cache-dir=.thinlto-cache
> +else
> +CC_FLAGS_LTO_CLANG := -flto
> +endif
> +CC_FLAGS_LTO_CLANG += -fvisibility=default
> +endif
> +
> +ifdef CONFIG_LTO
> +CC_FLAGS_LTO   := $(CC_FLAGS_LTO_CLANG)


$(CC_FLAGS_LTO_CLANG) is not used elsewhere.

Why didn't you add the flags to CC_FLAGS_LTO
directly?

Will it be useful if LTO_GCC is supported ?



> +KBUILD_CFLAGS  += $(CC_FLAGS_LTO)
> +export CC_FLAGS_LTO
> +endif




-- 
Best Regards
Masahiro Yamada
