Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1212FDC641
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 15:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410391AbfJRNiJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 09:38:09 -0400
Received: from [217.140.110.172] ([217.140.110.172]:39580 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2408565AbfJRNiJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 09:38:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E57F6442;
        Fri, 18 Oct 2019 06:37:45 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA813F6C4;
        Fri, 18 Oct 2019 06:37:42 -0700 (PDT)
Date:   Fri, 18 Oct 2019 14:37:40 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arch@vger.kernel.org, Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
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
Message-ID: <20191018133739.GD27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-6-git-send-email-Dave.Martin@arm.com>
 <20191011151028.GE33537@lakrids.cambridge.arm.com>
 <20191011172013.GQ27757@arm.com>
 <20191018111003.GC27759@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018111003.GC27759@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 18, 2019 at 12:10:03PM +0100, Mark Rutland wrote:
> On Fri, Oct 11, 2019 at 06:20:15PM +0100, Dave Martin wrote:
> > On Fri, Oct 11, 2019 at 04:10:29PM +0100, Mark Rutland wrote:
> > > On Thu, Oct 10, 2019 at 07:44:33PM +0100, Dave Martin wrote:
> > > > +#define arch_calc_vm_prot_bits(prot, pkey) arm64_calc_vm_prot_bits(prot)
> > > > +static inline unsigned long arm64_calc_vm_prot_bits(unsigned long prot)
> > > > +{
> > > > +	if (system_supports_bti() && (prot & PROT_BTI))
> > > > +		return VM_ARM64_BTI;
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > Can we call this arch_calc_vm_prot_bits() directly, with all the
> > > arguments:
> > > 
> > > static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> > > 						   unsigned long pkey)
> > > {
> > > 	...
> > > }
> > > #define arch_calc_vm_prot_bits arch_calc_vm_prot_bits
> > > 
> > > ... as that makes it a bit easier to match definition with use, and just
> > > definign the name makes it a bit clearer that that's probably for the
> > > benefit of some ifdeffery.
> > > 
> > > Likewise for the other functions here.
> > > 
> > > > +#define arch_vm_get_page_prot(vm_flags) arm64_vm_get_page_prot(vm_flags)
> > > > +static inline pgprot_t arm64_vm_get_page_prot(unsigned long vm_flags)
> > > > +{
> > > > +	return (vm_flags & VM_ARM64_BTI) ? __pgprot(PTE_GP) : __pgprot(0);
> > > > +}
> > > > +
> > > > +#define arch_validate_prot(prot, addr) arm64_validate_prot(prot, addr)
> > > > +static inline int arm64_validate_prot(unsigned long prot, unsigned long addr)
> > 
> > Can do, though it looks like a used sparc as a template, and that has a
> > sparc_ prefix.
> > 
> > powerpc uses the generic name, as does x86 ... in its UAPI headers.
> > Odd.
> > 
> > I can change the names here, though I'm not sure it adds a lot of value.
> > 
> > If you feel strongly I can do it.
> 
> I'd really prefer it because it minimizes surprises, and makes it much
> easier to hop around the codebase and find the thing you're looking for.

OK, I've no objection in that case.  I'll make the change.

[...]

Cheers
---Dave
