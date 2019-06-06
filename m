Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543B137E83
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfFFUPJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:15:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:47825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfFFUPJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:15:08 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 13:15:07 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 00/27] Control-flow Enforcement: Shadow Stack
Date:   Thu,  6 Jun 2019 13:06:19 -0700
Message-Id: <20190606200646.3951-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Intel has published Control-flow Enforcement (CET) in the Architecture
Instruction Set Extensions Programming Reference:

  https://software.intel.com/en-us/download/intel-architecture-instruction-set-
  extensions-programming-reference

The previous version (v6) of CET Shadow Stack patches is here:

  https://lkml.org/lkml/2018/11/20/225

Summary of changes from v6:

  Rebase to v5.2-rc3.

  Adapt XSAVES system state changes to the recent FPU changes:
    - Add modify_fpu_regs_begin(), modify_fpu_regs_end() to protect
      CET MSR changes.
    - Update signal handling.

  Move ELF header-parsing out of x86.

  Other small fixes in response to comments.

This version passed GLIBC built-in tests.

Hi Maintainers,

What else is needed before this series can be merged?

Thanks,
Yu-cheng


Yu-cheng Yu (27):
  Documentation/x86: Add CET description
  x86/cpufeatures: Add CET CPU feature flags for Control-flow
    Enforcement Technology (CET)
  x86/fpu/xstate: Change names to separate XSAVES system and user states
  x86/fpu/xstate: Introduce XSAVES system states
  x86/fpu/xstate: Add XSAVES system states for shadow stack
  x86/cet: Add control protection exception handler
  x86/cet/shstk: Add Kconfig option for user-mode shadow stack
  mm: Introduce VM_SHSTK for shadow stack memory
  mm/mmap: Prevent Shadow Stack VMA merges
  x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
  x86/mm: Introduce _PAGE_DIRTY_SW
  drm/i915/gvt: Update _PAGE_DIRTY to _PAGE_DIRTY_BITS
  x86/mm: Modify ptep_set_wrprotect and pmdp_set_wrprotect for
    _PAGE_DIRTY_SW
  x86/mm: Shadow stack page fault error checking
  mm: Handle shadow stack page fault
  mm: Handle THP/HugeTLB shadow stack page fault
  mm: Update can_follow_write_pte/pmd for shadow stack
  mm: Introduce do_mmap_locked()
  x86/cet/shstk: User-mode shadow stack support
  x86/cet/shstk: Introduce WRUSS instruction
  x86/cet/shstk: Handle signals for shadow stack
  binfmt_elf: Extract .note.gnu.property from an ELF file
  x86/cet/shstk: ELF header parsing of Shadow Stack
  x86/cet/shstk: Handle thread shadow stack
  mm/mmap: Add Shadow stack pages to memory accounting
  x86/cet/shstk: Add arch_prctl functions for Shadow Stack
  x86/cet/shstk: Add Shadow Stack instructions to opcode map

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 268 +++++++++++++
 arch/x86/Kconfig                              |  26 ++
 arch/x86/Makefile                             |   7 +
 arch/x86/entry/entry_64.S                     |   2 +-
 arch/x86/ia32/ia32_signal.c                   |   8 +
 arch/x86/include/asm/cet.h                    |  48 +++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/fpu/internal.h           |  25 +-
 arch/x86/include/asm/fpu/signal.h             |   2 +
 arch/x86/include/asm/fpu/types.h              |  22 ++
 arch/x86/include/asm/fpu/xstate.h             |  26 +-
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  18 +
 arch/x86/include/asm/pgtable.h                | 191 ++++++++--
 arch/x86/include/asm/pgtable_types.h          |  38 +-
 arch/x86/include/asm/processor.h              |   5 +
 arch/x86/include/asm/special_insns.h          |  32 ++
 arch/x86/include/asm/traps.h                  |   5 +
 arch/x86/include/uapi/asm/prctl.h             |   5 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/include/uapi/asm/sigcontext.h        |  15 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet.c                         | 327 ++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   |  85 +++++
 arch/x86/kernel/cpu/common.c                  |  25 ++
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/fpu/core.c                    |  26 +-
 arch/x86/kernel/fpu/init.c                    |  10 -
 arch/x86/kernel/fpu/signal.c                  |  81 +++-
 arch/x86/kernel/fpu/xstate.c                  | 156 +++++---
 arch/x86/kernel/idt.c                         |   4 +
 arch/x86/kernel/process.c                     |   8 +-
 arch/x86/kernel/process_64.c                  |  31 ++
 arch/x86/kernel/relocate_kernel_64.S          |   2 +-
 arch/x86/kernel/signal.c                      |  10 +-
 arch/x86/kernel/signal_compat.c               |   2 +-
 arch/x86/kernel/traps.c                       |  57 +++
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/lib/x86-opcode-map.txt               |  26 +-
 arch/x86/mm/fault.c                           |  18 +
 arch/x86/mm/pgtable.c                         |  41 ++
 drivers/gpu/drm/i915/gvt/gtt.c                |   2 +-
 fs/Kconfig.binfmt                             |   3 +
 fs/Makefile                                   |   1 +
 fs/binfmt_elf.c                               |  13 +
 fs/gnu_property.c                             | 351 ++++++++++++++++++
 fs/proc/task_mmu.c                            |   3 +
 include/asm-generic/pgtable.h                 |  14 +
 include/linux/elf.h                           |  12 +
 include/linux/mm.h                            |  26 ++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/elf.h                      |  14 +
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  12 +-
 mm/memory.c                                   |   7 +-
 mm/mmap.c                                     |  11 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 tools/objtool/arch/x86/lib/x86-opcode-map.txt |  26 +-
 61 files changed, 2029 insertions(+), 165 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100644 fs/gnu_property.c

-- 
2.17.1

