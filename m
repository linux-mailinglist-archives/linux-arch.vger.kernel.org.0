Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB14A5F0020
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiI2W34 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiI2W3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:29:52 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41721AF31;
        Thu, 29 Sep 2022 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490590; x=1696026590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ee+FmHlaRZ3WtLWWcGakPKSwBqxBedSfonqLJrJX0jM=;
  b=V8/DrkfwFRzmqriDXCQxDrKWSfUAvdFHPVIvXG3Mw71BbZjCmEJDPei9
   XILgAvCNaTtvyiktJVZ6zhyc0KJ28MHyCNipwnzF4VXOuXqA0hVyxF5Nx
   S+zAhqajSCKEGq13DzgOrb1r1WbqIYfjn3V85eluXP/swa3cvAIG4ipEf
   36m/FtQSpUndHrYOsEN2nM6m9qJVEdHZLp63FOR0IZiaWtMhf50B0/fWn
   KWb2p3hq6lohwoVDkcA0mjUTglgKaDaMqCIYV7JEcRbAOgL07RikbqkWM
   Ys+J5+MkqAzl2dCgTA3N38J9d/he0SdN6TXcZQr/zB3fPFsUzpZflpfqg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303531314"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="303531314"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016057"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016057"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:29:45 -0700
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
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v2 00/39] Shadowstacks for userspace
Date:   Thu, 29 Sep 2022 15:28:57 -0700
Message-Id: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This is an overdue followup to the “Shadow stacks for userspace” CET series. 
Thanks for all the comments on the first version [0]. They drove a decent 
amount of changes for v2. Since it has been awhile, I’ll try to summarize the 
areas that got major changes since last time. Smaller changes are listed in 
each patch.

The coverletter is organized into the following sections:
1. Shadow Stack Memory Solution
2. FPU API
3. Alt Shadow Stacks
4. Compatibility of Existing Binaries/Enabling Interface
5. CRIU Support
6. Bigger Selftest

Last time, two bigger pieces of new functionality were requested (Alt shadow
stack and CRIU support). Alt shadow stack support was requested, not because
there was an immediate need, but more because of the risk of signal ABI
decisions made now, creating implementation problems if alt shadow stacks were
added later.

A POC for alt shadow stacks may be enough to gauge this risk. CRIU support may 
also not be something critical for day one, if glibc disables all existing 
binaries as described in section 4. So I marked the patches at the end that 
support those two things as RFC/OPTIONAL. The earlier patches will support a 
smaller, basic initial implementation. So I’m wondering if we could consider
just enabling the basics upstream first, assuming the RFC pieces here look
passable.

1. Shadow Stack Memory Solution
===============================
Dave had a lot of questions and feedback about how shadow stack memory is 
handled, including why shadow stack VMAs were not VM_WRITE. These questions 
prompted a revisit of the design, and in the end shadow stack’s were switched 
to be VM_WRITE. I’ve tried to summarize how shadow stack memory is supposed to 
work, with some examples of how MM features interact with shadow stack memory.

Shadow Stack Memory Summary
---------------------------
Integrating shadow stack memory into the kernel has two main challenges. One, 
Write=0,Dirty=1 PTEs are already created by the kernel, and now they can’t be 
or they will inadvertently create shadow stack memory.

And, two, shadow stack memory fits strangely into the existing concepts of 
Copy-On-Write and “writable” memory. It is *sort of* writable, in that it can 
be changed by userspace, but sort of not in that it has Write=0 and can’t be 
written by normal mov-type accesses. So we still have the “writable” memory we 
always had, but now we also have another type of memory that is changeable from 
userspace. Another weird aspect is that memory has to be shadow stack, in order 
to serve a “shadow stack read”, so a shadow stack read also needs to cause 
something like a Copy-On-Write, as the result will be changeable from 
userspace.


