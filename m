Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF31B1706CA
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 18:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBZR5Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 12:57:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:37586 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgBZR5X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 12:57:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 09:57:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="241750174"
Received: from kcanfiel-mobl1.amr.corp.intel.com (HELO [10.251.18.127]) ([10.251.18.127])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2020 09:57:21 -0800
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-2-yu-cheng.yu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <9ae1cf84-1d84-1d34-c0ce-48b0d70b8f3f@intel.com>
Date:   Wed, 26 Feb 2020 09:57:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-2-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

> index ade4e6ec23e0..8b69ebf0baed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3001,6 +3001,12 @@
>  			noexec=on: enable non-executable mappings (default)
>  			noexec=off: disable non-executable mappings
>  
> +	no_cet_shstk	[X86-64] Disable Shadow Stack for user-mode
> +			applications

If we ever add kernel support, "no_cet_shstk" will mean "no cet shstk
for userspace"?

> +	no_cet_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
> +			applications
> +
>  	nosmap		[X86,PPC]
>  			Disable SMAP (Supervisor Mode Access Prevention)
>  			even if it is supported by processor.

BTW, this documentation is misplaced.  It needs to go to the spot where
you introduce the code for these options.

> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index a8de2fbc1caa..81f919801765 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -19,6 +19,7 @@ x86-specific Documentation
>     tlb
>     mtrr
>     pat
> +   intel_cet
>     intel_mpx
>     intel-iommu
>     intel_txt
> diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
> new file mode 100644
> index 000000000000..71e2462fea5c
> --- /dev/null
> +++ b/Documentation/x86/intel_cet.rst
> @@ -0,0 +1,294 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=========================================
> +Control-flow Enforcement Technology (CET)
> +=========================================
> +
> +[1] Overview
> +============
> +
> +Control-flow Enforcement Technology (CET) provides protection against
> +return/jump-oriented programming (ROP) attacks.  It can be setup to

							      ^ set up

> +protect both applications and the kernel.  In the first phase, only
> +user-mode protection is implemented in the 64-bit kernel; 32-bit
> +applications are supported in compatibility mode.

Please just say what *is* at the time of the writing.  We don't need to
talk about "phases".

Also, you haven't mentioned that this is a *hardware* feature and that
it's only on Intel CPUs at the moment.  That's kinda essential.  If I've
got an AMD CPU, I can just stop reading. :)

The hardware supports shadow stacks for both userspace and the kernel in
both 32 and 64-bit modes.  32-bit kernel support is not implemented.
Both 32-bit and 64-bit user applications can run on 64-bit kernels.

This is also missing the same key points about enabling as the Kconfig
text: apps don't get this for free and must be specifically enabled.

> +CET introduces Shadow Stack (SHSTK) and Indirect Branch Tracking
> +(IBT).  SHSTK is a secondary stack allocated from memory and cannot
> +be directly modified by applications.  When executing a CALL, the
> +processor pushes a copy of the return address to SHSTK. 

... and to the normal stack

>  Upon
> +function return, the processor pops the SHSTK copy and compares it
> +to the one from the program stack.  If the two copies differ, the
> +processor raises a control-protection fault.  IBT verifies indirect
> +CALL/JMP targets are intended as marked by the compiler with 'ENDBR'
> +opcodes (see CET instructions below).
> +
> +There are two kernel configuration options:
> +
> +    X86_INTEL_SHADOW_STACK_USER, and
> +    X86_INTEL_BRANCH_TRACKING_USER.
> +
> +To build a CET-enabled kernel, Binutils v2.31 and GCC v8.1 or later
> +are required.

Why are these needed to build a CET-enabled kernel?

>  To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +There are two command-line options for disabling CET features::
> +
> +    no_cet_shstk - disables SHSTK, and
> +    no_cet_ibt   - disables IBT.
> +
> +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.

Availability of what?

If I set X86_INTEL_SHADOW_STACK_USER=n, I'll still see the cpuinfo
flags, but I won't have runtime support.

Probably best to say that cpuinfo tells you about processor support only.

> +[2] CET assembly instructions
> +=============================

Why do we need this in the kernel?  What is specific to Linux or the
kernel?  Why wouldn't I just go read the SDM if I want to know how the
instructions work?

