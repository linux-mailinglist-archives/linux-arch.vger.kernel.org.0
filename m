Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57243352391
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhDAXcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 19:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDAXcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 19:32:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F06EC061788
        for <linux-arch@vger.kernel.org>; Thu,  1 Apr 2021 16:32:19 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 10so7489573ybx.11
        for <linux-arch@vger.kernel.org>; Thu, 01 Apr 2021 16:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=InV0o2ZlUPC6Ozgp8oy9RGMYSJbRTmoBDGoK3rQjBsY=;
        b=XOFf2TU/bBNAnTMUgJT1Ha9ov7VCwK7nKIEkSptSphT1lbyGKU0V4AUyA2V/MYUHdt
         mkzURWGQgvRNHgtxk14kZhXPP86rFZaDguPaANlC4nD7W2BOL7M5oaNfN/3RjZThiBRU
         8jnfNKkLq8wKnSUDRsG25RI/qzCKFqzZGaau/0vhiuYUIrTzmt0cYGjy/X/r1/CVmcPe
         7uvk9kzs5dJgdOB6qGUwJEe+xOIEuE7PV7c/XwCw/pKALImUnREFML4AsuEANkS5T3d1
         YPKVhM1RiVWSOK0rBGOOwzBUWjWLGYHjQCP2cHsWej+0lRRgQZH5SoUiEXBTTImPmMz4
         EMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=InV0o2ZlUPC6Ozgp8oy9RGMYSJbRTmoBDGoK3rQjBsY=;
        b=G066zQyfZaPcZMxroVFJGEdLJOoeo6v97vRiJZrbEQicae3QbWyz5bzRvxCkM7a7ao
         C7dN96ksW4CiG9UJnbPxlOgbUcGEPRHye60hnc8C0l5FmoFif8FuNaXTCasOZCLmRqTS
         mOzafGTzFft6BWjjOrKl51ac1wcjA4TTB2L2VvzSkux/K/QTTq+RNMsK0+MZsi//ZQck
         sCEqYdeOa4cjp4hN+VP9AhH/549h+SY5KGoJhFhwh5uclCom/CXMCqzbP5jPaZBgYw6O
         4zUdyY+hxjG0oLvP8oDQFtMUP/QteVypOInavH/YFEsf/2A0Zxnx91DJVBLCeZIlztu6
         ZN3w==
X-Gm-Message-State: AOAM533dROa+tvXyk9slexdr7OlvkAMVsM6k+NlO8lHfAPTCHLBmYOLG
        kqhhWqHQI3imYJkgspCYRVBW2YDXPea+oNkjidM=
X-Google-Smtp-Source: ABdhPJw8U4+8a6xnoKEeF9jnElBn7ZABd4xVWQ50keTIqLwqC9rIV/rzVhLU65O3ettyCtJgo9KPlURBGa5LqGtbTsM=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a25:790d:: with SMTP id
 u13mr15103634ybc.427.1617319938477; Thu, 01 Apr 2021 16:32:18 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:31:58 -0700
Message-Id: <20210401233216.2540591-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 00/18] Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series adds support for Clang's Control-Flow Integrity (CFI)
checking. With CFI, the compiler injects a runtime check before each
indirect function call to ensure the target is a valid function with
the correct static type. This restricts possible call targets and
makes it more difficult for an attacker to exploit bugs that allow the
modification of stored function pointers. For more details, see:

  https://clang.llvm.org/docs/ControlFlowIntegrity.html

The first patch contains build system changes and error handling,
and implements support for cross-module indirect call checking. The
remaining patches address issues caused by the compiler
instrumentation. These include fixing known type mismatches, as well
as issues with address space confusion and cross-module function
address equality.

These patches add support only for arm64, but I'll post patches also
for x86_64 after we address the remaining issues there, including
objtool support.

You can also pull this series from

  https://github.com/samitolvanen/linux.git cfi-v5

---
Changes in v5:
 - Changed module.lds.S to only include <asm/page.h> when CFI is
   enabled to fix the MIPS build.
 - Added a patch that fixes dynamic ftrace with CFI on arm64.

Changes in v4:
 - Per Mark's suggestion, dropped __pa_function() and renamed
   __va_function() to function_nocfi().
 - Added a comment to function_nocfi() to explain what it does.
 - Updated the psci patch to use an intermediate variable for
   the physical address for clarity.

Changes in v3:
 - Added a patch to change list_sort() callers treewide to use
   const pointers instead of simply removing the internal casts.
 - Changed cleanup_symbol_name() to return bool.
 - Changed module.lds.S to drop the .eh_frame section only with
   CONFIG_CFI_CLANG.
 - Switched to synchronize_rcu() in update_shadow().

Changes in v2:
 - Fixed .text merging in module.lds.S.
 - Added WARN_ON_FUNCTION_MISMATCH() and changed kernel/thread.c
   and kernel/workqueue.c to use the macro instead.


