Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6E674452
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjASVbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjASV3Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:29:16 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436CEA5CFE;
        Thu, 19 Jan 2023 13:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163449; x=1705699449;
  h=from:to:cc:subject:date:message-id;
  bh=KeghPjHYUOp2vxEfBJ4+MNk/QB9fTnQp/kAL+jxFnkc=;
  b=EG+G0Oq99FhhN5UGqQPnEoxm3iXKvDFP3RugfPsi+Se0V9ktIzJHNAAS
   gZyICg6WYA5ExYU7rzSJR0+bDQ5j8Zhkd72Lhz0r2v1sRfipRe54/ekOr
   0l+IDcdBFEqYWoSF+nQOIJ++eBBy8TfywodNXqAsu2LKi9D8Vm+MBEyz0
   sSPZgDdtereIsRGDmV56B20yoIfYeM/+WrRrd/BmXlNBfV+1Ef5xug16Z
   cdYhVvjECBVQKD2jx+IIWZ3MB/dzrIRE7qDIvcKarguT6JDloa6fRObWG
   /csQIwGHI5TGdg1R/lAFXDJLZNd4InXjBuqVhfoBaoaVtgtbmfc9ldDoi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119137"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119137"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989138978"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989138978"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:23 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v5 00/39] Shadow stacks for userspace
Date:   Thu, 19 Jan 2023 13:22:38 -0800
Message-Id: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

The main change in this version is the removal of the attempt to prevent 32 bit 
signals from being registered with shadow stack enabled. Peterz originally 
raised the issue that shadow stack support in 32 bit signals was in a half 
working state. The reason for that was 32 bit signals are not easy to support 
for shadow stack, and also there is not a huge demand for shadow stack support 
in 32 bit apps using 32 bit emulation on 64 bit kernels. At that point the 
solution was to prevent shadow stack from being enabled on 32 bit processes. 
But Peterz pointed that 64 bit apps can transition to 32 bit outside of kernel
interaction by making a far call to a 32 bit segment.

So the next solution was to prevent 32 bit signals from being registered when
shadow stack was enabled. This turned out to be hard to do, due to signals
being per-process and shadow stack being per task.

But it turns out this far call scenario was already mostly not possible due to 
the HW not supporting shadow stacks located outside of the 32 bit address space 
when in 32 bit mode. During the transition to 32 bit mode with an SSP pointing 
outside of the 32 bit address space, HW generates a #GP which in turn triggers 
a segfault. So basically there is already a barrier in place for this far call 
scenario for the most part. Creation of shadow stack memory is tightly 
controlled, so the solution in this version is just to *ensure* that shadow 
stacks can never be allocated in the 32 bit address space. For more information 
see the new patch: "x86/mm: Introduce MAP_ABOVE4G", and the documentation in 
patch 1.

Additionally:
 - A smattering of small changes from Boris and Kees
 - Fixed my spellcheck setup and then fixed a bunch of spelling issues in the
   commit logs.
 - An update to the pte_modify() PAGE_COW solution
 
I left tested-by tags in place per discussion with testers. Testers, please
retest.

Previous version [1].

[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20221203003606.6838-1-rick.p.edgecombe@intel.com/

Kirill A. Shutemov (1):
  x86: Introduce userspace API for shadow stack

Mike Rapoport (1):
  x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (14):
  x86/fpu: Add helper for modifying xstate
  x86/mm: Introduce _PAGE_COW
  x86/mm: Start actually marking _PAGE_COW
  mm: Handle faultless write upgrades for shstk
  mm: Don't allow write GUPs to shadow stack memory
  x86/mm: Introduce MAP_ABOVE4G
  mm: Warn on shadow stack memory in wrong vma
  x86/shstk: Introduce map_shadow_stack syscall
  x86/shstk: Support WRSS for userspace
  x86: Expose thread features in /proc/$PID/status
  x86/shstk: Wire in shadow stack interface
  selftests/x86: Add shadow stack test
  x86/fpu: Add helper for initing features
  x86/shstk: Add ARCH_SHSTK_STATUS

Yu-cheng Yu (23):
  Documentation/x86: Add CET shadow stack description
  x86/shstk: Add Kconfig option for shadow stack
  x86/cpufeatures: Add CPU feature flags for shadow stacks
  x86/cpufeatures: Enable CET CR4 bit for shadow stack
  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
  x86: Add user control-protection fault handler
  x86/mm: Remove _PAGE_DIRTY from kernel RO pages
  x86/mm: Move pmd_write(), pud_write() up in the file
  x86/mm: Update pte_modify for _PAGE_COW
  x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
    transition from _PAGE_DIRTY to _PAGE_COW
  mm: Move VM_UFFD_MINOR_BIT from 37 to 38
  mm: Introduce VM_SHADOW_STACK for shadow stack memory
  x86/mm: Check shadow stack page fault errors
  x86/mm: Update maybe_mkwrite() for shadow stack
  mm: Fixup places that call pte_mkwrite() directly
  mm: Add guard pages around a shadow stack.
  mm/mmap: Add shadow stack pages to memory accounting
  mm: Re-introduce vm_flags to do_mmap()
  x86/shstk: Add user-mode shadow stack support
  x86/shstk: Handle thread shadow stack
  x86/shstk: Introduce routines modifying shstk
  x86/shstk: Handle signals for shadow stack
  x86: Add PTRACE interface for shadow stack

 Documentation/filesystems/proc.rst            |   1 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/shstk.rst                   | 176 +++++
 arch/arm/kernel/signal.c                      |   2 +-
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal_64.c                 |   2 +-
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
 arch/x86/include/asm/pgtable.h                | 338 ++++++++-
 arch/x86/include/asm/pgtable_types.h          |  65 +-
 arch/x86/include/asm/processor.h              |   8 +
 arch/x86/include/asm/shstk.h                  |  40 ++
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
 arch/x86/kernel/fpu/regset.c                  |  87 +++
 arch/x86/kernel/fpu/xstate.c                  | 148 ++--
 arch/x86/kernel/fpu/xstate.h                  |   6 +
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/process.c                     |  18 +-
 arch/x86/kernel/process_64.c                  |   9 +-
 arch/x86/kernel/ptrace.c                      |  12 +
 arch/x86/kernel/shstk.c                       | 492 +++++++++++++
 arch/x86/kernel/signal.c                      |   1 +
 arch/x86/kernel/signal_32.c                   |   2 +-
 arch/x86/kernel/signal_64.c                   |   8 +-
 arch/x86/kernel/sys_x86_64.c                  |   6 +-
 arch/x86/kernel/traps.c                       |  87 ---
 arch/x86/mm/fault.c                           |  38 +
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pgtable.c                         |   6 +
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 fs/aio.c                                      |   2 +-
 fs/proc/array.c                               |   6 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |  59 +-
 include/linux/mman.h                          |   4 +
 include/linux/pgtable.h                       |  35 +
 include/linux/proc_fs.h                       |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |   2 +
 ipc/shm.c                                     |   2 +-
 kernel/sys_ni.c                               |   1 +
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |  12 +-
 mm/memory.c                                   |   7 +-
 mm/migrate_device.c                           |   4 +-
 mm/mmap.c                                     |  12 +-
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |  10 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/test_shadow_stack.c | 667 ++++++++++++++++++
 78 files changed, 2578 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

-- 
2.17.1

