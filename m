Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 898F3D4679
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfJKRUV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 13:20:21 -0400
Received: from foss.arm.com ([217.140.110.172]:38258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfJKRUV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 13:20:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADD8628;
        Fri, 11 Oct 2019 10:20:20 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C68FE3F703;
        Fri, 11 Oct 2019 10:20:17 -0700 (PDT)
Date:   Fri, 11 Oct 2019 18:20:15 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Florian Weimer <fweimer@redhat.com>,
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20191011172013.GQ27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011151028.GE33537@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 04:10:29PM +0100, Mark Rutland wrote:
> On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
> > This patch adds the bare minimum required to expose the ARMv8.5
> > Branch Target Identification feature to userspace.
> > 
> > By itself, this does _not_ automatically enable BTI for any initial
> > executable pages mapped by execve().  This will come later, but for
> > now it should be possible to enable BTI manually on those pages by
> > using mprotect() from within the target process.
> > 
> > Other arches already using the generic mman.h are already using
> > 0x10 for arch-specific prot flags, so we use that for PROT_BTI
> > here.
> > 
> > For consistency, signal handler entry points in BTI guarded pages
> > are required to be annotated as such, just like any other function.
> > This blocks a relatively minor attack vector, but comforming
> > userspace will have the annotations anyway, so we may as well
> > enforce them.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > 
> > ---
> > 
> > Changes since v1:
> > 
> >  * Configure SCTLR_EL1.BTx to disallow BR onto a PACIxSP instruction
> >    (except via X16/X17):
> > 
> >    The AArch64 procedure call standard requires binaries marked with
> >    GNU_PROPERTY_AARCH64_FEATURE_1_BTI to use X16/X17 in trampolines
> >    and tail calls, so it makes no sense to be permissive.
> > 
> >  * Rename PROT_BTI_GUARDED to PROT_BTI.
> > 
> >  * Rename VM_ARM64_GP to VM_ARM64_BTI:
> > 
> >    Although the architectural name for the BTI page table bit is "GP",
> >    BTI is nonetheless the feature it controls.  So avoid introducing
> >    the "GP" naming just for this -- it's just an unecessary extra
> >    source of confusion.
> > 
> >  * Tidy up masking with ~PSR_BTYPE_MASK.
> > 
> >  * Drop masking out of BTYPE on SVC, with a comment outlining why.
> > 
> >  * Split PSR_BTYPE_SHIFT definition into this patch.  It's not
> >    useful yet, but it makes sense to define PSR_BTYPE_* using this
> >    from the outset.
> > 
> >  * Migrate to ct_user_exit_irqoff in entry.S:el0_bti.
> 
> [...]
> 
> > diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> > new file mode 100644
> > index 0000000..cbfe3238
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/mman.h
> > @@ -0,0 +1,33 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_MMAN_H__
> > +#define __ASM_MMAN_H__
> > +
> > +#include <uapi/asm/mman.h>
> > +
> > +#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
> > +static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
> > +{
> > +	if (system_supports_bti() && (prot & PROT_BTI))
> > +		return VM_ARM64_BTI;
> > +
> > +	return 0;
> > +}
> 
> Can we call this arch_calc_vm_prot_bits() directly, with all the
> arguments:
> 
> static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> 						   unsigned long pkey)
> {
> 	...
> }
> #define arch_calc_vm_prot_bits arch_calc_vm_prot_bits
> 
> ... as that makes it a bit easier to match definition with use, and just
> definign the name makes it a bit clearer that that's probably for the
> benefit of some ifdeffery.
> 
> Likewise for the other functions here.
> 
> > +#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
> > +static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
> > +{
> > +	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
> > +}
> > +
> > +#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
> > +static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)

Can do, though it looks like a used sparc as a template, and that has a
sparc_ prefix.

powerpc uses the generic name, as does x86 ... in its UAPI headers.
Odd.

I can change the names here, though I'm not sure it adds a lot of value.

If you feel strongly I can do it.

> > +{
> > +	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
> > +
> > +	if (system_supports_bti())
> > +		supported |= PROT_BTI;
> > +
> > +	return (prot & ~supported) == 0;
> > +}
> 
> If we have this check, can we ever get into arm64_calc_vm_prot_bits()
> with PROT_BIT but !system_supports_bti()?
> 
> ... or can that become:
> 
> 	return (prot & PROT_BTI) ? VM_ARM64_BTI : 0;

We can reach this via mmap() and friends IIUC.

Since this function only gets called once-ish per vma I have a weak
preference for keeping the check here to avoid code fragility.


It does feel like arch_validate_prot() is supposed to be a generic gate
for prot flags coming into the kernel via any route though, but only the
mprotect() path actually uses it.

This function originally landed in v2.6.27 as part of the powerpc strong
access ordering support (PROT_SAO):

b845f313d78e ("mm: Allow architectures to define additional protection bits")
ef3d3246a0d0 ("powerpc/mm: Add Strong Access Ordering support")

where the mmap() path uses arch_calc_vm_prot_bits() without
arch_validate_prot(), just as in the current code.  powerpc's original
arch_calc_vm_prot_bits() does no obvious policing.


This might be a bug.  I can draft a patch to add it for the mmap() path
for people to comment on ... I can't figure out yet whether or not the
difference is intentional or there's some subtlety that I'm missed.

mmap( ... prot = -1 ... ) succeeds with effective rwx permissions and no
apparent ill effects on my random x86 box, but mprotect(..., -1) fails
with -EINVAL.

This is at least strange.

Theoretically, tightening this would be an ABI break, though I'd say
this behaviour is not intentional.

Thoughts?

[...]

Cheers
---Dave
