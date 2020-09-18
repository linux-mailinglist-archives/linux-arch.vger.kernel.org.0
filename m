Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7862704EC
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRTWR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:22:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:41776 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgIRTWR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 15:22:17 -0400
IronPort-SDR: WwZc1mBOOCFNuPpvE9XwdRjii4i1+j4rBUrPKMlFnVDUyhdvSH8wWVnb37GiHCGddh6E8rQ/PL
 FDkhHDsYvYVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147766214"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147766214"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:11 -0700
IronPort-SDR: 1rH8l5SCWRlV1dSFgdfTofNhF/eGeqTZH5FlipxyW8mZq1UnbwJGtBA5uiGZD1S6KIbSSeJ+qK
 8YOm81peAsQA==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484331792"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:10 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v12 00/26] Control-flow Enforcement: Shadow Stack
Date:   Fri, 18 Sep 2020 12:20:58 -0700
Message-Id: <20200918192125.25473-1-yu-cheng.yu@intel.com>
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
processors with CET are becoming available.  It would be nice if CET
support can be accepted into the kernel.  I will be working to address any
issues should they come up.

Changes in v12:

- Introduce x86-specific PROT_SHSTK for mprotect/mmap to replace the shadow
  stack allocation arch_prctl().

- Split shadow stack disabling and freeing into two functions.  This is
  because in the exit syscall, there is no need to disable shadow stack.

- The kernel ptrace patch is tested with an Intel-internal updated GDB.
  I am holding the kernel ptrace patch off to re-test it with my earlier
  patch for fixing regset holes.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] CET Shadow Stack patches v11:

    https://lkml.kernel.org/r/20200825002540.3351-1-yu-cheng.yu@intel.com/

[3] Indirect Branch Tracking patches v11.

    https://lkml.kernel.org/r/20200825002645.3658-1-yu-cheng.yu@intel.com/

[4] I am holding off the selftests changes and working to get Acked-by's.
    The earlier version of the selftests patches:

    https://lkml.kernel.org/r/20200521211720.20236-1-yu-cheng.yu@intel.com/

Yu-cheng Yu (26):
  Documentation/x86: Add CET description
  x86/cpufeatures: Add CET CPU feature flags for Control-flow
    Enforcement Technology (CET)
  x86/fpu/xstate: Introduce CET MSR XSAVES supervisor states
  x86/cet: Add control-protection fault handler
  x86/cet/shstk: Add Kconfig option for user-mode Shadow Stack
  x86/mm: Change _PAGE_DIRTY to _PAGE_DIRTY_HW
  x86/mm: Remove _PAGE_DIRTY_HW from kernel RO pages
  x86/mm: Introduce _PAGE_COW
  drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
  x86/mm: Update pte_modify for _PAGE_COW
  x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
    transition from _PAGE_DIRTY_HW to _PAGE_COW
  mm: Introduce VM_SHSTK for shadow stack memory
  x86/mm: Shadow Stack page fault error checking
  x86/mm: Update maybe_mkwrite() for shadow stack
  mm: Fixup places that call pte_mkwrite() directly
  mm: Add guard pages around a shadow stack.
  mm/mmap: Add shadow stack pages to memory accounting
  mm: Update can_follow_write_pte() for shadow stack
  mm: Re-introduce do_mmap_pgoff()
  x86/cet/shstk: User-mode shadow stack support
  x86/cet/shstk: Handle signals for shadow stack
  binfmt_elf: Define GNU_PROPERTY_X86_FEATURE_1_AND properties
  ELF: Introduce arch_setup_elf_property()
  x86/cet/shstk: Handle thread shadow stack
  x86/cet/shstk: Add arch_prctl functions for shadow stack
  mm: Introduce PROT_SHSTK for shadow stack

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 133 +++++++
 arch/arm64/include/asm/elf.h                  |   5 +
 arch/x86/Kconfig                              |  36 ++
 arch/x86/ia32/ia32_signal.c                   |  17 +
 arch/x86/include/asm/cet.h                    |  42 +++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/elf.h                    |  13 +
 arch/x86/include/asm/fpu/internal.h           |  10 +
 arch/x86/include/asm/fpu/types.h              |  23 +-
 arch/x86/include/asm/fpu/xstate.h             |   5 +-
 arch/x86/include/asm/idtentry.h               |   4 +
 arch/x86/include/asm/mman.h                   |  81 +++++
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  20 +
 arch/x86/include/asm/pgtable.h                | 209 ++++++++++-
 arch/x86/include/asm/pgtable_types.h          |  58 ++-
 arch/x86/include/asm/processor.h              |  15 +
 arch/x86/include/asm/special_insns.h          |  32 ++
 arch/x86/include/asm/traps.h                  |   2 +
 arch/x86/include/uapi/asm/mman.h              |  28 +-
 arch/x86/include/uapi/asm/prctl.h             |   4 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/include/uapi/asm/sigcontext.h        |   9 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet.c                         | 343 ++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   |  68 ++++
 arch/x86/kernel/cpu/common.c                  |  28 ++
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/fpu/signal.c                  | 100 +++++
 arch/x86/kernel/fpu/xstate.c                  |  28 +-
 arch/x86/kernel/idt.c                         |   4 +
 arch/x86/kernel/process.c                     |  14 +-
 arch/x86/kernel/process_64.c                  |  32 ++
 arch/x86/kernel/relocate_kernel_64.S          |   2 +-
 arch/x86/kernel/signal.c                      |  10 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 arch/x86/kernel/traps.c                       |  59 +++
 arch/x86/kvm/vmx/vmx.c                        |   2 +-
 arch/x86/mm/fault.c                           |  19 +
 arch/x86/mm/mmap.c                            |   2 +
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pgtable.c                         |  25 ++
 drivers/gpu/drm/i915/gvt/gtt.c                |   2 +-
 fs/aio.c                                      |   6 +-
 fs/binfmt_elf.c                               |   4 +
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/proc/task_mmu.c                            |   3 +
 include/linux/elf.h                           |   6 +
 include/linux/fs.h                            |   2 +-
 include/linux/mm.h                            |  46 ++-
 include/linux/mman.h                          |   8 +
 include/linux/pgtable.h                       |  35 ++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/elf.h                      |   9 +
 ipc/shm.c                                     |   2 +-
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  10 +-
 mm/memory.c                                   |   5 +-
 mm/migrate.c                                  |   3 +-
 mm/mmap.c                                     |  29 +-
 mm/mprotect.c                                 |   6 +-
 mm/nommu.c                                    |   6 +-
 mm/shmem.c                                    |   2 +-
 mm/util.c                                     |   4 +-
 scripts/as-x86_64-has-shadow-stack.sh         |   4 +
 tools/arch/x86/include/asm/cpufeatures.h      |   2 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 tools/arch/x86/include/asm/msr-index.h        |  20 +
 tools/arch/x86/include/uapi/asm/prctl.h       |   4 +
 72 files changed, 1649 insertions(+), 102 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/include/asm/mman.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100755 scripts/as-x86_64-has-shadow-stack.sh

-- 
2.21.0

