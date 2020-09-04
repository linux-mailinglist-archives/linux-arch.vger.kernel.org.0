Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E6625D678
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgIDKhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 06:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730043AbgIDKad (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:30:33 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02596206D4;
        Fri,  4 Sep 2020 10:30:30 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 00/29] arm64: Memory Tagging Extension user-space support
Date:   Fri,  4 Sep 2020 11:30:00 +0100
Message-Id: <20200904103029.32083-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

That's version 9 of the MTE user-space support (version 8 here [1]). The
series is also available on this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/mte

The patches below are missing some acks. If there are any objections,
please let me know (acks would be appreciated). I plan to queue them
together with the rest of the MTE series.

mm:

  [PATCH v7 07/29] mm: Add PG_arch_2 page flag
  [PATCH v7 08/29] mm: Preserve the PG_arch_2 flag in __split_huge_page_tail()
  [PATCH v7 13/29] mm: Introduce arch_calc_vm_flag_bits()

fs:
  
  [PATCH v7 24/29] fs: Handle intra-page faults in copy_mount_options()

arm64 KVM (small new addition in v9):

  [PATCH v9 04/29] arm64: kvm: mte: Hide the MTE CPUID information from the guests

There have been no further ABI changes and aiming for a 5.10 merge.
Minor changes in this version:

- Added a separate patch for arm64 KVM which hides the CPUID information
  and injects an undef exception in the guest if it accesses any of the
  MTE system registers.

- Slight improvement to the CONFIG_ARM64_AS_HAS_MTE comment.

- Rebased onto v5.9-rc3.

[1] https://lkml.kernel.org/r/20200824182758.27267-1-catalin.marinas@arm.com

Thanks.

Catalin Marinas (17):
  arm64: mte: Use Normal Tagged attributes for the linear map
  arm64: kvm: mte: Hide the MTE CPUID information from the guests
  mm: Preserve the PG_arch_2 flag in __split_huge_page_tail()
  arm64: mte: Clear the tags when a page is mapped in user-space with
    PROT_MTE
  arm64: Avoid unnecessary clear_user_page() indirection
  arm64: mte: Tags-aware aware memcmp_pages() implementation
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the generated random tags via
    prctl()
  arm64: mte: Restore the GCR_EL1 register after a suspend
  arm64: mte: Allow {set,get}_tagged_addr_ctrl() on non-current tasks
  arm64: mte: ptrace: Add PTRACE_{PEEK,POKE}MTETAGS support
  arm64: mte: ptrace: Add NT_ARM_TAGGED_ADDR_CTRL regset
  fs: Handle intra-page faults in copy_mount_options()

Kevin Brodsky (1):
  mm: Introduce arch_calc_vm_flag_bits()

Steven Price (4):
  mm: Add PG_arch_2 page flag
  mm: Add arch hooks for saving/restoring tags
  arm64: mte: Enable swap of tagged pages
  arm64: mte: Save tags when hibernating

Vincenzo Frascino (7):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Tags-aware copy_{user_,}highpage() implementations
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 305 ++++++++++++++++
 arch/arm64/Kconfig                            |  33 ++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/hwcap.h                |   2 +-
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  56 ++-
 arch/arm64/include/asm/mte.h                  |  86 +++++
 arch/arm64/include/asm/page.h                 |  19 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |  46 ++-
 arch/arm64/include/asm/processor.h            |  12 +-
 arch/arm64/include/asm/sysreg.h               |  61 ++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   2 +-
 arch/arm64/include/uapi/asm/mman.h            |   1 +
 arch/arm64/include/uapi/asm/ptrace.h          |   4 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cpufeature.c                |  35 ++
 arch/arm64/kernel/cpuinfo.c                   |   2 +-
 arch/arm64/kernel/entry.S                     |  37 ++
 arch/arm64/kernel/hibernate.c                 | 118 ++++++
 arch/arm64/kernel/mte.c                       | 336 ++++++++++++++++++
 arch/arm64/kernel/process.c                   |  48 ++-
 arch/arm64/kernel/ptrace.c                    |  51 ++-
 arch/arm64/kernel/signal.c                    |   9 +
 arch/arm64/kernel/suspend.c                   |   4 +
 arch/arm64/kernel/syscall.c                   |  10 +
 arch/arm64/kvm/sys_regs.c                     |  16 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/mte.S                          | 151 ++++++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/copypage.c                      |  25 +-
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  20 +-
 arch/arm64/mm/mteswap.c                       |  83 +++++
 arch/arm64/mm/proc.S                          |  32 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/namespace.c                                |  25 +-
 fs/proc/page.c                                |   3 +
 fs/proc/task_mmu.c                            |   4 +
 include/linux/kernel-page-flags.h             |   1 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  23 +-
 include/linux/page-flags.h                    |   3 +
 include/linux/pgtable.h                       |  28 ++
 include/trace/events/mmflags.h                |   9 +-
 include/uapi/asm-generic/siginfo.h            |   4 +-
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |   9 +
 mm/huge_memory.c                              |   3 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   6 +
 mm/page_io.c                                  |  10 +
 mm/shmem.c                                    |   9 +
 mm/swapfile.c                                 |   2 +
 mm/util.c                                     |   2 +-
 tools/vm/page-types.c                         |   2 +
 63 files changed, 1764 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/mteswap.c

