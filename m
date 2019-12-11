Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F299211BBE1
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 19:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfLKSki (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 13:40:38 -0500
Received: from foss.arm.com ([217.140.110.172]:42992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfLKSki (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Dec 2019 13:40:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32AFE31B;
        Wed, 11 Dec 2019 10:40:37 -0800 (PST)
Received: from arrakis.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BCCD63F6CF;
        Wed, 11 Dec 2019 10:40:35 -0800 (PST)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 00/22] arm64: Memory Tagging Extension user-space support
Date:   Wed, 11 Dec 2019 18:40:05 +0000
Message-Id: <20191211184027.20130-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series proposes the initial user-space support for the ARMv8.5
Memory Tagging Extension [1]. The patches are also available on this
branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/mte

Short description extracted from the MTE whitepaper [2]:

  MTE aims to increase the memory safety of code written in unsafe
  languages without requiring source changes, and in some cases, without
  requiring recompilation. The Arm Memory Tagging Extension implements
  lock and key access to memory. Locks can be set on memory and keys
  provided during memory access. If the key matches the lock, the access
  is permitted. If it does not match, an error is reported. Memory
  locations are tagged by adding four bits of metadata to each 16 bytes
  of physical memory. This is the Tag Granule. Tagging memory implements
  the lock. Pointers, and therefore virtual addresses, are modified to
  contain the key. In order to implement the key bits without requiring
  larger pointers MTE uses the Top Byte Ignore (TBI) feature of the
  ARMv8-A Architecture. When TBI is enabled, the top byte of a virtual
  address is ignored when using it as an input for address translation.
  This allows the top byte to store metadata.

The rough outline of this series, apart from some clean-up patches:

1. Enable detection of the MTE feature by the kernel.

2. Switch the linear map to use the Normal-Tagged memory attribute so
   that the kernel can read/write the tags in memory (a.k.a. allocation
   tags).

3. Handle tags in {clear,copy}_page() and memcmp_pages().

4. User tag fault exception handling and SIGSEGV injection.

5. PROT_MTE support to enable tag checks/accesses in user-space,
   together with new arch_calc_vm_flag_bits() and arch_validate_flags()
   hooks.

6. User control of tag check fault mode and tag exclusion via prctl(),
   built on top of the PR_{SET,GET}_TAGGED_ADDR_CTRL.

7. Documentation of the user ABI with a C example (though such MTE
   enabling and allocation tagging is expected to live in a C library).

For libc people interested in MTE, I suggest reading the last patch with
the ABI documentation.

Missing bits before upstreaming:

- Swap support. Currently ARM64_MTE (default n) selects ARCH_NO_SWAP.
  The SPARC ADI hooks for the similar feature are not sufficient for
  correct (no races) saving and restoring of the MTE metadata in swapped
  pages. A separate patch series will be posted once implemented.

- Related to the above is suspend to disk.

- ptrace() support to be able to access the tags in memory of a
  different process, something like {PEEK,POKE}_TAG.

- coredump (user) currently does not contain the tags.

- kselftests (work in progress)

- Clarify whether mmap(tagged_addr, PROT_MTE) pre-tags the memory with
  the tag given in the tagged_addr hint. Strong justification is
  required for this as it would force arm64 to disable the zero page.

- Clarify with the hardware architects whether CPUID checking is
  sufficient or additional description via FDT or ACPI is required.

[1] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[2] https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm_Memory_Tagging_Extension_Whitepaper.pdf

Catalin Marinas (13):
  kbuild: Add support for 'as-instr' to be used in Kconfig files
  arm64: alternative: Allow alternative_insn to always issue the first
    instruction
  arm64: Use macros instead of hard-coded constants for MAIR_EL1
  arm64: mte: Use Normal Tagged attributes for the linear map
  arm64: mte: Assembler macros and default architecture for .S files
  arm64: Tags-aware memcmp_pages() implementation
  mm: Introduce arch_calc_vm_flag_bits()
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the excluded tags via prctl()

Dave Martin (1):
  mm: Reserve asm-generic prot flags 0x10 and 0x20 for arch use

Vincenzo Frascino (8):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Tags-aware clear_page() implementation
  arm64: mte: Tags-aware copy_page() implementation
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 Documentation/arm64/cpu-feature-registers.rst |   4 +
 Documentation/arm64/elf_hwcaps.rst            |   4 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 229 ++++++++++++++++++
 arch/arm64/Kconfig                            |  32 +++
 arch/arm64/include/asm/alternative.h          |   8 +-
 arch/arm64/include/asm/assembler.h            |  16 ++
 arch/arm64/include/asm/cpucaps.h              |   5 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  78 ++++++
 arch/arm64/include/asm/mte.h                  |  11 +
 arch/arm64/include/asm/page.h                 |   4 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |   7 +-
 arch/arm64/include/asm/processor.h            |   4 +
 arch/arm64/include/asm/sysreg.h               |  70 ++++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/uapi/asm/hwcap.h           |   2 +
 arch/arm64/include/uapi/asm/mman.h            |  14 ++
 arch/arm64/include/uapi/asm/ptrace.h          |   1 +
 arch/arm64/kernel/cpufeature.c                |  59 +++++
 arch/arm64/kernel/cpuinfo.c                   |   2 +
 arch/arm64/kernel/entry.S                     |  17 ++
 arch/arm64/kernel/process.c                   | 141 ++++++++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |   8 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/clear_page.S                   |   7 +-
 arch/arm64/lib/copy_page.S                    |  23 ++
 arch/arm64/lib/mte.S                          |  46 ++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/cmppages.c                      |  26 ++
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/proc.S                          |  31 ++-
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  20 +-
 include/uapi/asm-generic/mman-common.h        |   2 +
 include/uapi/asm-generic/siginfo.h            |   9 +-
 include/uapi/linux/prctl.h                    |   9 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   8 +
 mm/shmem.c                                    |   3 +
 mm/util.c                                     |   2 +-
 scripts/Kconfig.include                       |   4 +
 50 files changed, 958 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/cmppages.c

