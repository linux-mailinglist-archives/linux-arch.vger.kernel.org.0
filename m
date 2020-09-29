Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE427DA68
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgI2Vqi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgI2Vqf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:35 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B18C061755
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f21so3360861qve.9
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ap+f/PgcipKb6Xwr77y488UFXUT7vfttNzHvf2XvHy4=;
        b=pxKmqbIyigake3W0fjk0CRWa/igqGxUHw3qFQELTPLC8nWdshs6mmWUCsQ6mIdj9mG
         uR5ZhLNSIBFiqGVc359gKgBsTxJNJ8p21PXv3uvfxnXCxmkNLh5wwhzGsP0HgoPqWeAO
         VjS8ZUqRHIykm1dP4nBu0NuaOvVgSyeBdxKSa0NKmaABqVUoEwbij5ohsdr/EJXpG30x
         orV+/IJfgecdn4qvWQ4NZpRQ3MXZCbtccw1nAVaWSBwDCbW3uVrbh0YwHbOTc6+nUKSI
         RwLmbxOmZQOdsU3BP0kHwmms5vuVFkSvwH1o+lLIJ+TNqdvCZDhucmsmE/67Tu8vBWfm
         jbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ap+f/PgcipKb6Xwr77y488UFXUT7vfttNzHvf2XvHy4=;
        b=X0xlsYjAJ5w1uLlC+1qB9PRXTND/3lAp2nk7PMMTU8kEgC/ZhAGaxwAP8iTNj4iw+i
         iLA7l0GsNwRU9jKrc4Ty5AWbfhx6tahK4+dnj/e+VXtw2nCzx1BdD//+Zr2xE7/HWwc5
         95H2Ctfk86TvJoF62cYUW4FCclk8lke5i0iZ+tqbES1xfQ/Gzt+NJ50P2fReX0HS4ohT
         RzvEiOrNB53pwQ7q0BxNDNgRDbSh671f0tgJonQtXxz7TvZHqbEipF9tXelfyhRHa0JQ
         7BfrAe95yU6CLcFl1F38wZpilMlmD+UjHWXlFtSSN2aAnyYaCZoxrdugUX8a5T3W0rKl
         njnQ==
X-Gm-Message-State: AOAM533u6iuINnWK3zhqwW4+okQGvrs2kvKPhVd1S5+5dmzh7vEDc7wk
        0XyjLM63EAlKrZ1aFs5maa/x+aGJDY7WlEyGN5o=
X-Google-Smtp-Source: ABdhPJz55DdleGieWMtR/fQtUn1HHck6f+hJzMa/0ZjSBmixhPTxqRcXtmlftsciZe+KGj3y0OcPa3T2LEQ42XxFFxA=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:b409:: with SMTP id
 u9mr6416334qve.9.1601415993082; Tue, 29 Sep 2020 14:46:33 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:02 -0700
Message-Id: <20200929214631.3516445-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 00/29] Add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series adds support for building x86_64 and arm64 kernels
with Clang's Link Time Optimization (LTO).

In addition to performance, the primary motivation for LTO is
to allow Clang's Control-Flow Integrity (CFI) to be used in the
kernel. Google has shipped millions of Pixel devices running three
major kernel versions with LTO+CFI since 2018.

Most of the patches are build system changes for handling LLVM
bitcode, which Clang produces with LTO instead of ELF object files,
postponing ELF processing until a later stage, and ensuring initcall
ordering.

Again, patches 1-3 are not directly related to LTO, but are needed
to compile LTO kernels with ToT Clang, so I'm including them in the
series for your convenience:

 - Patch 1 ("RAS/CEC: Fix cec_init() prototype") fixes an initcall
   type mismatch which breaks allmodconfig with LTO. This patch is
   in linux-next.
   
 - Patch 2 ("x86/asm: Replace __force_order with memory clobber")
   fixes x86 builds with LLVM's integrated assembler, which we use
   with LTO for inline assembly. This patch hasn't been picked up
   by maintainers yet.

 - Patch 3 ("kbuild: preprocess module linker script") is from
   Masahiro's kbuild tree and makes the LTO linker script changes
   much cleaner.

