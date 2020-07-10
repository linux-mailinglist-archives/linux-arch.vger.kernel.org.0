Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27CA21AC9E
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgGJB5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgGJB5J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:09 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF70C08C5CE;
        Thu,  9 Jul 2020 18:57:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z3so1810722pfn.12;
        Thu, 09 Jul 2020 18:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaZs4PvDZSCQHhg/idOxs9IRE6Ng3ZKb9zz1kieaNAk=;
        b=fMl48jJgG+BPVTWiIow0uenwROVafLRv/Pw6QEkzr+wXpEFWYCCtxcrQ49EcCzDH0d
         At9EdV+FbGfxN1VOcr79ARfZ/roxDFUMJkCpVxmEMokKKDA2KvlLcLlW/ffWvHymX3F2
         S8ZbdTobn5MmrfRiDgkpyfP+HhTC5RlzmE3D4GRIJ+voEiQRevtPCPMHgVrisdkD8eP2
         1jxxnQ21nD4j3VRBOitlqof8nHGFQaev2g82+kKkgb6CdXLxQQsI66/hvBCk9EbpX1og
         z2sy9mDLu0jTdygNIuOzks0ygls5Fp5EVO/7Mc5nrCQdLg9R4c0EYXLztb2rfja9cZPG
         Nkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QaZs4PvDZSCQHhg/idOxs9IRE6Ng3ZKb9zz1kieaNAk=;
        b=WheZu/i6eTUVkmh7qSJjvhcX1yY34SV861EO5EeT03GObJveZiOv4/5LhgrF91pTJe
         Cz9fMUTMLlcDX3vIyzooADx2qa2HWA9xrRuWj5+6JD8VumrVb2BnI86RDkVCj5fBxoDf
         XJcXN+BFQfjCT+sVVgkfyYs9+fujO9gFCJRXVioOzq+LTqxZ2qu3VHTAAO0Rf0CMOdZn
         CoBR5N1ZsbMaskHNw/xHHV0ysVP2dEx3a6R/VLvP9EdUUpxiZ6NeWiAdPEVhJjTQkXU6
         yCqUqL+puNAQmWRebq1u34FiE7IPEM3nbD+WNLVty3pHaZQ0ELiQiYxktw640uglANdl
         c+eQ==
X-Gm-Message-State: AOAM531KF1dJ0GwW7VDcYzpf1I3xjYXHpSc5jpIWdJeUSuIc+XZUAIN8
        UjRBO2+n1V/z6zW8B2iZbwYfudd5
X-Google-Smtp-Source: ABdhPJy2ypc+nOy85os0fHi/ZXUU5Gjee6en+B7W1uV4HyKRPCGEGLSUXEPhaRxLWRbIu5BDykA4OA==
X-Received: by 2002:a62:7b0d:: with SMTP id w13mr52660663pfc.160.1594346226667;
        Thu, 09 Jul 2020 18:57:06 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:06 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 0/7] mmu context cleanup, lazy tlb cleanup,
Date:   Fri, 10 Jul 2020 11:56:39 +1000
Message-Id: <20200710015646.2020871-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This blew up a bit bigger than I thought, so I'd like to get some
comments as to whether people agree with the direction it's going.

The patches aren't cleanly split out by arch, but as it is now it's
probably easier to get a quick overview of the changes at a glance
anyway.

So there's a few different things here.

1. Clean up and use asm-generic for no-op mmu context functions (so
   not just for nommu architectures). This should be functionally a
   no-op for everybody. This allows exit_lazy_tlb to easily be added.

2. Add exit_lazy_tlb and use it for x86, so this is x86 and membarrier
   specific changes. I _may_ have spotted a small membarrier / core sync
   bug here when adding exit_lazy_tlb.

3. Tidy up lazy tlb a little bit, have its own refcount function and
   allow it to be selected out. We can audit the nommu archs and
   deselect it for those.

