Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52E29A63
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 16:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfEXOxM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 10:53:12 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44662 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403860AbfEXOxM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 May 2019 10:53:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A735080D;
        Fri, 24 May 2019 07:53:11 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27EFA3F575;
        Fri, 24 May 2019 07:53:09 -0700 (PDT)
Date:   Fri, 24 May 2019 15:53:06 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arch@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Andrew Jones <drjones@redhat.com>,
        Paul Elliott <paul.elliott@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/8] arm64: Basic Branch Target Identification support
Message-ID: <20190524145306.GZ28398@e103592.cambridge.arm.com>
References: <1558693533-13465-1-git-send-email-Dave.Martin@arm.com>
 <1558693533-13465-5-git-send-email-Dave.Martin@arm.com>
 <20190524130217.GA15566@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524130217.GA15566@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 24, 2019 at 02:02:17PM +0100, Mark Rutland wrote:
> Hi Dave,
> 
> This generally looks good, but I have a few comments below.
> 
> On Fri, May 24, 2019 at 11:25:29AM +0100, Dave Martin wrote:
> > +#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
> > +static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
> > +{
> > +	if (system_supports_bti() && (prot & PROT_BTI_GUARDED))
> > +		return VM_ARM64_GP;
> > +
> > +	return 0;
> > +}
> > +
> > +#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
> > +static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
> > +{
> > +	return (vm_flags & VM_ARM64_GP) ? __pgprot(PTE_GP) : __pgprot(0);
> > +}
> 
> While the architectural name for the PTE bit is GP, it might make more
> sense to call the vm flag VM_ARM64_BTI, since people are more likely to
> recognise BTI than GP as a mnemonic.
> 
> Not a big deal either way, though.

I'm happy to change it.  It's a kernel internal flag used in
approximately zero places.  So whatever name is most intuitive for
kernel maintainers is fine.  Nobody else needs to look at it.

> > diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> > index b2de329..b868ef11 100644
> > --- a/arch/arm64/include/asm/ptrace.h
> > +++ b/arch/arm64/include/asm/ptrace.h
> > @@ -41,6 +41,7 @@
> >  
> >  /* Additional SPSR bits not exposed in the UABI */
> >  #define PSR_IL_BIT		(1 << 20)
> > +#define PSR_BTYPE_CALL		(2 << 10)
> 
> I thought BTYPE was a 2-bit field, so isn't there at leat one other
> value to have a mnemonic for?
> 
> Is it an enumeration or a bitmask?

It's a 2-bit enumeration, and for now this is the only value that the
kernel uses: this determines the types of BTI landing pad permitted at
signal handler entry points in BTI guarded pages.

Possibly it would be clearer to write it

#define PSR_BTYPE_CALL		(0b10 << 10)

but we don't write other ptrace.h constants this way.  In UAPI headers
we should avoid GCC-isms, but here it's OK since we already rely on this
syntax internally.

I can change it if you prefer, though my preference is to leave it.

> >  #endif /* _UAPI__ASM_HWCAP_H */
> > diff --git a/arch/arm64/include/uapi/asm/mman.h b/arch/arm64/include/uapi/asm/mman.h
> > new file mode 100644
> > index 0000000..4776b43
> > --- /dev/null
> > +++ b/arch/arm64/include/uapi/asm/mman.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI__ASM_MMAN_H
> > +#define _UAPI__ASM_MMAN_H
> > +
> > +#include <asm-generic/mman.h>
> > +
> > +#define PROT_BTI_GUARDED	0x10		/* BTI guarded page */
> 
> From prior discussions, I thought this would be PROT_BTI, without the
> _GUARDED suffix. Do we really need that?
> 
> AFAICT, all other PROT_* definitions only have a single underscore, and
> the existing arch-specific flags are PROT_ADI on sparc, and PROT_SAO on
> powerpc.

No strong opinon.  I was trying to make the name less obscure, but I'm
equally happy with PROT_BTI if people prefer that.

> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index b82e0a9..3717b06 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -1860,7 +1860,7 @@ void syscall_trace_exit(struct pt_regs *regs)
> >   */
> >  #define SPSR_EL1_AARCH64_RES0_BITS \
> >  	(GENMASK_ULL(63, 32) | GENMASK_ULL(27, 25) | GENMASK_ULL(23, 22) | \
> > -	 GENMASK_ULL(20, 13) | GENMASK_ULL(11, 10) | GENMASK_ULL(5, 5))
> > +	 GENMASK_ULL(20, 13) | GENMASK_ULL(5, 5))
> >  #define SPSR_EL1_AARCH32_RES0_BITS \
> >  	(GENMASK_ULL(63, 32) | GENMASK_ULL(22, 22) | GENMASK_ULL(20, 20))
> 
> Phew; I was worried this would be missed!

It was.  I had fun debugging that one :)

> > @@ -741,6 +741,11 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
> >  	regs->regs[29] = (unsigned long)&user->next_frame->fp;
> >  	regs->pc = (unsigned long)ka->sa.sa_handler;
> >  
> > +	if (system_supports_bti()) {
> > +		regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);
> 
> Nit: that can be:
> 
> 		regs->pstate &= ~PSR_BTYPE_MASK;

x & ~y is sensitive to the type of y and can clobber high bits, so I
prefer not to write it.  GCC generates the same code either way.

However, this will also trip us up elsewhere when the time comes, so
maybe it's a waste of time working around it here.

If you feel strongly, I'm happy to change it.

> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 5610ac0..85b456b 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -66,6 +66,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >  	unsigned long flags = current_thread_info()->flags;
> >  
> >  	regs->orig_x0 = regs->regs[0];
> > +	regs->pstate &= ~(regs->pstate & PSR_BTYPE_MASK);
> 
> Likewise:
> 
> 	regs->pstate &= ~PSR_BTYPE_MASK;
> 
> ... though I don't understand why that would matter to syscalls, nor how
> those bits could ever be set given we had to execute an SVC to get here.
> 
> What am I missing?

The behaviour is counterintuivite here.  The architecture guarantees to
preserve BTYPE for traps, faults and asynchronous exceptions, but for a
synchronous execption from normal architectural execution of an
exception-generating instruction (SVC/HVC/SMC) the architecture leaves
it IMP DEF whether BTYPE is preserved or zeroed in SPSR.

I suppose precisely because there's only one way to reach the SVC
handler, software knows for certain whether zero SPSR.BTYPE in that
case.  So hardware doesn't need to do it.

This may also simplify some trapping/emulation scenarios, but I need to
think about that.

Hmmm, I need to go and look at the HVC entry points and SMC emulation in
KVM though -- similar issues likely apply.  I didn't look.

Same for the bootwrapper, and anything else with exception vectors.

[...]

Cheers
---Dave