Dealing with the new meaning of Dirty and Write bits
----------------------------------------------------
The first issue is solved with creating PAGE_COW using a software PTE bit. This 
is hidden inside the pgtable.h helpers, such that it *mostly* (more on this 
later) happens without changing core code. Basically in pte_wrprotect() will 
clear Dirty and set Cow=1, if the pte was dirty. In pte_mkdirty(), it set’s COW 
if the PTE was Write=0. Then pte_dirty() returns true for Dirty=1 or Cow=1. 
Since this requires a little extra work, this behavior is compiled out when 
shadow stack support is not enabled for the kernel.


Dealing with a new type of writable memory
------------------------------------------
The other side of the problem - dealing with the concept-splitting new type of 
userspace changeable memory - leaves a bit more loose ends. Probably the most 
important thing is that we don’t want the kernel thinking that shadow stack 
memory is protected from changes from userspace. But we also don’t want the 
kernel to treat it like normal writable memory in some ways either, for example 
to get confused and inadvertently make it writable in the normal (PTE Write=1) 
sense.

The solution here is to treat shadow stack memory as a special class of
writable memory by updating places where memory is made writable to be aware of
it, and treat all shadow stack accesses as if they are writes.

Shadow stack accesses are always treated as write faults because even shadow 
stack reads need to be made (shadow stack) writable in order to service them. 
Logic creating PTE’s then decides whether to create shadow stack or normal 
writable memory by the VMA type. Most of this is encapsulated in 
maybe_mkwrite() but some differentiation needs to be open coded where 
pte_mkwrite() is called directly.

Shadow stack VMA’s are a special type of writable and so they are created as 
VM_WRITE | VM_SHADOW_STACK. The benefit of making them also VM_WRITE is that 
there is some existing logic around using VM_WRITE to make decisions in the 
kernel that apply to shadow stack memory as well.
        - Scheduling code decides whether to migrate a VMA depending on	whether
          it’s VM_WRITE. The same reasoning should apply for shadow stack
          memory.
        - While there is no current interface for mmap()ing files as shadow
          stack, various drivers enforce non-writable mappings by checking
          !VM_WRITE and clearing VM_MAYWRITE. Because there is no longer a way
          to mmap() something arbitrarily as shadow stack, this can’t be hit.
          But this un-hittable wrong logic makes the design confusing and
          brittle.

The downside of having shadow stack memory have VM_WRITE is that any logic that 
assumes VM_WRITE means normally writable, for example open coded like:
if (flags & VM_WRITE)
	pte_mkwrite()
...will no longer be correct. It will need to be changed to have additional 
logic that knows about shadow stack. It turns out there are not too many of 
these cases and so this series just adds the logic.

This solution for this second issue also tweaks the behavior of pte_write() and 
pte_dirty(). pte_write() check’s whether a pte is writable or not, previously 
this was only the case when Write=1, but now pte_write() also returns true for 
shadow stack memory.

There are some additional areas that are probably worth commenting on:

        COW
        ---
        When a shadow stack page is shared as part of COW, it becomes read-only,
        just like normally writable memory would be. As part of the Dirty bit
        solution described above, pte_wrprotect() will move Dirty=1 to COW=1.
        This will leave the PTE in a read-only state automatically. Then when
        it takes a shadow stack access, it will perform COW, copying the page
        and making it writable. Logic added as part of the shadow stack memory
        solution will detect that the VMA is shadow stack and make the PTE a
        shadow stack PTE.

        mprotect()/VM_WRITE
        -------------------
        Shadow stack memory doesn’t have a PROT flag. It is created either
        internally in the kernel or via a special syscall. When it is created
        this way, the VMA gets VM_WRITE|VM_SHADOW_STACK. However, some
        functionality of the kernel will remove VM_WRITE, for example
        mprotect(). When this happens the memory is expected to be read only. So
        without any intervention, there may be a VMA that is VM_SHADOW_STACK and
        not VM_WRITE. We could try to prevent this from happening, (for example
        block mprotect() from operating on shadow stack memory), however some
        things like userfaulfd call mprotect internally and depend on it to
        work.

        So mprotect()ing shadow stack memory can make it read-only (non-shadow
        stack). It can then become shadow stack again by mprotect()ing it with
        PROT_WRITE. It always keeps the VM_SHADOW_STACK, so that it can never
        become normally writable memory.

        GUP
        ---
        Shadow stack memory is generally treated as writable by the kernel, but
        it behaves differently then other writable memory with respect to GUP.
        FOLL_WRITE will not GUP shadow stack memory unless FOLL_FORCE is also
        set. Shadow stack memory is writable from the perspective of being
        changeable by userspace, but it is also protected memory from
        userspace’s perspective. So preventing it from being writable via
        FOLL_WRITE help’s make it harder for userspace to arbitrarily write to
        it. However, like read-only memory, FOLL_FORCE can still write through
        it. This means shadow stacks can be written to via things like
        “/proc/self/mem”. Apps that want extra security will have to prevent
        access to kernel features that can write with FOLL_FORCE.

