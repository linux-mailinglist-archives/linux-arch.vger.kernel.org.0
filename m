Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BACD79A6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 17:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732815AbfJOPVP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 11:21:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfJOPVO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 11:21:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AEF528;
        Tue, 15 Oct 2019 08:21:14 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A473F718;
        Tue, 15 Oct 2019 08:21:11 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:21:09 +0100
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
Subject: Re: [PATCH v2 09/12] arm64: traps: Fix inconsistent faulting
 instruction skipping
Message-ID: <20191015152108.GX27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-10-git-send-email-Dave.Martin@arm.com>
 <20191011152453.GF33537@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011152453.GF33537@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 04:24:53PM +0100, Mark Rutland wrote:
> On Thu, Oct 10, 2019 at 07:44:37PM +0100, Dave Martin wrote:
> > Correct skipping of an instruction on AArch32 works a bit
> > differently from AArch64, mainly due to the different CPSR/PSTATE
> > semantics.
> > 
> > There have been various attempts to get this right.  Currenty
> > arm64_skip_faulting_instruction() mostly does the right thing, but
> > does not advance the IT state machine for the AArch32 case.
> > 
> > arm64_compat_skip_faulting_instruction() handles the IT state
> > machine but is local to traps.c, and porting other code to use it
> > will make a mess since there are some call sites that apply for
> > both the compat and native cases.
> > 
> > Since manual instruction skipping implies a trap, it's a relatively
> > slow path.
> > 
> > So, make arm64_skip_faulting_instruction() handle both compat and
> > native, and get rid of the arm64_compat_skip_faulting_instruction()
> > special case.
> > 
> > Fixes: 32a3e635fb0e ("arm64: compat: Add CNTFRQ trap handler")
> > Fixes: 1f1c014035a8 ("arm64: compat: Add condition code checks and IT advance")
> > Fixes: 6436beeee572 ("arm64: Fix single stepping in kernel traps")
> > Fixes: bd35a4adc413 ("arm64: Port SWP/SWPB emulation support from arm")
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/kernel/traps.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> This looks good to me; it's certainly easier to reason about.
> 
> I couldn't spot a place where we do the wrong thing today, given AFAICT
> all the instances in arch/arm64/kernel/armv8_deprecated.c would be
> UNPREDICTABLE within an IT block.
> 
> It might be worth calling out an example in the commit message to
> justify the fixes tags.

IIRC I found no bug here; rather we have pointlessly fragmented code,
so I followed the "if fixing the same bug in multiple places, merge
those places so you need only fix it in one place next time" rule.

Since arm64_skip_faulting_instruction() is most of the way to being
generically usable anyway, this series merges all the special-case
handling into it.

I could add something like

--8<--

This allows this fiddly operation to be maintained in a single
place rather than trying to maintain fragmented versions spread
around arch/arm64.

-->8--

Any good?

Cheers
---Dave

[...]

> > 
> > diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> > index 15e3c4f..44c91d4 100644
> > --- a/arch/arm64/kernel/traps.c
> > +++ b/arch/arm64/kernel/traps.c
> > @@ -268,6 +268,8 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
> >  	}
> >  }
> >  
> > +static void advance_itstate(struct pt_regs *regs);
> > +
> >  void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> >  {
> >  	regs->pc += size;
> > @@ -278,6 +280,9 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
> >  	 */
> >  	if (user_mode(regs))
> >  		user_fastforward_single_step(current);
> > +
> > +	if (regs->pstate & PSR_MODE32_BIT)
> > +		advance_itstate(regs);
> >  }
> >  
> >  static LIST_HEAD(undef_hook);
> > @@ -629,19 +634,12 @@ static void advance_itstate(struct pt_regs *regs)
> >  	compat_set_it_state(regs, it);
> >  }
> >  
> > -static void arm64_compat_skip_faulting_instruction(struct pt_regs *regs,
> > -						   unsigned int sz)
> > -{
> > -	advance_itstate(regs);
> > -	arm64_skip_faulting_instruction(regs, sz);
> > -}
> > -
> >  static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
> >  {
> >  	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
> >  
> >  	pt_regs_write_reg(regs, reg, arch_timer_get_rate());
> > -	arm64_compat_skip_faulting_instruction(regs, 4);
> > +	arm64_skip_faulting_instruction(regs, 4);
> >  }
> >  
> >  static const struct sys64_hook cp15_32_hooks[] = {
> > @@ -661,7 +659,7 @@ static void compat_cntvct_read_handler(unsigned int esr, struct pt_regs *regs)
> >  
> >  	pt_regs_write_reg(regs, rt, lower_32_bits(val));
> >  	pt_regs_write_reg(regs, rt2, upper_32_bits(val));
> > -	arm64_compat_skip_faulting_instruction(regs, 4);
> > +	arm64_skip_faulting_instruction(regs, 4);
> >  }
> >  
> >  static const struct sys64_hook cp15_64_hooks[] = {
> > @@ -682,7 +680,7 @@ asmlinkage void __exception do_cp15instr(unsigned int esr, struct pt_regs *regs)
> >  		 * There is no T16 variant of a CP access, so we
> >  		 * always advance PC by 4 bytes.
> >  		 */
> > -		arm64_compat_skip_faulting_instruction(regs, 4);
> > +		arm64_skip_faulting_instruction(regs, 4);
> >  		return;
> >  	}
> >  
> > -- 
> > 2.1.4
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
