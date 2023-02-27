Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006A6A4E07
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjB0Wb2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjB0Wb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:31:27 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C84025BBA;
        Mon, 27 Feb 2023 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537086; x=1709073086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wgxjh9QgD3JL/mbNIdl6volkZkIB/jWnSXcuFGCrqwg=;
  b=CY3GFHSKn2onDY6JzsM1AC1wf7tGcSGSgBaetbbYbg2cBsyyBwrFv7EA
   1uobanq6HIisq/xL6ZVhi0p9UcE1W2B7Iu6ZsnuIC7RE+FbtVhsAGpl61
   CegWNlZL7X+Z1tQ5kAsi9Jcu8BE52n3H1Vbtfn6vADGeb7B+M5x2Yd92s
   M3oHUkgakpl5Y+rk4nQyUQAvsMoQTG2/9xTFNBdOqnfnvlWt0gFETwCn2
   FrAWHQxt4iVlyv2SxkrSWLan7C+Ovoa5sCgSfiJ/t8AUQoT39dMYaREhU
   79r75Rc6eq36SvL4ad/2JXyrgHjRSICyHq5oz1xyHYkbA3uWX0xoI5L0f
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313656974"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313656974"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:07 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024329"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024329"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:06 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v7 00/41] Shadow stacks for userspace
Date:   Mon, 27 Feb 2023 14:29:16 -0800
Message-Id: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series implements Shadow Stacks for userspace using x86's Control-flow 
Enforcement Technology (CET). CET consists of two related security features: 
shadow stacks and indirect branch tracking. This series implements just the 
shadow stack part of this feature, and just for userspace.

The main use case for shadow stack is providing protection against return 
oriented programming attacks. It works by maintaining a secondary (shadow) 
stack using a special memory type that has protections against modification. 
When executing a CALL instruction, the processor pushes the return address to 
both the normal stack and to the special permission shadow stack. Upon RET, 
the processor pops the shadow stack copy and compares it to the normal stack 
copy. For more details, see the coverletter from v1 [0].

The changes for this version are some more cleanup of comment and commit log
verbiage, and small refactor in the memory accounting patch. There was also
some feedback from David Hildenbrand about adding GUP tests for the
!FOLL_FORCE case. This is currently planned for a fast follow on patch.

Previous version [1].

Thanks,
Rick