Sami Tolvanen (18):
  add support for Clang CFI
  cfi: add __cficanonical
  mm: add generic function_nocfi macro
  module: ensure __cfi_check alignment
  workqueue: use WARN_ON_FUNCTION_MISMATCH
  kthread: use WARN_ON_FUNCTION_MISMATCH
  kallsyms: strip ThinLTO hashes from static functions
  bpf: disable CFI in dispatcher functions
  treewide: Change list_sort to use const pointers
  lkdtm: use function_nocfi
  psci: use function_nocfi for cpu_resume
  arm64: implement function_nocfi
  arm64: use function_nocfi with __pa_symbol
  arm64: add __nocfi to functions that jump to a physical address
  arm64: add __nocfi to __apply_alternatives
  arm64: ftrace: use function_nocfi for ftrace_call
  KVM: arm64: Disable CFI for nVHE
  arm64: allow CONFIG_CFI_CLANG to be selected

 Makefile                                      |  17 +
 arch/Kconfig                                  |  45 +++
 arch/arm64/Kconfig                            |   1 +
 arch/arm64/include/asm/memory.h               |  15 +
 arch/arm64/include/asm/mmu_context.h          |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c     |   3 +-
 arch/arm64/kernel/alternative.c               |   4 +-
 arch/arm64/kernel/cpu-reset.h                 |  10 +-
 arch/arm64/kernel/cpufeature.c                |   4 +-
 arch/arm64/kernel/ftrace.c                    |   2 +-
 arch/arm64/kernel/psci.c                      |   3 +-
 arch/arm64/kernel/smp_spin_table.c            |   3 +-
 arch/arm64/kvm/hyp/nvhe/Makefile              |   6 +-
 arch/arm64/kvm/vgic/vgic-its.c                |   8 +-
 arch/arm64/kvm/vgic/vgic.c                    |   3 +-
 block/blk-mq-sched.c                          |   3 +-
 block/blk-mq.c                                |   3 +-
 drivers/acpi/nfit/core.c                      |   3 +-
 drivers/acpi/numa/hmat.c                      |   3 +-
 drivers/clk/keystone/sci-clk.c                |   4 +-
 drivers/firmware/psci/psci.c                  |   7 +-
 drivers/gpu/drm/drm_modes.c                   |   3 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c   |   3 +-
 drivers/gpu/drm/i915/gvt/debugfs.c            |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   3 +-
 drivers/gpu/drm/radeon/radeon_cs.c            |   4 +-
 .../hw/usnic/usnic_uiom_interval_tree.c       |   3 +-
 drivers/interconnect/qcom/bcm-voter.c         |   2 +-
 drivers/md/raid5.c                            |   3 +-
 drivers/misc/lkdtm/usercopy.c                 |   2 +-
 drivers/misc/sram.c                           |   4 +-
 drivers/nvme/host/core.c                      |   3 +-
 .../controller/cadence/pcie-cadence-host.c    |   3 +-
 drivers/spi/spi-loopback-test.c               |   3 +-
 fs/btrfs/raid56.c                             |   3 +-
 fs/btrfs/tree-log.c                           |   3 +-
 fs/btrfs/volumes.c                            |   3 +-
 fs/ext4/fsmap.c                               |   4 +-
 fs/gfs2/glock.c                               |   3 +-
 fs/gfs2/log.c                                 |   2 +-
 fs/gfs2/lops.c                                |   3 +-
 fs/iomap/buffered-io.c                        |   3 +-
 fs/ubifs/gc.c                                 |   7 +-
 fs/ubifs/replay.c                             |   4 +-
 fs/xfs/scrub/bitmap.c                         |   4 +-
 fs/xfs/xfs_bmap_item.c                        |   4 +-
 fs/xfs/xfs_buf.c                              |   6 +-
 fs/xfs/xfs_extent_busy.c                      |   4 +-
 fs/xfs/xfs_extent_busy.h                      |   3 +-
 fs/xfs/xfs_extfree_item.c                     |   4 +-
 fs/xfs/xfs_refcount_item.c                    |   4 +-
 fs/xfs/xfs_rmap_item.c                        |   4 +-
 include/asm-generic/bug.h                     |  16 +
 include/asm-generic/vmlinux.lds.h             |  20 +-
 include/linux/bpf.h                           |   4 +-
 include/linux/cfi.h                           |  41 +++
 include/linux/compiler-clang.h                |   3 +
 include/linux/compiler_types.h                |   8 +
 include/linux/init.h                          |   6 +-
 include/linux/list_sort.h                     |   7 +-
 include/linux/mm.h                            |  10 +
 include/linux/module.h                        |  13 +-
 include/linux/pci.h                           |   4 +-
 init/Kconfig                                  |   2 +-
 kernel/Makefile                               |   4 +
 kernel/cfi.c                                  | 329 ++++++++++++++++++
 kernel/kallsyms.c                             |  55 ++-
 kernel/kthread.c                              |   3 +-
 kernel/module.c                               |  43 +++
 kernel/workqueue.c                            |   2 +-
 lib/list_sort.c                               |  17 +-
 lib/test_list_sort.c                          |   3 +-
 net/tipc/name_table.c                         |   4 +-
 scripts/Makefile.modfinal                     |   2 +-
 scripts/module.lds.S                          |  19 +-
 75 files changed, 759 insertions(+), 113 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c


base-commit: 6905b1dc3c32a094f0da61bd656a740f0a97d592
-- 
2.31.0.208.g409f899ff0-goog

