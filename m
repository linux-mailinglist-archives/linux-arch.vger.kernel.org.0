Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23F32E697
	for <lists+linux-arch@lfdr.de>; Fri,  5 Mar 2021 11:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEKoJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Mar 2021 05:44:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:53584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCEKnj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Mar 2021 05:43:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDAD5AF24;
        Fri,  5 Mar 2021 10:43:37 +0000 (UTC)
Date:   Fri, 5 Mar 2021 11:43:25 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, luto@kernel.org,
        x86@kernel.org, len.brown@intel.com, dave.hansen@intel.com,
        hjl.tools@gmail.com, Dave.Martin@arm.com, jannh@google.com,
        mpe@ellerman.id.au, carlos@redhat.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 3/6] x86/elf: Support a new ELF aux vector
 AT_MINSIGSTKSZ
Message-ID: <20210305104325.GA2896@zn.tnic>
References: <20210227165911.32757-1-chang.seok.bae@intel.com>
 <20210227165911.32757-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210227165911.32757-4-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 27, 2021 at 08:59:08AM -0800, Chang S. Bae wrote:
> Historically, signal.h defines MINSIGSTKSZ (2KB) and SIGSTKSZ (8KB), for
> use by all architectures with sigaltstack(2). Over time, the hardware state
> size grew, but these constants did not evolve. Today, literal use of these
> constants on several architectures may result in signal stack overflow, and
> thus user data corruption.
> 
> A few years ago, the ARM team addressed this issue by establishing
> getauxval(AT_MINSIGSTKSZ). This enables the kernel to supply at runtime
> value that is an appropriate replacement on the current and future
> hardware.
> 
> Add getauxval(AT_MINSIGSTKSZ) support to x86, analogous to the support
> added for ARM in commit 94b07c1f8c39 ("arm64: signal: Report signal frame
> size to userspace via auxv").
> 
> Also, include a documentation to describe x86-specific auxiliary vectors.
> 
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch")

Right, so this has a Fixes: tag and points to bugzilla entry which talks
about signal stack corruption with AVX-512F.

But if this is going to be backported to stable, then the patch(es)
should be minimal and not contain documentation. And if so, one will
need all three to be backported, which means, a cc:stable should contain
a comment explaining that.

Or am I misreading and they should not need to be backported to stable
because some <non-obvious reason>?

Also, I'm not sure backporting a patch to stable which changes ABI is
ok. It probably is but I don't know.

So what's the deal here?

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: H.J. Lu <hjl.tools@gmail.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: x86@kernel.org
> Cc: libc-alpha@sourceware.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-api@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
> ---
> Changes from v5:
> * Added a documentation.
> ---
>  Documentation/x86/elf_auxvec.rst   | 56 ++++++++++++++++++++++++++++++
>  arch/x86/include/asm/elf.h         |  4 +++
>  arch/x86/include/uapi/asm/auxvec.h |  4 +--
>  arch/x86/kernel/signal.c           |  5 +++
>  4 files changed, 67 insertions(+), 2 deletions(-)

You also need:

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4693e192b447..d58614d5cde6 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -35,3 +35,4 @@ x86-specific Documentation
    sva
    sgx
    features
+   elf_auxvec

to add this to the TOC.

>  create mode 100644 Documentation/x86/elf_auxvec.rst
> 
> diff --git a/Documentation/x86/elf_auxvec.rst b/Documentation/x86/elf_auxvec.rst
> new file mode 100644
> index 000000000000..751c552c4048
> --- /dev/null
> +++ b/Documentation/x86/elf_auxvec.rst
> @@ -0,0 +1,56 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +x86-specific ELF Auxiliary Vectors
> +==================================
> +
> +This document describes the semantics of the x86 auxiliary vectors.
> +
> +1. Introduction
> +---------------
> +
> +ELF Auxiliary vectors enable the kernel to efficiently provide
> +configuration specific parameters to userspace. In this example, a program
> +allocates an alternate stack based on the kernel-provided size.
> +
> +   #include <sys/auxv.h>
> +   #include <elf.h>
> +
> +   #ifndef AT_MINSIGSTKSZ
> +   #define AT_MINSIGSTKSZ	51
> +   #endif
> +
> +   stack_t ss;
> +   int err;
> +
> +   ss.ss_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
> +   ss.ss_sp = malloc(ss.ss_size);
> +   ...
> +
> +   err = sigaltstack(&ss, NULL);
> +   ...

That source code needs some special markup to look like source code -
currently, the result looks bad.

> +
> +
> +2. The exposed auxiliary vectors
> +---------------------------------
> +
> +AT_SYSINFO
> +    The entry point to the system call function the virtual Dynamic Shared
> +    Object (vDSO), not exported on 64-bit.

I can't parse that sentence.

> +
> +AT_SYSINFO_EHDR
> +    The start address of the page containing vDSO.
						^
						the


> +
> +AT_MINSIGSTKSZ
> +    The minimum stack size required to deliver a signal. It is a calculated
> +    sigframe size based on the largest possible user context. When programs
> +    use sigaltstack() to provide alternate signal stack, that stack must be
> +    at least the size to function properly on this hardware. Note that this
> +    is a minimum of the kernel to correctly get to the signal handler.

I get what this is trying to say but it reads weird. Simplify pls.

> +    Additional space must be added to handle objects pushed onto the stack
> +    by the signal handlers, as well as for nested signal delivery.
> +
> +    The purpose of this parameter is to accommodate the different stack
> +    sizes required by different hardware configuration. E.g., the x86
> +    system supporting the Advanced Vector Extension needs at least 8KB more
> +    than the one without it.

That could be simplified too.

> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 66bdfe838d61..cd10795c178e 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -312,6 +312,7 @@ do {									\
>  		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
>  		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
>  	}								\
> +	NEW_AUX_ENT(AT_MINSIGSTKSZ, get_sigframe_size());			\

Check vertical alignment of the '\'

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
