Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC31072D592
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjFMAMK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFMAMJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:12:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEE118;
        Mon, 12 Jun 2023 17:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615127; x=1718151127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RORxlZ98Wl3mWbZNi923VEpw7M4OMlmyTjEorQJY3e4=;
  b=HAtQSG9gSk9giPvRjFfwRDQ/WKxD/JGiumTcwXI0MGX0fZbDTEDoXZq1
   W5k2fzEnv0Eoem8r8C/xqRc76HwODsINgWXD2bOvbvjVBy7lvtEAISNqx
   yOVgS7w8sSef/SGOWjXC9fRAKVgmpKDwf5zZSs1nVOgJyIMtNTXMQmb6e
   nV9rqPzqYMYXzZYUwyBgfvCvxy7ZIMnQ9hL3qyrOiJFFNEomYr0RdL0mv
   tF0SVYEMMdh+GAH1SjiQ0xIKF4BCmZN1kvbkT2dSpL/oqJ6okHMXNuH8A
   j6bXNaXe6BZOlcLEqSdyLcojWxBwglVExP26xLz3QELJ6srs2+cJEy9jq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361556629"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361556629"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835670963"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835670963"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:05 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v9 00/42] Shadow stacks for userspace 
Date:   Mon, 12 Jun 2023 17:10:26 -0700
Message-Id: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series implements Shadow Stacks for userspace using x86's Control-flow 
Enforcement Technology (CET). CET consists of two related security
features: shadow stacks and indirect branch tracking. This series
implements just the  shadow stack part of this feature, and just for
userspace.

The main use case for shadow stack is providing protection against return 
oriented programming attacks. It works by maintaining a secondary (shadow) 
stack using a special memory type that has protections against 
modification. When executing a CALL instruction, the processor pushes the 
return address to both the normal stack and to the special permission 
shadow stack. Upon RET, the processor pops the shadow stack copy and 
compares it to the normal stack copy. For more details, see the 
coverletter from v1 [0].

Shadow Stack was rejected by Linus for 6.4 [1][2]. This is a new version 
that addresses his concerns. In the months since the series was queued in 
tip, there were also some non-critical things that turned up, that I was 
planning do as fast follow ups. Since we are doing a re-spin, I thought to 
just include them in the initial series. (see 3 and 4) Also, the whole 
series has been re-ordered, after some comments from Linus prompted some 
reflection.

Most of the patches are the same, so I’ll specifically list the patches 
with changes to help focus review.

1. Redo of the pte_mkwrite() refactoring patches
------------------------------------------------
The point of these patches was to make pte_mkwrite() take a VMA. 
Unfortunately the original version of this refactor had a bug. Linus 
suggested an alternate way of doing the refactor that would be less error 
prone. It sounds like this will be used by the riscv and possibly arm 
shadow stack features. It would be great to collect some Reviewed-by tags 
on these from anyone else that would depend on them.

Changed (and renamed) patches:
	mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
	mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()
	mm: Make pte_mkwrite() take a VMA

2. SavedDirty overhaul
----------------------
The Shadow Stack PTEs are defined by the HW as Write=0,Dirty=1. Since 
Linux usually creates PTEs like that when it write-protects dirty memory, 
the series introduced a SavedDirty software bit. When a PTE gets 
write-protected the Dirty bit shifts to the SavedDirty bit so it won't
become shadow stack. When it is made writable, the opposite happens.

In the previously queued version, the SavedDirty bit was only used when 
shadow stack was configured and available on the CPU. But this created two 
versions of the Dirty bit behavior on x86, adding complexity. Linus 
objected to this, and also the use of conditional control flow logic 
instead of bit math. After some trial and error, I ended up with something 
that tries to incorporate the feedback, but with some adjustments on the 
specifics. I would like some feedback on the maintainability tradeoffs 
taken and some scrutiny on the correctness as well.


First of all, switching to bit math for the SavedDirty dance really seems 
to be a big improvement. The conditional part is now branchless and 
isolated to two functions. Descriptions of the other changes follows, and 
a little less of a clear win to me.