> +[3] Application Enabling
> +========================
> +
> +An application's CET capability is marked in its ELF header and can
> +be verified from the following command output, in the
> +NT_GNU_PROPERTY_TYPE_0 field:
> +
> +    readelf -n <application>
> +
> +If an application supports CET and is statically linked, it will run
> +with CET protection.  If the application needs any shared libraries,
> +the loader checks all dependencies and enables CET only when all
> +requirements are met.

What about shared libraries loaded after the program starts?

> +[4] Legacy Libraries
> +====================
> +
> +GLIBC provides a few tunables for backward compatibility.
> +
> +GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
> +    Turn off SHSTK/IBT for the current shell.
> +
> +GLIBC_TUNABLES=glibc.tune.x86_shstk=<on, permissive>
> +    This controls how dlopen() handles SHSTK legacy libraries::
> +
> +        on         - continue with SHSTK enabled;
> +        permissive - continue with SHSTK off.

This seems like manpage fodder more than kernel documentation to me.

> +[5] CET system calls
> +====================
> +
> +The following arch_prctl() system calls are added for CET:

FWIW, I wouldn't call each of these a "system call".

"Several arch_prctl()'s have been added for CET:"

> +arch_prctl(ARCH_X86_CET_STATUS, unsigned long *addr)
> +    Return CET feature status.
> +
> +    The parameter 'addr' is a pointer to a user buffer.
> +    On returning to the caller, the kernel fills the following
> +    information::
> +
> +        *addr       = SHSTK/IBT status
> +        *(addr + 1) = SHSTK base address
> +        *(addr + 2) = SHSTK size
> +
> +arch_prctl(ARCH_X86_CET_DISABLE, unsigned long features)
> +    Disable SHSTK and/or IBT specified in 'features'.  Return -EPERM
> +    if CET is locked.
> +
> +arch_prctl(ARCH_X86_CET_LOCK)
> +    Lock in CET feature.

Shouldn't this say what "locking" means?

> +arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, unsigned long *addr)
> +    Allocate a new SHSTK and put a restore token at top.
> +
> +    The parameter 'addr' is a pointer to a user buffer and indicates
> +    the desired SHSTK size to allocate.  On returning to the caller,
> +    the kernel fills '*addr' with the base address of the new SHSTK.



> +arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE, unsigned long *addr)
> +    Mark an address range as IBT legacy code.
> +
> +    The parameter 'addr' is a pointer to a user buffer that has the
> +    following information::
> +
> +        *addr       = starting linear address of the legacy code
> +        *(addr + 1) = size of the legacy code
> +        *(addr + 2) = set (1); clear (0)
> +
> +Note:
> +  There is no CET-enabling arch_prctl function.  By design, CET is
> +  enabled automatically if the binary and the system can support it.

This is kinda interesting.  It means that a JIT couldn't choose to
protect the code it generates and have different rules from itself?

> +  The parameters passed are always unsigned 64-bit.  When an IA32
> +  application passing pointers, it should only use the lower 32 bits.

Won't a 32-bit app calling prctl() use the 32-bit ABI?  How would it
even know it's running on a 64-bit kernel?

> +[6] The implementation of the SHSTK
> +===================================
> +
> +SHSTK size
> +----------
> +
> +A task's SHSTK is allocated from memory to a fixed size of
> +RLIMIT_STACK.

I can't really parse that sentence.  Is this saying that shadow stacks
are limited by and share space with normal stacks via RLIMIT_STACK?

>  A compat-mode thread's SHSTK size is 1/4 of
> +RLIMIT_STACK.  The smaller 32-bit thread SHSTK allows more threads to
> +share a 32-bit address space.

I thought the size was passed in from userspace?  Where does this sizing
take place?  Is this a convention or is it being enforced?

> +Signal
> +------
> +
> +The main program and its signal handlers use the same SHSTK.  Because
> +the SHSTK stores only return addresses, a large SHSTK will cover the
> +condition that both the program stack and the sigaltstack run out.

						 ^ typo?

I'm not sure what this is trying to say.

> +The kernel creates a restore token at the SHSTK restoring address and
> +verifies that token when restoring from the signal handler.

