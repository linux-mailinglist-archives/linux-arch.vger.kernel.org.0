Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2444AB156
	for <lists+linux-arch@lfdr.de>; Sun,  6 Feb 2022 19:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiBFSmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Feb 2022 13:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiBFSma (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Feb 2022 13:42:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46652C06173B;
        Sun,  6 Feb 2022 10:42:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB4E2B80CF1;
        Sun,  6 Feb 2022 18:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1ADC340E9;
        Sun,  6 Feb 2022 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644172945;
        bh=ZHwFuWPqq+nhkelKsI7f7GhTLv5eAfwuxjFpnOSGkUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XFEMDVTrzxclH7giQVni2jRu6plPDcf3UJ/7EUbvDlh69SL0zAiDc2t6xE/cfO8OJ
         9IEE3sHgg2DFFwWK5n841pn1ZSr+yMXfKaP19Ldc2Rrkg+zzv38ieiUClHOFWwfYmv
         00/mIVIJ59EJoGHgpcu1XPtsomQWUKJw24xggL7rKjWvvp152RczW5T4UDEcxeWDbk
         n+fd//WFpUVWKnzvRWQK440yQbyPORqxhohUou10VXJG3tWqbgVHZPmuChOXAR9mjT
         L/faPpS/HJQ/0d0cEQ+ohEY/zOHkGF3AoBIhzZ/XMI72TbHeXyGzrnOhKR61cTWSxz
         pv47Lht61R6dA==
Date:   Sun, 6 Feb 2022 20:42:03 +0200
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
Message-ID: <YgAWVSGQg8FPCeba@kernel.org>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(added more CRIU people)

On Sun, Jan 30, 2022 at 01:18:03PM -0800, Rick Edgecombe wrote:
> Hi,
> 
> This is a slight reboot of the userspace CET series. I will be taking over the 
> series from Yu-cheng. Per some internal recommendations, I’ve reset the version
> number and am calling it a new series. Hopefully, it doesn’t cause confusion.
> 
> The new plan is to upstream only userspace Shadow Stack support at this point. 
> IBT can follow later, but for now I’ll focus solely on the most in-demand and
> widely available (with the feature on AMD CPUs now) part of CET.
> 
> I thought as part of this reset, it might be useful to more fully write-up the 
> design and summarize the history of the previous CET series. So this slightly
> long cover letter does that. The "Updates" section has the changes, if anyone
> doesn't want the history.
> 
> 
> Why is Shadow Stack Wanted
> ==========================
> The main use case for userspace shadow stack is providing protection against 
> return oriented programming attacks. Fedora and Ubuntu already have many/most 
> packages enabled for shadow stack. The main missing piece is Linux kernel 
> support and there seems to be a high amount of interest in the ecosystem for
> getting this feature supported. Besides security, Google has also done some
> work on using shadow stack to improve performance and reliability of tracing.
> 
> 
> Userspace Shadow Stack Implementation
> =====================================
> Shadow stack works by maintaining a secondary (shadow) stack that cannot be 
> directly modified by applications. When executing a CALL instruction, the 
> processor pushes the return address to both the normal stack and to the special 
> permissioned shadow stack. Upon ret, the processor pops the shadow stack copy 
> and compares it to the normal stack copy. If the two differ, the processor 
> raises a control protection fault. This implementation supports shadow stack on 
> 64 bit kernels only, with support for 32 bit only via IA32 emulation.
> 
> 	Shadow Stack Memory
> 	-------------------
> 	The majority of this series deals with changes for handling the special 
> 	shadow stack memory permissions. This memory is specified by the 
> 	Dirty+RO PTE bits. A tricky aspect of this is that this combination was 
> 	previously used to specify COW memory. So Linux needs to handle COW 
> 	differently when shadow stack is in use. The solution is to use a 
> 	software PTE bit to denote COW memory, and take care to clear the dirty
> 	bit when setting the memory RO.
> 
> 	Setup and Upkeep of HW Registers
> 	--------------------------------
> 	Using userspace CET requires a CR4 bit set, and also the manipulation 
> 	of two xsave managed MSRs. The kernel needs to modify these registers 
> 	during various operations like clone and signal handling. These 
> 	operations may happen when the registers are restored to the CPU, or 
> 	saved in an xsave buffer. Since the recent AMX triggered FPU overhaul 
> 	removed direct access to the xsave buffer, this series adds an 
> 	interface to operate on the supervisor xstate.
> 
> 	New ABIs
> 	--------
> 	This series introduces some new ABIs. The primary one is the shadow 
> 	stack itself. Since it is readable and the shadow stack pointer is 
> 	exposed to user space, applications can easily read and process the 
> 	shadow stack. And in fact the tracing usages plan to do exactly that.
> 
> 	Most of the shadow stack contents are written by HW, but some of the 
> 	entries are added by the kernel. The main place for this is signals. As 
> 	part of handling the signal the kernel does some manual adjustment of 
> 	the shadow stack that userspace depends on.
> 
> 	In addition to the contents of the shadow stack there is also user 
> 	visible behavior around when new shadow stacks are created and set in 
> 	the shadow stack pointer (SSP) register. This is relatively 
> 	straightforward – shadow stacks are created when new stacks are created 
> 	(thread creation, fork, etc). It is more or less what is required to 
> 	keep apps working.
> 
> 	For situations when userspace creates a new stack (i.e. makecontext(), 
> 	fibers, etc), a new syscall is provided for creating shadow stack 
> 	memory. To make the shadow stack usable, it needs to have a restore 
> 	token written to the protected memory. So the syscall provides a way to 
> 	specificity this should be done by the kernel.
> 
> 	When a shadow stack violation happens (when the return address of stack 
> 	not matching return address in shadow stack), a segfault is generated 
> 	with a new si_code specific to CET violations.
> 
> 	Lastly, a new arch_prctl interface is created for controlling the 
> 	enablement of CET-like features. It is intended to also be used for 
> 	LAM. It operates on the feature status per-thread, so for process wide 
> 	enabling it is intended to be used early in things like dynamic 
> 	linker/loaders. However, it can be used later for per-thread enablement 
> 	of features like WRSS.
> 
> 	WRSS
> 	----
> 	WRSS is an instruction that can write to shadow stacks. The HW provides 
> 	a way to enable this instruction for userspace use. Since shadow 
> 	stack’s are created initially protected, enabling WRSS allows any apps 
> 	that want to do unusual things with their stacks to have a way to 
> 	weaken protection and make things more flexible. A new feature bit is 
> 	defined to control enabling/disabling of WRSS.
> 
> 
> History
> =======
> The branding “CET” really consists of two features: “Shadow Stack” and 
> “Indirect Branch Tracking”. They both restrict previously allowed, but rarely 
> valid behaviors and require userspace to change to avoid these behaviors before 
> enabling the protection. These raw HW features need to be assembled into a 
> software solution across userspace and kernel in order to add security value.
> The kernel part of this solution has evolved iteratively starting with a lengthy
> RFC period. 
> 
> Until now, the enabling effort was trying to support both Shadow Stack and IBT. 
> This history will focus on a few areas of the shadow stack development history 
> that I thought stood out.
> 
> 	Signals
> 	-------
> 	Originally signals placed the location of the shadow stack restore 
> 	token inside the saved state on the stack. This was problematic from a 
> 	past ABI promises perspective. So the restore location was instead just 
> 	assumed from the shadow stack pointer. This works because in normal 
> 	allowed cases of calling sigreturn, the shadow stack pointer should be 
> 	right at the restore token at that time. There is no alternate shadow 
> 	stack support. If an alt shadow stack is added later we would need to 
> 	find a place to store the regular shadow stack token location. Options 
> 	could be to push something on the alt shadow stack, or to keep 
> 	something on the kernel side. So the current design keeps things simple 
> 	while slightly kicking the can down the road if alt shadow stacks 
> 	become a thing later. Siglongjmp is handled in glibc, using the incssp 
> 	instruction to unwind the shadow stack over the token.
> 
> 	Shadow Stack Allocation
> 	-----------------------
> 	makecontext() implementations need a way to create new shadow stacks 
> 	with restore token’s such that they can be pivoted to from userspace. 
> 	The first interface to do this was an arch_prctl(). It created a shadow 
> 	stack with a restore token pre-setup, since the kernel has an 
> 	instruction that can write to user shadow stacks. However, this 
> 	interface was abandoned for being strange.
> 
> 	The next version created PROT_SHADOW_STACK. This interface had two 
> 	problems. One, it left no options but for userspace to create writable 
> 	memory, write a restore token, then mproctect() it PROT_SHADOW_STACK. 
> 	The writable window left the shadow stack exposed, weakening the 
> 	security. Second, it caused problems with the guard pages. Since the 
> 	memory was initially created writable it did not have a guard page, but 
> 	then was mprotected later to a type of memory that should have one. 
> 	This resulted in missing guard pages and confused rb_subtree_gap’s.
> 
> 	This version introduces a new syscall that behaves similarly to the 
> 	initial arch_prctl() interface in that it has the kernel write the 
> 	restore token.
> 
> 	Enabling Interface
> 	------------------
> 	For the entire history of the original CET series, the design was to 
> 	enable shadow stack automatically if the feature bit was detected in 
> 	the elf header. Then it was userspace’s responsibility to turn it off 
> 	via an arch_prctl() if it was not desired, and this was handled by the 
> 	glibc dynamic loader. Glibc’s standard behavior (when CET if configured 
> 	is to leave shadow stack enabled if the executable and all linked 
> 	libraries are marked with shadow stacks.
> 
> 	Many distros (Fedora and others) have binaries already marked with 
> 	shadow stack, waiting for kernel support. Unfortunately their glibc 
> 	binaries expect the original arch_prctl() interface for allocating 
> 	shadow stacks, as those changes were pushed ahead of kernel support. 
> 	The net result of it all is, when updating to a kernel with shadow 
> 	stack these binaries would suddenly get shadow stack enabled and expect 
> 	the arch_prctl() interface to be there. And so calls to makecontext() 
> 	will fail, resulting in visible breakages. This series deals with this 
> 	problem as described below in "Updates".
> 
> 
> Updates
> =======
> These updates were mostly driven by public comments, but a lot of the design 
> elements are new. I would like some extra scrutiny on the updates.
> 
> 	New syscall for Shadow Stack Allocation
> 	---------------------------------------
> 	A new syscall is added for allocating shadow stacks to replace 
> 	PROT_SHADOW_STACK. Several options were considered, as described in the 
> 	“x86/cet/shstk: Introduce map_shadow_stack syscall”.
> 
> 	Xsave Managed Supervisor State Modifications
> 	--------------------------------------------
> 	The shadow stack feature requires the kernel to modify xsaves managed 
> 	state. On one of the last versions of Yu-cheng’s series Boris had 
> 	commented on the pattern it was using to do this not necessarily being 
> 	ideal. The pattern was to force a restore to the registers and always 
> 	do the modification there. Then Thomas did an overhaul of the fpu code, 
> 	part of which consisted of making raw access to the xsave buffer 
> 	private to the fpu code. So this series tries to expose access again, 
> 	and in a way that addresses Boris’ comments.
> 
> 	The method is to provide functions like wmsrl/rdmsrl, but that can 
> 	direct the operation to the correct location (registers or buffer), 
> 	while giving the proper notice to the fpu subsystem so things don’t get 
> 	clobbered or corrupted.
> 
> 	In the past a solution like this was discussed as part of the PASID 
> 	series, and Thomas was not in favor. In CET’s case there is a more 
> 	logic around the CET MSR’s than in PASID's, and wrapping this logic 
> 	minimizes near identical open coded logic needed to do this more 
> 	efficiently. In addition it resolves the above described problem of 
> 	having no access to the xsave buffer. So it is being put forward here 
> 	under the supposition that CET’s usage may lead to a different 
> 	conclusion, not to try to ignore past direction.
> 
> 	The user interrupt series has similar needs as CET, and will also use
> 	this internal interface if it’s found acceptable.
> 
> 	Support for WRSS
> 	----------------
> 	Andy Lutomirski had asked if we change the shadow stack allocation API 
> 	such that userspace cannot create arbitrary shadow stacks, then we look 
> 	at exposing an interface to enable the WRSS instruction for userspace. 
> 	This way app’s that want to do unexpected things with shadow stacks 
> 	would still have the option to create shadow stacks with arbitrary 
> 	data.
> 
> 	Switch Enabling Interface
> 	-------------------------
> 	As described above there is a problem with userspace binaries waiting 
> 	to break as soon as the kernel supports CET. This needs to be prevented 
> 	by changing the interface such that the old binaries will not enable 
> 	shadow stack AND behave as if shadow stack is not enabled. They should 
> 	run normally without shadow stack protection. Creating a new feature 
> 	(SHSTK2) for shadow stack was explored. SHSTK would never be supported 
> 	by the kernel, and all the userspace build tools would be updated to 
> 	target SHSTK2 instead of SHSTK. So old SHSTK binaries would be cleanly
> 	disabled.
> 
> 	But there are existing downsides to automatic elf header processing 
> 	based enabling. The elf header feature spec is not defined by the 
> 	kernel and there are proposals to expand it to describe additional 
> 	logic. A simpler interface where the kernel is simply told what to 
> 	enable, and leaves all the decision making to userspace, is more 
> 	flexible for userspace and simpler for the kernel. There also already 
> 	needs to be an ARCH_X86_FEATURE_ENABLE arch_prctl() for WRSS (and 
> 	likely LAM will use it too), so it avoids there being two ways to turn 
> 	on these types of features. The only tricky part for shadow stack, is 
> 	that it has to be enabled very early. Wherever the shadow stack is 
> 	enabled, the app cannot return from that point, otherwise there will be 
> 	a shadow stack violation. It turns out glibc can enable shadow stack 
> 	this early, so it works nicely. So not automatically enabling any 
> 	features in the elf header will cleanly disable all old binaries, which 
> 	expect the kernel to enable CET features automatically. Then after the 
> 	kernel changes are upstream, glibc can be updated to use the new
> 	interface. This is the solution implemented in this series.
> 
> 	Expand Commit Logs
> 	------------------
> 	As part of spinning up on this series, I found some of the commit logs 
> 	did not describe the changes in enough detail for me understand their 
> 	purpose. I tried to expand the logs and comments, where I had to go 
> 	digging. Hopefully it’s useful.
> 	
> 	Limit to only Intel Processors
> 	------------------------------
> 	Shadow stack is supported on some AMD processors, but this revision 
> 	(with expanded HW usage and xsaves changes) has only has been tested on 
> 	Intel ones. So this series has a patch to limit shadow stack support to 
> 	Intel processors. Ideally the patch would not even make it to mainline, 
> 	and should be dropped as soon as this testing is done. It's included 
> 	just in case.
> 
> 
> Future Work
> ===========
> Even though this is now exclusively a shadow stack series, there is still some 
> remaining shadow stack work to be done.
> 
> 	Ptrace
> 	------
> 	Early in the series, there was a patch to allow IA32_U_CET and
> 	IA32_PL3_SSP to be set. This patch was dropped and planned as a follow
> 	up to basic support, and it remains the plan. It will be needed for
> 	in-progress gdb support.
> 
> 	CRIU Support
> 	------------
> 	In the past there was some speculation on the mailing list about 
> 	whether CRIU would need to be taught about CET. It turns out, it does. 
> 	The first issue hit is that CRIU calls sigreturn directly from its 
> 	“parasite code” that it injects into the dumper process. This violates
> 	this shadow stack implementation’s protection that intends to prevent
> 	attackers from doing this.
> 
> 	With so many packages already enabled with shadow stack, there is 
> 	probably desire to make it work seamlessly. But in the meantime if 
> 	distros want to support shadow stack and CRIU, users could manually 
> 	disabled shadow stack via “GLIBC_TUNABLES=glibc.cpu.x86_shstk=off” for 
> 	a process they will wants to dump. It’s not ideal.
> 
> 	I’d like to hear what people think about having shadow stack in the 
> 	kernel without this resolved. Nothing would change for any users until 
> 	they enable shadow stack in the kernel and update to a glibc configured
> 	with CET. Should CRIU userspace be solved before kernel support?
> 
> 	Selftests
> 	---------
> 	There are some CET selftests being worked on and they are not included
> 	here.
> 
> Thanks,
> 
> Rick
> 
> Rick Edgecombe (7):
>   x86/mm: Prevent VM_WRITE shadow stacks
>   x86/fpu: Add helpers for modifying supervisor xstate
>   x86/fpu: Add unsafe xsave buffer helpers
>   x86/cet/shstk: Introduce map_shadow_stack syscall
>   selftests/x86: Add map_shadow_stack syscall test
>   x86/cet/shstk: Support wrss for userspace
>   x86/cpufeatures: Limit shadow stack to Intel CPUs
> 
> Yu-cheng Yu (28):
>   Documentation/x86: Add CET description
>   x86/cet/shstk: Add Kconfig option for Shadow Stack
>   x86/cpufeatures: Add CET CPU feature flags for Control-flow
>     Enforcement Technology (CET)
>   x86/cpufeatures: Introduce CPU setup and option parsing for CET
>   x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
>   x86/cet: Add control-protection fault handler
>   x86/mm: Remove _PAGE_DIRTY from kernel RO pages
>   x86/mm: Move pmd_write(), pud_write() up in the file
>   x86/mm: Introduce _PAGE_COW
>   drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
>   x86/mm: Update pte_modify for _PAGE_COW
>   x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for
>     transition from _PAGE_DIRTY to _PAGE_COW
>   mm: Move VM_UFFD_MINOR_BIT from 37 to 38
>   mm: Introduce VM_SHADOW_STACK for shadow stack memory
>   x86/mm: Check Shadow Stack page fault errors
>   x86/mm: Update maybe_mkwrite() for shadow stack
>   mm: Fixup places that call pte_mkwrite() directly
>   mm: Add guard pages around a shadow stack.
>   mm/mmap: Add shadow stack pages to memory accounting
>   mm: Update can_follow_write_pte() for shadow stack
>   mm/mprotect: Exclude shadow stack from preserve_write
>   mm: Re-introduce vm_flags to do_mmap()
>   x86/cet/shstk: Add user-mode shadow stack support
>   x86/process: Change copy_thread() argument 'arg' to 'stack_size'
>   x86/cet/shstk: Handle thread shadow stack
>   x86/cet/shstk: Introduce shadow stack token setup/verify routines
>   x86/cet/shstk: Handle signals for shadow stack
>   x86/cet/shstk: Add arch_prctl elf feature functions
> 
>  .../admin-guide/kernel-parameters.txt         |   4 +
>  Documentation/filesystems/proc.rst            |   1 +
>  Documentation/x86/cet.rst                     | 145 ++++++
>  Documentation/x86/index.rst                   |   1 +
>  arch/arm/kernel/signal.c                      |   2 +-
>  arch/arm64/kernel/signal.c                    |   2 +-
>  arch/arm64/kernel/signal32.c                  |   2 +-
>  arch/sparc/kernel/signal32.c                  |   2 +-
>  arch/sparc/kernel/signal_64.c                 |   2 +-
>  arch/x86/Kconfig                              |  22 +
>  arch/x86/Kconfig.assembler                    |   5 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  arch/x86/ia32/ia32_signal.c                   |  25 +-
>  arch/x86/include/asm/cet.h                    |  54 +++
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/disabled-features.h      |   8 +-
>  arch/x86/include/asm/fpu/api.h                |   8 +
>  arch/x86/include/asm/fpu/types.h              |  23 +-
>  arch/x86/include/asm/fpu/xstate.h             |   6 +-
>  arch/x86/include/asm/idtentry.h               |   4 +
>  arch/x86/include/asm/mman.h                   |  24 +
>  arch/x86/include/asm/mmu_context.h            |   2 +
>  arch/x86/include/asm/msr-index.h              |  20 +
>  arch/x86/include/asm/page_types.h             |   7 +
>  arch/x86/include/asm/pgtable.h                | 302 ++++++++++--
>  arch/x86/include/asm/pgtable_types.h          |  48 +-
>  arch/x86/include/asm/processor.h              |   6 +
>  arch/x86/include/asm/special_insns.h          |  30 ++
>  arch/x86/include/asm/trap_pf.h                |   2 +
>  arch/x86/include/uapi/asm/mman.h              |   8 +-
>  arch/x86/include/uapi/asm/prctl.h             |  10 +
>  arch/x86/include/uapi/asm/processor-flags.h   |   2 +
>  arch/x86/kernel/Makefile                      |   1 +
>  arch/x86/kernel/cpu/common.c                  |  20 +
>  arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
>  arch/x86/kernel/elf_feature_prctl.c           |  72 +++
>  arch/x86/kernel/fpu/xstate.c                  | 167 ++++++-
>  arch/x86/kernel/idt.c                         |   4 +
>  arch/x86/kernel/process.c                     |  17 +-
>  arch/x86/kernel/process_64.c                  |   2 +
>  arch/x86/kernel/shstk.c                       | 446 ++++++++++++++++++
>  arch/x86/kernel/signal.c                      |  13 +
>  arch/x86/kernel/signal_compat.c               |   2 +-
>  arch/x86/kernel/traps.c                       |  62 +++
>  arch/x86/mm/fault.c                           |  19 +
>  arch/x86/mm/mmap.c                            |  48 ++
>  arch/x86/mm/pat/set_memory.c                  |   2 +-
>  arch/x86/mm/pgtable.c                         |  25 +
>  drivers/gpu/drm/i915/gvt/gtt.c                |   2 +-
>  fs/aio.c                                      |   2 +-
>  fs/proc/task_mmu.c                            |   3 +
>  include/linux/mm.h                            |  19 +-
>  include/linux/pgtable.h                       |   8 +
>  include/linux/syscalls.h                      |   1 +
>  include/uapi/asm-generic/siginfo.h            |   3 +-
>  include/uapi/asm-generic/unistd.h             |   2 +-
>  ipc/shm.c                                     |   2 +-
>  kernel/sys_ni.c                               |   1 +
>  mm/gup.c                                      |  16 +-
>  mm/huge_memory.c                              |  27 +-
>  mm/memory.c                                   |   5 +-
>  mm/migrate.c                                  |   3 +-
>  mm/mmap.c                                     |  15 +-
>  mm/mprotect.c                                 |   9 +-
>  mm/nommu.c                                    |   4 +-
>  mm/util.c                                     |   2 +-
>  tools/testing/selftests/x86/Makefile          |   9 +-
>  .../selftests/x86/test_map_shadow_stack.c     |  75 +++
>  69 files changed, 1797 insertions(+), 92 deletions(-)
>  create mode 100644 Documentation/x86/cet.rst
>  create mode 100644 arch/x86/include/asm/cet.h
>  create mode 100644 arch/x86/include/asm/mman.h
>  create mode 100644 arch/x86/kernel/elf_feature_prctl.c
>  create mode 100644 arch/x86/kernel/shstk.c
>  create mode 100644 tools/testing/selftests/x86/test_map_shadow_stack.c
> 
> 
> base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
> -- 
> 2.17.1

-- 
Sincerely yours,
Mike.
