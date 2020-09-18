Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5532706EF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIRUXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIRUW6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:22:58 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24421C0613CE;
        Fri, 18 Sep 2020 13:22:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u126so8474106oif.13;
        Fri, 18 Sep 2020 13:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=doA4ol07JEk8RvmCDvE+88F3JtPRfseL2+6tdCDWQqw=;
        b=QAjG/sl8UIY2V68ScqGjPqpSnpyz8SiLhlbn+9TwfGAlU68sN4f6HL/rOl6hNuR8t9
         TRbjj/+3zjcGPvS5IQxjWb/SP42RdnzIX7W8+TJpQe23EaF2Y/NG+ym3GGBfZHxbs37r
         LMgygcdaRo2kO7syRCAuu7brZtOvkwg5mK7rWbTUzLrCw74gT20ynO2Qs0XvEeOcOWFJ
         v9ZcGiwgCjZGdPRJpa7ylfICzg4yKuPqOtIhviSXNi8Ep8P21xCOMMF8LvMOvBRt2kw0
         Uw68vY0hOQO28Jh2eL0Pq9UKC07QXtghNEhuXjMIdeUZi8ez+WswdseqqcN1TAEA+Jo0
         WQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=doA4ol07JEk8RvmCDvE+88F3JtPRfseL2+6tdCDWQqw=;
        b=RREw4O0Nvu+TjqCrx9ZWr3YgNl85YWy5UgBhnVHrDNZ+PKZtP4FPh7A1tKYQzCn83v
         AL9OyIMHrAiMO1g7X9aFcH8Yz5pC1aCiIHs5GfrmYqEX1q2R2WYGhDeVi0dfh7QvMTEf
         A7iChSWUNzksaQB0p2kFzTCvGN5USlp9thKxyAFCiP6XE9xqTzDFnN0hFdk3jVmTF3sz
         d2ByZfMRuSWC+KbnZAtLcN+yl1mcmRuu3eSRuKIkwXGm8jsuXxD/oCKWc5wdMNBaCeSS
         B1q3bX+oZ1vfDbKSmYTiBisxlJBHK/CaN5PnHt1xgcEY0rvPIV38cGpOMnaHL3mwAKox
         nz0g==
X-Gm-Message-State: AOAM532KvgC5c7fFZ/ju9Y3StU/uB/hCH2hO/LE+GlHHm66oKlvSgwlC
        9oTHUsoZ9ti9TxkAFUg2bpWWnBuOIiuh9rc8M08=
X-Google-Smtp-Source: ABdhPJwphP9ojdahsOdNIORs8jQM7iAKWDDRb89RyKBzU9JdoeiJZQyTzCMhdFKMEp06LRl3gHYmyPqZfVD8YGyWrm4=
X-Received: by 2002:aca:4754:: with SMTP id u81mr10252669oia.72.1600460577384;
 Fri, 18 Sep 2020 13:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 18 Sep 2020 22:22:46 +0200
Message-ID: <CA+icZUW1MYSUz8jwOaVpi6ib1dyCv1VmG5priw6TTzXGSh_8Gg@mail.gmail.com>
Subject: Re: [PATCH v3 00/30] Add support for Clang LTO
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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

On Fri, Sep 18, 2020 at 10:14 PM 'Sami Tolvanen' via Clang Built Linux
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
> Note that patches 1-5 are not directly related to LTO, but are
> needed to compile LTO kernels with ToT Clang, so I'm including them
> in the series for your convenience:
>
>  - Patches 1-3 fix build issues with LLVM and they are already in
>    linux-next.
>
>  - Patch 4 fixes x86 builds with LLVM IAS, but it hasn't yet been
>    picked up by maintainers.
>
>  - Patch 5 is from Masahiro's kbuild tree and makes the LTO linker
>    script changes much cleaner.
>

Hi Sami,

might be good to point to your GitHub tree and corresponding
release-tag for easy fetching.

Thanks.

Regards,
- Sedat -