Furthermore, patches 4-8 include Peter's patch for generating
__mcount_loc with objtool, and build system changes to enable it on
x86. With these patches, we no longer need to annotate functions
that have non-call references to __fentry__ with LTO, which makes
supporting dynamic ftrace much simpler.

Patch 9 disables recordmcount for arm64 when patchable function
entry is used (enabled by default if the compiler supports the
feature), which removes thousands of unnecessary recordmcount
invocations from a defconfig build.

Note that you can also pull this series from

  https://github.com/samitolvanen/linux.git lto-v4


---
Changes in v4:

  - Fixed a typo in Makefile.lib to correctly pass --no-fp to objtool.

  - Moved ftrace configs related to generating __mcount_loc to Kconfig,
    so they are available also in Makefile.modfinal.

  - Dropped two prerequisite patches that were merged to Linus' tree.

Changes in v3:

  - Added a separate patch to remove the unused DISABLE_LTO treewide,
    as filtering out CC_FLAGS_LTO instead is preferred.

  - Updated the Kconfig help to explain why LTO is behind a choice
    and disabled by default.

  - Dropped CC_FLAGS_LTO_CLANG, compiler-specific LTO flags are now
    appended directly to CC_FLAGS_LTO.

  - Updated $(AR) flags as KBUILD_ARFLAGS was removed earlier.

  - Fixed ThinLTO cache handling for external module builds.

  - Rebased on top of Masahiro's patch for preprocessing modules.lds,
    and moved the contents of module-lto.lds to modules.lds.S.

  - Moved objtool_args to Makefile.lib to avoid duplication of the
    command line parameters in Makefile.modfinal.

  - Clarified in the commit message for the initcall ordering patch
    that the initcall order remains the same as without LTO.

  - Changed link-vmlinux.sh to use jobserver-exec to control the
    number of jobs started by generate_initcall_ordering.pl.

  - Dropped the x86/relocs patch to whitelist L4_PAGE_OFFSET as it's
    no longer needed with ToT kernel.

  - Disabled LTO for arch/x86/power/cpu.c to work around a Clang bug
    with stack protector attributes.

Changes in v2:

  - Fixed -Wmissing-prototypes warnings with W=1.

  - Dropped cc-option from -fsplit-lto-unit and added .thinlto-cache
    scrubbing to make distclean.

  - Added a comment about Clang >=11 being required.

  - Added a patch to disable LTO for the arm64 KVM nVHE code.

  - Disabled objtool's noinstr validation with LTO unless enabled.

  - Included Peter's proposed objtool mcount patch in the series
    and replaced recordmcount with the objtool pass to avoid
    whitelisting relocations that are not calls.

  - Updated several commit messages with better explanations.


Arvind Sankar (1):
  x86/asm: Replace __force_order with memory clobber

Luca Stefani (1):
  RAS/CEC: Fix cec_init() prototype

Masahiro Yamada (1):
  kbuild: preprocess module linker script

Peter Zijlstra (1):
  objtool: Add a pass for generating __mcount_loc