I think there's a sentence or two of background missing here.  I'm
really lost as to what this is trying to tell me.

> +IBT for signal delivering and sigreturn is the same as the main
> +program's setup; except for WAIT_ENDBR status, which can be read from
> +MSR_IA32_U_CET.  In general, a task is in WAIT_ENDBR after an
> +indirect CALL/JMP and before the next instruction starts.

I'm 100% lost.  I have no idea what this is trying to tell me or why it
is relevant to the kernel.

> +Fork
> +----
> +
> +The SHSTK's vma has VM_SHSTK flag set; its PTEs are required to be
> +read-only and dirty.  When a SHSTK PTE is not present, RO, and dirty,
> +a SHSTK access triggers a page fault with an additional SHSTK bit set
> +in the page fault error code.
> +
> +When a task forks a child, its SHSTK PTEs are copied and both the
> +parent's and the child's SHSTK PTEs are cleared of the dirty bit.
> +Upon the next SHSTK access, the resulting SHSTK page fault is handled
> +by page copy/re-use.

What's the most important thing about shadow stacks and fork()?  Does
this documentation tell that to the reader?

> +When a pthread child is created, the kernel allocates a new SHSTK for
> +the new thread.

Why is this here?  Are pthread children created work fork()?

> +Setjmp/Longjmp
> +--------------
> +
> +Longjmp unwinds SHSTK until it matches the program stack.

I'm missing what this has to do with the kernel.

> +Ucontext
> +--------
> +
> +In GLIBC, getcontext/setcontext is implemented in similar way as
> +setjmp/longjmp.
> +
> +When makecontext creates a new ucontext, a new SHSTK is allocated for
> +that context with ARCH_X86_CET_ALLOC_SHSTK syscall.  The kernel

Nit: ARCH_X86_CET_ALLOC_SHSTK is not a syscall.

> +creates a restore token at the top of the new SHSTK and the user-mode
> +code switches to the new SHSTK with the RSTORSSP instruction.

This seems like a howto for doing user-level threading.  It seems like
it could be replaced by a single sentence in the
ARCH_X86_CET_ALLOC_SHSTK documentation explaining that new shadow stacks
are generally (always??) allocated along with new stacks.  Since new
clone() threads need a new stack, they also need a new shadow stack.
User-level threads that need a new stack are also expected to allocate a
new shadow stack.

Right?

> +[7] The management of read-only & dirty PTEs for SHSTK
> +======================================================
> +
> +A RO and dirty PTE exists in the following cases:
> +
> +(a) A page is modified and then shared with a fork()'ed child;
> +(b) A R/O page that has been COW'ed;
> +(c) A SHSTK page.
> +
> +The processor only checks the dirty bit for (c).  To prevent the use
> +of non-SHSTK memory as SHSTK, we use a spare bit of the 64-bit PTE as
> +DIRTY_SW for (a) and (b) above.  This results to the following PTE
> +settings::
> +
> +    Modified PTE:             (R/W + DIRTY_HW)
> +    Modified and shared PTE:  (R/O + DIRTY_SW)
> +    R/O PTE, COW'ed:          (R/O + DIRTY_SW)
> +    SHSTK PTE:                (R/O + DIRTY_HW)
> +    SHSTK PTE, COW'ed:        (R/O + DIRTY_HW)
> +    SHSTK PTE, shared:        (R/O + DIRTY_SW)
> +
> +Note that DIRTY_SW is only used in R/O PTEs but not R/W PTEs.

I really don't think this belongs in the documentation, especially since
it's duplicated almost verbatim in code comments.

> +[8] The implementation of IBT legacy bitmap
> +===========================================
> +
> +When IBT is active, a non-IBT-capable legacy library can be executed
> +if its address ranges are specified in the legacy code bitmap.  The
> +bitmap covers the whole user-space address, which is TASK_SIZE_MAX
> +for 64-bit and TASK_SIZE for IA32, and its each bit indicates a 4-KB
> +legacy code page.  It is read-only from an application, and setup by

								^ set up

> +the kernel as a special mapping when the first time the application
> +calls arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE).  The application
> +manages the bitmap through the arch_prctl.



