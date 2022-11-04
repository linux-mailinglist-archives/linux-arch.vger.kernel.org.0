Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2E361A428
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKDWjY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKDWjX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:39:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69098D5F;
        Fri,  4 Nov 2022 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601562; x=1699137562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EOYT0vuz7XHRWe+Redde381AH312EMRniui4mw/0G/E=;
  b=Y6bftg2ZflfNX2JVc9eZW4T+I8gH5k6Tm2EH9/6cvO2AF9mdXwJVKt8b
   C+GnK7gFEBdMJhnQB3tCzE6GfdJIzV9DHpAjDItjnEoGZDMjF6tRCs+hl
   8l9I8gvCF0iOdiytuyNYqe/vf4trTfhR+8HQp+oP/1Ph0nDHF+tjY+KE/
   H1bGVV4CIL1JOoxuK+r6qutkLd1rJo7o5h3a4ZvNMDqf01/F/U4dHs4k2
   1LvhlOvFaUoKYrVbTyakke4E2pdVd2Gv6UmLjjJQ/ajvdT0/oacxDpzGJ
   iyXD6X6xPl5NtIWFNyGwXhFZKyKrqIpt53qhManoywcBlghKB/ayCjREG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840468"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840468"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668513906"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668513906"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:21 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v3 00/37] Shadow stacks for userspace
Date:   Fri,  4 Nov 2022 15:35:27 -0700
Message-Id: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This series implements Shadow Stacks for userspace using x86's Control-flow 
enforcement technology (CET). CET consists of two related security features: 
Shadow Stacks and Indirect Branch Tracking. This series implements just the 
Shadow Stack part of this feature, and just for userspace.

The main use case for shadow stack is providing protection against return 
oriented programming attacks. It works by maintaining a secondary (shadow) 
stack using a special memory type that has protections against modification. 
When executing a CALL instruction, the processor pushes the return address to 
both the normal stack and to the special permissioned shadow stack. Upon RET, 
the processor pops the shadow stack copy and compares it to the normal stack 
copy. For more details, see the coverletter from v1 [0].

Thanks to all the reviewers of v2 [1]. There was a lot of very helpful 
feedback. For v3 there are a lot of small changes, but not really any big ones. 
I think the only remaining unresolved big issue is what to do about the 
existing binaries that will fail if glibc is updated to utilize the shadow 
stack kernel support. I am honestly not sure what is the right way forward. 
More discussion on this below.

Other notable changes were:
 - Dropping sigaltshstk support. It sounded like this could be a future
   enhancement.
 - Remove AMD patch (Thanks for Tested-by from John Allen)
 - Promote ptrace/criu patches from OPTIONAL. If we might not have a new shadow
   stack bit on day 1, we should give ptrace users something to work with.
 - Detangle arch_prctl() numbers from LAM
   
Smaller changes are in the patches after the break.

This is off of v6.1-rc3 and this cleanup series [2]. Find the full tree here 
[3].


Existing package compatibility problems
=======================================

This feature has a history of compatibility issues with existing userspace due 
to the userspace enabling landing upstream ahead of the kernel support. The 
first major issue encountered was the classic bad kernel regression - that some 
existing distros would fail to boot on CET enabled kernels. This was due to 
upstream glibc targeting an old abandoned CET kernel interface. It was resolved 
with v1 of this series by switching the kernel enabling interface so old glibc 
can’t find it, and is no longer an issue.

However there are still some lesser compatibility issues that are worth 
discussing, and possibly help avoid on the kernel's side. These are around apps 
being marked as shadow stack compatible when they actually are not.

When a binary is compatible with shadow stack it is supposed to be marked with 
a specific elf bit . The design of the shadow stack implementation is that 
glibc will detect this bit, and call kernel APIs to enable shadow stack.

Upstream glibc does not yet know how to do this. So the kernel’s shadow stack 
implementation, and any compatibility issues, will remain dormant until these 
CET glibc changes make it there. But many application binaries with the bit 
marked exist today, and critically, it was applied widely and automatically by 
some popular distro builds without verification that the packages actually 
support shadow stack. So when glibc is updated, shadow stack will suddenly turn 
on very widely with some missing verification.

