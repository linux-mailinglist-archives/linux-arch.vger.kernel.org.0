Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1003325E9DA
	for <lists+linux-arch@lfdr.de>; Sat,  5 Sep 2020 21:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgIEThf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Sep 2020 15:37:35 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:30314 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgIEThc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Sep 2020 15:37:32 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 085JbALl009573;
        Sun, 6 Sep 2020 04:37:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 085JbALl009573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599334631;
        bh=qozGFnhPSdbD06RPHilTJ+T1xcEFy1jS07es42hBORQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l0JpktinNZUUOvq3YaMwDq/ifNpnDP0gI95M31CjjXo1Eo94WrN03LIDgJpLcYwtL
         z9rgrmnqKUqvwXcLrciQlOuCofICyLfOZbZEyHxIxKrJGKnjMzNdlZMhJk2CoYRgjR
         4QF3+yVbHIBOiW+LmEVHW+IwGpqUB26c6OLRm+7PfH4FyWoPT71PcG85ElPIfW6Omk
         1g+oXnyKP3MqKrTz+Krb4jydBoJ62bBXHUKz1EHULd5E8pmZrUzot7l8lQgSZabn53
         nohOP4JkiXeP2HPCD3KNOJE6maDBtMDY5G9YWljANdAXMZKw0EDzT7hvjXhujTuLny
         Yi65YfpHrkkMw==
X-Nifty-SrcIP: [209.85.216.48]
Received: by mail-pj1-f48.google.com with SMTP id o16so4741190pjr.2;
        Sat, 05 Sep 2020 12:37:10 -0700 (PDT)
X-Gm-Message-State: AOAM531rIohb3SGdNrfcDptzx/KUoTVrOmp0BWq2TvrVhAr37GqG1YKV
        VacKs/PpEde/IL17a9NIWeqRU5Bb7AsVTl/YXeE=
X-Google-Smtp-Source: ABdhPJziZ9f8lgHmxEMKePErG9t9t5m7cVzvc4yA5ksVH1KdneA0j3i5ocVxCcNskDWKBlLw4HV4GrUALFdcs5gC5MA=
X-Received: by 2002:a17:90b:1211:: with SMTP id gl17mr13959817pjb.87.1599334629836;
 Sat, 05 Sep 2020 12:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <20200903203053.3411268-10-samitolvanen@google.com>
In-Reply-To: <20200903203053.3411268-10-samitolvanen@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Sep 2020 04:36:32 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ40LGvfjca9DASXjyUgRbjFNDWZXgFtMXJ54Xmi6vwkg@mail.gmail.com>
Message-ID: <CAK7LNAQ40LGvfjca9DASXjyUgRbjFNDWZXgFtMXJ54Xmi6vwkg@mail.gmail.com>
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
> which defaults to LTO being disabled.

What is the reason for doing this in a choice?
To turn off LTO_CLANG for compile-testing?

I would rather want to give LTO_CLANG more chances
to be enabled/tested.




> To use LTO, the architecture
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


I think this would break external module builds
because it would create cache files in the
kernel source tree.

External module builds should never ever touch
the kernel tree, which is usually located under
the read-only /usr/src/ in distros.


.thinlto-cache should be created in the module tree
when it is built with M=.






> +else
> +CC_FLAGS_LTO_CLANG := -flto
> +endif
> +CC_FLAGS_LTO_CLANG += -fvisibility=default
> +endif
> +
> +ifdef CONFIG_LTO
> +CC_FLAGS_LTO   := $(CC_FLAGS_LTO_CLANG)
> +KBUILD_CFLAGS  += $(CC_FLAGS_LTO)
> +export CC_FLAGS_LTO
> +endif
> +
>  ifdef CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B
>  KBUILD_CFLAGS += -falign-functions=32
>  endif
> @@ -1499,7 +1515,7 @@ MRPROPER_FILES += include/config include/generated          \
>                   *.spec
>
>  # Directories & files removed with 'make distclean'
> -DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS
> +DISTCLEAN_FILES += tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS .thinlto-cache



This was suggested in v1, but I could not understand
why doing this in distclean was appropriate.

Is keeping cache files of kernel objects
useful for external module builds?

Also, please clean up .thinlto-cache for external module builds.








>
>  # clean - Delete most, but leave enough to build external modules
>  #
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..11bb2f48dfe8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -552,6 +552,74 @@ config SHADOW_CALL_STACK
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
> +choice
> +       prompt "Link Time Optimization (LTO)"
> +       default LTO_NONE
> +       help
> +         This option enables Link Time Optimization (LTO), which allows the
> +         compiler to optimize binaries globally.
> +
> +         If unsure, select LTO_NONE.
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
> +       depends on !FTRACE_MCOUNT_RECORD
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
> index 5430febd34be..c1f0d58272bd 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -89,15 +89,18 @@
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
> +# With CONFIG_LTO_CLANG, .o files might be LLVM bitcode, so we need to run
> +# LTO to compile them into native code before running modpost
> +prelink-ext = .lto
> +
> +quiet_cmd_cc_lto_link_modules = LTO [M] $@
> +cmd_cc_lto_link_modules =                                              \
> +       $(LD) $(ld_flags) -r -o $@                                      \
> +               --whole-archive $(filter-out FORCE,$^)
> +
> +%.lto.o: %.o FORCE
> +       $(call if_changed,cc_lto_link_modules)
> +
> +PHONY += FORCE
> +FORCE:
> +
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
> index 372c3719f94c..ebb9f912aab6 100755
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
> 2.28.0.402.g5ffc5be6b7-goog
>


--
Best Regards

Masahiro Yamada
