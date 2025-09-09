Return-Path: <linux-arch+bounces-13457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF446B50525
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 20:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990B24E56F5
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 18:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDB326D62;
	Tue,  9 Sep 2025 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gfxLZN+S"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD5F35942;
	Tue,  9 Sep 2025 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442321; cv=none; b=QZ/8W5UI7sJZSBM1Kll0k/dx7v7g+nOpRTFfHBp0TT1htAum2lVHmg+lR2WotSyNqO896AwYV3IDfAPkTa3sObz2o3DJVd/tZYZo7vOso8BMOuPcdJGBnvR7av1OfGFoO7n60OjGu0WZJkdNwAr1imqEmB+Ekp9qum1GwkEt6BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442321; c=relaxed/simple;
	bh=7W1NU86YgYwuRNRQ3nC/1yP5VbhkioIjALJMcMFiogo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jzwxl2eG2+KlAnj8SHtFZeVhB1MeLUsBFEMoFJfHTZ+ZSQ7hSHYHQaOLpyrIsHIg9AgLESaIA4zAYIxxdDdqwLo3UX5W90V6T0Xs14AL52HMd4h0CEWg74fARSeSBxQLKKzGNQOTgX3B+kelzvqevlR/tBNn4EwexIgq9HQGuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gfxLZN+S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90448211AA25;
	Tue,  9 Sep 2025 11:25:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90448211AA25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757442319;
	bh=1hoA3dBgdIbJBi75fbtaCF4eMDYRur2MvxM0Dn6pPsc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gfxLZN+SNW4Cmu0AfiGj5kHKKqKuQITwsmZMdDN4rTENRgkNgVuYpuQ6aKlWtch78
	 I2RNx8DwxNCULh4d5f5Tpb4JRLwBjxUwpSrqlF6ad7kuEgqnilcsQ54LZwxhwUTj5t
	 AoUew+GHFXTtbjcuzswY63cPvD8m7i3wFbzFRIBM=
Message-ID: <4c9c60c2-104a-658b-ec37-85518f13198e@linux.microsoft.com>
Date: Tue, 9 Sep 2025 11:25:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0 5/6] x86/hyperv: Implement hypervisor ram collection
 into vmcore
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de
References: <20250904021017.1628993-1-mrathor@linux.microsoft.com>
 <20250904021017.1628993-6-mrathor@linux.microsoft.com>
 <aLoUsvfcAqGdV9Qr@skinsburskii.localdomain>
 <69639330-7fa0-0dce-2504-8c5e3c6e9a64@linux.microsoft.com>
 <aMBj_2ad2vGEIy9J@skinsburskii.localdomain>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aMBj_2ad2vGEIy9J@skinsburskii.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 10:29, Stanislav Kinsburskii wrote:
