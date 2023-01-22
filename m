Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6630A676B94
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjAVIUo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Jan 2023 03:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAVIUn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Jan 2023 03:20:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFF5595;
        Sun, 22 Jan 2023 00:20:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9583A60B65;
        Sun, 22 Jan 2023 08:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8002C433EF;
        Sun, 22 Jan 2023 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674375640;
        bh=m4H80+TIF4duNDh4EgU1la2WrEseSp4CLGoM7x1IKUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6hKozL6nvfWd0+VUczs21N/LNXiWPDq6tbHswzRA5Hit6J98G/dY0zntw2Eorog1
         7UE1/8hIlXjS8dv+1Haa8dr5cNAcOk40AvTWrmu2AbOFnovnURb+B7BzNyIzkRcj5P
         3Swd61dO2A4XfRzZVpA/BbxwjjzpaB2CzlsbAObbzf7o1kcGtYFSdFbn+jmBFj2Xdl
         6go9Z1GXo967Er7lud3k8tmYs/sB+g9VnlQyHwhZErWJLZsL9Zhghct26OASG6AcOg
         PWayv+kxIMbsVQ9xiwcxJl5bRM0QCKMxGJtjOMSorl6dVutRWIdCpnat/TNRKtK5hN
         r6NWCdllHUktg==
