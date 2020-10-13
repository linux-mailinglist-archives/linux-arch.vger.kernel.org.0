Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7F28C63A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 02:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgJMAdc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 20:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgJMAcG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2020 20:32:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299C7C0613D1
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:06 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ec4so11699932qvb.21
        for <linux-arch@vger.kernel.org>; Mon, 12 Oct 2020 17:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OJOo2mPtwLVt3Btef9tCd4OBHWCay8DKkoOT1RdZm54=;
        b=UojFnS6wp9+JkvfRaZdkt/NHiq0Zo5bAk02S+Aq1YdUoQ5nxE3VNdJSkV/kMJ2nw2T
         0v1jg0c9rc8Jll2FYmptKRB0cfatcnVKfJDbXsCbITB8hx8EKXIyP9f8QdZXHE80tYoI
         DUx95eFr58Tlzz6u2QG7P1+GldeGJb5/GaqS8BysO3vyqzJeLHSqFBDPKYO1FIHhaHxb
         JdxhrPGWineDlAATmjOIdda6W0jJClm7N/Cx516up2FK41rMqqZtXXSkkdoG74dB8ML7
         LGMGbxkjwfNozzN1XOkol6/VYuOz3xQRX5iPmzS0Wy9b/Z5N/PVfpYpa1MLWhbgzu4gN
         Yz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OJOo2mPtwLVt3Btef9tCd4OBHWCay8DKkoOT1RdZm54=;
        b=jA3/YjPAYQBaNeXw60wjtAwQWyNixGvMCC8PjE/+tTLDl0V2WrvJRYEnZinrsR4BLS
         ZQKBn6HBlPn9anQ8YwwX2AegmUJwmVv0bSsBwkAb2a8i0J33LhDXUsK9Zh9EkdlSDNuT
         HNCAxbMm6tkx671UL0aa/Im2gmuk/7alBmzkCK2hOwjeosb+FPQe4+IYNtQRN7g7Uz8Z
         uTgWNd2gwJFuRBVFCG29j4IKF9+SMGpufqM5dMWy0WCR1mjq0oHu8k649ElnmzasMSRJ
         nAba5Mw+/A+Rr4SFcPxg1M5BcRPdO6QqmTcN1pi7JSryvg1K1wclr7sIailZ4W6bOpg9
         gs9Q==
X-Gm-Message-State: AOAM531HMawZzYxZKQmQjj/tpUEI2GA6x1kDGhfUpyOEc7GW+H0G8rX7
        QSKkhRuGovcJus/g2pdjR/GpmvVjOjh/EYKZEto=
X-Google-Smtp-Source: ABdhPJxH4NF2ufwWCu0rT4xNxHqUl6H1eRA5phXQVHXpMwo0zp1WH5b4jhlrx0nHNlt0XKW8iPthPAU05BvJlu74qas=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d848:: with SMTP id
 i8mr28244513qvj.31.1602549125192; Mon, 12 Oct 2020 17:32:05 -0700 (PDT)
Date:   Mon, 12 Oct 2020 17:31:38 -0700
Message-Id: <20201013003203.4168817-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v6 00/25] Add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

This patch series adds support for building the x86_64 kernel with
Clang's Link Time Optimization (LTO).

In addition to performance, the primary motivation for LTO is
to allow Clang's Control-Flow Integrity (CFI) to be used in the
kernel. Google has shipped millions of Pixel devices running three
major kernel versions with LTO+CFI since 2018.

Most of the patches are build system changes for handling LLVM
bitcode, which Clang produces with LTO instead of ELF object files,
postponing ELF processing until a later stage, and ensuring initcall
ordering.

Note that this version is based on tip/master to reduce the number
of prerequisite patches, and to make it easier to manage changes to
objtool. Patch 1 is from Masahiro's kbuild tree, and while it's not
directly related to LTO, it makes the module linker script changes
cleaner.

Furthermore, patches 2-6 include Peter's patch for generating
__mcount_loc with objtool, and build system changes to enable it on
x86. With these patches, we no longer need to annotate functions
that have non-call references to __fentry__ with LTO, which greatly
simplifies supporting dynamic ftrace.

