Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53460DC3C2
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 13:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404781AbfJRLQc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 07:16:32 -0400
Received: from [217.140.110.172] ([217.140.110.172]:35572 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2404572AbfJRLQc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 07:16:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18428B56;
        Fri, 18 Oct 2019 04:16:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4D4D3F6C4;
        Fri, 18 Oct 2019 04:16:05 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:16:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
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
        linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>,
        Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 05/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20191018111603.GD27759@lakrids.cambridge.arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
 <20191011172013.GQ27757@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011172013.GQ27757@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[adding mm folk]

On Fri, Oct 11, 2019 at 06:20:15PM +0100, Dave Martin wrote:
> On Fri, Oct 11, 2019 at 04:10:29PM +0100, Mark Rutland wrote:
> > On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
> > > +#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
> > > +static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)
> > > +{
> > > +	unsigned long supported = PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM;
> > > +
> > > +	if (system_supports_bti())
> > > +		supported |= PROT_BTI;
> > > +
> > > +	return (prot & ~supported) == 0;
> > > +}
> > 
> > If we have this check, can we ever get into arm64_calc_vm_prot_bits()
> > with PROT_BIT but !system_supports_bti()?
> > 
> > ... or can that become:
> > 
> > 	return (prot & PROT_BTI) ? VM_ARM64_BTI : 0;
> 
> We can reach this via mmap() and friends IIUC.
> 
> Since this function only gets called once-ish per vma I have a weak
> preference for keeping the check here to avoid code fragility.
> 
> 
> It does feel like arch_validate_prot() is supposed to be a generic gate
> for prot flags coming into the kernel via any route though, but only the
> mprotect() path actually uses it.
> 
> This function originally landed in v2.6.27 as part of the powerpc strong
> access ordering support (PROT_SAO):
> 
> b845f313d78e ("mm: Allow architectures to define additional protection bits")
> ef3d3246a0d0 ("powerpc/mm: Add Strong Access Ordering support")
> 
> where the mmap() path uses arch_calc_vm_prot_bits() without
> arch_validate_prot(), just as in the current code.  powerpc's original
> arch_calc_vm_prot_bits() does no obvious policing.
> 
> This might be a bug.  I can draft a patch to add it for the mmap() path
> for people to comment on ... I can't figure out yet whether or not the
> difference is intentional or there's some subtlety that I'm missed.

From reading those two commit messages, it looks like this was an
oversight. I'd expect that we should apply this check for any
user-provided prot (i.e. it should apply to both mprotect and mmap).

Ben, Andrew, does that make sense to you?

... or was there some reason to only do this for mprotect?

Thanks,
Mark.

> mmap( ... prot = -1 ... ) succeeds with effective rwx permissions and no
> apparent ill effects on my random x86 box, but mprotect(..., -1) fails
> with -EINVAL.
> 
> This is at least strange.
> 
> Theoretically, tightening this would be an ABI break, though I'd say
> this behaviour is not intentional.
> 
> Thoughts?
> 
> [...]
> 
> Cheers
> ---Dave