One thing that came up in this discussion was the performance impact of 
the CMPXCHG loop added to ptep_set_wrprotect() in order to atomically do 
the shift of Dirty to SavedDirty when a live PTE is being write-protected. 
The concern was that this could impact the performance of fork() where it 
is used to write-protect memory in the parent MM.

Linus had suggested to optimize the single threaded fork case to offset 
the concerns of a performance impact. However, trying to stress this case, 
I was unable to concoct a microbenchmark to show any slowdown of the LOCK 
CMPXCHG loop vs the original LOCK AND. Hypothetically the CMPXCHG could 
scale worse, but since I couldn’t actually entice it to show any slowdown, 
I was thinking that the original worries might have been misplaced and we 
could get away with the unconditional CMPXCHG loop.

As Dave previously mentioned, the other wrinkle in all of this is that on 
CPUs that don’t support shadow stack, a CPU could rarely set Dirty=1 on a 
PTE with Write=0. So the kernel logic needs to be robust to PTEs that have 
Write=0,Dirty=1 PTEs in non-shadow stack cases on these CPUs. And also 
should be able to handle Write=0,Dirty=1,SavedDirty=1 PTEs. Similarly, a 
KNL (Xeon Phi platform) erratum can result in Dirty=1 bits getting set on 
Present=0 PTEs.

In order to make the core-MM logic work correctly with shadow stack, 
pte_write() needs to also return true for Write=0,Dirty=1 memory. Since 
those older platforms can cause Dirty=1,Write=0 PTEs despite the kernels 
efforts to not create any itself, the kernel can’t have this shadow stack 
pte_write() logic when running on them. So the kernel can only check for 
shadow stack memory in pte_write() when shadow stack is supported by the 
CPU. Also, the kernel needs to make sure to not trigger any warnings when 
it sees a Dirty=0,Write=1 PTE in an unexpected place. So these are also 
only done when shadow stack is supported on the CPU. These checks are 
isolated to single place in pte_shstk().

So in the end, we can shift the Dirty bit around unconditionally, but the 
kernels behavior around the Dirty bit still needs to adjust depending on 
the CPU actually supporting shadow stack.

Refactoring the SavedDirty<->Dirty setting logic into bitmath made it so 
it would be a lot easier to compile the SavedDirty bit out if needed. 
Basically it can be removed with only two checks in 
mksaveddirty_shift()/clear_saveddirty_shift() (see “x86/mm: Introduce 
_PAGE_SAVED_DIRTY”).

That all makes me wonder if it would still be better to disable SavedDirty 
when shadow stack is not supported. One aspect of the idea to make 
SavedDirty  unconditional, was to unify the sets of rules to have to 
reason about. But due to the behavior of the pre-shadow stack CPUs, this 
also comes at the increased runtime behaviors we need to worry about. The 
other point brought up was the increased testing of having SavedDirty used 
more widely. But since we have to turn off the warnings and other logic, 
this testing isn’t fully happening on these older platforms either. So I’m 
not sure if the unconditional SavedDirty is really a win or not. I thought 
it was slightly.

So in this version SavedDirty is turned on universally for x86. Even for 
32 bit, which, while seeming a bit silly, allows there to be only one 
version of the ptep_set_wrprotect() logic.

Changed patches:
	x86/mm: Start actually marking _PAGE_SAVED_DIRTY
	x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
	x86/mm: Introduce _PAGE_SAVED_DIRTY
	mm: Warn on shadow stack memory in wrong vma
	x86/mm: Warn if create Write=0,Dirty=1 with raw prot

3. Shadow stack protections enhancements
----------------------------------------
The shadow stack signal frame format uses a special shadow stack frame 
pattern that should not occur naturally in order to avoid forgery on 
sigreturn. Two patches are added to strengthen the forgery checks. These 
could have been squashed into the signal patch, but I thought leaving them 
separate might make review easier for those familiar with the last series. 
I was waffling on whether to postpone them to minimize changes from the 
previously queued changed to v9. In the end, as long as the series was 
already getting re-spun, I thought the extra protections were worth 
starting with.

The new mmap maple tree code needs to be taught specifically about 
VM_SHADOW_STACK, instead of just relying on vm_start_gap() like the old RB 
stuff, so that is added as well to retain the start guard gap with maple
tree.

