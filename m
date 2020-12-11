Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BC2D7E72
	for <lists+linux-arch@lfdr.de>; Fri, 11 Dec 2020 19:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbgLKSri (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Dec 2020 13:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389228AbgLKSrQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2020 13:47:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8DC0613D3
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z125so4896044ybb.15
        for <linux-arch@vger.kernel.org>; Fri, 11 Dec 2020 10:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9znxVvQ/9PAVTHgEOV292+fDBKHMlDcfsU9d9H/6O4k=;
        b=dDPDz2owZCXqbcbTzyDFDHaLvLysHx0+EojIIsUxOE+4+nVDQN3cySzJWf+v38GzE6
         itt4delaGLVPa1agOcoLlx6yvf8/Rvpbx90SpVAfQWw4Gienn1eBmn3U01FJOI8ozMIr
         oMwqy/QUN545CHIweR5daxLHf67HQMOOpqjFZBTDMYiIgeSPbYC+HR2Mp72lyQexsgH2
         le8MqKN1R49giFoPdbvq5e2AAwJFmKDPhtJK56jSZ1yU84DMqlwnkKWfajf4PJtMFRlg
         MB4gCztbRGqrOceiEJjc4NYhFy6Vpnx8PltpWjcUUixEZtuM8A1KmPcSyof8U8uYsIsl
         LJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9znxVvQ/9PAVTHgEOV292+fDBKHMlDcfsU9d9H/6O4k=;
        b=Zm0j3DD1P202h1lBm88WS1i5SAHcHVp6qhcdSUlo6euFyXKUH2UpnPWKjZQbgOcbJN
         1fQ/ChTlhAR7SJeAlzi6SEy3RywvtB3nG9Ise0jAOGrXE3q4PAPdg4RKqOID2KoPEEbk
         ruFQcl0aKnBSVexocOq/oLLmFK4KrruxjpINZzQUToGp/n77AIB3Z//5I1wx2K8cuM8j
         wXA2EZczcrtHWvgtab7cgfMKqeuQ9ndwDzeVOuDzB/NjvrbQHOLN/wZGU/p5dPleKDzr
         o/7k+TcPBLMMS6QCjPsRdXZe9EUUA1DLpnSZ9J8FnPmNMNdk2IJDCIUBYo57TSKSqLHe
         8Izg==
X-Gm-Message-State: AOAM530ieFYpAWBRgRfB6X25EGBFLyiy77/cFkEyOKHKpCwiNM1tzc0U
        3tgwA05zlx0scLGwneSUKk5kn/aOxsm/d9Iv3UY=
X-Google-Smtp-Source: ABdhPJz0ek2SN2U3fjfWQhqwMXyCIcZwDvklDVCCSVaJyxuiJlfb7KJJKz1h/PtZ4xu/S0R9tK22wDIg3yDTEgQwy4E=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:22d5:: with SMTP id
 i204mr22729999ybi.0.1607712395089; Fri, 11 Dec 2020 10:46:35 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:46:17 -0800
Message-Id: <20201211184633.3213045-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v9 00/16] Add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch series adds support for building the kernel with Clang's
Link Time Optimization (LTO). In addition to performance, the primary
motivation for LTO is to allow Clang's Control-Flow Integrity (CFI)
to be used in the kernel. Google has shipped millions of Pixel
devices running three major kernel versions with LTO+CFI since 2018.

Most of the patches are build system changes for handling LLVM
bitcode, which Clang produces with LTO instead of ELF object files,
postponing ELF processing until a later stage, and ensuring initcall
ordering.

Note that arm64 support depends on Will's memory ordering patches
[1]. I will post x86_64 patches separately after we have fixed the
remaining objtool warnings [2][3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
[2] https://lore.kernel.org/lkml/20201120040424.a3wctajzft4ufoiw@treble/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/log/?h=objtool-vmlinux

You can also pull this series from

  https://github.com/samitolvanen/linux.git lto-v9

---
Changes in v9:

  - Added HAS_LTO_CLANG dependencies to LLVM=1 and LLVM_IAS=1 to avoid
    issues with mismatched toolchains.

  - Dropped the .mod patch as Masahiro landed a better solution to
    the split line issue in commit 7d32358be8ac ("kbuild: avoid split
    lines in .mod files").

  - Updated CC_FLAGS_LTO to use -fvisibility=hidden to avoid weak symbol
    visibility issues with ThinLTO on x86.

  - Changed LTO_CLANG_FULL to depend on !COMPILE_TEST to prevent
    timeouts in automated testing.

  - Added a dependency to CPU_LITTLE_ENDIAN to ARCH_SUPPORTS_LTO_CLANG
    in arch/arm64/Kconfig.

  - Added a default symbol list to fix an issue with TRIM_UNUSED_KSYMS.

  Changes in v8:

  - Cleaned up the LTO Kconfig options based on suggestions from
    Nick and Kees.

  - Dropped the patch to disable LTO for the arm64 nVHE KVM code as
    David pointed out it's not needed anymore.

Changes in v7:

  - Rebased to master again.

  - Added back arm64 patches as the prerequisites are now staged,
    and dropped x86_64 support until the remaining objtool issues
    are resolved.

  - Dropped ifdefs from module.lds.S.

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


Sami Tolvanen (16):
  tracing: move function tracer options to Kconfig
  kbuild: add support for Clang LTO
  kbuild: lto: fix module versioning
  kbuild: lto: limit inlining
  kbuild: lto: merge module sections
  kbuild: lto: add a default list of used symbols
  init: lto: ensure initcall ordering
  init: lto: fix PREL32 relocations
  PCI: Fix PREL32 relocations for LTO
  modpost: lto: strip .lto from module names
  scripts/mod: disable LTO for empty.c
  efi/libstub: disable LTO
  drivers/misc/lkdtm: disable LTO for rodata.o
  arm64: vdso: disable LTO
  arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
  arm64: allow LTO to be selected

 .gitignore                            |   1 +
 Makefile                              |  45 +++--
 arch/Kconfig                          |  90 +++++++++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/kernel/vdso/Makefile       |   3 +-
 drivers/firmware/efi/libstub/Makefile |   2 +
 drivers/misc/lkdtm/Makefile           |   1 +
 include/asm-generic/vmlinux.lds.h     |  11 +-
 include/linux/init.h                  |  79 +++++++-
 include/linux/pci.h                   |  19 +-
 init/Kconfig                          |   1 +
 kernel/trace/Kconfig                  |  16 ++
 scripts/Makefile.build                |  48 ++++-
 scripts/Makefile.lib                  |   6 +-
 scripts/Makefile.modfinal             |   9 +-
 scripts/Makefile.modpost              |  25 ++-
 scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
 scripts/link-vmlinux.sh               |  70 ++++++-
 scripts/lto-used-symbollist           |   5 +
 scripts/mod/Makefile                  |   1 +
 scripts/mod/modpost.c                 |  16 +-
 scripts/mod/modpost.h                 |   9 +
 scripts/mod/sumversion.c              |   6 +-
 scripts/module.lds.S                  |  24 +++
 24 files changed, 696 insertions(+), 65 deletions(-)
 create mode 100755 scripts/generate_initcall_order.pl
 create mode 100644 scripts/lto-used-symbollist


base-commit: 33dc9614dc208291d0c4bcdeb5d30d481dcd2c4c
-- 
2.29.2.576.ga3fc446d84-goog

