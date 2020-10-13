Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61D028CBBF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgJMKdD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 06:33:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731075AbgJMKc4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 06:32:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B332920E65;
        Tue, 13 Oct 2020 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602585175;
        bh=JBKlu3TBZRpOD6AYMAAMNwmUxGC5eOT4l+a4F2M8/Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E6jwmkjFjAtdaNxPdhjGZgQ2j2WimDR+a50PtvDDPg80kVoHdHMkzP9f67yKZDkYL
         ce7I7FEWOW2cAPO8g8sJtfZ1vX9JB0I7/VLFTWQMz39CDQGP8BznY7XYd9aSvfZ7Xf
         pDdDB/Pc6Ok1YvVXUCFX7Z7tVMOdGXl0ZcUoPFEY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kSHbx-000nbS-H0; Tue, 13 Oct 2020 11:32:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 13 Oct 2020 11:32:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
In-Reply-To: <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
 <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
 <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <8cdbcf81bae94f4b030e2906191d80af@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: james.morse@arm.com, qais.yousef@arm.com, linux-arch@vger.kernel.org, will@kernel.org, peterz@infradead.org, catalin.marinas@arm.com, gregkh@linuxfoundation.org, torvalds@linux-foundation.org, morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi James,

On 2020-10-12 16:32, James Morse wrote:
> Hi Marc, Qais,
> 
> On 09/10/2020 13:48, Qais Yousef wrote:
>> On 10/09/20 13:34, Marc Zyngier wrote:
>>> On 2020-10-09 10:58, Qais Yousef wrote:
> 
>>>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>>>> index b588c3b5c2f0..22ff3373d855 100644
>>>>>> --- a/arch/arm64/kvm/arm.c
>>>>>> +++ b/arch/arm64/kvm/arm.c
>>>>>> @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>>  	struct kvm_run *run = vcpu->run;
>>>>>>  	int ret;
>>>>>> 
>>>>>> +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
>>>>>> +		kvm_err("Illegal AArch32 mode at EL0, can't run.");
>>>>> 
>>>>> No, we don't scream on the console in an uncontrolled way based on
>>>>> illegal user input (yes, the VM *is* userspace).
>>>> 
>>>> It seemed kind to print a good reason of what just happened.
> 
>>>>> Furthermore, you seem to deal with the same problem *twice*. See
>>>>> below.
>>>> 
>>>> It's done below because we could loop back into the guest again, so 
>>>> we
>>>> force an
>>>> exit then. Here to make sure if the VMM ignores the error value we
>>>> returned
>>>> earlier it can't force its way back in again.
> 
>>> Which we already handle if you do what I hinted at below.
> 
> Do we trust the VMM not to try and get out of this?

I usually don't put the words trust and VMM in the same sentence...

> We sanity-check the SPSR values the VMM writes via set_one_reg() to
> prevent aarch32 on systems that don't support it. It seems strange
> that if you can get the bad value out of hardware: you can keep it.

The guest went into an illegal state, and we return that illegal state
to userspace. Garbage in, garbage out. I'm not too bothered about that,
but we cal always sanity check it.

> Returning to aarch32 from EL2 on a CPU that doesn't support it is 
> terrifying.

And I'm not proposing that we even try.

> 
> To avoid always testing on entry from user-space, we could add a
> 'vmm-fixed-bad-value-from-hardware' request type, and refactor
> check_vcpu_requests() to
> allow it to force a guest exit. Any KVM_EXIT_FAIL_ENTRY can set this
> to ensure the VMM
> doesn't have its fingers in its ears.
> 
> This means the VMM can fix this by set_one_reg()ing an exception to
> aarch64 if it really
> wants to, but it can't restart the guest with the bad SPSR value.
> 
> 
>>>>>> +		return -ENOEXEC;
>>>>>> +	}
>>>>>> +
>>>>>>  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
>>>>>>  		return -ENOEXEC;
>>>>>> 
>>>>>> @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu 
>>>>>> *vcpu)
>>>>>> 
>>>>>>  		preempt_enable();
>>>>>> 
>>>>>> +		/*
>>>>>> +		 * For asym aarch32 systems we present a 64bit only system to
>>>>>> +		 * the guest. But in case it managed somehow to escape that and
>>>>>> +		 * enter 32bit mode, catch that and prevent it from running
>>>>>> +		 * again.
>>>>> 
>>>>> The guest didn't *escape* anything. It merely used the CPU as
>>>>> designed.
>>>>> The fact that the hypervisor cannot prevent the guest from using
>>>>> AArch32
>>>>> is an architectural defect.
> 
>>>> Because I probably didn't navigate my way correctly around the code.
>>>> Mind
>>>> expanding how to mark the vcpu as uninitialized? I have tried 2 ways
>>>> in that effect but they were really horrible, so will abstain from
>>>> sharing :-)
>>> 
>>> You can try setting vcpu->arch.target to -1, which is already caught 
>>> by
>>> kvm_vcpu_initialized() right at the top of this function. This will
> 
>>> prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.
> 
> This doesn't reset SPSR, so this lets the VMM restart the guest with a
> bad value.

That's not my reading of the code. Without a valid target, you cannot 
enter
the guest (kvm_vcpu_initialized() prevents you to do so). To set the 
target,
you need to issue a KVM_ARM_VCPU_INIT ioctl, which eventually calls
kvm_reset_vcpu(), which does set PSTATE to something legal.

Or do you mean the guest's SPSR_EL1? Why would that matter?

> I think we should make it impossible to return to aarch32 from EL2 on
> these systems.

And I'm saying that the above fulfills that requirement. Am I missing
something obvious?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
