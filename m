Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57872B88C4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 00:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgKRXtB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 18:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRXtA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 18:49:00 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E4FC0613D6
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 15:48:58 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t18so1932453plo.0
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 15:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qJhOENprwVDBgKHWe+Nqa+ACNZQmHxei86hUJ0EJ4k=;
        b=jmbyV0dz5fdggeIDE+RnwLHGCNqBevZTZcN0Y6IcCYP++3BQ6/O3Q+if3XNyLFfjGg
         DjZTn3v5c69jwAfKB4zf2KznteGBMBL3KiEPeVJWzwQ4BD7Sog+51pMxdq1YH2+N0h4q
         CkPpA8V56TMFRd5OIHNDKTEwxexLLC38e4M/acOi/3AmGeKvHB2JR3C+Xy6FRD1yliKA
         GNmG9tcQEN5SBnZZT8Nne7Hi2aqKzQkLSA3MReN8x8O9QPT0EL2jpBmiylCsICyBbBzf
         G+ck1ptf0D19vq68YoMiThN24ogs+GHhgSA9a+W957MXRVXqUtE2U4X/JyQyLi961GpH
         rkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qJhOENprwVDBgKHWe+Nqa+ACNZQmHxei86hUJ0EJ4k=;
        b=Hal5LMLxBNhogcR8OA5cnEZGtAWVFRTBkbTE92rPUGnt+NgE9cFALnB/i+qhbcWjw2
         wFMEqGZUoGCzVzdJC9qnhKsct0dTviuqa0Zib/Q6KZ7WMPzmfw5xz9+Vqmv2KH+Xp4vQ
         kik1lOSAtMXaCg4+mlBohxiptElY36PH2ApeAH90jdXhT89pqBHrqYHarLPjd2TLSW0Z
         V0phrhRbDeV4dR5/mvFAMuJsQdVDo9dlYhBjJHFubaeumIWE6nov4z3w7nMnyQgFKqlI
         3PG+VZhUWf6dmbwm39eCuEIOPPj9kMZG4UBTS0kYcea4pcAUN/twS3Exprk8/Ei9QHX+
         3TFA==
X-Gm-Message-State: AOAM530RZztsBFrYGq10rqnJc0L2IAE6bn5tzgqsnB47qTCt+S+TXhzE
        f8diXdZeAM7MLM/dQA4ckszv00YURFlK4K4PlzWv8w==
X-Google-Smtp-Source: ABdhPJycZ9fkgVioD6gEnGSg9ifM4kVvWrYIbY+iuByY8hvrPXyHzILikyzkPFgr0e19nT+K+ZV8BTIrE+aEETW/2bE=
X-Received: by 2002:a17:902:221:b029:d8:f938:b112 with SMTP id
 30-20020a1709020221b02900d8f938b112mr6500995plc.10.1605743337329; Wed, 18 Nov
 2020 15:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com> <20201118220731.925424-3-samitolvanen@google.com>
In-Reply-To: <20201118220731.925424-3-samitolvanen@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 18 Nov 2020 15:48:45 -0800
Message-ID: <CAKwvOdnYTMzaahnBqdNYPz3KMdnkp=jZ4hxiqkTYzM5+BBdezA@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] kbuild: add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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

On Wed, Nov 18, 2020 at 2:07 PM Sami Tolvanen <samitolvanen@google.com> wrote:
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
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  Makefile                          | 19 +++++++-
>  arch/Kconfig                      | 75 +++++++++++++++++++++++++++++++
>  include/asm-generic/vmlinux.lds.h | 11 +++--
>  scripts/Makefile.build            |  9 +++-
>  scripts/Makefile.modfinal         |  9 +++-
>  scripts/Makefile.modpost          | 21 ++++++++-
>  scripts/link-vmlinux.sh           | 32 +++++++++----
>  7 files changed, 158 insertions(+), 18 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 8c8feb4245a6..240560e88d69 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -893,6 +893,21 @@ KBUILD_CFLAGS      += $(CC_FLAGS_SCS)
>  export CC_FLAGS_SCS
>  endif
>
> +ifdef CONFIG_LTO_CLANG
> +ifdef CONFIG_THINLTO
> +CC_FLAGS_LTO   += -flto=thin -fsplit-lto-unit
> +KBUILD_LDFLAGS += --thinlto-cache-dir=$(extmod-prefix).thinlto-cache
> +else
> +CC_FLAGS_LTO   += -flto
> +endif
> +CC_FLAGS_LTO   += -fvisibility=default
> +endif
> +
> +ifdef CONFIG_LTO
> +KBUILD_CFLAGS  += $(CC_FLAGS_LTO)
> +export CC_FLAGS_LTO
> +endif
> +
>  ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
>  KBUILD_CFLAGS += -falign-functions=32
>  endif
> @@ -1473,7 +1488,7 @@ MRPROPER_FILES += include/config include/generated          \
>                   *.spec
>
>  # Directories & files removed with 'make distclean'
> -DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
> +DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS .thinlto-cache
>
>  # clean - Delete most, but leave enough to build external modules
>  #
> @@ -1719,7 +1734,7 @@ PHONY += compile_commands.json
>
>  clean-dirs := $(KBUILD_EXTMOD)
>  clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps \
> -       $(KBUILD_EXTMOD)/compile_commands.json
> +       $(KBUILD_EXTMOD)/compile_commands.json $(KBUILD_EXTMOD)/.thinlto-cache
>
>  PHONY += help
>  help:
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..a41fcb3ca7c6 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -598,6 +598,81 @@ config SHADOW_CALL_STACK
>           reading and writing arbitrary memory may be able to locate them
>           and hijack control flow by modifying the stacks.
>
> +config LTO
> +       bool
> +
> +config ARCH_SUPPORTS_LTO_CLANG
> +       bool
> +       help
> +         An architecture should select this option if it supports:
> +         - compiling with Clang,
> +         - compiling inline assembly with Clang's integrated assembler,
> +         - and linking with LLD.
> +
> +config ARCH_SUPPORTS_THINLTO
> +       bool
> +       help
> +         An architecture should select this option if it supports Clang's
> +         ThinLTO.
> +
> +config THINLTO
> +       bool "Clang ThinLTO"
> +       depends on LTO_CLANG && ARCH_SUPPORTS_THINLTO
> +       default y
> +       help
> +         This option enables Clang's ThinLTO, which allows for parallel
> +         optimization and faster incremental compiles. More information
> +         can be found from Clang's documentation:
> +
> +           https://clang.llvm.org/docs/ThinLTO.html
> +
> +         If you say N here, the compiler will use full LTO, which may
> +         produce faster code, but building the kernel will be significantly
> +         slower as the linker won't efficiently utilize multiple threads.
> +
> +         If unsure, say Y.

