Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C5E2B873A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKRWHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbgKRWHe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:07:34 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A6C0613D6
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g129so4521434ybf.20
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RLGcqGrpsLlRbzosDVd0xMcJRplKck51D58hnCA0m40=;
        b=FEACl+hPLvLCehd5Y1IKJBTJMbR0QNknmx7JyEdblpLzyJtFGWeraZl9sfry0j3+TK
         kM1Ew0qwvXu8KiNhkl6/Lts6lfNP0QOtRmYpgESW0VKFUjrDc5GbVOF5mwwP/eHkKFsy
         FofVx9oGp4zsyD83lrr4uaPQAiM/oxp3HRLr27hBWDGyYPHGds3tdIhKnE0AUSYvkx+1
         TwEFXYs+aBQvHKOt2LEYwCaN+5eXT83BFAe3QJVAC6b+iFUY+dDobgfDt2BlWuLx2V4z
         3XbU9NTi2LeOeIv8rGJ6XXsrxQN/svzHG1smnTQhehYdm8prrKq5jKeMSosG+9Wvmj5x
         VHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RLGcqGrpsLlRbzosDVd0xMcJRplKck51D58hnCA0m40=;
        b=StqjXBxHxdZsEBdMOS7GlY4oyp6+t1KoTmTTGeqcnRNJqq1mLvmAc8nfelyKlHvYCX
         LwL58YuYJ9TZOfRFpTE2bZqjwQLInqGkfbDL262C5VcAoH48e3G5SlbAvMyvOAsd4kkj
         QfKOmWWN8aLg5bVA/0k/dlLWVjZNwSqba4qFHITtIYCsmmi1lCq5w4q7aWotAhXzE5ht
         N2jVyhoD+U+d58iUmWz6qLnXmnLuZGvCPn8EfON1gLNSKNV/Izr5jX4Fj4sFle8KvPZl
         aF2JuoYp4IOjVFmmms0s8wMIaKtGyLqFwjTql2bYgKTh5xJi4DScmrz+Zq9fROmpU7pg
         UKVg==
X-Gm-Message-State: AOAM5339uLKGeXnBc+MIyTwQ6BsKqPA4qR8zzJkfjbRT3jhNMoYG+bvb
        M26j3r1fsV0d4Qbj3xQZmLelCAV9DDbwTcsthkE=
X-Google-Smtp-Source: ABdhPJweJ21RzDAwp/tDBtJMRIUdyZdQmeb2yPsOyAN1xKpWf0eVIsvADvmRn84CHCirimlOu0esu246TN+ciGuGs0Q=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:cb11:: with SMTP id
 b17mr8848931ybg.236.1605737253032; Wed, 18 Nov 2020 14:07:33 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:14 -0800
Message-Id: <20201118220731.925424-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 00/17] Add support for Clang LTO
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
motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
be used in the kernel. Google has shipped millions of Pixel devices
running three major kernel versions with LTO+CFI since 2018.

Most of the patches are build system changes for handling LLVM bitcode,
which Clang produces with LTO instead of ELF object files, postponing
ELF processing until a later stage, and ensuring initcall ordering.

Note that v7 brings back arm64 support as Will has now staged the
prerequisite memory ordering patches [1], and drops x86_64 while we work
on fixing the remaining objtool warnings [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto
[2] https://lore.kernel.org/lkml/20201114004911.aip52eimk6c2uxd4@treble/

You can also pull this series from

  https://github.com/samitolvanen/linux.git lto-v7

---
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


Sami Tolvanen (17):
  tracing: move function tracer options to Kconfig
  kbuild: add support for Clang LTO
  kbuild: lto: fix module versioning
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

 .gitignore                            |   1 +
 Makefile                              |  45 +++--
 arch/Kconfig                          |  74 +++++++
 arch/arm64/Kconfig                    |   4 +
 arch/arm64/kernel/vdso/Makefile       |   3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile      |   4 +-
 drivers/firmware/efi/libstub/Makefile |   2 +
 drivers/misc/lkdtm/Makefile           |   1 +
 include/asm-generic/vmlinux.lds.h     |  11 +-
 include/linux/init.h                  |  79 +++++++-
 include/linux/pci.h                   |  19 +-
 kernel/trace/Kconfig                  |  16 ++
 scripts/Makefile.build                |  50 ++++-
 scripts/Makefile.lib                  |   6 +-
 scripts/Makefile.modfinal             |   9 +-
 scripts/Makefile.modpost              |  25 ++-
 scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
 scripts/link-vmlinux.sh               |  70 ++++++-
 scripts/mod/Makefile                  |   1 +
 scripts/mod/modpost.c                 |  16 +-
 scripts/mod/modpost.h                 |   9 +
 scripts/mod/sumversion.c              |   6 +-
 scripts/module.lds.S                  |  24 +++
 23 files changed, 677 insertions(+), 68 deletions(-)
 create mode 100755 scripts/generate_initcall_order.pl


base-commit: 0fa8ee0d9ab95c9350b8b84574824d9a384a9f7d
-- 
2.29.2.299.gdc1121823c-goog