In an ideal world this would be ok, because glibc has resolved many of the 
shadow stack violating conditions internally. So as long as apps stick to the 
normal usage of the glibc implementations for doing exotic stack things, then 
apps *should* just work. However, in the real world there are apps that don't 
stick to this. Especially JITs can violate the shadow stack enforcement.

In internal testing we have found one popular package, node.js, crashes on 
startup. It's unknown how many other apps would crash with more complicated 
usage than a basic startup test. My assumption is that there are more that 
would.

The other compatibility issue that comes from the widespread presence of this 
elf bit, is ptrace using applications. Some like, CRIU, do unusual 
shadow-stack-violating things to the seized process as part of basic operation. 
So while the application may not have issues in itself, they run into trouble 
working with shadow stack enabled tracees. Others, like GDB, would fail when 
doing some limited specific things like the "call a function" operation. While 
it’s not unusual to have a new feature break saving and restoring an individual 
target app, it is a bit unusual to have a new feature break CRIU usage for most 
apps on the system. The kernel changes required for a fixed CRIU and GDB are 
included in this series, but the userspace fixes are not upstream.


Blocking CET for the existing binaries
======================================

So we are not talking about a traditional kernel regression, where a fresh 
kernel update breaks userspace. Instead we are talking about a userspace 
component choosing to break existing apps by using new kernel functionality. 
I’m not sure if it is the kernel’s job to stop this or not. But the kernel 
actually could. It could detect the shadow stack elf bit and then later return 
failure for the APIs that enable shadow stack. This would result in these apps 
simply running normally without shadow stack.

Florian Weimer points out that this is a bit nasty, and I have to agree. I 
think the workaround for this belongs in glibc. The best thing would be to pick 
a new elf bit and have glibc look for this new one instead when deciding to 
call the kernel shadow stack APIs. Then the old binaries could continue to work 
without shadow stack, and new, more highly tested ones could be marked with the 
new bit. Since there would then be kernel support and also there is a lot of 
supporting HW out there, any CET enabling issues would be caught much earlier 
when starting over with a new bit. So you could have a normal slow rollout 
instead of a big bang.

But it doesn’t seem like the glibc developers are interested in working on a 
solution. So I included a patch to do the detection and disable on the kernel 
side and marked it RFC.

Distro’s could easily remove any kernel side check, and they can also fix 
userspace regressions with package updates, or even before they turn on shadow 
stack for their kernels. So we are talking about protecting users who will want 
to use bleeding edge kernels and glibcs they build themselves. Probably not the 
biggest category of users, but a helpful one to upstream developers.

This RFC patch also includes the ability for the kernel to allow broken 
binaries by Kconfig, gated by CONFIG_EXPERT. So with this kernel patch, a user 
who wants to try out CET would end up reading the Kconfig option and 
understanding the situation before encountering breakage. But having this 
release valve also is less of a forcing function to drive creation of a new elf 
bit. So if that never happens, allowing broken binaries (ones with the existing 
elf bit) would probably eventually have to become the default.

Another option might be a sysctl knob to toggle allowing these binaries instead 
of a Kconfig option.

