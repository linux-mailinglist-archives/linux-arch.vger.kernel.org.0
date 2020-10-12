Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7D328BBF5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388710AbgJLPdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 11:33:15 -0400
Received: from foss.arm.com ([217.140.110.172]:53424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389340AbgJLPdP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 11:33:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5DEF1FB;
        Mon, 12 Oct 2020 08:33:14 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 702A03F719;
        Mon, 12 Oct 2020 08:33:13 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] arm64: kvm: Handle Asymmetric AArch32 systems
To:     Qais Yousef <qais.yousef@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-2-qais.yousef@arm.com>
 <7c058d22dce84ec7636863c1486b11d1@kernel.org>
 <20201009095857.cq3bmmobxeq3tm5z@e107158-lin.cambridge.arm.com>
 <63e379d1399b5c898828f6802ce3dca5@kernel.org>
 <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <54379ee1-97b1-699b-9500-655164f2e083@arm.com>
Date:   Mon, 12 Oct 2020 16:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201009124817.i7u53qrntvu7l5zq@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc, Qais,

On 09/10/2020 13:48, Qais Yousef wrote:
> On 10/09/20 13:34, Marc Zyngier wrote:
>> On 2020-10-09 10:58, Qais Yousef wrote:

>>>>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>>>>> index b588c3b5c2f0..22ff3373d855 100644
>>>>> --- a/arch/arm64/kvm/arm.c
>>>>> +++ b/arch/arm64/kvm/arm.c
>>>>> @@ -644,6 +644,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>>  	struct kvm_run *run = vcpu->run;
>>>>>  	int ret;
>>>>>
>>>>> +	if (!system_supports_32bit_el0() && vcpu_mode_is_32bit(vcpu)) {
>>>>> +		kvm_err("Illegal AArch32 mode at EL0, can't run.");
>>>>
>>>> No, we don't scream on the console in an uncontrolled way based on
>>>> illegal user input (yes, the VM *is* userspace).
>>>
>>> It seemed kind to print a good reason of what just happened.

>>>> Furthermore, you seem to deal with the same problem *twice*. See
>>>> below.
>>>
>>> It's done below because we could loop back into the guest again, so we
>>> force an
>>> exit then. Here to make sure if the VMM ignores the error value we
>>> returned
>>> earlier it can't force its way back in again.

>> Which we already handle if you do what I hinted at below.

Do we trust the VMM not to try and get out of this?

We sanity-check the SPSR values the VMM writes via set_one_reg() to prevent aarch32 on
systems that don't support it. It seems strange that if you can get the bad value out of
hardware: you can keep it.
Returning to aarch32 from EL2 on a CPU that doesn't support it is terrifying.

To avoid always testing on entry from user-space, we could add a
'vmm-fixed-bad-value-from-hardware' request type, and refactor check_vcpu_requests() to
allow it to force a guest exit. Any KVM_EXIT_FAIL_ENTRY can set this to ensure the VMM
doesn't have its fingers in its ears.

This means the VMM can fix this by set_one_reg()ing an exception to aarch64 if it really
wants to, but it can't restart the guest with the bad SPSR value.


>>>>> +		return -ENOEXEC;
>>>>> +	}
>>>>> +
>>>>>  	if (unlikely(!kvm_vcpu_initialized(vcpu)))
>>>>>  		return -ENOEXEC;
>>>>>
>>>>> @@ -804,6 +809,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>>>>>
>>>>>  		preempt_enable();
>>>>>
>>>>> +		/*
>>>>> +		 * For asym aarch32 systems we present a 64bit only system to
>>>>> +		 * the guest. But in case it managed somehow to escape that and
>>>>> +		 * enter 32bit mode, catch that and prevent it from running
>>>>> +		 * again.
>>>>
>>>> The guest didn't *escape* anything. It merely used the CPU as
>>>> designed.
>>>> The fact that the hypervisor cannot prevent the guest from using
>>>> AArch32
>>>> is an architectural defect.

>>> Because I probably didn't navigate my way correctly around the code.
>>> Mind
>>> expanding how to mark the vcpu as uninitialized? I have tried 2 ways
>>> in that effect but they were really horrible, so will abstain from
>>> sharing :-)
>>
>> You can try setting vcpu->arch.target to -1, which is already caught by
>> kvm_vcpu_initialized() right at the top of this function. This will

>> prevent any reentry unless the VMM issues a KVM_ARM_VCPU_INIT ioctl.

This doesn't reset SPSR, so this lets the VMM restart the guest with a bad value.

I think we should make it impossible to return to aarch32 from EL2 on these systems.


Thanks,

James


> That's actually one of the things I tried before ending with this patch.
> I thought it's really aggressive and unfriendly.
> 
> It does indeed cause qemu to abort out completely.
> 
>> +                       /* Reset target so it won't run again */
>> +                       vcpu->arch.target = -1;
>>
