Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8281D572D
	for <lists+linux-arch@lfdr.de>; Fri, 15 May 2020 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEORQY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 May 2020 13:16:24 -0400
Received: from foss.arm.com ([217.140.110.172]:59310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEORQY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93FA1042;
        Fri, 15 May 2020 10:16:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4954D3F305;
        Fri, 15 May 2020 10:16:21 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Subject: [PATCH v4 00/26] arm64: Memory Tagging Extension user-space support
Date:   Fri, 15 May 2020 18:15:46 +0100
Message-Id: <20200515171612.1020-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the fourth version (third version here [1]) of the series adding
user-space support for the ARMv8.5 Memory Tagging Extension ([2], [3]).
The patches are also available on this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/mte-v4

Changes in this version:

- Swap and suspend to disk support for saving/restoring tags.

- Deferred the tag zeroing from clear_page() to set_pte_at() to cope
  with RAM filesystems that do not start from a zeroed page. The
  copy_page() function was also optimised to only copy tags if the page
  has been previously mapped as tagged (PROT_MTE). This mechanism
  requires a new PG_arch_2 flag.

- memcmp_pages() rewritten to always return a no-match if at least one
  of the pages is tagged (tag comparison avoided).

- ptrace() updated to prevent accessing tags in a page that has not been
  mapped with PROT_MTE (PG_arch_2 flag not set).

- copy_mount_options() fix re-implemented to avoid
  arch_has_exact_copy_from_user().

- The CPUID handling has been reworked to ensure that, when the feature
  is not backed by the DT, the HWCAP is also hidden from user. Note that
  the DT description is still under internal discussion on whether we
  need it or not.

- A new early param, arm64.mte_disable, was introduced to facilitate
  testing with and without MTE on platforms that support it.

- Asynchronous TCF SIGSEGV is no longer forced, so it can be ignored but
  the user thread.

- CONFIG_ARM64_MTE is now default y since swap is supported.

To do or discuss:

- prctl() accepting an include vs exclude mask for the GCR_EL1.Excl
  field. There is an ongoing discussion on v3 which accepts an include
  mask with 0 being a special case equivalent to 1. If this is not
  desirable, we can change this to an exclude mask.

- mmap(tagged_addr, PROT_MTE) pre-tagging the memory with the tag given
  in the tagged_addr hint.

- ptrace() to expose the prctl() configuration for the user thread (or
  the TCF and GCR_EL1.Excl fields).

- coredump (user) to also dump the tags.

- Kselftest patches will be made available.

[1] https://lore.kernel.org/linux-arm-kernel/20200421142603.3894-1-catalin.marinas@arm.com/
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm_Memory_Tagging_Extension_Whitepaper.pdf

Catalin Marinas (14):
  arm64: mte: Use Normal Tagged attributes for the linear map
  arm64: mte: Clear the tags when a page is mapped in user-space with
    PROT_MTE
  arm64: mte: Tags-aware aware memcmp_pages() implementation
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the generated random tags via
    prctl()
  arm64: mte: Restore the GCR_EL1 register after a suspend
  arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS support
  fs: Handle intra-page faults in copy_mount_options()
  arm64: mte: Check the DT memory nodes for MTE support
  arm64: mte: Introduce early param to disable MTE support

Kevin Brodsky (1):
  mm: Introduce arch_calc_vm_flag_bits()

Steven Price (4):
  mm: Add PG_ARCH_2 page flag
  mm: Add arch hooks for saving/restoring tags
  arm64: mte: Enable swap of tagged pages
  arm64: mte: Save tags when hibernating

Vincenzo Frascino (7):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Tags-aware copy_page() implementation
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 .../admin-guide/kernel-parameters.txt         |   4 +
 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   5 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 297 ++++++++++++++++
 arch/arm64/Kconfig                            |  33 ++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |   1 +
 arch/arm64/include/asm/assembler.h            |  12 +
 arch/arm64/include/asm/cpucaps.h              |   4 +-
 arch/arm64/include/asm/cpufeature.h           |  12 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  78 +++++
 arch/arm64/include/asm/mte.h                  |  86 +++++
 arch/arm64/include/asm/page.h                 |   2 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |  45 ++-
 arch/arm64/include/asm/processor.h            |   4 +
 arch/arm64/include/asm/sysreg.h               |  62 ++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   2 +
 arch/arm64/include/uapi/asm/mman.h            |  14 +
 arch/arm64/include/uapi/asm/ptrace.h          |   4 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cpufeature.c                | 126 ++++++-
 arch/arm64/kernel/cpuinfo.c                   |   2 +
 arch/arm64/kernel/entry.S                     |  37 ++
 arch/arm64/kernel/hibernate.c                 | 118 +++++++
 arch/arm64/kernel/mte.c                       | 324 ++++++++++++++++++
 arch/arm64/kernel/process.c                   |  31 +-
 arch/arm64/kernel/ptrace.c                    |   9 +-
 arch/arm64/kernel/signal.c                    |   8 +
 arch/arm64/kernel/suspend.c                   |   4 +
 arch/arm64/kernel/syscall.c                   |  10 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/mte.S                          | 140 ++++++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/copypage.c                      |  14 +-
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/mteswap.c                       |  82 +++++
 arch/arm64/mm/proc.S                          |   8 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/namespace.c                                |  24 +-
 fs/proc/page.c                                |   3 +
 fs/proc/task_mmu.c                            |   4 +
 include/asm-generic/pgtable.h                 |  23 ++
 include/linux/kernel-page-flags.h             |   1 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  22 +-
 include/linux/page-flags.h                    |   3 +
 include/trace/events/mmflags.h                |   9 +-
 include/uapi/asm-generic/siginfo.h            |   4 +-
 include/uapi/linux/prctl.h                    |   9 +
 mm/Kconfig                                    |   3 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   6 +
 mm/page_io.c                                  |  10 +
 mm/shmem.c                                    |   9 +
 mm/swapfile.c                                 |   2 +
 mm/util.c                                     |   2 +-
 tools/vm/page-types.c                         |   2 +
 64 files changed, 1765 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/mteswap.c