Added/changes patches:
	x86/shstk: Check that SSP is aligned on sigreturn
	x86/shstk: Check that signal frame is shadow stack mem
	mm: Add guard pages around a shadow stack

4. Selftest enhancements
------------------------
A few miscellaneous selftest enhancements that accumulated since the old 
series landed in tip. Added a test for the shadow stack guard gap and the 
shadow stack ptrace interface. Also fixed a race that caused the uffd test 
to sometimes hang.

Changed patches:
	selftests/x86: Add shadow stack test

Since some of the changes were extensive in the modified patches, I 
dropped some review tags. But I left testing tags, testers please retest.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/CAHk-=wiuVXTfgapmjYQvrEDzn3naF2oYnHuky+feEJSj_G_yFQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAHk-=wiB0wy6oXOsPtYU4DSbqJAY8z5iNBKdjdOp2LP23khUoA@mail.gmail.com/

Mike Rapoport (1):
  x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (38):
  mm: Rename arch pte_mkwrite()'s to pte_mkwrite_novma()
  mm: Move pte/pmd_mkwrite() callers with no VMA to _novma()
  mm: Make pte_mkwrite() take a VMA
  x86/shstk: Add Kconfig option for shadow stack
  x86/traps: Move control protection handler to separate file
  x86/cpufeatures: Add CPU feature flags for shadow stacks
  x86/mm: Move pmd_write(), pud_write() up in the file
  x86/mm: Introduce _PAGE_SAVED_DIRTY
  x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
  x86/mm: Start actually marking _PAGE_SAVED_DIRTY
  x86/mm: Remove _PAGE_DIRTY from kernel RO pages
  x86/mm: Check shadow stack page fault errors
  mm: Add guard pages around a shadow stack.
  mm: Warn on shadow stack memory in wrong vma
  x86/mm: Warn if create Write=0,Dirty=1 with raw prot
  mm/mmap: Add shadow stack pages to memory accounting
  x86/mm: Introduce MAP_ABOVE4G
  x86/mm: Teach pte_mkwrite() about stack memory
  mm: Don't allow write GUPs to shadow stack memory
  Documentation/x86: Add CET shadow stack description
  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
  x86/fpu: Add helper for modifying xstate
  x86: Introduce userspace API for shadow stack
  x86/shstk: Add user control-protection fault handler
  x86/shstk: Add user-mode shadow stack support
  x86/shstk: Handle thread shadow stack
  x86/shstk: Introduce routines modifying shstk
  x86/shstk: Handle signals for shadow stack
  x86/shstk: Check that SSP is aligned on sigreturn
  x86/shstk: Check that signal frame is shadow stack mem
  x86/shstk: Introduce map_shadow_stack syscall
  x86/shstk: Support WRSS for userspace
  x86: Expose thread features in /proc/$PID/status
  x86/shstk: Wire in shadow stack interface
  x86/cpufeatures: Enable CET CR4 bit for shadow stack
  selftests/x86: Add shadow stack test
  x86: Add PTRACE interface for shadow stack
  x86/shstk: Add ARCH_SHSTK_STATUS