2. FPU API
==========
The last version of this had an interface for modifying the FPU state in either 
the buffer or the registers to try to minimize saves and restores. Shortly 
after that, Thomas experimented with a different fpu optimization that was 
incompatible with how the interface kept state in the caller. So it doesn't
seem like a robust interface and for this version the optimization piece of the
API is dropped in this series, and the force restore technique is used again.

3. Alt Shadow Stacks
====================
Andy Lutomirski asked about alt shadow stack support. The following describes 
the design of shadow stack support for signals and alt shadow stacks.

Signal handling and shadow stacks
---------------------------------
Signals push information about the execution context to the stack that will 
handle the signal. The data pushed is use to restore registers and other state 
after the signal. In the case of handling the signal on a normal stack, the 
stack just needs to be unwound over the stack frame, but in the case of alt 
stacks, the saved stack pointer is important for the sigreturn to find it’s way 
back to the thread stack. With shadow stack there is a new type of stack 
pointer, the shadow stack pointer (SSP), that needs to be restored. Just like 
the regular stack pointer, it needs to be saved somewhere in order to implement 
shadow alt stacks. Beyond supporting basic functionality, it would be nice if 
shadow stack’s could make sigreturn oriented programming (SROP) attacks harder.

Alt stacks
----------
The automatically-created thread shadow stacks are sized such that shadow stack 
overflows should not normally be expected. However, especially since userspace 
can create and pivot to arbitrarily sized shadow stacks and we now optionally 
have WRSS, overflows are not impossible. To cover the case of shadow stack 
overflow, user’s may want to handle a signal on an alternate shadow stack.

Normal signal alt stacks had problems with using swapcontext() in the signal 
handler. Apps couldn’t do it safely, because a subsequent signal would 
overwrite the previous signal’s stack. The kernel would see the current stack 
pointer was not on the shadow stack (since it swapcontext()ed off of it), so 
would restart the signal from the end of the alt stack, clobbering the previous 
signal. The solution was to create a new flag that would change the signal 
behavior to disable alt stack switching while on the alt stack. Then new 
signals would be pushed onto the alt stack. On sigreturn, when the sigframe for 
the first signal that switched to the alt stack is encountered, the alt signal 
stack would be re-enabled. Then subsequent signals would start at the end of 
the alt stack again.

For regular alt stacks, this swapcontext() capable behavior is enabled by 
having the kernel clear its copy of the alt signal stack address and length 
after this data is saved to the sigframe. So when the first sigframe on the alt 
stack is sigreturn-ed, the alt stack is automatically restored.

In order to support swapcontext() on alt shadow stacks, we can have something 
similar where we push the SSP, alt shadow stack base and length to some kind of 
shadow stack sigframe. This leaves the question of where to push this data.

SROP
----
Similar to normal returns, sigreturn’s can be security sensitive. One exploit 
technique (SROP) is to call sigreturn directly with the stack pointer at a 
forged sigframe. So this involves being somewhere else on the stack, than a 
real kernel placed sigframe. These attacks can be made harder by placing 
something on the protected shadow stack to signify that a specific location on 
the shadow stack corresponds to where sigreturn is supposed to be called. The 
kernel can check for this token during sigreturn, and then sigreturn can’t be 
called at arbitrary places on the stack.

