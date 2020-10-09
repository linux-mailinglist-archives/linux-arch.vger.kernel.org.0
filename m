Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2326288672
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387413AbgJIJ7C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 05:59:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJIJ7B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 05:59:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6323D6E;
        Fri,  9 Oct 2020 02:59:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8FBCF3F66B;
        Fri,  9 Oct 2020 02:58:59 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:58:57 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
Message-ID: <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c058d22dce84ec7636863c1486b11d1@kernel.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/09/20 09:12, Marc Zyngier wrote:
> On 2020-10-08 19:16, Qais Yousef wrote:
> > On a system without uniform support for AArch32 at EL0, it is possible
> > for the guest to force run AArch32 at EL0 and potentially cause an
> > illegal exception if running on the wrong core.
> > 
> > Add an extra check to catch if the guest ever does that and prevent it
> > from running again, treating it as ARM_EXCEPTION_IL.
> > 
> > We try to catch this misbehavior as early as possible and not rely on
> > PSTATE.IL to occur.
> 
> nit: PSTATE.IL doesn't "occur". It is an "Illegal Exception Return" that
> can happen.

+1

> 
> > 
> > Tested on Juno by instrumenting the host to:
> > 
> > 	* Fake asym aarch32.
> > 	* Comment out hiding of ID registers from the guest.
> > 
> > Any attempt to run 32bit app in the guest will produce such error on
> > qemu:
> > 
> > 	# ./test
> > 	error: kvm run failed Invalid argument
> > 	R00=ffff0fff R01=ffffffff R02=00000000 R03=00087968
> > 	R04=000874b8 R05=ffd70b24 R06=ffd70b2c R07=00000055
> > 	R08=00000000 R09=00000000 R10=00000000 R11=00000000
> > 	R12=0000001c R13=ffd6f974 R14=0001ff64 R15=ffff0fe0
> > 	PSR=a0000010 N-C- A usr32
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  arch/arm64/kvm/arm.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > index b588c3b5c2f0..22ff3373d855 100644
> > --- a/arch/arm64/kvm/arm.c
> > +++ b/arch/arm64/kvm/arm.c
> > @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> >  	struct kvm_run *run = vcpu->run;
> >  	int ret;
> > 
> > +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> > +		kvm_err("Illegal AArch32 mode at EL0, can't run.");
> 
> No, we don't scream on the console in an uncontrolled way based on
> illegal user input (yes, the VM *is* userspace).

It seemed kind to print a good reason of what just happened.

> 
> Furthermore, you seem to deal with the same problem *twice*. See below.

It's done below because we could loop back into the guest again, so we force an
exit then. Here to make sure if the VMM ignores the error value we returned
earlier it can't force its way back in again.

> 
> > +		return -ENOEXEC;
> > +	}
> > +
> >  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
> >  		return -ENOEXEC;
> > 
> > @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> > 
> >  		preempt_enable();
> > 
> > +		/*
> > +		 * For asym aarch32 systems we present a 64bit only system to
> > +		 * the guest. But in case it managed somehow to escape that and
> > +		 * enter 32bit mode, catch that and prevent it from running
> > +		 * again.
> 
> The guest didn't *escape* anything. It merely used the CPU as designed.
> The fact that the hypervisor cannot prevent the guest from using AArch32
> is an architectural defect.

Happy to change the wording if you tell me what you prefer :-)

> 
> > +		 */
> > +		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
> > +			kvm_err("Detected illegal AArch32 mode at EL0, exiting.");
> 
> Same remark as above. Userspace has access to PSTATE and can work out
> the issue by itself.

Okay.

> 
> > +			ret = ARM_EXCEPTION_IL;
> 
> This will cause the thread to return to userspace after having done a
> vcpu_put(). So why don't you just mark the vcpu as uninitialized before
> returning to userspace? It already is in an illegal state, and the only
> reasonable thing userspace can do is to reset it.

Because I probably didn't navigate my way correctly around the code. Mind
expanding how to mark the vcpu as uninitialized? I have tried 2 ways
in that effect but they were really horrible, so will abstain from sharing :-)

> 
> This way, we keep the horror in a single place, and force userspace to
> take action if it really wants to recover the guest.

Happy to try it out.

Thanks

--
Qais Yousef
