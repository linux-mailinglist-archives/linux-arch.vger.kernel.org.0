Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B166ED43E0
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 17:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfJKPKf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 11:10:35 -0400
Received: from foss.arm.com ([217.140.110.172]:35370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfJKPKf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 11:10:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C38A142F;
        Fri, 11 Oct 2019 08:10:34 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63DC13F68E;
        Fri, 11 Oct 2019 08:10:31 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:10:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Sudakshina Das <sudi.das@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20191011151028.GE33537@lakrids.cambridge.arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
> This patch adds the bare minimum required to expose the ARMv8.5
> Branch Target Identification feature to userspace.
> 
> By itself, this does _not_ automatically enable BTI for any initial
> executable pages mapped by execve().  This will come later, but for
> now it should be possible to enable BTI manually on those pages by
> using mprotect() from within the target process.
> 
> Other arches already using the generic mman.h are already using
> 0x10 for arch-specific prot flags, so we use that for PROT_BTI
> here.
> 
> For consistency, signal handler entry points in BTI guarded pages
> are required to be annotated as such, just like any other function.
> This blocks a relatively minor attack vector, but comforming
> userspace will have the annotations anyway, so we may as well
> enforce them.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> ---
> 
> Changes since v1:
> 
>  * Configure SCTLR_EL1.BTx to disallow BR onto a PACIxSP instruction
>    (except via X16/X17):
> 
>    The AArch64 procedure call standard requires binaries marked with
>    GNU_PROPERTY_AARCH64_FEATURE_1_BTI to use X16/X17 in trampolines
>    and tail calls, so it makes no sense to be permissive.
> 
>  * Rename PROT_BTI_GUARDED to PROT_BTI.
> 
>  * Rename VM_ARM64_GP to VM_ARM64_BTI:
> 
>    Although the architectural name for the BTI page table bit is "GP",
>    BTI is nonetheless the feature it controls.  So avoid introducing
>    the "GP" naming just for this -- it's just an unecessary extra
>    source of confusion.
> 
>  * Tidy up masking with ~PSR_BTYPE_MASK.
> 
>  * Drop masking out of BTYPE on SVC, with a comment outlining why.
> 
>  * Split PSR_BTYPE_SHIFT definition into this patch.  It's not
>    useful yet, but it makes sense to define PSR_BTYPE_* using this
>    from the outset.
> 
>  * Migrate to ct_user_exit_irqoff in entry.S:el0_bti.

[...]

> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> new file mode 100644
> index 0000000..cbfe3238
> --- /dev/null
> +++ b/arch/arm64/include/asm/mman.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#include <uapi/asm/mman.h>
> +
> +#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
> +static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
> +{
> +	if (system_supports_bti() && (prot & PROT_BTI))
> +		return VM_ARM64_BTI;
> +
> +	return 0;
> +}

Can we call this arch_calc_vm_prot_bits() directly, with all the
arguments:

static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
						   unsigned long pkey)
{
	...
}
#define arch_calc_vm_prot_bits arch_calc_vm_prot_bits

... as that makes it a bit easier to match definition with use, and just
definign the name makes it a bit clearer that that's probably for the
benefit of some ifdeffery.

Likewise for the other functions here.

> +#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
> +static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
> +{
> +	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
> +}
> +
> +#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
> +static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)
> +{
> +	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
> +
> +	if (system_supports_bti())
> +		supported |= PROT_BTI;
> +
> +	return (prot & ~supported) == 0;
> +}

If we have this check, can we ever get into arm64_calc_vm_prot_bits()
with PROT_BIT but !system_supports_bti()?

... or can that become:

	return (prot & PROT_BTI) ? VM_ARM64_BTI : 0;

> +#endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 3df60f9..f85d1fc 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -150,6 +150,7 @@
>  #define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
>  #define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
>  #define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
> +#define PTE_GP			(_AT(pteval_t, 1) << 50)	/* BTI guarded */

As a heads-up for anyone looking at the latest ARM ARM (ARM DDI
0487E.a), GP is missing from some of the descriptions of the table
formats in section D5.3.1 in the latest ARM ARM (ARM DDI 0487E.a), which
imply it's RES0.

It looks like that'll be fixed for the next release.

[...]

> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 84a8227..6c5adea 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -737,6 +737,8 @@ el0_sync:
>  	b.eq	el0_pc
>  	cmp	x24, #ESR_ELx_EC_UNKNOWN	// unknown exception in EL0
>  	b.eq	el0_undef
> +	cmp	x24, #ESR_ELx_EC_BTI		// branch target exception
> +	b.eq	el0_bti
>  	cmp	x24, #ESR_ELx_EC_BREAKPT_LOW	// debug exception in EL0
>  	b.ge	el0_dbg
>  	b	el0_inv
> @@ -887,6 +889,15 @@ el0_undef:
>  	mov	x0, sp
>  	bl	do_undefinstr
>  	b	ret_to_user
> +el0_bti:
> +	/*
> +	 * Branch target exception
> +	 */
> +	ct_user_exit_irqoff
> +	enable_daif
> +	mov	x0, sp
> +	bl	do_bti
> +	b	ret_to_user

As a heads-up, this'll conflict with James's conversion of the sync
entry points to C.

> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index dd2cdc0..4a3bd32 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -730,6 +730,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
>  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
>  	regs->pc = (unsigned long)ka->sa.sa_handler;
>  
> +	if (system_supports_bti()) {
> +		regs->pstate &= ~PSR_BTYPE_MASK;
> +		regs->pstate |= PSR_BTYPE_CALL;
> +	}
> +

I think we might need a comment as to what we're trying to ensure here.

I was under the (perhaps mistaken) impression that we'd generate a
pristine pstate for a signal handler, and it's not clear to me that we
must ensure the first instruction is a target instruction.

[...]

> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 34739e8..15e3c4f 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -406,6 +406,12 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
>  	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
>  }
>  
> +asmlinkage void __exception do_bti(struct pt_regs *regs)
> +{
> +	BUG_ON(!user_mode(regs));
> +	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
> +}

This was only wired up into the EL0 sync entry paths, so I think we can
drop the BUG_ON() -- we don't have similar in other EL0-only paths.

Thanks,
Mark.