4. Add a non-refcounting lazy mmu mode, to help scalability when the
   same mm is used for a lot of lazy mmu switching.

Comments, questions on anything would be much appreciated.

Thanks,
Nick

Nicholas Piggin (7):
  asm-generic: add generic MMU versions of mmu context functions
  arch: use asm-generic mmu context for no-op implementations
  mm: introduce exit_lazy_tlb
  x86: use exit_lazy_tlb rather than
    membarrier_mm_sync_core_before_usermode
  lazy tlb: introduce lazy mm refcount helper functions
  lazy tlb: allow lazy tlb mm switching to be configurable
  lazy tlb: shoot lazies, a non-refcounting lazy tlb option

 .../membarrier-sync-core/arch-support.txt     |  6 +-
 arch/Kconfig                                  | 23 +++++
 arch/alpha/include/asm/mmu_context.h          | 12 +--
 arch/arc/include/asm/mmu_context.h            | 16 ++--
 arch/arm/include/asm/mmu_context.h            | 26 +-----
 arch/arm64/include/asm/mmu_context.h          |  7 +-
 arch/csky/include/asm/mmu_context.h           |  8 +-
 arch/hexagon/include/asm/mmu_context.h        | 33 ++------
 arch/ia64/include/asm/mmu_context.h           | 17 +---
 arch/m68k/include/asm/mmu_context.h           | 47 ++---------
 arch/microblaze/include/asm/mmu_context.h     |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h  |  8 +-
 arch/microblaze/include/asm/processor.h       |  3 -
 arch/mips/include/asm/mmu_context.h           | 11 +--
 arch/nds32/include/asm/mmu_context.h          | 10 +--
 arch/nios2/include/asm/mmu_context.h          | 21 +----
 arch/nios2/mm/mmu_context.c                   |  1 +
 arch/openrisc/include/asm/mmu_context.h       |  8 +-
 arch/openrisc/mm/tlb.c                        |  2 +
 arch/parisc/include/asm/mmu_context.h         | 12 +--
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/include/asm/mmu_context.h        | 22 ++---
 arch/powerpc/kernel/smp.c                     |  2 +-
 arch/powerpc/mm/book3s64/radix_tlb.c          |  4 +-
 arch/riscv/include/asm/mmu_context.h          | 22 +----
 arch/s390/include/asm/mmu_context.h           |  9 +-
 arch/sh/include/asm/mmu_context.h             |  7 +-
 arch/sh/include/asm/mmu_context_32.h          |  9 --
 arch/sparc/include/asm/mmu_context_32.h       | 10 +--
 arch/sparc/include/asm/mmu_context_64.h       | 10 +--
 arch/um/include/asm/mmu_context.h             | 12 ++-
 arch/unicore32/include/asm/mmu_context.h      | 24 +-----
 arch/x86/include/asm/mmu_context.h            | 41 +++++++++
 arch/x86/include/asm/sync_core.h              | 28 -------
 arch/xtensa/include/asm/mmu_context.h         | 11 +--
 arch/xtensa/include/asm/nommu_context.h       | 26 +-----
 fs/exec.c                                     |  5 +-
 include/asm-generic/mmu_context.h             | 77 +++++++++++++----
 include/asm-generic/nommu_context.h           | 19 +++++
 include/linux/sched/mm.h                      | 35 ++++----
 include/linux/sync_core.h                     | 21 -----
 kernel/cpu.c                                  |  6 +-
 kernel/exit.c                                 |  2 +-
 kernel/fork.c                                 | 39 +++++++++
 kernel/kthread.c                              | 12 ++-
 kernel/sched/core.c                           | 84 ++++++++++++-------
 kernel/sched/sched.h                          |  4 +-
 47 files changed, 388 insertions(+), 427 deletions(-)
 delete mode 100644 arch/x86/include/asm/sync_core.h
 create mode 100644 include/asm-generic/nommu_context.h
 delete mode 100644 include/linux/sync_core.h

-- 
2.23.0

