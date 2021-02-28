Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D024432702E
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 04:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhB1Dns (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Feb 2021 22:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhB1Dnq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Feb 2021 22:43:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 833BB64E38;
        Sun, 28 Feb 2021 03:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614483784;
        bh=iSYg3PQmQzHSmYCsrbphy/ikk+I0jqnR2OgkaYvOyfE=;
        h=From:To:Cc:Subject:Date:From;
        b=V/sAaOkZGP6CBQSb9z9KVyt3Pa1ismuXdj7pOH4ZIcUnooVQScqbMcwCmynAi6J1j
         jcssNeJkKWOe0e7+AQH3Gelpfn3GVsZETp0uKfQTuHJuNob6mLc7tqas6Pk7IoM4kK
         9bnVEZr3+4/rI3vdR6xu6A7v6NR7NMPMieQb3eCdBIHXX0LTbeUxjfXohTLfvr8034
         u2Eh663Nsqb640guioaCqMT9qcVv38oZoj1Z/XAMuL7Mdg8dN4PBU+m0V+3RW6afio
         lhGCN/1dajrRBqc9INUs/V+CYmNge5pwJNuzRXCEN9Xjf4/1pcjhsogq/RrC1bSuBb
         f3TsTA0iYthVQ==
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Subject: [GIT PULL] csky changes for v5.12-rc1
Date:   Sun, 28 Feb 2021 11:43:00 +0800
Message-Id: <20210228034300.1090149-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://github.com/c-sky/csky-linux.git tags/csky-for-linus-5.12-rc1

for you to fetch changes up to 6607aa6f6b68fc9b5955755f1b1be125cf2a9d03:

  csky: Fixup compile error (2021-02-27 22:04:14 +0800)

----------------------------------------------------------------
arch/csky patches for 5.12-rc1

Features:
 - Add new memory layout 2.5G(user):1.5G(kernel)
 - Add kmemleak support
 - Reconstruct VDSO framework
   Add VDSO with GENERIC_GETTIMEOFDAY,
   GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO
 - Add faulthandler_disabled() check
 - Support(Fixup) swapon
 - Add(Fixup) _PAGE_ACCESSED for default pgprot
 - abort uaccess retries upon fatal signal (From arm)

Fixup & Optimization:
 - Fixup perf probe failed
 - Fixup show_regs doesn't contain regs->usp
 - Remove custom asm/atomic.h implementation
 - Fixup barrier design
 - Fixup futex SMP implementation
 - Fixup asm/cmpxchg.h with correct ordering barrier
 - Cleanup asm/spinlock.h
 - Fixup PTE global for 2.5:1.5 virtual memory
 - Remove prologue of page fault handler in entry.S
 - Fix TLB maintenance synchronization problem
 - Add show_tlb for CPU_CK860 debug
 - Fixup FAULT_FLAG_XXX param for handle_mm_fault
 - Fixup update_mmu_cache called with user io mapping
 - Fixup do_page_fault parent irq status
 - Fix a size determination in gpr_get()
 - pgtable.h: Coding convention
 - kprobe: Fixup code in simulate without 'long'
 - Fixup pfn_valid error with wrong max_mapnr
 - use free_initmem_default() in free_initmem()
 - Fixup compile error

----------------------------------------------------------------
David Hildenbrand (1):
      csky: use free_initmem_default() in free_initmem()

Guo Ren (27):
      csky: Add memory layout 2.5G(user):1.5G(kernel)
      csky: Fixup perf probe failed
      csky: Fixup show_regs doesn't contain regs->usp
      csky: Remove custom asm/atomic.h implementation
      csky: Fixup barrier design
      csky: Fixup futex SMP implementation
      csky: Fixup asm/cmpxchg.h with correct ordering barrier
      csky: Cleanup asm/spinlock.h
      csky: Fixup PTE global for 2.5:1.5 virtual memory
      csky: Remove prologue of page fault handler in entry.S
      csky: Add kmemleak support
      csky: Fix TLB maintenance synchronization problem
      csky: Add show_tlb for CPU_CK860 debug
      csky: Fixup FAULT_FLAG_XXX param for handle_mm_fault
      csky: Fixup update_mmu_cache called with user io mapping
      csky: Add faulthandler_disabled() check
      csky: Fixup do_page_fault parent irq status
      csky: Sync riscv mm/fault.c for easy maintenance
      csky: mm: abort uaccess retries upon fatal signal
      csky: Reconstruct VDSO framework
      csky: Fixup _PAGE_ACCESSED for default pgprot
      csky: pgtable.h: Coding convention
      csky: Fixup swapon
      csky: kprobe: Fixup code in simulate without 'long'
      csky: Add VDSO with GENERIC_GETTIMEOFDAY, GENERIC_TIME_VSYSCALL, HAVE_GENERIC_VDSO
      csky: Fixup pfn_valid error with wrong max_mapnr
      csky: Fixup compile error

Tian Tao (1):
      csky: remove unused including <linux/version.h>

Zhenzhong Duan (1):
      csky: Fix a size determination in gpr_get()

 arch/csky/Kconfig                         |  24 +-
 arch/csky/abiv1/inc/abi/cacheflush.h      |   1 -
 arch/csky/abiv1/inc/abi/ckmmu.h           |  10 +-
 arch/csky/abiv1/inc/abi/entry.h           |   1 -
 arch/csky/abiv1/inc/abi/page.h            |   1 -
 arch/csky/abiv1/inc/abi/pgtable-bits.h    |  40 +--
 arch/csky/abiv1/inc/abi/reg_ops.h         |   1 -
 arch/csky/abiv1/inc/abi/regdef.h          |   6 +-
 arch/csky/abiv1/inc/abi/string.h          |   1 -
 arch/csky/abiv1/inc/abi/switch_context.h  |   1 -
 arch/csky/abiv1/inc/abi/vdso.h            |  18 +-
 arch/csky/abiv2/cacheflush.c              |   3 +
 arch/csky/abiv2/inc/abi/ckmmu.h           |  44 +++-
 arch/csky/abiv2/inc/abi/entry.h           |  20 +-
 arch/csky/abiv2/inc/abi/fpu.h             |   1 -
 arch/csky/abiv2/inc/abi/page.h            |   1 -
 arch/csky/abiv2/inc/abi/pgtable-bits.h    |  37 ++-
 arch/csky/abiv2/inc/abi/reg_ops.h         |   1 -
 arch/csky/abiv2/inc/abi/regdef.h          |   6 +-
 arch/csky/abiv2/inc/abi/switch_context.h  |   1 -
 arch/csky/abiv2/inc/abi/vdso.h            |  20 +-
 arch/csky/abiv2/sysdep.h                  |   1 -
 arch/csky/include/asm/addrspace.h         |   1 -
 arch/csky/include/asm/atomic.h            | 212 ----------------
 arch/csky/include/asm/barrier.h           |  83 +++++--
 arch/csky/include/asm/bitops.h            |   1 -
 arch/csky/include/asm/bug.h               |   3 +-
 arch/csky/include/asm/cacheflush.h        |   1 -
 arch/csky/include/asm/checksum.h          |   1 -
 arch/csky/include/asm/clocksource.h       |   8 +
 arch/csky/include/asm/cmpxchg.h           |  27 ++-
 arch/csky/include/asm/elf.h               |   1 -
 arch/csky/include/asm/fixmap.h            |   1 -
 arch/csky/include/asm/ftrace.h            |   1 -
 arch/csky/include/asm/futex.h             | 121 ++++++++++
 arch/csky/include/asm/highmem.h           |   1 -
 arch/csky/include/asm/io.h                |   1 -
 arch/csky/include/asm/memory.h            |   2 +-
 arch/csky/include/asm/mmu.h               |   1 -
 arch/csky/include/asm/mmu_context.h       |  10 +-
 arch/csky/include/asm/page.h              |   2 +-
 arch/csky/include/asm/perf_event.h        |   1 -
 arch/csky/include/asm/pgalloc.h           |   3 +-
 arch/csky/include/asm/pgtable.h           |  80 +++---
 arch/csky/include/asm/processor.h         |   3 +-
 arch/csky/include/asm/ptrace.h            |   1 -
 arch/csky/include/asm/segment.h           |   3 +-
 arch/csky/include/asm/shmparam.h          |   1 -
 arch/csky/include/asm/spinlock.h          | 167 -------------
 arch/csky/include/asm/spinlock_types.h    |  10 -
 arch/csky/include/asm/string.h            |   1 -
 arch/csky/include/asm/switch_to.h         |   1 -
 arch/csky/include/asm/syscalls.h          |   1 -
 arch/csky/include/asm/thread_info.h       |   2 -
 arch/csky/include/asm/tlb.h               |   1 -
 arch/csky/include/asm/tlbflush.h          |   1 -
 arch/csky/include/asm/traps.h             |   1 -
 arch/csky/include/asm/uaccess.h           |   1 -
 arch/csky/include/asm/unistd.h            |   1 -
 arch/csky/include/asm/vdso.h              |  21 +-
 arch/csky/include/asm/vdso/clocksource.h  |   9 +
 arch/csky/include/asm/vdso/gettimeofday.h | 114 +++++++++
 arch/csky/include/asm/vdso/processor.h    |  12 +
 arch/csky/include/asm/vdso/vsyscall.h     |  22 ++
 arch/csky/include/uapi/asm/byteorder.h    |   1 -
 arch/csky/include/uapi/asm/perf_regs.h    |   1 -
 arch/csky/include/uapi/asm/ptrace.h       |   1 -
 arch/csky/include/uapi/asm/sigcontext.h   |   1 -
 arch/csky/include/uapi/asm/unistd.h       |   1 -
 arch/csky/kernel/Makefile                 |   2 +-
 arch/csky/kernel/atomic.S                 |  24 +-
 arch/csky/kernel/entry.S                  | 106 +-------
 arch/csky/kernel/head.S                   |  10 +-
 arch/csky/kernel/perf_event.c             |   4 +-
 arch/csky/kernel/probes/simulate-insn.c   |  22 +-
 arch/csky/kernel/ptrace.c                 | 128 +++++++++-
 arch/csky/kernel/setup.c                  |  18 +-
 arch/csky/kernel/signal.c                 |   4 +-
 arch/csky/kernel/smp.c                    |   7 +-
 arch/csky/kernel/traps.c                  |  10 +-
 arch/csky/kernel/vdso.c                   | 127 ++++++----
 arch/csky/kernel/vdso/.gitignore          |   4 +
 arch/csky/kernel/vdso/Makefile            |  72 ++++++
 arch/csky/kernel/vdso/note.S              |  12 +
 arch/csky/kernel/vdso/rt_sigreturn.S      |  14 ++
 arch/csky/kernel/vdso/so2s.sh             |   5 +
 arch/csky/kernel/vdso/vdso.S              |  16 ++
 arch/csky/kernel/vdso/vdso.lds.S          |  58 +++++
 arch/csky/kernel/vdso/vgettimeofday.c     |  28 +++
 arch/csky/kernel/vmlinux.lds.S            |   2 +-
 arch/csky/mm/fault.c                      | 388 ++++++++++++++++++------------
 arch/csky/mm/init.c                       |  56 +++--
 arch/csky/mm/tlb.c                        |  42 +++-
 include/linux/cpuhotplug.h                |   1 +
 94 files changed, 1347 insertions(+), 992 deletions(-)
 delete mode 100644 arch/csky/include/asm/atomic.h
 create mode 100644 arch/csky/include/asm/clocksource.h
 create mode 100644 arch/csky/include/asm/futex.h
 create mode 100644 arch/csky/include/asm/vdso/clocksource.h
 create mode 100644 arch/csky/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/csky/include/asm/vdso/processor.h
 create mode 100644 arch/csky/include/asm/vdso/vsyscall.h
 create mode 100644 arch/csky/kernel/vdso/.gitignore
 create mode 100644 arch/csky/kernel/vdso/Makefile
 create mode 100644 arch/csky/kernel/vdso/note.S
 create mode 100644 arch/csky/kernel/vdso/rt_sigreturn.S
 create mode 100755 arch/csky/kernel/vdso/so2s.sh
 create mode 100644 arch/csky/kernel/vdso/vdso.S
 create mode 100644 arch/csky/kernel/vdso/vdso.lds.S
 create mode 100644 arch/csky/kernel/vdso/vgettimeofday.c
