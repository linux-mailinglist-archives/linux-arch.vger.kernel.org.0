Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068262888DB
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 14:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733281AbgJIMee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 08:34:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733276AbgJIMee (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 08:34:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57621222B9;
        Fri,  9 Oct 2020 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602246873;
        bh=6wvQDemS1Nv4dK4+35ZHEiiOtDoRhAF4hdYiwj35z9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=df3+TMYwanDj5dtf5xjz4t66/6zMxC10hbA9r6L3+MnSwr527BlhL0MtVxcnrvXgo
         nFmaGAE65irod1HjXlo0PuNBO1S1VVDj0WMC+F0y+lZUYKs4jfJJJ6erPD1r2g/OGH
         uxyNlGbqFKG8vJonvn3EY+rQf45V9zTNbUISdk3M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kQrbT-00108l-AD; Fri, 09 Oct 2020 13:34:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 09 Oct 2020 13:34:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
In-Reply-To: <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <63e379d1399b5c898828f6802ce3dca5@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qais.yousef@arm.com, catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-09 10:58, Qais Yousef wrote:

[...]

>> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> > index b588c3b5c2f0..22ff3373d855 100644
>> > --- a/arch/arm64/kvm/arm.c
>> > +++ b/arch/arm64/kvm/arm.c
>> > @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>> >  	struct kvm_run *run = vcpu->run;
>> >  	int ret;
>> >
>> > +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
>> > +		kvm_err("Illegal AArch32 mode at EL0, can't run.");
>> 
>> No, we don't scream on the console in an uncontrolled way based on
>> illegal user input (yes, the VM *is* userspace).
> 
> It seemed kind to print a good reason of what just happened.

I'm afraid it only serves as an instrument to spam the console. 
Userspace
gave you an illegal state, you respond with an error. The error is, on
its own, descriptive enough. In general, we only print on the console
when KVM is faced with an internal error of some sort. That's not the
case here.

> 
>> 
>> Furthermore, you seem to deal with the same problem *twice*. See 
>> below.
> 
> It's done below because we could loop back into the guest again, so we 
> force an
> exit then. Here to make sure if the VMM ignores the error value we 
> returned
> earlier it can't force its way back in again.

Which we already handle if you do what I hinted at below.

>> 
>> > +		return -ENOEXEC;
>> > +	}
>> > +
>> >  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
>> >  		return -ENOEXEC;
>> >
>> > @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>> >
>> >  		preempt_enable();
>> >
>> > +		/*
>> > +		 * For asym aarch32 systems we present a 64bit only system to
>> > +		 * the guest. But in case it managed somehow to escape that and
>> > +		 * enter 32bit mode, catch that and prevent it from running
>> > +		 * again.
>> 
>> The guest didn't *escape* anything. It merely used the CPU as 
>> designed.
>> The fact that the hypervisor cannot prevent the guest from using 
>> AArch32
>> is an architectural defect.
> 
> Happy to change the wording if you tell me what you prefer :-)

"The ARMv8 architecture doesn't give the hypervisor a mechanism to 
prevent
  a guest from dropping to AArch32 EL0 if implemented by the CPU. If we 
spot
  the guest in such state and that we decided it wasn't supposed to do so
  (like with the asymmetric AArch32 case), return to userspace with a 
fatal
  error."

> 
>> 
>> > +		 */
>> > +		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
>> > +			kvm_err("Detected illegal AArch32 mode at EL0, exiting.");
>> 
>> Same remark as above. Userspace has access to PSTATE and can work out
>> the issue by itself.
> 
> Okay.
> 
>> 
>> > +			ret = ARM_EXCEPTION_IL;
>> 
>> This will cause the thread to return to userspace after having done a
>> vcpu_put(). So why don't you just mark the vcpu as uninitialized 
>> before
>> returning to userspace? It already is in an illegal state, and the 
>> only
>> reasonable thing userspace can do is to reset it.
> 
> Because I probably didn't navigate my way correctly around the code. 
> Mind
> expanding how to mark the vcpu as uninitialized? I have tried 2 ways
> in that effect but they were really horrible, so will abstain from 
> sharing :-)

You can try setting vcpu->arch.target to -1, which is already caught by
kvm_vcpu_initialized() right at the top of this function. This will
prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.

         M.
-- 
Jazz is not dead. It just smells funny...