You can also pull this series from

  https://github.com/samitolvanen/linux.git lto-v6

---
Changes in v6:

  - Added the missing --mcount flag to patch 5.

  - Dropped the arm64 patches from this series and will repost them
    later.

Changes in v5:

  - Rebased on top of tip/master.

  - Changed the command line for objtool to use --vmlinux --duplicate
    to disable warnings about retpoline thunks and to fix .orc_unwind
    generation for vmlinux.o.

  - Added --noinstr flag to objtool, so we can use --vmlinux without
    also enabling noinstr validation.

  - Disabled objtool's unreachable instruction warnings with LTO to
    disable false positives for the int3 padding in vmlinux.o.

  - Added ANNOTATE_RETPOLINE_SAFE annotations to the indirect jumps
    in x86 assembly code to fix objtool warnings with retpoline.

  - Fixed modpost warnings about missing version information with
    CONFIG_MODVERSIONS.

  - Included Makefile.lib into Makefile.modpost for ld_flags. Thanks
    to Sedat for pointing this out.

  - Updated the help text for ThinLTO to better explain the trade-offs.

  - Updated commit messages with better explanations.

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


Masahiro Yamada (1):
  kbuild: preprocess module linker script

Peter Zijlstra (1):
  objtool: Add a pass for generating __mcount_loc

Sami Tolvanen (23):
  objtool: Don't autodetect vmlinux.o
  tracing: move function tracer options to Kconfig
  tracing: add support for objtool mcount
  x86, build: use objtool mcount
  treewide: remove DISABLE_LTO
  kbuild: add support for Clang LTO
  kbuild: lto: fix module versioning
  objtool: Split noinstr validation from --vmlinux
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
  x86/asm: annotate indirect jumps
  x86, vdso: disable LTO only for vDSO
  x86, cpu: disable LTO for cpu.c
  x86, build: allow LTO_CLANG and THINLTO to be selected

 .gitignore                                    |   1 +
 Makefile                                      |  68 +++--
 arch/Kconfig                                  |  74 +++++
 arch/arm/Makefile                             |   4 -
 .../module.lds => include/asm/module.lds.h}   |   2 +
 arch/arm64/Makefile                           |   4 -
 .../module.lds => include/asm/module.lds.h}   |   2 +
 arch/arm64/kernel/vdso/Makefile               |   1 -
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
 arch/x86/entry/vdso/Makefile                  |   5 +-
 arch/x86/kernel/acpi/wakeup_64.S              |   2 +
 arch/x86/platform/pvh/head.S                  |   2 +
 arch/x86/power/Makefile                       |   4 +
 arch/x86/power/hibernate_asm_64.S             |   3 +
 drivers/firmware/efi/libstub/Makefile         |   2 +
 drivers/misc/lkdtm/Makefile                   |   1 +
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
 scripts/Makefile.modpost                      |  25 +-
 scripts/generate_initcall_order.pl            | 270 ++++++++++++++++++
 scripts/link-vmlinux.sh                       |  98 ++++++-
 scripts/mod/Makefile                          |   1 +
 scripts/mod/modpost.c                         |  16 +-
 scripts/mod/modpost.h                         |   9 +
 scripts/mod/sumversion.c                      |   6 +-
 scripts/{module-common.lds => module.lds.S}   |  31 ++
 scripts/package/builddeb                      |   2 +-
 tools/objtool/builtin-check.c                 |  10 +-
 tools/objtool/builtin.h                       |   2 +-
 tools/objtool/check.c                         |  84 +++++-
 tools/objtool/check.h                         |   1 +
 tools/objtool/objtool.c                       |   1 +
 tools/objtool/objtool.h                       |   1 +
 54 files changed, 895 insertions(+), 128 deletions(-)
 rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
 rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
 rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
 rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
 create mode 100644 include/asm-generic/module.lds.h
 create mode 100755 scripts/generate_initcall_order.pl
 rename scripts/{module-common.lds => module.lds.S} (59%)


base-commit: a292570e9f694ed50d3e69afd6d54272fd40deca
-- 
2.28.0.1011.ga647a8990f-goog