I think the order of these new configs makes it so that ThinLTO
appears above LTO in menuconfig; I don't like that, and wish it came
immediately after.  Does `THINLTO` have to be defined _after_ the
choice for LTO_NONE/LTO_CLANG, perhaps?

Secondly, I don't like how ThinLTO is a config and not a choice.  If I
don't set ThinLTO, what am I getting?  That's a rhetorical question; I
know its full LTO, and I guess the help text does talk about the
tradeoffs and what you would get.  I guess what's curious to me is
"why does it display ThinLTO? Why not FullLTO?"  I can't help but
wonder if a kconfig `choice` rather than a `config` would be better
here, that way it's more obvious the user is making a choice between
ThinLTO vs Full LTO, rather than the current patches which look like
"ThinkLTO on/off."

These are cosmetic concerns, feel free to ignore.  Just a thought.

> +
> +choice
> +       prompt "Link Time Optimization (LTO)"
> +       default LTO_NONE
> +       help
> +         This option enables Link Time Optimization (LTO), which allows the
> +         compiler to optimize binaries globally.
> +
> +         If unsure, select LTO_NONE. Note that LTO is very resource-intensive
> +         so it's disabled by default.
> +
> +config LTO_NONE
> +       bool "None"
> +
> +config LTO_CLANG
> +       bool "Clang's Link Time Optimization (EXPERIMENTAL)"
> +       # Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
> +       depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
> +       depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> +       depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> +       depends on ARCH_SUPPORTS_LTO_CLANG
> +       depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT
> +       depends on !KASAN
> +       depends on !GCOV_KERNEL
> +       depends on !MODVERSIONS
> +       select LTO
> +       help
> +          This option enables Clang's Link Time Optimization (LTO), which
> +          allows the compiler to optimize the kernel globally. If you enable
> +          this option, the compiler generates LLVM bitcode instead of ELF
> +          object files, and the actual compilation from bitcode happens at
> +          the LTO link step, which may take several minutes depending on the
> +          kernel configuration. More information can be found from LLVM's
> +          documentation:
> +
> +           https://llvm.org/docs/LinkTimeOptimization.html
> +
> +         To select this option, you also need to use LLVM tools to handle
> +         the bitcode by passing LLVM=1 to make.
> +
> +endchoice
> +
>  config HAVE_ARCH_WITHIN_STACK_FRAMES
>         bool
>         help
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index b2b3d81b1535..8988a2e445d8 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -90,15 +90,18 @@
>   * .data. We don't want to pull in .data..other sections, which Linux
>   * has defined. Same for text and bss.
>   *
> + * With LTO_CLANG, the linker also splits sections by default, so we need
> + * these macros to combine the sections during the final link.
> + *
>   * RODATA_MAIN is not used because existing code already defines .rodata.x
>   * sections to be brought in with rodata.
>   */
> -#ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> +#if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LTO_CLANG)
>  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
> +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral*
>  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> -#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
> -#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
> +#define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
> +#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
>  #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
>  #else
>  #define TEXT_MAIN .text
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 2175ddb1ee0c..ed74b2f986f7 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -111,7 +111,7 @@ endif
>  # ---------------------------------------------------------------------------
>
>  quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
> -      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) -fverbose-asm -S -o $@ $<
> +      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<
>
>  $(obj)/%.s: $(src)/%.c FORCE
>         $(call if_changed_dep,cc_s_c)
> @@ -425,8 +425,15 @@ $(obj)/lib.a: $(lib-y) FORCE
>  # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
>  # module is turned into a multi object module, $^ will contain header file
>  # dependencies recorded in the .*.cmd file.
> +ifdef CONFIG_LTO_CLANG
> +quiet_cmd_link_multi-m = AR [M]  $@
> +cmd_link_multi-m =                                             \
> +       rm -f $@;                                               \
> +       $(AR) cDPrsT $@ $(filter %.o,$^)
> +else
>  quiet_cmd_link_multi-m = LD [M]  $@
>        cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
> +endif
>
>  $(multi-used-m): FORCE
>         $(call if_changed,link_multi-m)
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index ae01baf96f4e..2cb9a1d88434 100644
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
> @@ -36,7 +43,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>                 -T scripts/module.lds -o $@ $(filter %.o, $^);          \
>         $(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>
> -$(modules): %.ko: %.o %.mod.o scripts/module.lds FORCE
> +$(modules): %.ko: %$(prelink-ext).o %.mod.o scripts/module.lds FORCE
>         +$(call if_changed,ld_ko_o)
>
>  targets += $(modules) $(modules:.ko=.mod.o)
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index f54b6ac37ac2..9ff8bfdb574d 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -43,6 +43,9 @@ __modpost:
>  include include/config/auto.conf
>  include scripts/Kbuild.include
>
> +# for ld_flags
> +include scripts/Makefile.lib
> +
>  MODPOST = scripts/mod/modpost                                                          \
>         $(if $(CONFIG_MODVERSIONS),-m)                                                  \
>         $(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)                                        \
> @@ -102,12 +105,26 @@ $(input-symdump):
>         @echo >&2 'WARNING: Symbol version dump "$@" is missing.'
>         @echo >&2 '         Modules may not have dependencies or modversions.'
>
> +ifdef CONFIG_LTO_CLANG
> +# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode, so we need to run
> +# LTO to compile them into native code before running modpost
> +prelink-ext := .lto
> +
> +quiet_cmd_cc_lto_link_modules = LTO [M] $@
> +cmd_cc_lto_link_modules = $(LD) $(ld_flags) -r -o $@ --whole-archive $^
> +
> +%.lto.o: %.o
> +       $(call if_changed,cc_lto_link_modules)
> +endif
> +
> +modules := $(sort $(shell cat $(MODORDER)))
> +
>  # Read out modules.order to pass in modpost.
>  # Otherwise, allmodconfig would fail with "Argument list too long".
>  quiet_cmd_modpost = MODPOST $@
> -      cmd_modpost = sed 's/ko$$/o/' $< | $(MODPOST) -T -
> +      cmd_modpost = sed 's/\.ko$$/$(prelink-ext)\.o/' $< | $(MODPOST) -T -
>
> -$(output-symdump): $(MODORDER) $(input-symdump) FORCE
> +$(output-symdump): $(MODORDER) $(input-symdump) $(modules:.ko=$(prelink-ext).o) FORCE
>         $(call if_changed,modpost)
>
>  targets += $(output-symdump)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 6eded325c837..596507573a48 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -56,6 +56,14 @@ modpost_link()
>                 ${KBUILD_VMLINUX_LIBS}                          \
>                 --end-group"
>
> +       if [ -n "${CONFIG_LTO_CLANG}" ]; then
> +               # This might take a while, so indicate that we're doing
> +               # an LTO link
> +               info LTO ${1}
> +       else
> +               info LD ${1}
> +       fi
> +
>         ${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${objects}
>  }
>
> @@ -103,13 +111,22 @@ vmlinux_link()
>         fi
>
>         if [ "${SRCARCH}" != "um" ]; then
> -               objects="--whole-archive                        \
> -                       ${KBUILD_VMLINUX_OBJS}                  \
> -                       --no-whole-archive                      \
> -                       --start-group                           \
> -                       ${KBUILD_VMLINUX_LIBS}                  \
> -                       --end-group                             \
> -                       ${@}"
> +               if [ -n "${CONFIG_LTO_CLANG}" ]; then
> +                       # Use vmlinux.o instead of performing the slow LTO
> +                       # link again.
> +                       objects="--whole-archive                \
> +                               vmlinux.o                       \
> +                               --no-whole-archive              \
> +                               ${@}"
> +               else
> +                       objects="--whole-archive                \
> +                               ${KBUILD_VMLINUX_OBJS}          \
> +                               --no-whole-archive              \
> +                               --start-group                   \
> +                               ${KBUILD_VMLINUX_LIBS}          \
> +                               --end-group                     \
> +                               ${@}"
> +               fi
>
>                 ${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}      \
>                         ${strip_debug#-Wl,}                     \
> @@ -274,7 +291,6 @@ fi;
>  ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
>
>  #link vmlinux.o
> -info LD vmlinux.o
>  modpost_link vmlinux.o
>  objtool_link vmlinux.o
>
> --
> 2.29.2.299.gdc1121823c-goog
>


-- 
Thanks,
~Nick Desaulniers