> On Thu, Sep 04, 2025 at 07:38:53PM -0700, Mukesh R wrote:
>> On 9/4/25 15:37, Stanislav Kinsburskii wrote:
>>> On Wed, Sep 03, 2025 at 07:10:16PM -0700, Mukesh Rathor wrote:
>>>> +
>>>> +/*
>>>> + * Common function for all cpus before devirtualization.
>>>> + *
>>>> + * Hypervisor crash: all cpus get here in nmi context.
>>>> + * Linux crash: the panicing cpu gets here at base level, all others in nmi
>>>> + *		context. Note, panicing cpu may not be the bsp.
>>>> + *
>>>> + * The function is not inlined so it will show on the stack. It is named so
>>>> + * because the crash cmd looks for certain well known function names on the
>>>> + * stack before looking into the cpu saved note in the elf section, and
>>>> + * that work is currently incomplete.
>>>> + *
>>>> + * Notes:
>>>> + *  Hypervisor crash:
>>>> + *    - the hypervisor is in a very restrictive mode at this point and any
>>>> + *	vmexit it cannot handle would result in reboot. For example, console
>>>> + *	output from here would result in synic ipi hcall, which would result
>>>> + *	in reboot. So, no mumbo jumbo, just get to kexec as quickly as possible.
>>>> + *
>>>> + *  Devirtualization is supported from the bsp only.
>>>> + */
>>>> +static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
>>>> +{
>>>> +	struct hv_input_disable_hyp_ex *input;
>>>> +	u64 status;
>>>> +	int msecs = 1000, ccpu = smp_processor_id();
>>>> +
>>>> +	if (ccpu == 0) {
>>>> +		/* crash_save_cpu() will be done in the kexec path */
>>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>>>> +		atomic_inc(&crash_cpus_wait);
>>>> +	} else {
>>>> +		crash_save_cpu(regs, ccpu);
>>>> +		cpu_emergency_stop_pt();	/* disable performance trace */
>>>> +		atomic_inc(&crash_cpus_wait);
>>>> +		for (;;);			/* cause no vmexits */
>>>> +	}
>>>> +
>>>> +	while (atomic_read(&crash_cpus_wait) < num_online_cpus() && msecs--)
>>>> +		mdelay(1);
>>>> +
>>>> +	stop_nmi();
>>>> +	if (!hv_has_crashed)
>>>> +		hv_notify_prepare_hyp();
>>>> +
>>>> +	if (crashing_cpu == -1)
>>>> +		crashing_cpu = ccpu;		/* crash cmd uses this */
>>>> +
>>>> +	hv_hvcrash_ctxt_save();
>>>> +	hv_mark_tss_not_busy();
>>>> +	hv_crash_fixup_kernpt();
>>>> +
>>>> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
>>>> +	memset(input, 0, sizeof(*input));
>>>> +	input->rip = trampoline_pa;	/* PA of hv_crash_asm32 */
>>>> +	input->arg = devirt_cr3arg;	/* PA of trampoline page table L4 */
>>>> +
>>>> +	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
>>>> +	if (!hv_result_success(status)) {
>>>> +		pr_emerg("%s: %s\n", __func__, hv_result_to_string(status));
>>>> +		pr_emerg("Hyper-V: disable hyp failed. kexec not possible\n");
>>>
>>> These prints won't ever be printed to any console as prints in NMI
>>> handler are deffered.
>>
>> It's mostly for debug. There are different config options allowing one
>> to build kernel easily dumping to either uart, led, speaker etc... There
>> are no easy ways to debug. kernel debuggers could trap EMERGENCY printks 
>> also...  
>>
>> Are you 100% sure printk is async even if KERN_EMERG? If yes, I'd like to 
>> propose someday to make it bypass all that for pr_emerg.
>>
> 
> Yes, I'm quite sure. Right now this looks like is dead code.
> 
>>
>>> Also, how are they aligned with the notice in the comment on top of
>>> the function stating that console output would lead to synic ipi call?
>>
>> Comment says "Hypervisor Crash". Please reread the whole block.
>>
> 
> The comment states that in case of hypervisor crash "console
> output from here would result in synic ipi hcall, which would result in
> reboot".
> So, why printing anything if it will simply lead to reboot?
> 
>>>
>>> Resetting the machine from an NMI handler is sloppy.
>>> There could be another NMI, which triggers the panic, leading to this handler.
>>> NMI handlers servicing is batched meanining that not only this handler
>>> won't output anything, but also any other prints from any other handlers
>>> executed before the same lock won't be written out to consoles.
>>>
>>> This introduces silent machine resets for the root partition. Can the
>>> intrusive logic me moved to a tasklet?
>>
>> I really don't think you understand what is going on here. I've tried
>> telling you at least once in the past year, there is no return from the nmi 
>> handler in case of hyp crash, and that this is panic mode, something 
>> really bad has happened! It could be memory corruption, it could be 
>> hw failure...  The hyp goes in emergency mode that just mostly loops, 
>> handling tiny number of hypercalls and msrs for support of dom0/root 
>> like windows that implements custom core collection in raw mode.
>>
> 
> I wasn't clear.
> I wasn't talking about a hypervisor crash. If it is so intrusive, that an
> attempt to print things to console may lead to reboot, then there should
> be no prints for this case.

The line after the print is reboot!! 
Ah, forget it! heck with the prints... 

> But this same logic is also used for Linux crashes, when prints can and
> should be printed to console.

check the panic function to figure when/where it prints, then check
where the nmi is called from. that will help.

> Moreover, whe same logic is used for a case when there is no crash
> kernel loaded, which as I said already leads to silent reboot if panic
> has happened in NMI handler.
> 
> I believe this needs to be fixed.
> 
> Stas
> 