Shadow stack signal format
--------------------------
So to handle alt shadow stacks we need to push some data onto a stack. To 
prevent SROP we need to push something to the shadow stack that the kernel can 
know it must have placed there itself. To support both we can push a special 
shadow stack sigframe to the shadow stack that contains the necessary alt stack 
restore data, in a format that couldn't possibly occur naturally. To be extra 
careful, this data should be written such that it can't be used as a regular 
shadow stack return address or a shadow stack tokens. To make sure it can’t be 
used, data is pushed with the high bit (bit 63) set. This bit is a linear 
address bit in both the token format and a normal return address, so it should 
not conflict with anything. It puts any return address in the kernel half of 
the address space, so would never be created naturally by a userspace program. 
It will not be a valid restore token either, as the kernel address will never 
be pointing to the previous frame in the shadow stack.

When a signal hits, the format pushed to the stack that is handling the signal 
is four 8 byte values (since we are 64 bit only):
|1...old SSP|1...alt stack size|1...alt stack base|0|

The zero (without high bit set) at the end is pushed to act as a guard frame. 
An attacker cannot restore from a point where the frame processed would span 
two shadow stack sigframes because the kernel would detect the missing high 
bit.

setjmp()/longjmp()
------------------
In past designs for userspace shadow stacks, shadow alt stacks were not 
supported. Since there was only one shadow stack, longjmp() could jump out of a 
signal by using incssp to unwind the SSP to the place where the setjmp() was 
called. In order to support longjmp() off of an alt shadow stack, a restore 
token could be pushed to the original stack before switching to the alt stack. 
Userspace could search the alt stack for the alt stack sigframe to find the 
restore token, then restore back to it and continue unwinding. However, the 
main point of alt shadow stacks is to handle shadow stack overflows. So 
requiring there be space to push a token would prevent the feature from being 
used for it’s main purpose. So in this design nothing is pushed to the old 
stack.

Since shadow alt stacks are a new feature, longjmp()ing from an alt shadow stack 
will simply not be supported. If a libc want’s to support this it will need to 
enable WRSS and write it’s own restore token. This could likely even let it 
jump straight back to the setjmp() point and skip the whole incssp piece. It 
could even work for longjmp() after a swapcontext(). So this kernel design 
makes longjmp() support a security/compatibility tradeoff that the kernel is 
not entirely in charge of making.

sigaltshstk() syscall
---------------------
The sigaltstack() syscall works pretty well and is familiar interface, so 
sigaltshstk() is just a copy. It uses the same stack_t struct for transferring 
the shadow stack point, size and flags. For the flags however, it will not 
honor the meaning of the existing flags. Future flags may not have sensible 
meanings for shadow stack, so sigaltshstk() will start from scratch for flag 
meanings. As long as we are making new flag meanings, we can make SS_AUTODISARM 
the default behavior for sigaltshstk(), and not require a flag. Today the only 
flag supported is SS_DISABLE, and a !SS_AUTODISARM mode is not supported.

sigaltshstk() is separate from sigaltstack(). You can have one without the 
other, neither or both together. Because the shadow stack specific state is 
pushed to the shadow stack, the two features don’t need to know about each 
other.

Preventing use as an arbitrary “set SSP”
----------------------------------------
So now when a signal hits it will jump to the location specified in 
sigaltshstk(). Currently (without WRSS), userspace doesn’t have the ability to 
arbitrarily set the SSP. But telling the kernel to set the SSP to an arbitrary 
point on signal is kind of like that. So there would be a weakening of the 
shadow stack protections unless additional checks are made. With the 
SS_AUTODISARM-style behavior, the SSP will only jump to the shadow stack if the 
SSP is not already on the shadow stack, otherwise it will just push the SSP. So 
we really only need to worry about the transition to the start of the alt 
shadow stack. So the kernel checks for a token whenever transitioning to the 
alt stack from a place other than the alt stack. This token can be placed when 
doing the allocation using the existing map_shadow_stack syscall.

RFC
---
Lastly, Andy Lutomirski raised the issue of alt shadow stacks (I think) out of 
concern that we might settle on an ABI that wouldn’t support them if there was 
later demand. The ABI of the sigreturn token was actually changed to support alt
shadow stacks here. So if this whole series feels like a lot of code, I wanted
to toss out the option of settling on how we could do alt shadow stacks
someday, but then leave the implementation until later.


