Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D04641213
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiLCAga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbiLCAg3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:36:29 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0655F4EA3;
        Fri,  2 Dec 2022 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027788; x=1701563788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UExb0P455rgshLHt6GYI1t6rsa+B8lT8eGARn4e7l/I=;
  b=C2bx68riARE++8vncPuCZ+2R8c9173dMLMzWoj//m2s+8P0lSHQG9mSR
   c9b4/53UTfezYQZUiXcRDQgkP6Ln6E4kplUPPNT6VOfW6XWj22PK8gBXA
   kysc5b+AkAbKREJf4DvShiNjZJj+mWFDzxvx/H5QRtMjlVWLH+lgqTXaK
   FKLlz97bZdsgQCwXBzUt6Z9mC9qhHxuCqXy5Tljjv1FzvggALX04zm3Wv
   9DCwXDWMbia6NSPz1gAly0Zq4Pzg9VNpUwvcGOGMwdh5tU8j1NJGPisJD
   YYIiqcYZusWD+a6riwyrTlaIgtRu9htHK/pomW8mWcwd9D1/tlZ9jwjpA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313710614"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313710614"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479735"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479735"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:36:26 -0800
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
Subject: [PATCH v4 00/39] Shadow stacks for userspace
Date:   Fri,  2 Dec 2022 16:35:27 -0800
Message-Id: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series implements Shadow Stacks for userspace using x86's Control-flow 
Enforcement Technology (CET). CET consists of two related security features: 
Shadow Stacks and Indirect Branch Tracking. This series implements just the 
Shadow Stack part of this feature, and just for userspace.

The main use case for shadow stack is providing protection against return 
oriented programming attacks. It works by maintaining a secondary (shadow) 
stack using a special memory type that has protections against modification. 
When executing a CALL instruction, the processor pushes the return address to 
both the normal stack and to the special permissioned shadow stack. Upon RET, 
the processor pops the shadow stack copy and compares it to the normal stack 
copy. For more details, see the coverletter from v1 [0].


I humbly think this is looking decent at this point, please consider applying.

Again there were some smaller changes (logged in the patches). The more
noteworthy changes were:
 - Separate Shadow stack from IBT in kernel APIs. This involves renaming the
   arch_prctl()s. And changing the ptrace cet regset interface to only expose
   the SSP, and not any IBT bits.
 - Handle 32 bit case more completely. (see commit log of “x86: Prevent 32 bit
   operations for 64 bit shstk tasks” for the details)
 - Drop elf header bit filtering compatibility patch for now, per Linus. [1]
 - Break apart _PAGE_COW patch for bisectability reasons.

I left the Tested-by tags that were already in place, testers please re-test.

Previous version [2].

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com/
[2] https://lore.kernel.org/lkml/20221104223604.29615-1-rick.p.edgecombe@intel.com/

Kirill A. Shutemov (1):
  x86: Introduce userspace API for shadow stack

Mike Rapoport (1):
  x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (13):
  x86/fpu: Add helper for modifying xstate
  x86/mm: Introduce _PAGE_COW
  x86/mm: Start actually marking _PAGE_COW
  mm: Don't allow write GUPs to shadow stack memory
  mm: Warn on shadow stack memory in wrong vma
  x86/shstk: Introduce map_shadow_stack syscall
  x86/shstk: Support wrss for userspace
  x86: Expose thread features in /proc/$PID/status
  x86: Prevent 32 bit operations for 64 bit shstk tasks
  x86/shstk: Wire in shadow stack interface
  selftests/x86: Add shadow stack test
  x86/fpu: Add helper for initing features
  x86/shstk: Add ARCH_SHSTK_STATUS

Yu-cheng Yu (24):
  Documentation/x86: Add CET shadow stack description
  x86/shstk: Add Kconfig option for Shadow Stack
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
  x86/mm: Check Shadow Stack page fault errors
  x86/mm: Update maybe_mkwrite() for shadow stack
  mm: Fixup places that call pte_mkwrite() directly
  mm: Add guard pages around a shadow stack.
  mm/mmap: Add shadow stack pages to memory accounting
  mm/mprotect: Exclude shadow stack from preserve_write
  mm: Re-introduce vm_flags to do_mmap()
  x86/shstk: Add user-mode shadow stack support
  x86/shstk: Handle thread shadow stack
  x86/shstk: Introduce routines modifying shstk
  x86/shstk: Handle signals for shadow stack
  x86: Add PTRACE interface for shadow stack

 Documentation/filesystems/proc.rst            |   1 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/shstk.rst                   | 172 +++++
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
 arch/x86/include/asm/fpu/types.h              |  14 +-
 arch/x86/include/asm/fpu/xstate.h             |   6 +-
 arch/x86/include/asm/idtentry.h               |   2 +-
 arch/x86/include/asm/mmu_context.h            |   2 +
 arch/x86/include/asm/msr.h                    |  11 +
 arch/x86/include/asm/pgtable.h                | 320 +++++++-
 arch/x86/include/asm/pgtable_types.h          |  65 +-
 arch/x86/include/asm/processor.h              |   8 +
 arch/x86/include/asm/shstk.h                  |  52 ++
 arch/x86/include/asm/sighandling.h            |   1 +
 arch/x86/include/asm/special_insns.h          |  13 +
 arch/x86/include/asm/tlbflush.h               |   3 +-
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/uapi/asm/mman.h              |   3 +
 arch/x86/include/uapi/asm/prctl.h             |  12 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cpu/common.c                  |  37 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/proc.c                    |  23 +
 arch/x86/kernel/fpu/core.c                    |  60 +-
 arch/x86/kernel/fpu/regset.c                  |  87 +++
 arch/x86/kernel/fpu/xstate.c                  | 148 ++--
 arch/x86/kernel/fpu/xstate.h                  |   6 +
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/process.c                     |  18 +-
 arch/x86/kernel/process_64.c                  |   8 +
 arch/x86/kernel/ptrace.c                      |  12 +
 arch/x86/kernel/shstk.c                       | 495 +++++++++++++
 arch/x86/kernel/signal.c                      |  21 +
 arch/x86/kernel/signal_64.c                   |   6 +
 arch/x86/kernel/signal_compat.c               |   7 +-
 arch/x86/kernel/traps.c                       | 107 ++-
 arch/x86/mm/fault.c                           |  38 +
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pgtable.c                         |   6 +
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 fs/aio.c                                      |   2 +-
 fs/proc/array.c                               |   6 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |  57 +-
 include/linux/pgtable.h                       |  35 +
 include/linux/proc_fs.h                       |   2 +
 include/linux/ptrace.h                        |   1 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |   2 +
 ipc/shm.c                                     |   2 +-
 kernel/signal.c                               |   8 +
 kernel/sys_ni.c                               |   1 +
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |  20 +-
 mm/memory.c                                   |   7 +-
 mm/migrate_device.c                           |   4 +-
 mm/mmap.c                                     |  12 +-
 mm/mprotect.c                                 |   8 +
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |  10 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/test_shadow_stack.c | 685 ++++++++++++++++++
 78 files changed, 2560 insertions(+), 178 deletions(-)
 create mode 100644 Documentation/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

-- 
2.17.1

