Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC9D288DDE
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389625AbgJIQNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389144AbgJIQNm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 12:13:42 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8A6C0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 09:13:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k4so7110105pff.4
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2020 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=U16gZthY7GiG18hos+s39UYV/dexC5axxz2McFtoNlo=;
        b=vhS3dYYv7bY+kDyncQJsbZHYYRW1XDqySvWZWDFarm0NAC6t9TncD/IBNB/bSb7aeW
         yO1QWKnY9zZuRVt0I5ketNvf2kwK6hQr/FtPX4aTTCjPQpQH9Kg5pG4twJezVXWA7gG5
         q61G4nTK1e1JfKvUs62OWO2wUvu5uFU95sw9VJOgMZ84UQFi9tifXdq1QzQQb9/Q4Bar
         SMjL1y00LJghai39w0XQPvPAqn9xpZkft1LV9D9T1plKJclDr7pQLMRdfPsbiVEMAusr
         HQiAgzqgWCYnbolCw3ACEgXYwB2G6s0voPqAnEYoukixEBca0YeYYXWai/YvJXDmoRdf
         XvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=U16gZthY7GiG18hos+s39UYV/dexC5axxz2McFtoNlo=;
        b=Ji/NdMPl3MSqFo8d55kfUYomRUGzZYuWoJGWHzbbRdbip8s+7zP4ebQ4RXq2WIm3HF
         fSfD8ZyzdlQLg9Ghr31YMpaglMN5OXANTgcmAd6Ic9gIaStcaYHOFf+T66e3x7R2k644
         P/ZWHqGJ2y9Re7HVBM426G4Am4Ogi1ca+qYVFOsjDKKns9iyJIJMh7sX5RqFmHft8ubO
         ZYSWrL76IkIBU/LeiEXTxuSKwkuw22lhkCy0WMTq0QWjp2pa97rIN78f+GpWUsdvatoN
         ybXnjx0EcDgczXo1cbaSGox1NnrXwdJQc1ZOhLUqnKQTfyucSj5xfLn4IaxNHyOphHq/
         yFfw==
X-Gm-Message-State: AOAM533D7U6J1KNS+kp6Yezz7oGtErh9+v/1JIz6ZTH5IZsWoUJZsqgM
        PQ4iYxNwBT3ZJaIa96HK9dkTPJfRqQLavgKM5V0=
X-Google-Smtp-Source: ABdhPJwbxDO8SrAUtzuxujURZ/yjaUl/YNSKyWSLiFwER3BiW6zhR2u6G2f7Brx3XJ1eZPqqUJbUpRgrV5plJ6K3FIk=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:aa7:8812:0:b029:154:e0ed:1fed with
 SMTP id c18-20020aa788120000b0290154e0ed1fedmr12987823pfo.33.1602260020696;
 Fri, 09 Oct 2020 09:13:40 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:09 -0700
Message-Id: <20201009161338.657380-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 00/29] Add support for Clang LTO
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

  https://github.com/samitolvanen/linux.git lto-v5

---
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

Sami Tolvanen (27):
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
  arm64: vdso: disable LTO
  KVM: arm64: disable LTO for the nVHE directory
  arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
  arm64: allow LTO_CLANG and THINLTO to be selected
  x86/asm: annotate indirect jumps
  x86, vdso: disable LTO only for vDSO
  x86, cpu: disable LTO for cpu.c
  x86, build: allow LTO_CLANG and THINLTO to be selected

 .gitignore                                    |   1 +
 Makefile                                      |  68 +++--
 arch/Kconfig                                  |  74 +++++
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
 tools/objtool/check.c                         |  84 +++++-
 tools/objtool/include/objtool/builtin.h       |   2 +-
 tools/objtool/include/objtool/check.h         |   1 +
 tools/objtool/include/objtool/objtool.h       |   1 +
 tools/objtool/objtool.c                       |   1 +
 56 files changed, 903 insertions(+), 131 deletions(-)
 rename arch/arm/{kernel/module.lds => include/asm/module.lds.h} (72%)
 rename arch/arm64/{kernel/module.lds => include/asm/module.lds.h} (76%)
 rename arch/ia64/{module.lds => include/asm/module.lds.h} (100%)
 rename arch/m68k/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/powerpc/{kernel/module.lds => include/asm/module.lds.h} (100%)
 rename arch/riscv/{kernel/module.lds => include/asm/module.lds.h} (84%)
 create mode 100644 include/asm-generic/module.lds.h
 create mode 100755 scripts/generate_initcall_order.pl
 rename scripts/{module-common.lds => module.lds.S} (59%)


base-commit: 80396d76da65fc8b82581c0260c25a6aa0a495a3
-- 
2.28.0.1011.ga647a8990f-goog

