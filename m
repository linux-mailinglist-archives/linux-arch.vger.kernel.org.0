Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2935D338295
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 01:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhCLAto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 19:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhCLAtV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930BFC061761
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:21 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q77so27809233ybq.0
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tdPCoglx2rEXEqBLmU0P2QxdgUDSrZlH5oMXt14Ies0=;
        b=SAiryR+/1F4QR2Sh8/WAofpQOiQwcTfPu82zao4pCXa65lDYdqykBnXnKwFzTFtMK/
         Q87M8HfYyHqw99Zdf118VxSCYvhYnQG+eORKppK6x+MBlf2oo3XoOt/Ohol2wSmQf/xp
         wVB0nZ00nVc3+TPKKfTZbsjBNWzzFRvtYZXbIz4ACG5q8p5WvFqy7E2CFmi9Ajz+E04A
         Uy8u/v8dN+bKkASP3R9AC07S2LEbbwjDZ5SaGCse/p2/gv+5lH2YYZ87b6g6SBBijhwA
         347Gs/LWWReVAPqK6YJPcO1tmv+IQfOs/BpEy7EpcOK3zCcOayp6J+gmy+3OI53yFvzD
         zZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tdPCoglx2rEXEqBLmU0P2QxdgUDSrZlH5oMXt14Ies0=;
        b=bJPX/3Eson26ikhUrH9FMbLnSGBHMl0rBTMNcbea+yKtHYlwqBJhuSVsEKM9sFVi6i
         75OMX95HML1g2n/WGDCbpR8kahaHXl0FuvmyG703uNRuYUbo0K5RM7+R6yCsAPzmIUX2
         7QIIgtQZQus6YtQ7bRqshU/B3lq6/nDkeL8mTOFWIWnACnwIrk9eDKTer3WIuYREn7Ui
         vgrak3z3B/QOxLSOjzo6a/yhSJPOYOmJ7BeerEKacMMb/V3noJGB6M1z7k9uZCxWApvc
         zCUh/aSGaTYkc8TPndbVfOF9cKoBF+H4pkuI33Lu7koN4eTrUA6fM7nV6/FmNc/9Qxfi
         WaYQ==
X-Gm-Message-State: AOAM53122RvntGVdExAwoLweRSpJlReE0dUPgaGx7+2do0PVaHudMDSY
        yD9AHWGqcrnawwArMYGkikcvre5EErM5U818mlU=
X-Google-Smtp-Source: ABdhPJzShn28s+halMR+vzT0zjcZemE7Ff5yb7+xlvVhoC/UuBoxjvMG/z2t2Y6cw7vtqzmvzKenzjBEbPWRbnPwaZo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:a25:e785:: with SMTP id
 e127mr15903182ybh.451.1615510160709; Thu, 11 Mar 2021 16:49:20 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:02 -0800
Message-Id: <20210312004919.669614-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 00/17] Add support for Clang CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

  https://github.com/samitolvanen/linux.git cfi-v1


Sami Tolvanen (17):
  add support for Clang CFI
  cfi: add __cficanonical
  mm: add generic __va_function and __pa_function macros
  module: cfi: ensure __cfi_check alignment
  workqueue: cfi: disable callback pointer check with modules
  kthread: cfi: disable callback pointer check with modules
  kallsyms: cfi: strip hashes from static functions
  bpf: disable CFI in dispatcher functions
  lib/list_sort: fix function type mismatches
  lkdtm: use __va_function
  psci: use __pa_function for cpu_resume
  arm64: implement __va_function
  arm64: use __pa_function
  arm64: add __nocfi to functions that jump to a physical address
  arm64: add __nocfi to __apply_alternatives
  KVM: arm64: Disable CFI for nVHE
  arm64: allow CONFIG_CFI_CLANG to be selected

 Makefile                                  |  17 ++
 arch/Kconfig                              |  45 +++
 arch/arm64/Kconfig                        |   1 +
 arch/arm64/include/asm/memory.h           |  15 +
 arch/arm64/include/asm/mmu_context.h      |   4 +-
 arch/arm64/kernel/acpi_parking_protocol.c |   2 +-
 arch/arm64/kernel/alternative.c           |   4 +-
 arch/arm64/kernel/cpu-reset.h             |  10 +-
 arch/arm64/kernel/cpufeature.c            |   4 +-
 arch/arm64/kernel/psci.c                  |   3 +-
 arch/arm64/kernel/smp_spin_table.c        |   2 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |   6 +-
 drivers/firmware/psci/psci.c              |   4 +-
 drivers/misc/lkdtm/usercopy.c             |   2 +-
 include/asm-generic/vmlinux.lds.h         |  20 +-
 include/linux/bpf.h                       |   4 +-
 include/linux/cfi.h                       |  41 +++
 include/linux/compiler-clang.h            |   3 +
 include/linux/compiler_types.h            |   8 +
 include/linux/init.h                      |   6 +-
 include/linux/mm.h                        |   8 +
 include/linux/module.h                    |  13 +-
 include/linux/pci.h                       |   4 +-
 init/Kconfig                              |   2 +-
 kernel/Makefile                           |   4 +
 kernel/cfi.c                              | 329 ++++++++++++++++++++++
 kernel/kallsyms.c                         |  54 +++-
 kernel/kthread.c                          |   8 +-
 kernel/module.c                           |  43 +++
 kernel/workqueue.c                        |   9 +-
 lib/list_sort.c                           |   8 +-
 scripts/Makefile.modfinal                 |   2 +-
 scripts/module.lds.S                      |  14 +-
 33 files changed, 655 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/cfi.h
 create mode 100644 kernel/cfi.c


base-commit: 28806e4d9b97865b450d72156e9ad229f2067f0b
-- 
2.31.0.rc2.261.g7f71774620-goog

