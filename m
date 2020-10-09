Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20D1288EE8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389701AbgJIQai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389471AbgJIQai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:30:38 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29409C0613D2;
        Fri,  9 Oct 2020 09:30:38 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c5so9666724ilr.9;
        Fri, 09 Oct 2020 09:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2Gc2VbZdU1IXiw57R85Qt4LavpkHTDXOYsNp+15DYcg=;
        b=hEJDk5aBM0OyqBiz/S2cVXzsuVix3FYn+kcS8O/nMkNrXwfPu3otjRaoP9O72rYi1n
         VjYgucLsJp3Z0hR/a2uaU9ns3nc7w4a7XUDetwg855x7SSC1DCcnd4EuUhQ8JwrBIpux
         s5MK022NgE0jxmvV9srK5hu5hnQSALf/i/ahx+83zw85cza0K01ntWXWSsjiEWgsaL+F
         LCVUVda2u45vCa63xSh7XUKzTMLwA/RY9xZ7HLgC18IHAvuO7h7GmXOuV1rPbw01inLF
         75zwGqlQi0C/qZRRfmtw3sj/uucK+NkR6M9+b6Grz2pok1SOVBvXn5qCWkT6jYv5rCc3
         qTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2Gc2VbZdU1IXiw57R85Qt4LavpkHTDXOYsNp+15DYcg=;
        b=dFKvrWJvyx9I4jKPP7IjpK+OpdpnG8IZGJLPDorwy9/Q3Y6yr/wYQeX5PLjtmHRVrv
         epdIOkbERUV3XadSS8RPTyrfSk5O2ciukPUbmhU0HMZBhesFuYjBj0IYAKx6zbqU3zSP
         urOXorrXIdZhqVKkK0qL3YOg89/67TOXVo6mwWGhugJt+PcvAkifmP8iDMiDcCdtoKfF
         GMxNBMQ8vImtPMExQEehQYga0Gx3TbqhSWZ0T+Cp1eNCh+6pQH5on1QbSnwGhKWcGMlP
         2pokPcyLb3EGIl4kpWeszG/fvoLNSiGefnZCizH+nKZI4TTtrg1G7cgvCcU9wyWfrimx
         xw/Q==
X-Gm-Message-State: AOAM530HwV5fDglmnqQssyKG+N1WC8+iAMLc3CJQ7P7VA1YI+FsPmxlF
        Ldhfkw48VC7LpQntHpNrA+4ybSW9raTb3D0Mli4=
X-Google-Smtp-Source: ABdhPJwBFeZdsljqopYTCCei86vRF8PIXqbXb7fERVj0i5Cq3wzs1MXDtB1itEnSoiXD6rCUYCsGvFHBayZUFIR0ZXw=
X-Received: by 2002:a92:7f05:: with SMTP id a5mr11486123ild.112.1602261037165;
 Fri, 09 Oct 2020 09:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 18:30:24 +0200
Message-ID: <CA+icZUVWdRWfhPhPy79Hpjmqbfw+n8xsgMKv_RU+hoh1bphXdg@mail.gmail.com>
Subject: Re: [PATCH v5 00/29] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 9, 2020 at 6:13 PM 'Sami Tolvanen' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> This patch series adds support for building x86_64 and arm64 kernels
> with Clang's Link Time Optimization (LTO).
>
> In addition to performance, the primary motivation for LTO is
> to allow Clang's Control-Flow Integrity (CFI) to be used in the
> kernel. Google has shipped millions of Pixel devices running three
> major kernel versions with LTO+CFI since 2018.
>
> Most of the patches are build system changes for handling LLVM
> bitcode, which Clang produces with LTO instead of ELF object files,
> postponing ELF processing until a later stage, and ensuring initcall
> ordering.
>
> Note that this version is based on tip/master to reduce the number
> of prerequisite patches, and to make it easier to manage changes to
> objtool. Patch 1 is from Masahiro's kbuild tree, and while it's not
> directly related to LTO, it makes the module linker script changes
> cleaner.
>
> Furthermore, patches 2-6 include Peter's patch for generating
> __mcount_loc with objtool, and build system changes to enable it on
> x86. With these patches, we no longer need to annotate functions
> that have non-call references to __fentry__ with LTO, which greatly
> simplifies supporting dynamic ftrace.
>
> You can also pull this series from
>
>   https://github.com/samitolvanen/linux.git lto-v5
>
> ---
> Changes in v5:
>
>   - Rebased on top of tip/master.
>

What are the plans to get this into mainline?
Linux v5.10 :-) too early - needs more review/testing?

