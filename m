Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D089636CC8D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239050AbhD0Uow (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:44:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:31779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239062AbhD0Uou (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:44:50 -0400
IronPort-SDR: HYUrBhNsD+XxQT1p0vq5enFxjL6XYeeXHsmNHoSpa+nDcKDIE4nASpuzRyfQNvGwIJwuyl3yvc
 xYXTf0iS7pzg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281922444"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="281922444"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:06 -0700
IronPort-SDR: UrRiS7HbW5+0dqtqtEHCMaJ6UoumfTg7yy79fGETtlPolkbyRx6kx6Yin4r0pKaH3C4T1RnbMh
 KrwwaKtZwKmA==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="465623422"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:05 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v26 00/30] Control-flow Enforcement: Shadow Stack
Date:   Tue, 27 Apr 2021 13:42:45 -0700
Message-Id: <20210427204315.24153-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

CET can protect applications and the kernel.  This series enables only
application-level protection, and has three parts:

  - Shadow stack [2],
  - Indirect branch tracking [3], and
  - Selftests [4].

I have run tests on these patches for quite some time, and they have been
very stable.  Linux distributions with CET are available now, and Intel
processors with CET are already on the market.  It would be nice if CET
support can be accepted into the kernel.  I will be working to address any
issues should they come up.

Changes in v26:
- Patch #19: Instead of passing vm_flags, pass vma pointer to can_follow_*().
- Patch #29: Instead of passing vma is anonymous, pass vma pointer to
  arch_validate_flags().
- Patch #30: Change PROT_SHSTK to PROT_SHADOW_STACK, remove redundant
  VM_SHARED check.
- Rebase to Linus tree v5.12.

Changes in v25:
- Remove Kconfig X86_CET and software-defined feature flag X86_FEATURE_CET.
  Use X86_SHADOW_STACK and X86_FEATURE_SHSTK directly.  Update related
  areas accordingly.
- Patch #16: Make same changes to do_huge_pmd_numa_page() as to
  do_numa_page().
- Patch #25: Update signal handling, use restorer address already
  retrieved, update MSR restoring code.
- Smaller changes are called out in each patch.
- Rebase to Linus tree v5.12-rc7.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] Shadow Stack patches v25:

    https://lore.kernel.org/r/20210415221419.31835-1-yu-cheng.yu@intel.com/

[3] Indirect Branch Tracking patches v25

    https://lore.kernel.org/r/20210415221734.32628-1-yu-cheng.yu@intel.com/

[4] I am holding off the selftests changes and working to get Reviewed-by's.
    The earlier version of the selftests patches:

    https://lkml.kernel.org/r/20200521211720.20236-1-yu-cheng.yu@intel.com/

[5] The kernel ptrace patch is tested with an Intel-internal updated GDB.
    I am holding off the kernel ptrace patch to re-test it with my earlier
    patch for fixing regset holes.