4. Compatibility of Existing Binaries/Enabling Interface
========================================================
The last version of this dealt with the problem of old glib’s breaking against 
future upstream shadow stack enabled kernels. Unfortunately, more userspace 
issues have been found. In anticipation of kernel support, some distro’s have 
been apparently force compiling applications with shadow stack support. Of 
course compiling with shadow stack really mostly means marking the elf header 
bit as “this binary supports shadow stack”. And having this bit doesn’t
necessarily mean that the binary actually supports shadow stack. In the case of
JITing or other custom stack switching programs, it often doesn’t. I have come
across at least one popular distro package that completely fails to even start
up, so there are likely more issues hidden in less common code paths. None of
these apps will break until glibc is updated to use the new kernel API for
enabling shadow stack. They will simply not run with shadow stack.

Waiting until glibc updates to break packages might not technically be a kernel 
regression, but it’s not good either. With the current kernel API, the decision
of which binaries to enable shadow stack is left to userspace. So to prevent
breakages my plan is to engage the glibc community to detect and not enable CET
for these old binaries as part of the upstream of glibc CET support that will
work with the new kernel interface. Then only enable CET on future more
carefully compiled binaries. This will also lessen the impact of old CRIU’s
(pre-Mike’s changes) failing to save shadow stack enabled programs, as most
existing binaries wouldn't all turn on with CET at once.

5. CRIU Support
===============
Big thanks to Mike Rapoport for a POC [1] that fixes CRIU to work with 
processes that enable shadow stacks. The general design is to allow CET 
features to be unlocked via ptrace only, then WRSS can be used to manipulate 
the shadow stack to allow CRIU’s sigreturn-oriented operation to continue to 
work. He needed a few tweaks to the kernel in order for CRIU to do this, 
including the general CET ptrace support that was missing in recent postings of 
CET. So this is added back in, as well as his new UNLOCK ptrace-only 
arch_prctl(). With the new plan of not trying to enable shadow stack for most 
apps all at once, I wonder if this functionality might also be a good candidate 
for a fast follow up. Note, this CRIU POC will need to be updated to target the 
final signal shadow stack format.

6. Bigger Selftest
==================
A new selftest that exercises the shadow stack kernel features without any 
special glibc requirements. It manually enables shadow stack with the 
arch_prctl() and exercises shadow stack arch_prctl(), shadow stack MM, 
userfaultfd, signal, and the 2 new syscalls.

[0] https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
[1] https://lore.kernel.org/lkml/YpYDKVjMEYVlV6Ya@kernel.org/


Kirill A. Shutemov (2):
  x86: Introduce userspace API for CET enabling
  x86: Expose thread features status in /proc/$PID/arch_status

Mike Rapoport (1):
  x86/cet/shstk: Add ARCH_CET_UNLOCK