Sami Tolvanen (25):
  objtool: Don't autodetect vmlinux.o
  tracing: move function tracer options to Kconfig
  tracing: add support for objtool mcount
  x86, build: use objtool mcount
  arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
  treewide: remove DISABLE_LTO
  kbuild: add support for Clang LTO
  kbuild: lto: fix module versioning
  kbuild: lto: postpone objtool
  kbuild: lto: limit inlining
  kbuild: lto: merge module sections
  kbuild: lto: remove duplicate dependencies from .mod files
  init: lto: ensure initcall ordering
  init: lto: fix PREL32 relocations
  PCI: Fix PREL32 relocations for LTO
  modpost: lto: strip .lto from module names
  scripts/mod: disable LTO for empty.c
  efi/libstub: disable LTO
  drivers/misc/lkdtm: disable LTO for rodata.o
  arm64: vdso: disable LTO
  KVM: arm64: disable LTO for the nVHE directory
  arm64: allow LTO_CLANG and THINLTO to be selected
  x86, vdso: disable LTO only for vDSO
  x86, cpu: disable LTO for cpu.c
  x86, build: allow LTO_CLANG and THINLTO to be selected

 .gitignore                                    |   1 +
 Makefile                                      |  68 +++--
 arch/Kconfig                                  |  68 +++++
 arch/arm/Makefile                             |   4 -
 .../module.lds => include/asm/module.lds.h}   |   2 +
 arch/arm64/Kconfig                            |   4 +
 arch/arm64/Makefile                           |   4 -
 .../module.lds => include/asm/module.lds.h}   |   2 +
 arch/arm64/kernel/vdso/Makefile               |   4 +-
 arch/arm64/kvm/hyp/nvhe/Makefile              |   4 +-
 arch/ia64/Makefile                            |   1 -
 .../{module.lds => include/asm/module.lds.h}  |   0
 arch/m68k/Makefile                            |   1 -
 .../module.lds => include/asm/module.lds.h}   |   0
 arch/powerpc/Makefile                         |   1 -
 .../module.lds => include/asm/module.lds.h}   |   0
 arch/riscv/Makefile                           |   3 -
 .../module.lds => include/asm/module.lds.h}   |   3 +-
 arch/sparc/vdso/Makefile                      |   2 -
 arch/um/include/asm/Kbuild                    |   1 +
 arch/x86/Kconfig                              |   3 +
 arch/x86/Makefile                             |   5 +
 arch/x86/boot/compressed/pgtable_64.c         |   9 -
 arch/x86/entry/vdso/Makefile                  |   5 +-
 arch/x86/include/asm/special_insns.h          |  28 +-
 arch/x86/kernel/cpu/common.c                  |   4 +-
 arch/x86/power/Makefile                       |   4 +
 drivers/firmware/efi/libstub/Makefile         |   2 +
 drivers/misc/lkdtm/Makefile                   |   1 +
 drivers/ras/cec.c                             |   9 +-
 include/asm-generic/Kbuild                    |   1 +
 include/asm-generic/module.lds.h              |  10 +
 include/asm-generic/vmlinux.lds.h             |  11 +-
 include/linux/init.h                          |  79 ++++-
 include/linux/pci.h                           |  19 +-
 kernel/Makefile                               |   3 -
 kernel/trace/Kconfig                          |  29 ++
 scripts/.gitignore                            |   1 +
 scripts/Makefile                              |   3 +
 scripts/Makefile.build                        |  69 +++--
 scripts/Makefile.lib                          |  17 +-
 scripts/Makefile.modfinal                     |  29 +-
 scripts/Makefile.modpost                      |  22 +-
 scripts/generate_initcall_order.pl            | 270 ++++++++++++++++++
 scripts/link-vmlinux.sh                       |  95 +++++-
 scripts/mod/Makefile                          |   1 +
 scripts/mod/modpost.c                         |  16 +-
 scripts/mod/modpost.h                         |   9 +
 scripts/mod/sumversion.c                      |   6 +-
 scripts/{module-common.lds => module.lds.S}   |  31 ++
 scripts/package/builddeb                      |   2 +-
 tools/objtool/builtin-check.c                 |  13 +-
 tools/objtool/builtin.h                       |   2 +-
 tools/objtool/check.c                         |  83 ++++++
 tools/objtool/check.h                         |   1 +
 tools/objtool/objtool.h                       |   1 +
 56 files changed, 906 insertions(+), 160 deletions(-)
 rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
 rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
 rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
 rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
 create mode 100644 include/asm-generic/module.lds.h
 create mode 100755 scripts/generate_initcall_order.pl
 rename scripts/{module-common.lds => module.lds.S} (59%)


base-commit: ccc1d052eff9f3cfe59d201263903fe1d46c79a5
-- 
2.28.0.709.gb0816b6eb0-goog