[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20230218211433.26859-1-rick.p.edgecombe@intel.com/

Kirill A. Shutemov (1):
  x86: Introduce userspace API for shadow stack

Mike Rapoport (1):
  x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (19):
  x86/fpu: Add helper for modifying xstate
  x86: Move control protection handler to separate file
  mm: Introduce pte_mkwrite_kernel()
  s390/mm: Introduce pmd_mkwrite_kernel()
  mm: Make pte_mkwrite() take a VMA
  x86/mm: Introduce _PAGE_SAVED_DIRTY
  x86/mm: Start actually marking _PAGE_SAVED_DIRTY
  x86/mm: Teach pte_mkwrite() about stack memory
  mm: Don't allow write GUPs to shadow stack memory
  x86/mm: Introduce MAP_ABOVE4G
  mm: Warn on shadow stack memory in wrong vma
  x86/mm: Warn if create Write=0,Dirty=1 with raw prot
  x86/shstk: Introduce map_shadow_stack syscall
  x86/shstk: Support WRSS for userspace
  x86: Expose thread features in /proc/$PID/status
  x86/shstk: Wire in shadow stack interface
  selftests/x86: Add shadow stack test
  x86/fpu: Add helper for initing features
  x86/shstk: Add ARCH_SHSTK_STATUS

Yu-cheng Yu (20):
  Documentation/x86: Add CET shadow stack description
  x86/shstk: Add Kconfig option for shadow stack
  x86/cpufeatures: Add CPU feature flags for shadow stacks
  x86/cpufeatures: Enable CET CR4 bit for shadow stack
  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
  x86/shstk: Add user control-protection fault handler
  x86/mm: Remove _PAGE_DIRTY from kernel RO pages
  x86/mm: Move pmd_write(), pud_write() up in the file
  x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
  mm: Move VM_UFFD_MINOR_BIT from 37 to 38
  mm: Introduce VM_SHADOW_STACK for shadow stack memory
  x86/mm: Check shadow stack page fault errors
  mm: Add guard pages around a shadow stack.
  mm/mmap: Add shadow stack pages to memory accounting
  mm: Re-introduce vm_flags to do_mmap()
  x86/shstk: Add user-mode shadow stack support
  x86/shstk: Handle thread shadow stack
  x86/shstk: Introduce routines modifying shstk
  x86/shstk: Handle signals for shadow stack
  x86: Add PTRACE interface for shadow stack

 Documentation/filesystems/proc.rst            |   1 +
 Documentation/mm/arch_pgtable_helpers.rst     |   9 +-
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/shstk.rst                   | 176 +++++
 arch/alpha/include/asm/pgtable.h              |   6 +-
 arch/arc/include/asm/hugepage.h               |   2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h     |   7 +-
 arch/arm/include/asm/pgtable-3level.h         |   7 +-
 arch/arm/include/asm/pgtable.h                |   2 +-
 arch/arm/kernel/signal.c                      |   2 +-
 arch/arm64/include/asm/pgtable.h              |   9 +-
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/arm64/mm/trans_pgd.c                     |   4 +-
 arch/csky/include/asm/pgtable.h               |   2 +-
 arch/hexagon/include/asm/pgtable.h            |   2 +-
 arch/ia64/include/asm/pgtable.h               |   2 +-
 arch/loongarch/include/asm/pgtable.h          |   4 +-
 arch/m68k/include/asm/mcf_pgtable.h           |   2 +-
 arch/m68k/include/asm/motorola_pgtable.h      |   6 +-
 arch/m68k/include/asm/sun3_pgtable.h          |   6 +-
 arch/microblaze/include/asm/pgtable.h         |   2 +-
 arch/mips/include/asm/pgtable.h               |   6 +-
 arch/nios2/include/asm/pgtable.h              |   2 +-
 arch/openrisc/include/asm/pgtable.h           |   2 +-
 arch/parisc/include/asm/pgtable.h             |   6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  |   2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  |   2 +-
 arch/riscv/include/asm/pgtable.h              |   6 +-
 arch/s390/include/asm/hugetlb.h               |   4 +-
 arch/s390/include/asm/pgtable.h               |  14 +-
 arch/s390/mm/pageattr.c                       |   4 +-
 arch/sh/include/asm/pgtable_32.h              |  10 +-
 arch/sparc/include/asm/pgtable_32.h           |   2 +-
 arch/sparc/include/asm/pgtable_64.h           |   6 +-
 arch/sparc/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal_64.c                 |   2 +-
 arch/um/include/asm/pgtable.h                 |   2 +-
 arch/x86/Kconfig                              |  24 +
 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |  16 +-
 arch/x86/include/asm/fpu/api.h                |   9 +
 arch/x86/include/asm/fpu/regset.h             |   7 +-
 arch/x86/include/asm/fpu/sched.h              |   3 +-
 arch/x86/include/asm/fpu/types.h              |  16 +-
 arch/x86/include/asm/fpu/xstate.h             |   6 +-
 arch/x86/include/asm/idtentry.h               |   2 +-
 arch/x86/include/asm/mmu_context.h            |   2 +
 arch/x86/include/asm/msr.h                    |  11 +
 arch/x86/include/asm/pgtable.h                | 322 +++++++-
 arch/x86/include/asm/pgtable_types.h          |  56 +-
 arch/x86/include/asm/processor.h              |   8 +
 arch/x86/include/asm/shstk.h                  |  40 +
 arch/x86/include/asm/special_insns.h          |  13 +
 arch/x86/include/asm/tlbflush.h               |   3 +-
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/asm/traps.h                  |  12 +
 arch/x86/include/uapi/asm/mman.h              |   4 +
 arch/x86/include/uapi/asm/prctl.h             |  12 +
 arch/x86/kernel/Makefile                      |   4 +
 arch/x86/kernel/cet.c                         | 152 ++++
 arch/x86/kernel/cpu/common.c                  |  35 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/proc.c                    |  23 +
 arch/x86/kernel/fpu/core.c                    |  59 +-
 arch/x86/kernel/fpu/regset.c                  |  86 +++
 arch/x86/kernel/fpu/xstate.c                  | 148 ++--
 arch/x86/kernel/fpu/xstate.h                  |   6 +
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/process.c                     |  18 +-
 arch/x86/kernel/process_64.c                  |   9 +-
 arch/x86/kernel/ptrace.c                      |  12 +
 arch/x86/kernel/shstk.c                       | 491 +++++++++++++
 arch/x86/kernel/signal.c                      |   1 +
 arch/x86/kernel/signal_32.c                   |   2 +-
 arch/x86/kernel/signal_64.c                   |   8 +-
 arch/x86/kernel/sys_x86_64.c                  |   6 +-
 arch/x86/kernel/traps.c                       |  87 ---
 arch/x86/mm/fault.c                           |  31 +
 arch/x86/mm/pat/set_memory.c                  |   4 +-
 arch/x86/mm/pgtable.c                         |  38 +
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/mmu_pv.c                         |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 arch/xtensa/include/asm/pgtable.h             |   2 +-
 fs/aio.c                                      |   2 +-
 fs/proc/array.c                               |   6 +
 fs/proc/task_mmu.c                            |   3 +
 include/asm-generic/hugetlb.h                 |   4 +-
 include/linux/mm.h                            |  46 +-
 include/linux/mman.h                          |   4 +
 include/linux/pgtable.h                       |  14 +
 include/linux/proc_fs.h                       |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |   2 +
 ipc/shm.c                                     |   2 +-
 kernel/sys_ni.c                               |   1 +
 mm/debug_vm_pgtable.c                         |  16 +-
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |   7 +-
 mm/hugetlb.c                                  |   4 +-
 mm/internal.h                                 |   8 +-
 mm/memory.c                                   |   5 +-
 mm/migrate_device.c                           |   2 +-
 mm/mmap.c                                     |  10 +-
 mm/mprotect.c                                 |   2 +-
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |   2 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 .../testing/selftests/x86/test_shadow_stack.c | 695 ++++++++++++++++++
 118 files changed, 2669 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

-- 
2.17.1