[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/20220929222936.14584-1-rick.p.edgecombe@intel.com/
[2] https://lore.kernel.org/lkml/20221021221803.10910-1-rick.p.edgecombe@intel.com/
[3] https://github.com/rpedgeco/linux/tree/user_shstk_v3


Kirill A. Shutemov (1):
  x86: Introduce userspace API for CET enabling

Mike Rapoport (1):
  x86/cet/shstk: Add ARCH_CET_UNLOCK

Rick Edgecombe (10):
  x86/fpu: Add helper for modifying xstate
  mm: Don't allow write GUPs to shadow stack memory
  mm: Warn on shadow stack memory in wrong vma
  x86/shstk: Introduce map_shadow_stack syscall
  x86/shstk: Support wrss for userspace
  x86: Expose thread features in /proc/$PID/status
  x86/cet/shstk: Wire in CET interface
  selftests/x86: Add shadow stack test
  x86/fpu: Add helper for initing features
  fs/binfmt_elf: Block old shstk elf bit

Yu-cheng Yu (25):
  Documentation/x86: Add CET description
  x86/cet/shstk: Add Kconfig option for Shadow Stack
  x86/cpufeatures: Add CPU feature flags for shadow stacks
  x86/cpufeatures: Enable CET CR4 bit for shadow stack
  x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
  x86/cet: Add user control-protection fault handler
  x86/mm: Remove _PAGE_DIRTY from kernel RO pages
  x86/mm: Move pmd_write(), pud_write() up in the file
  x86/mm: Introduce _PAGE_COW
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
  x86/cet: Add PTRACE interface for CET

 Documentation/filesystems/proc.rst            |   1 +
 Documentation/x86/cet.rst                     | 151 +++++
 Documentation/x86/index.rst                   |   1 +
 arch/arm/kernel/signal.c                      |   2 +-
 arch/arm64/include/asm/elf.h                  |   5 +
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal_64.c                 |   2 +-
 arch/x86/Kconfig                              |  37 ++
 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 arch/x86/ia32/ia32_signal.c                   |   1 +
 arch/x86/include/asm/cet.h                    |  42 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/disabled-features.h      |  17 +-
 arch/x86/include/asm/elf.h                    |  11 +
 arch/x86/include/asm/fpu/api.h                |   9 +
 arch/x86/include/asm/fpu/regset.h             |   7 +-
 arch/x86/include/asm/fpu/sched.h              |   3 +-
 arch/x86/include/asm/fpu/types.h              |  14 +-
 arch/x86/include/asm/fpu/xstate.h             |   6 +-
 arch/x86/include/asm/idtentry.h               |   2 +-
 arch/x86/include/asm/mmu_context.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/msr.h                    |  11 +
 arch/x86/include/asm/pgtable.h                | 321 ++++++++--
 arch/x86/include/asm/pgtable_types.h          |  65 +-
 arch/x86/include/asm/processor.h              |   9 +
 arch/x86/include/asm/special_insns.h          |  13 +
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/uapi/asm/mman.h              |   3 +
 arch/x86/include/uapi/asm/prctl.h             |  11 +
 arch/x86/kernel/Makefile                      |   2 +
 arch/x86/kernel/cpu/common.c                  |  35 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/cpu/proc.c                    |  23 +
 arch/x86/kernel/fpu/core.c                    |  60 +-
 arch/x86/kernel/fpu/regset.c                  |  90 +++
 arch/x86/kernel/fpu/xstate.c                  | 148 +++--
 arch/x86/kernel/fpu/xstate.h                  |   6 +
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/process.c                     |  18 +-
 arch/x86/kernel/process_64.c                  |  41 +-
 arch/x86/kernel/ptrace.c                      |  20 +
 arch/x86/kernel/shstk.c                       | 499 +++++++++++++++
 arch/x86/kernel/signal.c                      |   7 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 arch/x86/kernel/traps.c                       | 107 +++-
 arch/x86/mm/fault.c                           |  26 +
 arch/x86/mm/mmap.c                            |  23 +
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/mm/pgtable.c                         |   6 +
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 fs/aio.c                                      |   2 +-
 fs/binfmt_elf.c                               |  24 +-
 fs/proc/array.c                               |   6 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/elf.h                           |   6 +
 include/linux/mm.h                            |  37 +-
 include/linux/pgtable.h                       |  35 ++
 include/linux/proc_fs.h                       |   2 +
 include/linux/syscalls.h                      |   1 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |  16 +
 ipc/shm.c                                     |   2 +-
 kernel/sys_ni.c                               |   1 +
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |  19 +-
 mm/memory.c                                   |   7 +-
 mm/migrate_device.c                           |   4 +-
 mm/mmap.c                                     |  19 +-
 mm/mprotect.c                                 |   7 +
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |  10 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/test_shadow_stack.c | 574 ++++++++++++++++++
 80 files changed, 2502 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/x86/cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

-- 
2.17.1

