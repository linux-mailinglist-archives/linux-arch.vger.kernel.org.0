Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBBC250DA6
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgHYAd2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:33:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:12283 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgHYA3d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:33 -0400
IronPort-SDR: ptWo45aXPjMJa5vHYvObbwOBDUDzSYU6Q/+/b0+P7iQ4u+iKoJMnRcEyJDH5XmFByARgSrGX1K
 AS49vHukV3Lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075245"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:29 -0700
IronPort-SDR: +ixf0feFasPgS2JIBfpwdEH7OcPp+nDHQQ7IwSKUCHdN49S3H5pYwxzxO/ddWTMF876ij7k2In
 zcK5DzFLh5fA==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474134921"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:28 -0700
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
Subject: [PATCH v11 00/25] Control-flow Enforcement: Shadow Stack
Date:   Mon, 24 Aug 2020 17:25:15 -0700
Message-Id: <20200825002540.3351-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details are in "Intel 64 and
IA-32 Architectures Software Developer's Manual" [1].

CET can protect applications and the kernel.  This series enables only
application-level protection, and has three parts:

  - shadow stack [2],
  - indirect branch tracking, ptrace [3], and
  - selftests [4].

I have run tests on these patches for quite some time, and they have been
very stable.  Linux distributions with CET are available now, and Intel
processors with CET are becoming available.  It would be nice if CET
support can be accepted into the kernel.  I will be working to address any
issues should they come up.

Changes in v11:

- Rebase to v5.9-rc1.
- There was no more caller passing vm_flags to do_mmap() and the input
  parameter was removed.  Shadow stack allocation is a new user passing
  VM_SHSTK.  Thus, reintroduce the parameter and do_mmap_pgoff().
- Selftests/x86/sigreturn does a sigreturn from 64-bit to a 32-bit context,
  and needs a shadow stack in the 32-bit address range.  For all similar
  purposes, change shadow stack allocation arch_prctl() to take MAP_32BIT
  and MAP_POPULATE flags from the user.
- Update arch_prctl() for checking invalid inputs and using proper return
  codes.
- Other smaller changes are noted in each patch's log.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] CET Shadow Stack patches v10:

    https://lkml.kernel.org/r/20200429220732.31602-1-yu-cheng.yu@intel.com/

[3] There is no Indirect Branch Tracking patches v10.  There have been no
    major changes since v9:

    https://lkml.kernel.org/r/20200205182308.4028-1-yu-cheng.yu@intel.com/

[4] I am holding off the selftests changes and working to get Acked-by's.
    The earlier version of the selftests patches:

    https://lkml.kernel.org/r/20200521211720.20236-1-yu-cheng.yu@intel.com/

Yu-cheng Yu (25):
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

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 143 +++++++
 arch/arm64/include/asm/elf.h                  |   5 +
 arch/x86/Kconfig                              |  36 ++
 arch/x86/ia32/ia32_signal.c                   |  17 +
 arch/x86/include/asm/cet.h                    |  40 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/elf.h                    |  13 +
 arch/x86/include/asm/fpu/internal.h           |  10 +
 arch/x86/include/asm/fpu/types.h              |  23 +-
 arch/x86/include/asm/fpu/xstate.h             |   5 +-
 arch/x86/include/asm/idtentry.h               |   4 +
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  17 +
 arch/x86/include/asm/pgtable.h                | 209 +++++++++-
 arch/x86/include/asm/pgtable_types.h          |  58 ++-
 arch/x86/include/asm/processor.h              |  15 +
 arch/x86/include/asm/special_insns.h          |  32 ++
 arch/x86/include/asm/traps.h                  |   2 +
 arch/x86/include/uapi/asm/prctl.h             |   5 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/include/uapi/asm/sigcontext.h        |   9 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet.c                         | 357 ++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   |  98 +++++
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
 include/linux/pgtable.h                       |  35 ++
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/elf.h                      |   9 +
 ipc/shm.c                                     |   2 +-
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  10 +-
 mm/memory.c                                   |   5 +-
 mm/migrate.c                                  |   3 +-
 mm/mmap.c                                     |  21 +-
 mm/mprotect.c                                 |   2 +-
 mm/nommu.c                                    |   6 +-
 mm/shmem.c                                    |   2 +-
 mm/util.c                                     |   4 +-
 scripts/as-x86_64-has-shadow-stack.sh         |   4 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 tools/arch/x86/include/uapi/asm/prctl.h       |   5 +
 67 files changed, 1574 insertions(+), 77 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100755 scripts/as-x86_64-has-shadow-stack.sh

-- 
2.21.0