Yu-cheng Yu (3):
  mm: Re-introduce vm_flags to do_mmap()
  mm: Move VM_UFFD_MINOR_BIT from 37 to 38
  mm: Introduce VM_SHADOW_STACK for shadow stack memory

 Documentation/arch/x86/index.rst              |   1 +
 Documentation/arch/x86/shstk.rst              | 179 ++++
 Documentation/filesystems/proc.rst            |   1 +
 Documentation/mm/arch_pgtable_helpers.rst     |  12 +-
 arch/Kconfig                                  |   3 +
 arch/alpha/include/asm/pgtable.h              |   2 +-
 arch/arc/include/asm/hugepage.h               |   2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h     |   2 +-
 arch/arm/include/asm/pgtable-3level.h         |   2 +-
 arch/arm/include/asm/pgtable.h                |   2 +-
 arch/arm/kernel/signal.c                      |   2 +-
 arch/arm64/include/asm/pgtable.h              |   4 +-
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/arm64/mm/trans_pgd.c                     |   4 +-
 arch/csky/include/asm/pgtable.h               |   2 +-
 arch/hexagon/include/asm/pgtable.h            |   2 +-
 arch/ia64/include/asm/pgtable.h               |   2 +-
 arch/loongarch/include/asm/pgtable.h          |   4 +-
 arch/m68k/include/asm/mcf_pgtable.h           |   2 +-
 arch/m68k/include/asm/motorola_pgtable.h      |   2 +-
 arch/m68k/include/asm/sun3_pgtable.h          |   2 +-
 arch/microblaze/include/asm/pgtable.h         |   2 +-
 arch/mips/include/asm/pgtable.h               |   6 +-
 arch/nios2/include/asm/pgtable.h              |   2 +-
 arch/openrisc/include/asm/pgtable.h           |   2 +-
 arch/parisc/include/asm/pgtable.h             |   2 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h  |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h  |   4 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  |   4 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  |   2 +-
 arch/riscv/include/asm/pgtable.h              |   6 +-
 arch/s390/include/asm/hugetlb.h               |   2 +-
 arch/s390/include/asm/pgtable.h               |   4 +-
 arch/s390/mm/pageattr.c                       |   4 +-
 arch/sh/include/asm/pgtable_32.h              |   4 +-
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
 arch/x86/include/asm/pgtable.h                | 302 +++++-
 arch/x86/include/asm/pgtable_types.h          |  46 +-
 arch/x86/include/asm/processor.h              |   8 +
 arch/x86/include/asm/shstk.h                  |  38 +
 arch/x86/include/asm/special_insns.h          |  13 +
 arch/x86/include/asm/tlbflush.h               |   3 +-
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/asm/traps.h                  |  12 +
 arch/x86/include/uapi/asm/mman.h              |   4 +
 arch/x86/include/uapi/asm/prctl.h             |  12 +
 arch/x86/kernel/Makefile                      |   4 +
 arch/x86/kernel/cet.c                         | 152 +++
 arch/x86/kernel/cpu/common.c                  |  35 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/proc.c                    |  23 +
 arch/x86/kernel/fpu/core.c                    |  54 +-
 arch/x86/kernel/fpu/regset.c                  |  81 ++
 arch/x86/kernel/fpu/xstate.c                  |  90 +-
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/process.c                     |  21 +-
 arch/x86/kernel/process_64.c                  |   8 +
 arch/x86/kernel/ptrace.c                      |  12 +
 arch/x86/kernel/shstk.c                       | 529 +++++++++++
 arch/x86/kernel/signal.c                      |   1 +
 arch/x86/kernel/signal_32.c                   |   2 +-
 arch/x86/kernel/signal_64.c                   |   8 +-
 arch/x86/kernel/sys_x86_64.c                  |   6 +-
 arch/x86/kernel/traps.c                       |  87 --
 arch/x86/mm/fault.c                           |  22 +
 arch/x86/mm/pat/set_memory.c                  |   4 +-
 arch/x86/mm/pgtable.c                         |  40 +
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/mmu_pv.c                         |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 arch/xtensa/include/asm/pgtable.h             |   2 +-
 fs/aio.c                                      |   2 +-
 fs/proc/array.c                               |   6 +
 fs/proc/task_mmu.c                            |   3 +
 include/asm-generic/hugetlb.h                 |   2 +-
 include/linux/mm.h                            |  67 +-
 include/linux/mman.h                          |   4 +
 include/linux/pgtable.h                       |  28 +
 include/linux/proc_fs.h                       |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |   2 +
 ipc/shm.c                                     |   2 +-
 kernel/sys_ni.c                               |   1 +
 mm/debug_vm_pgtable.c                         |  12 +-
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |  11 +-
 mm/internal.h                                 |   4 +-
 mm/memory.c                                   |   5 +-
 mm/migrate.c                                  |   2 +-
 mm/migrate_device.c                           |   2 +-
 mm/mmap.c                                     |  14 +-
 mm/mprotect.c                                 |   2 +-
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |   2 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   2 +-
 .../testing/selftests/x86/test_shadow_stack.c | 884 ++++++++++++++++++
 117 files changed, 2789 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/arch/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

-- 
2.34.1

