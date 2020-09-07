Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E4F25FD29
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgIGPbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 11:31:17 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:42350 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730126AbgIGPbN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 11:31:13 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 087FUq3p028956;
        Tue, 8 Sep 2020 00:30:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 087FUq3p028956
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599492652;
        bh=LaAhPv7xf0fzyzAeNRC0oSM953AkWxA0K40O3j1oCJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yna4t3lcBn3ihm+SsMQJlSW4XLVip7NZS99xKV6wjegTr21Y5C+6/U7bVUwTlcnB3
         dAmf1vUY7jje4VMpEF5B9l3HdyZldxrn5AXwW+dJOhdygQuD1gpo1B7WlJLi4042rB
         wpL8A6q4haTi7v3IdY0Yz7k421Qa5DJ7HjSymgZP9UOkdS5L+VUN1HdPhWxO0fbpqq
         sqd7DXuvbF/TUg/5jmbJC5BH0SP6sb2Rjrmz2EPA8uMz+CX6itEvKBHdMkyZwmZ2lm
         UGnHdDg5OmpNRGnyEq7vt5ZnO4AVkuczrZKm7pug4SY+XcKT7YxjN66TWcAmcWHrm9
         GYuGjQJXsXUnw==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id bh1so4594746plb.12;
        Mon, 07 Sep 2020 08:30:52 -0700 (PDT)
X-Gm-Message-State: AOAM532PME+KZv2QiB8Ls5zr5M9hnDVaTJwUVXix08jd/4jQLwbkSBSD
        UK86K9ig84qWFdqTxYGRAGYYKMwV2F1awyonCsg=
X-Google-Smtp-Source: ABdhPJyEfw+RTulZSFTnkTeBt2WLDcgnnJBCvvqMaD56gohQ35yMLXLHW+vK/ERS8QsJRkz5skzAxWakdk+WfgH2rog=
X-Received: by 2002:a17:90b:208:: with SMTP id fy8mr4808973pjb.153.1599492651374;
 Mon, 07 Sep 2020 08:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-10-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-10-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 8 Sep 2020 00:30:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7SbBPz06s5Gf2d+zry+Px1=jcUrC9c=_zQiCJLttY3A@mail.gmail.com>
Message-ID: <CAK7LNAR7SbBPz06s5Gf2d+zry+Px1=jcUrC9c=_zQiCJLttY3A@mail.gmail.com>
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



>  #define TEXT_MAIN .text
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6ecf30c70ced..a5f4b5d407e6 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -111,7 +111,7 @@ endif
>  # ---------------------------------------------------------------------------
>
>  quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
> -      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
> +      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
>
>  $(obj)/%.s: $(src)/%.c FORCE
>         $(call if_changed_dep,cc_s_c)
> @@ -428,8 +428,15 @@ $(obj)/lib.a: $(lib-y) FORCE
>  # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
>  # module is turned into a multi object module, $^ will contain header file
>  # dependencies recorded in the .*.cmd file.
> +ifdef CONFIG_LTO_CLANG
> +quiet_cmd_link_multi-m = AR [M]  $@
> +cmd_link_multi-m =                                             \
> +       rm -f $@;                                               \
> +       $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)


KBUILD_ARFLAGS no longer exists in the mainline.
(commit 13dc8c029cabf52ba95f60c56eb104d4d95d5889)




> +else
>  quiet_cmd_link_multi-m = LD [M]  $@
>        cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> +endif
>
>  $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 411c1e600e7d..1005b147abd0 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -6,6 +6,7 @@
>  PHONY := __modfinal
>  __modfinal:
>
> +include $(objtree)/include/config/auto.conf
>  include $(srctree)/scripts/Kbuild.include
>
>  # for c_flags
> @@ -29,6 +30,12 @@ quiet_cmd_cc_o_c = CC [M]  $@
>
>  ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
>
> +ifdef CONFIG_LTO_CLANG
> +# With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
> +# avoid a second slow LTO link
> +prelink-ext := .lto
> +endif
> +
>  quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o =                                                     \
>         $(LD) -r $(KBUILD_LDFLAGS)                                      \
> @@ -37,7 +44,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                 -o $@ $(filter %.o, $^);                                \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
> -$(modules): %.ko: %.o %.mod.o $(KBUILD_LDS_MODULE) FORCE
> +$(modules): %.ko: %$(prelink-ext).o %.mod.o $(KBUILD_LDS_MODULE) FORCE
>         +$(call if_changed,ld_ko_o)
>
>  targets += $(modules) $(modules:.ko=.mod.o)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index f54b6ac37ac2..a70f1f7da6aa 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -102,12 +102,32 @@ $(input-symdump):
>         @echo >&2 'WARNING: Symbol version dump "$@" is missing.'
>         @echo >&2 '         Modules may not have dependencies or modversions.'
>
> +ifdef CONFIG_LTO_CLANG
> +# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode,

or, .o files might be even thin archives.

For example,

$ file net/ipv6/netfilter/nf_defrag_ipv6.o
net/ipv6/netfilter/nf_defrag_ipv6.o: thin archive with 6 symbol entries


Now we have 3 possibilities for .o files:

  - ELF  (real .o)
  - LLVM bitcode (.bc)
  - Thin archive (.a)


Let me discuss how to proceed with this...





--
Best Regards
Masahiro Yamada