Will clang-cfi be based on this, too?

>   - Changed the command line for objtool to use --vmlinux --duplicate
>     to disable warnings about retpoline thunks and to fix .orc_unwind
>     generation for vmlinux.o.
>
>   - Added --noinstr flag to objtool, so we can use --vmlinux without
>     also enabling noinstr validation.
>
>   - Disabled objtool's unreachable instruction warnings with LTO to
>     disable false positives for the int3 padding in vmlinux.o.
>
>   - Added ANNOTATE_RETPOLINE_SAFE annotations to the indirect jumps
>     in x86 assembly code to fix objtool warnings with retpoline.
>
>   - Fixed modpost warnings about missing version information with
>     CONFIG_MODVERSIONS.
>
>   - Included Makefile.lib into Makefile.modpost for ld_flags. Thanks
>     to Sedat for pointing this out.
>

That was a long way to detect this as I had very big Debian Linux
debug packages generated with CONFIG_DEBUG_INFO_COMPRESSED=y.

Thanks for v5 of clang-lto.

- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/1086#issuecomment-705754002

>   - Updated the help text for ThinLTO to better explain the trade-offs.
>
>   - Updated commit messages with better explanations.
>
> Changes in v4:
>
>   - Fixed a typo in Makefile.lib to correctly pass --no-fp to objtool.
>
>   - Moved ftrace configs related to generating __mcount_loc to Kconfig,
>     so they are available also in Makefile.modfinal.
>
>   - Dropped two prerequisite patches that were merged to Linus' tree.
>
> Changes in v3:
>
>   - Added a separate patch to remove the unused DISABLE_LTO treewide,
>     as filtering out CC_FLAGS_LTO instead is preferred.
>
>   - Updated the Kconfig help to explain why LTO is behind a choice
>     and disabled by default.
>
>   - Dropped CC_FLAGS_LTO_CLANG, compiler-specific LTO flags are now
>     appended directly to CC_FLAGS_LTO.
>
>   - Updated $(AR) flags as KBUILD_ARFLAGS was removed earlier.
>
>   - Fixed ThinLTO cache handling for external module builds.
>
>   - Rebased on top of Masahiro's patch for preprocessing modules.lds,
>     and moved the contents of module-lto.lds to modules.lds.S.
>
>   - Moved objtool_args to Makefile.lib to avoid duplication of the
>     command line parameters in Makefile.modfinal.
>
>   - Clarified in the commit message for the initcall ordering patch
>     that the initcall order remains the same as without LTO.
>
>   - Changed link-vmlinux.sh to use jobserver-exec to control the
>     number of jobs started by generate_initcall_ordering.pl.
>
>   - Dropped the x86/relocs patch to whitelist L4_PAGE_OFFSET as it's
>     no longer needed with ToT kernel.
>
>   - Disabled LTO for arch/x86/power/cpu.c to work around a Clang bug
>     with stack protector attributes.
>
> Changes in v2:
>
>   - Fixed -Wmissing-prototypes warnings with W=1.
>
>   - Dropped cc-option from -fsplit-lto-unit and added .thinlto-cache
>     scrubbing to make distclean.
>
>   - Added a comment about Clang >=11 being required.
>
>   - Added a patch to disable LTO for the arm64 KVM nVHE code.
>
>   - Disabled objtool's noinstr validation with LTO unless enabled.
>
>   - Included Peter's proposed objtool mcount patch in the series
>     and replaced recordmcount with the objtool pass to avoid
>     whitelisting relocations that are not calls.
>
>   - Updated several commit messages with better explanations.
>
>
> Masahiro Yamada (1):
>   kbuild: preprocess module linker script
>
> Peter Zijlstra (1):
>   objtool: Add a pass for generating __mcount_loc
>
> Sami Tolvanen (27):
>   objtool: Don't autodetect vmlinux.o
>   tracing: move function tracer options to Kconfig
>   tracing: add support for objtool mcount
>   x86, build: use objtool mcount
>   treewide: remove DISABLE_LTO
>   kbuild: add support for Clang LTO
>   kbuild: lto: fix module versioning
>   objtool: Split noinstr validation from --vmlinux
>   kbuild: lto: postpone objtool
>   kbuild: lto: limit inlining
>   kbuild: lto: merge module sections
>   kbuild: lto: remove duplicate dependencies from .mod files
>   init: lto: ensure initcall ordering
>   init: lto: fix PREL32 relocations
>   PCI: Fix PREL32 relocations for LTO
>   modpost: lto: strip .lto from module names
>   scripts/mod: disable LTO for empty.c
>   efi/libstub: disable LTO
>   drivers/misc/lkdtm: disable LTO for rodata.o
>   arm64: vdso: disable LTO
>   KVM: arm64: disable LTO for the nVHE directory
>   arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
>   arm64: allow LTO_CLANG and THINLTO to be selected
>   x86/asm: annotate indirect jumps
>   x86, vdso: disable LTO only for vDSO
>   x86, cpu: disable LTO for cpu.c
>   x86, build: allow LTO_CLANG and THINLTO to be selected
>
>  .gitignore                                    |   1 +
>  Makefile                                      |  68 +++--
>  arch/Kconfig                                  |  74 +++++
>  arch/arm/Makefile                             |   4 -
>  .../module.lds => include/asm/module.lds.h}   |   2 +
>  arch/arm64/Kconfig                            |   4 +
>  arch/arm64/Makefile                           |   4 -
>  .../module.lds => include/asm/module.lds.h}   |   2 +
>  arch/arm64/kernel/vdso/Makefile               |   4 +-
>  arch/arm64/kvm/hyp/nvhe/Makefile              |   4 +-
>  arch/ia64/Makefile                            |   1 -
>  .../{module.lds => include/asm/module.lds.h}  |   0
>  arch/m68k/Makefile                            |   1 -
>  .../module.lds => include/asm/module.lds.h}   |   0
>  arch/powerpc/Makefile                         |   1 -
>  .../module.lds => include/asm/module.lds.h}   |   0
>  arch/riscv/Makefile                           |   3 -
>  .../module.lds => include/asm/module.lds.h}   |   3 +-
>  arch/sparc/vdso/Makefile                      |   2 -
>  arch/um/include/asm/Kbuild                    |   1 +
>  arch/x86/Kconfig                              |   3 +
>  arch/x86/Makefile                             |   5 +
>  arch/x86/entry/vdso/Makefile                  |   5 +-
>  arch/x86/kernel/acpi/wakeup_64.S              |   2 +
>  arch/x86/platform/pvh/head.S                  |   2 +
>  arch/x86/power/Makefile                       |   4 +
>  arch/x86/power/hibernate_asm_64.S             |   3 +
>  drivers/firmware/efi/libstub/Makefile         |   2 +
>  drivers/misc/lkdtm/Makefile                   |   1 +
>  include/asm-generic/Kbuild                    |   1 +
>  include/asm-generic/module.lds.h              |  10 +
>  include/asm-generic/vmlinux.lds.h             |  11 +-
>  include/linux/init.h                          |  79 ++++-
>  include/linux/pci.h                           |  19 +-
>  kernel/Makefile                               |   3 -
>  kernel/trace/Kconfig                          |  29 ++
>  scripts/.gitignore                            |   1 +
>  scripts/Makefile                              |   3 +
>  scripts/Makefile.build                        |  69 +++--
>  scripts/Makefile.lib                          |  17 +-
>  scripts/Makefile.modfinal                     |  29 +-
>  scripts/Makefile.modpost                      |  25 +-
>  scripts/generate_initcall_order.pl            | 270 ++++++++++++++++++
>  scripts/link-vmlinux.sh                       |  98 ++++++-
>  scripts/mod/Makefile                          |   1 +
>  scripts/mod/modpost.c                         |  16 +-
>  scripts/mod/modpost.h                         |   9 +
>  scripts/mod/sumversion.c                      |   6 +-
>  scripts/{module-common.lds => module.lds.S}   |  31 ++
>  scripts/package/builddeb                      |   2 +-
>  tools/objtool/builtin-check.c                 |  10 +-
>  tools/objtool/check.c                         |  84 +++++-
>  tools/objtool/include/objtool/builtin.h       |   2 +-
>  tools/objtool/include/objtool/check.h         |   1 +
>  tools/objtool/include/objtool/objtool.h       |   1 +
>  tools/objtool/objtool.c                       |   1 +
>  56 files changed, 903 insertions(+), 131 deletions(-)
>  rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
>  rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
>  rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
>  rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
>  rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
>  rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
>  create mode 100644 include/asm-generic/module.lds.h
>  create mode 100755 scripts/generate_initcall_order.pl
>  rename scripts/{module-common.lds => module.lds.S} (59%)
>
>
> base-commit: 80396d76da65fc8b82581c0260c25a6aa0a495a3
> --
> 2.28.0.1011.ga647a8990f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20201009161338.657380-1-samitolvanen%40google.com.
