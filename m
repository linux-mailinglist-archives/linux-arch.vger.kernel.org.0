Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C716EF9E
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 21:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgBYUCp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Feb 2020 15:02:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33560 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgBYUCl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:02:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so131209pfn.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQeUDKl06LgoNFBc6pEk0PTumVXMZ4mVvEuwrAXI7uY=;
        b=XoIPfLemR94vEOoPzPzdFPogDmamx8wLH/WM1VQteQRzvhT6GB8xsPWtaqFEXeUA0W
         ZHK7/MHB3AGkPwIDVpP9Mdpf8YwBKBsuBd8JN+CaUcGHXIrIdNPeBtqhhOqbhndtDa4O
         Psa/qNyDQLJdzTMyOWS0H6G6U4b2SAZ+OWP2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQeUDKl06LgoNFBc6pEk0PTumVXMZ4mVvEuwrAXI7uY=;
        b=HzMCuyMEtqUE/568r3105pGQtAYWuZnZ8SWafmEHob9lLN/iSnZypAC/LQPrXuB9F1
         vCCZnqhyyDN+rVkSuTrAApq9V/lJ5rJegOiOIZHj9pnZOvZLzeockocf/tKEeZ8RYwWi
         88QUOkw3rtwZ3VXch2Dt1c2cBQj8kEA5adD77eikpWz8Ob9Upvk0G1NxIwUMMHgtP0Pz
         G9jhnQDV/5/A+bR7Qk6SamI0Qynr5ffIriNKgq3tTgKpd6O+Xbz5qHMIYtvwjgufbgGu
         wU6DdJP817aqQhhHoKtOd2KXRoi61NmZBEpXyKgJUFv7aKy7jxN+h/GOebFfrNElqsZ6
         8w7A==
X-Gm-Message-State: APjAAAXRPrsBUlJH5WU6rPSYiUVMm/mbCvttDs0ZEC3VffaxLgMvHOXw
        jm/c4cbxLn54QnAhlB1X5DJW1Q==
X-Google-Smtp-Source: APXvYqyT2ZJiB1WbvNfuBRYqOcrKs1wCxNkM+RFoTBr4uFL/8c6Jfd6+X7eg9jWaE+LP0V+Hol7+5A==
X-Received: by 2002:a65:4382:: with SMTP id m2mr190612pgp.3.1582660959080;
        Tue, 25 Feb 2020 12:02:39 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n2sm17404161pgi.48.2020.02.25.12.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:02:38 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:02:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 01/27] Documentation/x86: Add CET description
Message-ID: <202002251159.939AA6A@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-2-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-2-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:09AM -0800, Yu-cheng Yu wrote:
> Explain no_cet_shstk/no_cet_ibt kernel parameters, and introduce a new
> document on Control-flow Enforcement Technology (CET).
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