Rick Edgecombe (11):
  x86/fpu: Add helper for modifying xstate
  mm: Don't allow write GUPs to shadow stack memory
  x86/cet/shstk: Introduce map_shadow_stack syscall
  x86/cet/shstk: Support wrss for userspace
  x86/cet/shstk: Wire in CET interface
  selftests/x86: Add shadow stack test
  x86/cpufeatures: Limit shadow stack to Intel CPUs
  x86: Separate out x86_regset for 32 and 64 bit
  x86: Improve formatting of user_regset arrays
  x86/fpu: Add helper for initing features
  x86: Add alt shadow stack support

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
  x86/cet/shstk: Add user-mode shadow stack support
  x86/cet/shstk: Handle thread shadow stack
  x86/cet/shstk: Introduce routines modifying shstk
  x86/cet/shstk: Handle signals for shadow stack
  x86/cet: Add PTRACE interface for CET

 Documentation/filesystems/proc.rst            |   1 +
 Documentation/x86/cet.rst                     | 143 ++++
 Documentation/x86/index.rst                   |   1 +
 arch/arm/kernel/signal.c                      |   2 +-
 arch/arm64/kernel/signal.c                    |   2 +-
 arch/arm64/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal32.c                  |   2 +-
 arch/sparc/kernel/signal_64.c                 |   2 +-
 arch/x86/Kconfig                              |  18 +
 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
 arch/x86/ia32/ia32_signal.c                   |   1 +
 arch/x86/include/asm/cet.h                    |  49 ++
 arch/x86/include/asm/cpufeatures.h            |   1 +
 arch/x86/include/asm/disabled-features.h      |   8 +-
 arch/x86/include/asm/fpu/api.h                |   6 +
 arch/x86/include/asm/fpu/regset.h             |   7 +-
 arch/x86/include/asm/fpu/sched.h              |   3 +-
 arch/x86/include/asm/fpu/types.h              |  14 +-
 arch/x86/include/asm/fpu/xstate.h             |   6 +-
 arch/x86/include/asm/idtentry.h               |   2 +-
 arch/x86/include/asm/mmu_context.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   5 +
 arch/x86/include/asm/msr.h                    |  11 +
 arch/x86/include/asm/pgtable.h                | 314 ++++++++-
 arch/x86/include/asm/pgtable_types.h          |  48 +-
 arch/x86/include/asm/processor.h              |  11 +
 arch/x86/include/asm/special_insns.h          |  13 +
 arch/x86/include/asm/trap_pf.h                |   2 +
 arch/x86/include/uapi/asm/mman.h              |   2 +
 arch/x86/include/uapi/asm/prctl.h             |  10 +
 arch/x86/kernel/Makefile                      |   4 +
 arch/x86/kernel/cpu/common.c                  |  30 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
 arch/x86/kernel/fpu/core.c                    |  59 +-
 arch/x86/kernel/fpu/regset.c                  |  95 +++
 arch/x86/kernel/fpu/xstate.c                  | 198 +++---
 arch/x86/kernel/fpu/xstate.h                  |   6 +
 arch/x86/kernel/idt.c                         |   2 +-
 arch/x86/kernel/proc.c                        |  63 ++
 arch/x86/kernel/process.c                     |  24 +-
 arch/x86/kernel/process_64.c                  |   8 +-
 arch/x86/kernel/ptrace.c                      | 188 +++--
 arch/x86/kernel/shstk.c                       | 628 +++++++++++++++++
 arch/x86/kernel/signal.c                      |  10 +
 arch/x86/kernel/signal_compat.c               |   2 +-
 arch/x86/kernel/traps.c                       |  98 ++-
 arch/x86/mm/fault.c                           |  21 +
 arch/x86/mm/mmap.c                            |  25 +
 arch/x86/mm/pat/set_memory.c                  |   2 +-
 arch/x86/xen/enlighten_pv.c                   |   2 +-
 arch/x86/xen/xen-asm.S                        |   2 +-
 fs/aio.c                                      |   2 +-
 fs/proc/task_mmu.c                            |   3 +
 include/linux/mm.h                            |  38 +-
 include/linux/pgtable.h                       |  14 +
 include/linux/syscalls.h                      |   2 +
 include/uapi/asm-generic/siginfo.h            |   3 +-
 include/uapi/asm-generic/unistd.h             |   2 +-
 include/uapi/linux/elf.h                      |   1 +
 ipc/shm.c                                     |   2 +-
 kernel/sys_ni.c                               |   2 +
 mm/gup.c                                      |   2 +-
 mm/huge_memory.c                              |  16 +-
 mm/memory.c                                   |   3 +-
 mm/migrate_device.c                           |   3 +-
 mm/mmap.c                                     |  22 +-
 mm/mprotect.c                                 |   7 +
 mm/nommu.c                                    |   4 +-
 mm/userfaultfd.c                              |  10 +-
 mm/util.c                                     |   2 +-
 tools/testing/selftests/x86/Makefile          |   4 +-
 .../testing/selftests/x86/test_shadow_stack.c | 646 ++++++++++++++++++
 73 files changed, 2670 insertions(+), 281 deletions(-)
 create mode 100644 Documentation/x86/cet.rst
 create mode 100644 arch/x86/include/asm/cet.h
 create mode 100644 arch/x86/kernel/proc.c
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.17.1

