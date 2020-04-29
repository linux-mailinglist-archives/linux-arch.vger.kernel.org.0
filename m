Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348D81BEB7E
	for <lists+linux-arch@lfdr.de>; Thu, 30 Apr 2020 00:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgD2WIj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Apr 2020 18:08:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:61292 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2WIj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Apr 2020 18:08:39 -0400
IronPort-SDR: nYmsTfa/6Y2tGmvXKBBiw9JR/OqxNTO4KeBT1/b7bOEzM9uinrHxoAje5m1wLuHKxEHdn9Eu7x
 SYpzcihYAMhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2020 15:08:38 -0700
IronPort-SDR: FX4plVa4G4mfPix4PKHCYpqINVobk2F9X81qSj53z0RN2TSqObuUAJUF173i7h0NryIq96S4Ds
 cNfnzsOKFGTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; 
   d="scan'208";a="276308832"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 29 Apr 2020 15:08:37 -0700
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
Subject: [PATCH v10 00/26] Control-flow Enforcement: Shadow Stack
Date:   Wed, 29 Apr 2020 15:07:06 -0700
Message-Id: <20200429220732.31602-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Control-flow Enforcement (CET) is a new Intel processor feature that blocks
return/jump-oriented programming attacks.  Details can be found in "Intel
64 and IA-32 Architectures Software Developer's Manual" [1].

This series depends on the XSAVES supervisor state series that was split
out and submitted earlier [2].

I have gone through previous comments, and hope all concerns have been
resolved now.  Please inform me if anything is overlooked.

Changes in v10:

- A shadow stack PTE is (!_PAGE_RW and _PAGE_DIRTY_HW).  In handling page
  faults, previous versions of this series use helpers such as arch_copy_
  pte_mapping() and arch_set_vma_features() to manage the _PAGE_DIRTY_HW
  bit for the copy-on-write logic.  This has been simplified by treating
  shadow stack as logically writable, and shadow stack faults are handled
  similarly as for normal writable data pages.  Functions pte_write(),
  pte_mkwrite(), pte_wrprotect(), maybe_mkwrite() etc. are updated
  accordingly.

- Signal return code is updated according to the XSAVES supervisor state
  changes.

- Other smaller changes are noted in each patch's log.

[1] Intel 64 and IA-32 Architectures Software Developer's Manual:

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] XSAVES supervisor states patches:
    https://lkml.kernel.org/r/20200328164307.17497-1-yu-cheng.yu@intel.com/

[3] CET Shadow Stack patches v9:

    https://lkml.kernel.org/r/20200205181935.3712-1-yu-cheng.yu@intel.com/

Dave Martin (1):
  ELF: Add ELF program property parsing support

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
  x86/cet/shstk: User-mode shadow stack support
  x86/cet/shstk: Handle signals for shadow stack
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Introduce arch_setup_elf_property()
  x86/cet/shstk: ELF header parsing for shadow stack
  x86/cet/shstk: Handle thread shadow stack
  x86/cet/shstk: Add arch_prctl functions for shadow stack

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 129 +++++++
 arch/x86/Kconfig                              |  36 ++
 arch/x86/entry/entry_64.S                     |   2 +-
 arch/x86/ia32/ia32_signal.c                   |  17 +
 arch/x86/include/asm/cet.h                    |  40 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/elf.h                    |  13 +
 arch/x86/include/asm/fpu/internal.h           |  10 +
 arch/x86/include/asm/fpu/types.h              |  22 ++
 arch/x86/include/asm/fpu/xstate.h             |   5 +-
 arch/x86/include/asm/mmu_context.h            |   3 +
 arch/x86/include/asm/msr-index.h              |  18 +
 arch/x86/include/asm/pgtable.h                | 209 +++++++++-
 arch/x86/include/asm/pgtable_types.h          |  58 ++-
 arch/x86/include/asm/processor.h              |  15 +
 arch/x86/include/asm/special_insns.h          |  32 ++
 arch/x86/include/asm/traps.h                  |   7 +
 arch/x86/include/uapi/asm/prctl.h             |   5 +
 arch/x86/include/uapi/asm/processor-flags.h   |   2 +
 arch/x86/include/uapi/asm/sigcontext.h        |   9 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cet.c                         | 356 ++++++++++++++++++
 arch/x86/kernel/cet_prctl.c                   |  87 +++++
 arch/x86/kernel/cpu/common.c                  |  28 ++
 arch/x86/kernel/cpu/cpuid-deps.c              |   2 +
 arch/x86/kernel/fpu/signal.c                  | 101 +++++
 arch/x86/kernel/fpu/xstate.c                  |  25 +-
 arch/x86/kernel/idt.c                         |   4 +
 arch/x86/kernel/process.c                     |  12 +-
 arch/x86/kernel/process_64.c                  |  29 ++
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
 fs/Kconfig.binfmt                             |   3 +
 fs/binfmt_elf.c                               | 131 +++++++
 fs/compat_binfmt_elf.c                        |   4 +
 fs/proc/task_mmu.c                            |   3 +
 include/asm-generic/pgtable.h                 |  35 ++
 include/linux/elf.h                           |  33 ++
 include/linux/mm.h                            |  34 +-
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/linux/elf.h                      |  12 +
 mm/gup.c                                      |   8 +-
 mm/huge_memory.c                              |  10 +-
 mm/memory.c                                   |   5 +-
 mm/migrate.c                                  |   3 +-
 mm/mmap.c                                     |   5 +
 mm/mprotect.c                                 |   2 +-
 scripts/as-x86_64-has-shadow-stack.sh         |   4 +
 .../arch/x86/include/asm/disabled-features.h  |   8 +-
 60 files changed, 1670 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/x86/intel_cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/cet_prctl.c
 create mode 100755 scripts/as-x86_64-has-shadow-stack.sh

-- 
2.21.0