I'm not a huge fan of the boot param names, but I can't suggest anything
better. ;) I love the extensive docs!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../admin-guide/kernel-parameters.txt         |   6 +
>  Documentation/x86/index.rst                   |   1 +
>  Documentation/x86/intel_cet.rst               | 294 ++++++++++++++++++
>  3 files changed, 301 insertions(+)
>  create mode 100644 Documentation/x86/intel_cet.rst
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..8b69ebf0baed 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3001,6 +3001,12 @@
>  			noexec=on: enable non-executable mappings (default)
>  			noexec=off: disable non-executable mappings
>  
> +	no_cet_shstk	[X86-64] Disable Shadow Stack for user-mode
> +			applications
> +
> +	no_cet_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
> +			applications
> +
>  	nosmap		[X86,PPC]
>  			Disable SMAP (Supervisor Mode Access Prevention)
>  			even if it is supported by processor.
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
> +protect both applications and the kernel.  In the first phase, only
> +user-mode protection is implemented in the 64-bit kernel; 32-bit
> +applications are supported in compatibility mode.
> +
> +CET introduces Shadow Stack (SHSTK) and Indirect Branch Tracking
> +(IBT).  SHSTK is a secondary stack allocated from memory and cannot
> +be directly modified by applications.  When executing a CALL, the
> +processor pushes a copy of the return address to SHSTK.  Upon
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
> +are required.  To build a CET-enabled application, GLIBC v2.28 or
> +later is also required.
> +
> +There are two command-line options for disabling CET features::
> +
> +    no_cet_shstk - disables SHSTK, and
> +    no_cet_ibt   - disables IBT.
> +
> +At run time, /proc/cpuinfo shows the availability of SHSTK and IBT.
> +
> +[2] CET assembly instructions
> +=============================
> +
> +RDSSP %r
> +    Read the SHSTK pointer into %r.
> +
> +INCSSP %r
> +    Unwind (increment) the SHSTK pointer (0 ~ 255) steps as indicated
> +    in the operand register.  The GLIBC longjmp uses INCSSP to unwind
> +    the SHSTK until that matches the program stack.  When it is
> +    necessary to unwind beyond 255 steps, longjmp divides and repeats
> +    the process.
> +
> +RSTORSSP (%r)
> +    Switch to the SHSTK indicated in the 'restore token' pointed by
> +    the operand register and replace the 'restore token' with a new
> +    token to be saved (with SAVEPREVSSP) for the outgoing SHSTK.
> +
> +::
> +
> +                                Before RSTORSSP
> +
> +               Incoming SHSTK                 Current/Outgoing SHSTK
> +
> +          |----------------------|           |----------------------|
> +   addr=x |                      |     ssp-> |                      |
> +          |----------------------|           |----------------------|
> +   (%r)-> | rstor_token=(x|Lg)   |  addr=y-8 |                      |
> +          |----------------------|           |----------------------|
> +
> +                                After RSTORSSP
> +
> +          |----------------------|           |----------------------|
> +   addr=x |                      |           |                      |
> +          |----------------------|           |----------------------|
> +    ssp-> | rstor_token=(y|Pv|Lg)|  addr=y-8 |                      |
> +          |----------------------|           |----------------------|
> +
> +    note:
> +        1. Only valid addresses and restore tokens can be on the
> +           user-mode SHSTK.
> +        2. A token is always of type u64 and must align to u64.
> +        3. The incoming SHSTK pointer in a rstor_token must point to
> +           immediately above the token.
> +        4. 'Lg' is bit[0] of a rstor_token indicating a 64-bit SHSTK.
> +        5. 'Pv' is bit[1] of a rstor_token indicating the token is to
> +           be used only for the next SAVEPREVSSP and invalid for
> +           RSTORSSP.
> +
> +SAVEPREVSSP
> +    Pop the SHSTK 'restore token' pointed by current SHSTK pointer
> +    and store it at (previous SHSTK pointer - 8).
> +
> +::
> +
> +                               After SAVEPREVSSP
> +
> +          |----------------------|           |----------------------|
> +    ssp-> |                      |           |                      |
> +          |----------------------|           |----------------------|
> + addr=x-8 | rstor_token=(y|Pv|Lg)|  addr=y-8 | rstor_token(y|Lg)    |
> +          |----------------------|           |----------------------|
> +
> +WRUSS %r0, (%r1)
> +    Write the value in %r0 to the SHSTK address pointed by (%r1).
> +    This is a kernel-mode only instruction.
> +
> +ENDBR and NOTRACK prefix
> +    When IBT is enabled, an indirect CALL/JMP must either::
> +
> +        have a NOTRACK prefix,
> +        reach an ENDBR, or
> +        reach an address within a legacy code page;
> +
> +    or it results in a control-protection fault.
> +
> +    When the target address is derived from information that cannot
> +    be modified, the compiler uses the NOTRACK prefix.  In other
> +    cases, the compiler inserts an ENDBR at the target address.
> +
> +    A legacy code page is designated in the legacy code bitmap, which
> +    is explained below in section [8].
> +
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
> +
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
> +
> +[5] CET system calls
> +====================
> +
> +The following arch_prctl() system calls are added for CET:
> +
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
> +
> +arch_prctl(ARCH_X86_CET_ALLOC_SHSTK, unsigned long *addr)
> +    Allocate a new SHSTK and put a restore token at top.
> +
> +    The parameter 'addr' is a pointer to a user buffer and indicates
> +    the desired SHSTK size to allocate.  On returning to the caller,
> +    the kernel fills '*addr' with the base address of the new SHSTK.
> +
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
> +
> +  The parameters passed are always unsigned 64-bit.  When an IA32
> +  application passing pointers, it should only use the lower 32 bits.
> +
> +[6] The implementation of the SHSTK
> +===================================
> +
> +SHSTK size
> +----------
> +
> +A task's SHSTK is allocated from memory to a fixed size of
> +RLIMIT_STACK.  A compat-mode thread's SHSTK size is 1/4 of
> +RLIMIT_STACK.  The smaller 32-bit thread SHSTK allows more threads to
> +share a 32-bit address space.
> +
> +Signal
> +------
> +
> +The main program and its signal handlers use the same SHSTK.  Because
> +the SHSTK stores only return addresses, a large SHSTK will cover the
> +condition that both the program stack and the sigaltstack run out.
> +
> +The kernel creates a restore token at the SHSTK restoring address and
> +verifies that token when restoring from the signal handler.
> +
> +IBT for signal delivering and sigreturn is the same as the main
> +program's setup; except for WAIT_ENDBR status, which can be read from
> +MSR_IA32_U_CET.  In general, a task is in WAIT_ENDBR after an
> +indirect CALL/JMP and before the next instruction starts.
> +
> +A task's WAIT_ENDBR is reset for its signal handler, but preserved on
> +the task's stack; and then restored from sigreturn.
> +
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
> +
> +When a pthread child is created, the kernel allocates a new SHSTK for
> +the new thread.
> +
> +Setjmp/Longjmp
> +--------------
> +
> +Longjmp unwinds SHSTK until it matches the program stack.
> +
> +Ucontext
> +--------
> +
> +In GLIBC, getcontext/setcontext is implemented in similar way as
> +setjmp/longjmp.
> +
> +When makecontext creates a new ucontext, a new SHSTK is allocated for
> +that context with ARCH_X86_CET_ALLOC_SHSTK syscall.  The kernel
> +creates a restore token at the top of the new SHSTK and the user-mode
> +code switches to the new SHSTK with the RSTORSSP instruction.
> +
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
> +
> +[8] The implementation of IBT legacy bitmap
> +===========================================
> +
> +When IBT is active, a non-IBT-capable legacy library can be executed
> +if its address ranges are specified in the legacy code bitmap.  The
> +bitmap covers the whole user-space address, which is TASK_SIZE_MAX
> +for 64-bit and TASK_SIZE for IA32, and its each bit indicates a 4-KB
> +legacy code page.  It is read-only from an application, and setup by
> +the kernel as a special mapping when the first time the application
> +calls arch_prctl(ARCH_X86_CET_MARK_LEGACY_CODE).  The application
> +manages the bitmap through the arch_prctl.
> -- 
> 2.21.0
> 

-- 
Kees Cook