Date:   Sun, 22 Jan 2023 10:20:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        eranian@google.com, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v5 00/39] Shadow stacks for userspace
Message-ID: <Y8zxy4uVId8xlY1G@kernel.org>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 19, 2023 at 01:22:38PM -0800, Rick Edgecombe wrote:
> Hi,
> 
> This series implements Shadow Stacks for userspace using x86's Control-flow 
> Enforcement Technology (CET). CET consists of two related security features: 
> shadow stacks and indirect branch tracking. This series implements just the 
> shadow stack part of this feature, and just for userspace.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> Previous version [1].
> 
> [0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
> [1] https://lore.kernel.org/lkml/20221203003606.6838-1-rick.p.edgecombe@intel.com/
> 
> Kirill A. Shutemov (1):
>   x86: Introduce userspace API for shadow stack
> 
> Mike Rapoport (1):
>   x86/shstk: Add ARCH_SHSTK_UNLOCK
> 
> Rick Edgecombe (14):
>   x86/fpu: Add helper for modifying xstate
>   x86/mm: Introduce _PAGE_COW
>   x86/mm: Start actually marking _PAGE_COW
>   mm: Handle faultless write upgrades for shstk
>   mm: Don't allow write GUPs to shadow stack memory
>   x86/mm: Introduce MAP_ABOVE4G
>   mm: Warn on shadow stack memory in wrong vma
>   x86/shstk: Introduce map_shadow_stack syscall
>   x86/shstk: Support WRSS for userspace
>   x86: Expose thread features in /proc/$PID/status
>   x86/shstk: Wire in shadow stack interface
>   selftests/x86: Add shadow stack test
>   x86/fpu: Add helper for initing features
>   x86/shstk: Add ARCH_SHSTK_STATUS
> 
> Yu-cheng Yu (23):
>   Documentation/x86: Add CET shadow stack description
>   x86/shstk: Add Kconfig option for shadow stack
>   x86/cpufeatures: Add CPU feature flags for shadow stacks
>   x86/cpufeatures: Enable CET CR4 bit for shadow stack
>   x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
>   x86: Add user control-protection fault handler
>   x86/mm: Remove _PAGE_DIRTY from kernel RO pages
>   x86/mm: Move pmd_write(), pud_write() up in the file
>   x86/mm: Update pte_modify for _PAGE_COW
>   x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
>     transition from _PAGE_DIRTY to _PAGE_COW
>   mm: Move VM_UFFD_MINOR_BIT from 37 to 38
>   mm: Introduce VM_SHADOW_STACK for shadow stack memory
>   x86/mm: Check shadow stack page fault errors
>   x86/mm: Update maybe_mkwrite() for shadow stack
>   mm: Fixup places that call pte_mkwrite() directly
>   mm: Add guard pages around a shadow stack.
>   mm/mmap: Add shadow stack pages to memory accounting
>   mm: Re-introduce vm_flags to do_mmap()
>   x86/shstk: Add user-mode shadow stack support
>   x86/shstk: Handle thread shadow stack
>   x86/shstk: Introduce routines modifying shstk
>   x86/shstk: Handle signals for shadow stack
>   x86: Add PTRACE interface for shadow stack
> 
>  Documentation/filesystems/proc.rst            |   1 +
>  Documentation/x86/index.rst                   |   1 +
>  Documentation/x86/shstk.rst                   | 176 +++++
>  arch/arm/kernel/signal.c                      |   2 +-
>  arch/arm64/kernel/signal.c                    |   2 +-
>  arch/arm64/kernel/signal32.c                  |   2 +-
>  arch/sparc/kernel/signal32.c                  |   2 +-
>  arch/sparc/kernel/signal_64.c                 |   2 +-
>  arch/x86/Kconfig                              |  24 +
>  arch/x86/Kconfig.assembler                    |   5 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/include/asm/disabled-features.h      |  16 +-
>  arch/x86/include/asm/fpu/api.h                |   9 +
>  arch/x86/include/asm/fpu/regset.h             |   7 +-
>  arch/x86/include/asm/fpu/sched.h              |   3 +-
>  arch/x86/include/asm/fpu/types.h              |  16 +-
>  arch/x86/include/asm/fpu/xstate.h             |   6 +-
>  arch/x86/include/asm/idtentry.h               |   2 +-
>  arch/x86/include/asm/mmu_context.h            |   2 +
>  arch/x86/include/asm/msr.h                    |  11 +
>  arch/x86/include/asm/pgtable.h                | 338 ++++++++-
>  arch/x86/include/asm/pgtable_types.h          |  65 +-
>  arch/x86/include/asm/processor.h              |   8 +
>  arch/x86/include/asm/shstk.h                  |  40 ++
>  arch/x86/include/asm/special_insns.h          |  13 +
>  arch/x86/include/asm/tlbflush.h               |   3 +-
>  arch/x86/include/asm/trap_pf.h                |   2 +
>  arch/x86/include/asm/traps.h                  |  12 +
>  arch/x86/include/uapi/asm/mman.h              |   4 +
>  arch/x86/include/uapi/asm/prctl.h             |  12 +
>  arch/x86/kernel/Makefile                      |   4 +
>  arch/x86/kernel/cet.c                         | 152 ++++
>  arch/x86/kernel/cpu/common.c                  |  35 +-
>  arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
>  arch/x86/kernel/cpu/proc.c                    |  23 +
>  arch/x86/kernel/fpu/core.c                    |  59 +-
>  arch/x86/kernel/fpu/regset.c                  |  87 +++
>  arch/x86/kernel/fpu/xstate.c                  | 148 ++--
>  arch/x86/kernel/fpu/xstate.h                  |   6 +
>  arch/x86/kernel/idt.c                         |   2 +-
>  arch/x86/kernel/process.c                     |  18 +-
>  arch/x86/kernel/process_64.c                  |   9 +-
>  arch/x86/kernel/ptrace.c                      |  12 +
>  arch/x86/kernel/shstk.c                       | 492 +++++++++++++
>  arch/x86/kernel/signal.c                      |   1 +
>  arch/x86/kernel/signal_32.c                   |   2 +-
>  arch/x86/kernel/signal_64.c                   |   8 +-
>  arch/x86/kernel/sys_x86_64.c                  |   6 +-
>  arch/x86/kernel/traps.c                       |  87 ---
>  arch/x86/mm/fault.c                           |  38 +
>  arch/x86/mm/pat/set_memory.c                  |   2 +-
>  arch/x86/mm/pgtable.c                         |   6 +
>  arch/x86/xen/enlighten_pv.c                   |   2 +-
>  arch/x86/xen/xen-asm.S                        |   2 +-
>  fs/aio.c                                      |   2 +-
>  fs/proc/array.c                               |   6 +
>  fs/proc/task_mmu.c                            |   3 +
>  include/linux/mm.h                            |  59 +-
>  include/linux/mman.h                          |   4 +
>  include/linux/pgtable.h                       |  35 +
>  include/linux/proc_fs.h                       |   2 +
>  include/linux/syscalls.h                      |   1 +
>  include/uapi/asm-generic/siginfo.h            |   3 +-
>  include/uapi/asm-generic/unistd.h             |   2 +-
>  include/uapi/linux/elf.h                      |   2 +
>  ipc/shm.c                                     |   2 +-
>  kernel/sys_ni.c                               |   1 +
>  mm/gup.c                                      |   2 +-
>  mm/huge_memory.c                              |  12 +-
>  mm/memory.c                                   |   7 +-
>  mm/migrate_device.c                           |   4 +-
>  mm/mmap.c                                     |  12 +-
>  mm/nommu.c                                    |   4 +-
>  mm/userfaultfd.c                              |  10 +-
>  mm/util.c                                     |   2 +-
>  tools/testing/selftests/x86/Makefile          |   4 +-
>  .../testing/selftests/x86/test_shadow_stack.c | 667 ++++++++++++++++++
>  78 files changed, 2578 insertions(+), 259 deletions(-)
>  create mode 100644 Documentation/x86/shstk.rst
>  create mode 100644 arch/x86/include/asm/shstk.h
>  create mode 100644 arch/x86/kernel/cet.c
>  create mode 100644 arch/x86/kernel/shstk.c
>  create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c
> 
> -- 
> 2.17.1
> 