Yu-cheng Yu (30):
  Documentation/x86: Add CET description
  x86/cet/shstk: Add Kconfig option for Shadow Stack
  x86/cpufeatures: Add CET CPU feature flags for Control-flow
    Enforcement Technology (CET)
  x86/cpufeatures: Introduce CPU setup and option parsing for CET
  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
  x86/cet: Add control-protection fault handler
  x86/mm: Remove _PAGE_DIRTY from kernel RO pages
  x86/mm: Move pmd_write(), pud_write() up in the file
  x86/mm: Introduce _PAGE_COW
  drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
  x86/mm: Update pte_modify for _PAGE_COW
  x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
    transition from _PAGE_DIRTY to _PAGE_COW
  mm: Introduce VM_SHADOW_STACK for shadow stack memory
  x86/mm: Shadow Stack page fault error checking
  x86/mm: Update maybe_mkwrite() for shadow stack
  mm: Fixup places that call pte_mkwrite() directly
  mm: Add guard pages around a shadow stack.
  mm/mmap: Add shadow stack pages to memory accounting
  mm: Update can_follow_write_pte() for shadow stack
  mm/mprotect: Exclude shadow stack from preserve_write
  mm: Re-introduce vm_flags to do_mmap()
  x86/cet/shstk: Add user-mode shadow stack support
  x86/cet/shstk: Handle thread shadow stack
  x86/cet/shstk: Introduce shadow stack token setup/verify routines
  x86/cet/shstk: Handle signals for shadow stack
  ELF: Introduce arch_setup_elf_property()
  x86/cet/shstk: Add arch_prctl functions for shadow stack
  mm: Move arch_calc_vm_prot_bits() to arch/x86/include/asm/mman.h
  mm: Update arch_validate_flags() to include vma anonymous
  mm: Introduce PROT_SHADOW_STACK for shadow stack

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/filesystems/proc.rst            |   1 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 136 ++++++++
 arch/arm64/include/asm/elf.h                  |   5 +
 arch/arm64/include/asm/mman.h                 |   4 +-
 arch/sparc/include/asm/mman.h                 |   4 +-
 arch/x86/Kconfig                              |  24 ++
 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/ia32/ia32_signal.c                   |  24 +-
 arch/x86/include/asm/cet.h                    |  52 +++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/elf.h                    |  13 +
 arch/x86/include/asm/fpu/internal.h           |   2 +
 arch/x86/include/asm/fpu/types.h              |  23 +-
 arch/x86/include/asm/fpu/xstate.h             |   6 +-
 arch/x86/include/asm/idtentry.h               |   4 +
 arch/x86/include/asm/mman.h                   |  88 +++++
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  19 ++
 arch/x86/include/asm/page_types.h             |   7 +
 arch/x86/include/asm/pgtable.h                | 299 +++++++++++++++--
 arch/x86/include/asm/pgtable_types.h          |  48 ++-
 arch/x86/include/asm/processor.h              |   5 +
 arch/x86/include/asm/special_insns.h          |  32 ++
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/uapi/asm/mman.h              |  28 +-
 arch/x86/include/uapi/asm/prctl.h             |   4 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/include/uapi/asm/sigcontext.h        |   9 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet_prctl.c                   |  60 ++++
 arch/x86/kernel/cpu/common.c                  |  14 +
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/fpu/signal.c                  | 137 +++++++-
 arch/x86/kernel/fpu/xstate.c                  |  10 +-
 arch/x86/kernel/idt.c                         |   4 +
 arch/x86/kernel/process.c                     |  21 +-
 arch/x86/kernel/process_64.c                  |  32 ++
 arch/x86/kernel/shstk.c                       | 304 ++++++++++++++++++
 arch/x86/kernel/signal.c                      |   9 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 arch/x86/kernel/traps.c                       |  63 ++++
 arch/x86/mm/fault.c                           |  19 ++
 arch/x86/mm/mmap.c                            |  48 +++
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pgtable.c                         |  25 ++
 drivers/gpu/drm/i915/gvt/gtt.c                |   2 +-
 fs/aio.c                                      |   2 +-
 fs/binfmt_elf.c                               |   4 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/elf.h                           |   6 +
 include/linux/mm.h                            |  18 +-
 include/linux/mman.h                          |   2 +-
 include/linux/pgtable.h                       |   7 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/elf.h                      |   9 +
 ipc/shm.c                                     |   2 +-
 mm/gup.c                                      |  16 +-
 mm/huge_memory.c                              |  27 +-
 mm/memory.c                                   |   5 +-
 mm/migrate.c                                  |   3 +-
 mm/mmap.c                                     |  17 +-
 mm/mprotect.c                                 |  11 +-
 mm/nommu.c                                    |   4 +-
 mm/util.c                                     |   2 +-
 67 files changed, 1644 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/include/asm/mman.h
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100644 arch/x86/kernel/shstk.c

-- 
2.21.0

