Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6961B296C
	for <lists+linux-arch@lfdr.de>; Tue, 21 Apr 2020 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDUO0M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Apr 2020 10:26:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35842 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUO0M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Apr 2020 10:26:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3293BC14;
        Tue, 21 Apr 2020 07:26:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A51F33F68F;
        Tue, 21 Apr 2020 07:26:09 -0700 (PDT)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v3 00/23] arm64: Memory Tagging Extension user-space support
Date:   Tue, 21 Apr 2020 15:25:40 +0100
Message-Id: <20200421142603.3894-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is the third version (second version here [1]) of the series
adding user-space support for the ARMv8.5 Memory Tagging Extension ([2],
[3]). The patches are also available on this branch:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux devel/mte-v3

Changes in this version:

- Ignore asynchronous tag check faults caused by the kernel accessing
  user space (uaccess routines). One of the reasons is that the kernel
  has a few places where it over-reads the user buffer
  (copy_mount_options(), strncpy_from user()) causing an incorrect
  reporting of a tag check fault. The second reason is that such
  asynchronous tag check fault in uaccess was reported as a SIGSEGV
  while the uaccess synchronous faults usually cause an error being
  returned (-EFAULT).

- Device Tree support for marking a memory node as MTE-capable. MTE will
  only be enabled if all the memory nodes support the feature. In the
  absence of any memory node in the DT or if the system is booted with
  ACPI, MTE will be disabled.

- ptrace() support to access the tags in another process address space.
  See the documentation patch for details.

- fs patch for copy_mount_options() to cope with in-page faults. Prior
  to 5.7, this function had a byte-by-byte fallback. It has since been
  updated so that a fault in the first page would lead to the copy being
  aborted altogether.

- GCR_EL1 restoring after a CPU suspend.

- Fix the pgattr_change_is_safe() to only allow changes between Normal
  and Normal-Tagged.

- Update a BUILD_BUG on x86 for NSIGSEGV != 7 following the generic
  value update.

- Rebased to 5.7-rc2.

Swap support is available but not included with this series as we'd like
some feedback from linux-mm folk on the right approach. To be posted
shortly.

Kselftest patches will also be made available soon.

To be decided/implemented:

- mmap(tagged_addr, PROT_MTE) pre-tagging the memory with the tag given
  in the tagged_addr hint.

- coredump (user) to also dump the tags.

[1] https://lore.kernel.org/linux-arm-kernel/20200226180526.3272848-1-catalin.marinas@arm.com/
[2] https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/posts/enhancing-memory-safety
[3] https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Arm_Memory_Tagging_Extension_Whitepaper.pdf

Catalin Marinas (14):
  arm64: alternative: Allow alternative_insn to always issue the first
    instruction
  arm64: mte: Use Normal Tagged attributes for the linear map
  arm64: mte: Assembler macros and default architecture for .S files
  arm64: Tags-aware memcmp_pages() implementation
  arm64: mte: Add PROT_MTE support to mmap() and mprotect()
  mm: Introduce arch_validate_flags()
  arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
  mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
  arm64: mte: Allow user control of the tag check mode via prctl()
  arm64: mte: Allow user control of the generated random tags via
    prctl()
  arm64: mte: Restore the GCR_EL1 register after a suspend
  arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS support
  fs: Allow copy_mount_options() to access user-space in a single pass
  arm64: mte: Check the DT memory nodes for MTE support

Kevin Brodsky (1):
  mm: Introduce arch_calc_vm_flag_bits()

Vincenzo Frascino (8):
  arm64: mte: system register definitions
  arm64: mte: CPU feature detection and initial sysreg configuration
  arm64: mte: Tags-aware clear_page() implementation
  arm64: mte: Tags-aware copy_page() implementation
  arm64: mte: Add specific SIGSEGV codes
  arm64: mte: Handle synchronous and asynchronous tag check faults
  arm64: mte: Kconfig entry
  arm64: mte: Add Memory Tagging Extension documentation

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   5 +
 Documentation/arm64/index.rst                 |   1 +
 .../arm64/memory-tagging-extension.rst        | 260 +++++++++++++++++
 arch/arm64/Kconfig                            |  32 +++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts     |   1 +
 arch/arm64/include/asm/alternative.h          |   8 +-
 arch/arm64/include/asm/assembler.h            |  17 ++
 arch/arm64/include/asm/cpucaps.h              |   4 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   3 +-
 arch/arm64/include/asm/memory.h               |  17 +-
 arch/arm64/include/asm/mman.h                 |  78 ++++++
 arch/arm64/include/asm/mte.h                  |  56 ++++
 arch/arm64/include/asm/page.h                 |   2 +-
 arch/arm64/include/asm/pgtable-prot.h         |   2 +
 arch/arm64/include/asm/pgtable.h              |   7 +-
 arch/arm64/include/asm/processor.h            |   4 +
 arch/arm64/include/asm/sysreg.h               |  62 +++++
 arch/arm64/include/asm/thread_info.h          |   4 +-
 arch/arm64/include/asm/uaccess.h              |  11 +
 arch/arm64/include/uapi/asm/hwcap.h           |   2 +
 arch/arm64/include/uapi/asm/mman.h            |  14 +
 arch/arm64/include/uapi/asm/ptrace.h          |   4 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/cpufeature.c                | 107 +++++++
 arch/arm64/kernel/cpuinfo.c                   |   2 +
 arch/arm64/kernel/entry.S                     |  36 +++
 arch/arm64/kernel/mte.c                       | 262 ++++++++++++++++++
 arch/arm64/kernel/process.c                   |  31 ++-
 arch/arm64/kernel/ptrace.c                    |  17 +-
 arch/arm64/kernel/signal.c                    |   8 +
 arch/arm64/kernel/suspend.c                   |   4 +
 arch/arm64/kernel/syscall.c                   |  10 +
 arch/arm64/lib/Makefile                       |   2 +
 arch/arm64/lib/clear_page.S                   |   7 +-
 arch/arm64/lib/copy_page.S                    |  23 ++
 arch/arm64/lib/mte.S                          |  96 +++++++
 arch/arm64/mm/Makefile                        |   1 +
 arch/arm64/mm/cmppages.c                      |  26 ++
 arch/arm64/mm/dump.c                          |   4 +
 arch/arm64/mm/fault.c                         |   9 +-
 arch/arm64/mm/mmu.c                           |  22 +-
 arch/arm64/mm/proc.S                          |   8 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 fs/namespace.c                                |   7 +-
 fs/proc/task_mmu.c                            |   4 +
 include/linux/mm.h                            |   8 +
 include/linux/mman.h                          |  22 +-
 include/linux/uaccess.h                       |   8 +
 include/uapi/asm-generic/siginfo.h            |   4 +-
 include/uapi/linux/prctl.h                    |   9 +
 mm/mmap.c                                     |   9 +
 mm/mprotect.c                                 |   6 +
 mm/shmem.c                                    |   3 +
 mm/util.c                                     |   2 +-
 57 files changed, 1332 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/arm64/memory-tagging-extension.rst
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/asm/mte.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h
 create mode 100644 arch/arm64/kernel/mte.c
 create mode 100644 arch/arm64/lib/mte.S
 create mode 100644 arch/arm64/mm/cmppages.c