> ---
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
> Arvind Sankar (2):
>   x86/boot/compressed: Disable relocation relaxation
>   x86/asm: Replace __force_order with memory clobber
>
> Luca Stefani (1):
>   RAS/CEC: Fix cec_init() prototype
>
> Masahiro Yamada (1):
>   kbuild: preprocess module linker script
>
> Nick Desaulniers (1):
>   lib/string.c: implement stpcpy
>
> Peter Zijlstra (1):
>   objtool: Add a pass for generating __mcount_loc
>
> Sami Tolvanen (24):
>   objtool: Don't autodetect vmlinux.o
>   kbuild: add support for objtool mcount
>   x86, build: use objtool mcount
>   treewide: remove DISABLE_LTO
>   kbuild: add support for Clang LTO
>   kbuild: lto: fix module versioning
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
>   arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
>   arm64: vdso: disable LTO
>   KVM: arm64: disable LTO for the nVHE directory
>   arm64: allow LTO_CLANG and THINLTO to be selected
>   x86, vdso: disable LTO only for vDSO
>   x86, cpu: disable LTO for cpu.c
>   x86, build: allow LTO_CLANG and THINLTO to be selected
>
>  .gitignore                                    |   1 +
>  Makefile                                      |  74 ++++-
>  arch/Kconfig                                  |  68 +++++
>  arch/arm/Makefile                             |   4 -
>  .../module.lds => include/asm/module.lds.h}   |   2 +
>  arch/arm64/Kconfig                            |   2 +
>  arch/arm64/Makefile                           |   5 +-
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
>  arch/x86/boot/compressed/Makefile             |   2 +
>  arch/x86/boot/compressed/pgtable_64.c         |   9 -
>  arch/x86/entry/vdso/Makefile                  |   5 +-
>  arch/x86/include/asm/special_insns.h          |  28 +-
>  arch/x86/kernel/cpu/common.c                  |   4 +-
>  arch/x86/power/Makefile                       |   4 +
>  drivers/firmware/efi/libstub/Makefile         |   2 +
>  drivers/misc/lkdtm/Makefile                   |   1 +
>  drivers/ras/cec.c                             |   9 +-
>  include/asm-generic/Kbuild                    |   1 +
>  include/asm-generic/module.lds.h              |  10 +
>  include/asm-generic/vmlinux.lds.h             |  11 +-
>  include/linux/init.h                          |  79 ++++-
>  include/linux/pci.h                           |  19 +-
>  kernel/Makefile                               |   3 -
>  kernel/trace/Kconfig                          |   5 +
>  lib/string.c                                  |  24 ++
>  scripts/.gitignore                            |   1 +
>  scripts/Makefile                              |   3 +
>  scripts/Makefile.build                        |  69 +++--
>  scripts/Makefile.lib                          |  17 +-
>  scripts/Makefile.modfinal                     |  29 +-
>  scripts/Makefile.modpost                      |  22 +-
>  scripts/generate_initcall_order.pl            | 270 ++++++++++++++++++
>  scripts/link-vmlinux.sh                       |  95 +++++-
>  scripts/mod/Makefile                          |   1 +
>  scripts/mod/modpost.c                         |  16 +-
>  scripts/mod/modpost.h                         |   9 +
>  scripts/mod/sumversion.c                      |   6 +-
>  scripts/{module-common.lds => module.lds.S}   |  31 ++
>  scripts/package/builddeb                      |   2 +-
>  tools/objtool/builtin-check.c                 |  13 +-
>  tools/objtool/builtin.h                       |   2 +-
>  tools/objtool/check.c                         |  83 ++++++
>  tools/objtool/check.h                         |   1 +
>  tools/objtool/objtool.h                       |   1 +
>  58 files changed, 919 insertions(+), 154 deletions(-)
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
> base-commit: 92ab97adeefccf375de7ebaad9d5b75d4125fe8b
> --
> 2.28.0.681.g6f77f65b4e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200918201436.2932360-1-samitolvanen%40google.com.
