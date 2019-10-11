Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3472D434C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 16:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfJKOo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 10:44:57 -0400
Received: from foss.arm.com ([217.140.110.172]:34594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbfJKOo5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 10:44:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9716142F;
        Fri, 11 Oct 2019 07:44:56 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E268F3F68E;
        Fri, 11 Oct 2019 07:44:53 -0700 (PDT)
Date:   Fri, 11 Oct 2019 15:44:51 +0100
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
Subject: Re: [PATCH v2 12/12] KVM: arm64: BTI: Reset BTYPE when skipping
 emulated instructions
Message-ID: <20191011144451.GI27757@arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-13-git-send-email-Dave.Martin@arm.com>
 <20191011142454.GD33537@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011142454.GD33537@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 11, 2019 at 03:24:55PM +0100, Mark Rutland wrote:
> On Thu, Oct 10, 2019 at 07:44:40PM +0100, Dave Martin wrote:
> > Since normal execution of any non-branch instruction resets the
> > PSTATE BTYPE field to 0, so do the same thing when emulating a
> > trapped instruction.
> > 
> > Branches don't trap directly, so we should never need to assign a
> > non-zero value to BTYPE here.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > ---
> >  arch/arm64/include/asm/kvm_emulate.h | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index d69c1ef..33957a12 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -452,8 +452,10 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
> >  {
> >  	if (vcpu_mode_is_32bit(vcpu))
> >  		kvm_skip_instr32(vcpu, is_wide_instr);
> > -	else
> > +	else {
> >  		*vcpu_pc(vcpu) += 4;
> > +		*vcpu_cpsr(vcpu) &= ~(u64)PSR_BTYPE_MASK;
> > +	}
> 
> Style nit: both sides of an if-else should match brace-wise. i.e. please
> add braces to the other side.

Will fix.  Strange, checkpatch didn't catch that, maybe because only one
arm of the if was patched.

> As with the prior patch, the u64 cast can also go.
> 
> Otherwise, this looks right to me.

For some reason I thought there was a different prevailing style in the
KVM code, but now I see no evidence of that.

Will fix.

Thanks for the review.

Cheers
---Dave
