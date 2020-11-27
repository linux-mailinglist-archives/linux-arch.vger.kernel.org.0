Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9392C6A73
	for <lists+linux-arch@lfdr.de>; Fri, 27 Nov 2020 18:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgK0ROP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Nov 2020 12:14:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbgK0ROP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Nov 2020 12:14:15 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57490221EB;
        Fri, 27 Nov 2020 17:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606497254;
        bh=tWBrsQAV0dVK6FFIiWA7bl7RIx2UuTl5wZD4vgMjKfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PZh/9V5LjXhxcgHdYZjEjrlc6/fzCy2+1KDzfiQtymlnX9gJlq8hFqrH/053xA6Gz
         52oonsz6RSsVxU2uQ7o4ZHhevVwmWpYb+jHcexgQdxKqMmJFe08OAmKOcLtR1jhqVY
         K2YdLf3VT4ue93dSx7hXcr1mq1sZ8sUL16yImbv8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kihJz-00E7Sw-V0; Fri, 27 Nov 2020 17:14:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Nov 2020 17:14:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 03/14] KVM: arm64: Kill 32-bit vCPUs on systems with
 mismatched EL0 support
In-Reply-To: <20201127115304.GB20564@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-4-will@kernel.org>
 <9bd06b193e7fb859a1207bb1302b7597@kernel.org>
 <20201127115304.GB20564@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <583c4074bbd4cf8b8085037745a5d1c0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, peterz@infradead.org, morten.rasmussen@arm.com, qais.yousef@arm.com, surenb@google.com, qperret@google.com, tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-11-27 11:53, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 10:26:47AM +0000, Marc Zyngier wrote:
>> On 2020-11-24 15:50, Will Deacon wrote:
>> > If a vCPU is caught running 32-bit code on a system with mismatched
>> > support at EL0, then we should kill it.
>> >
>> > Acked-by: Marc Zyngier <maz@kernel.org>
>> > Signed-off-by: Will Deacon <will@kernel.org>
>> > ---
>> >  arch/arm64/kvm/arm.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> > index 5750ec34960e..d322ac0f4a8e 100644
>> > --- a/arch/arm64/kvm/arm.c
>> > +++ b/arch/arm64/kvm/arm.c
>> > @@ -633,6 +633,15 @@ static void check_vcpu_requests(struct kvm_vcpu
>> > *vcpu)
>> >  	}
>> >  }
>> >
>> > +static bool vcpu_mode_is_bad_32bit(struct kvm_vcpu *vcpu)
>> > +{
>> > +	if (likely(!vcpu_mode_is_32bit(vcpu)))
>> > +		return false;
>> > +
>> > +	return !system_supports_32bit_el0() ||
>> > +		static_branch_unlikely(&arm64_mismatched_32bit_el0);
>> > +}
>> > +
>> >  /**
>> >   * kvm_arch_vcpu_ioctl_run - the main VCPU run function to execute
>> > guest code
>> >   * @vcpu:	The VCPU pointer
>> > @@ -816,7 +825,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>> >  		 * with the asymmetric AArch32 case), return to userspace with
>> >  		 * a fatal error.
>> >  		 */
>> > -		if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
>> > +		if (vcpu_mode_is_bad_32bit(vcpu)) {
>> >  			/*
>> >  			 * As we have caught the guest red-handed, decide that
>> >  			 * it isn't fit for purpose anymore by making the vcpu
>> 
>> Given the new definition of system_supports_32bit_el0() in the 
>> previous
>> patch,
>> why do we need this patch at all?
> 
> I think the check is still needed, as this is an unusual case where we
> want to reject the mismatched system. For example, imagine
> 'arm64_mismatched_32bit_el0' is true and we're on a mismatched system: 
> in
> this case system_supports_32bit_el0() will return 'true' because we
> allow 32-bit applications to run, we support the 32-bit personality 
> etc.
> 
> However, we still want to terminate 32-bit vCPUs if we spot them in 
> this
> situation, so we have to check for:
> 
> 	!system_supports_32bit_el0() ||
> 	static_branch_unlikely(&arm64_mismatched_32bit_el0)
> 
> so that we only allow 32-bit vCPUs when all of the physical CPUs 
> support
> it at EL0.
> 
> I could make this clearer either by adding a comment, or avoiding
> system_supports_32bit_el0() entirely here and just checking the
> sanitised SYS_ID_AA64PFR0_EL1 register directly instead.
> 
> What do you prefer?

Yeah, the sanitized read feels better, if only because that is
what we are going to read in all the valid cases, unfortunately.
read_sanitised_ftr_reg() is sadly not designed to be called on
a fast path, meaning that 32bit guests will do a bsearch() on
the ID-regs every time they exit...

I guess we will have to evaluate how much we loose with this.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
