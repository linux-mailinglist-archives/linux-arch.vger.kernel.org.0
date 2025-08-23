Return-Path: <linux-arch+bounces-13255-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7EB32673
	for <lists+linux-arch@lfdr.de>; Sat, 23 Aug 2025 04:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91387AAA8F
	for <lists+linux-arch@lfdr.de>; Sat, 23 Aug 2025 02:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E41FF7D7;
	Sat, 23 Aug 2025 02:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GjVLRSsK"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4001A5B8D;
	Sat, 23 Aug 2025 02:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755915920; cv=none; b=Vs+s4Cv4dz+yAz2MKCmHy4nUPnxTVTmTvQGuHuOQJPmXnbUz/ozNMwRb7w1JR671ZZ4rMEnateJKznz7HxG9GAags0e/VLMwngjqBtEOOZebTENA0V5oc2sE2IICQ/163kI1vS0EsTQEWC1K5KA2M7YqdKrj/RyKwUs7XBY/q30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755915920; c=relaxed/simple;
	bh=PM7cD9nTxySnbUQZGscpBUeIv/ats1aD5ukPOJqDbZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbuKwgSN7HxBl8S/IIqsaJH1rHVRdZPimXPdVkJ42BsaFFqctvnboCs6VQdaPpXBcfG+s9Fq6rUuY/o2ALHL7iGt3rmSTyajJoRsLMTrMjzQMclV4T5/RMdajbVS412XtnA0Fzotv4MOi+ptP8MCKZrlVOpFTIltjZZw2PXhh8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GjVLRSsK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.192.3] (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id E4847211A290;
	Fri, 22 Aug 2025 19:25:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4847211A290
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755915910;
	bh=4y5QZ5oFZhp2SJvVoX6O4b6evTpheMhZ02f8/B45KnY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GjVLRSsKRMfVHbq/xQ970m7p4avf+00bZS1RAkr0uceT5HHlLG3+G5uWmSXlf+gZa
	 dl8L5veqyG/O4AMtu+QdvFgaLRSKgOIv803vQUwbApnz0whx6+59oAh83MOSBPWn8k
	 G7d3+W4Fs/ZU+8iK834Lx57vBG732bsLqXxKeF0Y=
Message-ID: <d6e63ef3-bdd2-f185-f065-76b333dd1fc3@linux.microsoft.com>
Date: Fri, 22 Aug 2025 19:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250415180728.1789-1-mhklinux@outlook.com>
 <20250415180728.1789-2-mhklinux@outlook.com>
 <f711d4ad-87a8-9cb3-aabc-a493ff18986a@linux.microsoft.com>
 <33b59cc4-2834-b6c7-5ffd-7b9d620a4ce5@linux.microsoft.com>
 <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
 <SN6PR02MB4157875C0979EFF29626A18CD43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157875C0979EFF29626A18CD43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 19:10, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, August 21, 2025 1:50 PM
>>
>> On 8/21/25 12:24, Michael Kelley wrote:
>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, August 20, 2025
>> 7:58 PM
>>>>
>>>> On 8/20/25 17:31, Mukesh R wrote:
>>>>> On 4/15/25 11:07, mhkelley58@gmail.com wrote:
>>>>>> From: Michael Kelley <mhklinux@outlook.com>
>>>>>>
>>>>>>
>> <snip>
>>>>>
>>>>>
>>>>> IMHO, this is unnecessary change that just obfuscates code. With status quo
>>>>> one has the advantage of seeing what exactly is going on, one can use the
>>>>> args any which way, change batch size any which way, and is thus flexible.
>>>
>>> I started this patch set in response to some errors in open coding the
>>> use of hyperv_pcpu_input/output_arg, to see if helper functions could
>>> regularize the usage and reduce the likelihood of future errors. Balancing
>>> the pluses and minuses of the result, in my view the helper functions are
>>> an improvement, though not overwhelmingly so. Others may see the
>>> tradeoffs differently, and as such I would not go to the mat in arguing the
>>> patches must be taken. But if we don't take them, we need to go back and
>>> clean up minor errors and inconsistencies in the open coding at some
>>> existing hypercall call sites.
>>
>> Yes, definitely. Assuming Nuno knows what issues you are referring to,
>> I'll work with him to get them addressed asap. Thanks for noticing them.
>> If Nuno is not aware, I'll ping you for more info.
>>
>>
>>>>> With time these functions only get more complicated and error prone. The
>>>>> saving of ram is very minimal, this makes analyzing crash dumps harder,
>>>>> and in some cases like in your patch 3/7 disables unnecessarily in error case:
>>>>>
>>>>> - if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
>>>>> -  pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
>>>>> -   HV_MAX_MODIFY_GPA_REP_COUNT);
>>>>> + local_irq_save(flags);      <<<<<<<
>>>>> ...
>>>
>>> FWIW, this error case is not disabled. It is checked a few lines further down as:
>>
>> I meant disabled interrupts. The check moves after disabling interrupts, so
>> it runs "disabled" in traditional OS terminology :).
> 
> Got it. But why is it problem to make this check with interrupts disabled?

You are creating disabling overhead where that overhead previously
did not exist.


> The check is just for robustness and should never be true since
> hv_mark_gpa_visiblity() is called from only one place that already ensures
> the PFN count won't overflow a single page.
> 
>>
>>>
>>> +       if (count > batch_size) {
>>> +               pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
>>> +                      batch_size);
>>>
>>>>>
>>>>> So, this is a nak from me. sorry.
>>>>>
>>>>
>>>> Furthermore, this makes us lose the ability to permanently map
>>>> input/output pages in the hypervisor. So, Wei kindly undo.
>>>>
>>>
>>> Could you elaborate on "lose the ability to permanently map
>>> input/output pages in the hypervisor"? What specifically can't be
>>> done and why?
>>
>> Input and output are mapped at fixed GPA/SPA always to avoid hyp
>> having to map/unmap every time.
> 
> OK. But how does this patch set impede doing a fixed mapping?

The output address can be varied depending on the hypercall, instead
of it being fixed always at fixed address:

          *(void **)output = space + offset; <<<<<<

> Wouldn't that fixed mapping be done at the time the page or pages
> are allocated, and then be transparent to hypercall call sites?
> 
>>
>>> <snip>
>>>
>>>>>
>>>>>> +/*
>>>>>> + * Allocate one page that is shared between input and output args, which is
>>>>>> + * sufficient for all current hypercalls. If a future hypercall requires
>>>>>
>>>>> That is incorrect. We've iommu map hypercalls that will use up entire page
>>>>> for input. More coming as we implement ram withdrawl from the hypervisor.
>>>
>>> At least some form of ram withdrawal is already implemented upstream as
>>> hv_call_withdraw_memory(). The hypercall has a very small input using the
>>> hv_setup_in() helper, but the output list of PFNs must go to a separately
>>> allocated page so it can be retained with interrupts enabled while
>>> __free_page() is called. The use of this separate output page predates the
>>> introduction of the hv_setup_in() helper.
>>
>> Yeah, I am talking about hyp memory that loader gives it, and during the
>> lifetime it accumulates for VMs. We are opening the flood gates, so you
>> will see lots patches very soon.
>>
>>
>>> For iommu map hypercalls, what do the input and output look like? Is the
>>> paradigm different from the typical small fixed portion plus a variable size
>>> array of values that are fed into a rep hypercall? Is there also a large amount
>>> of output from the hypercall? Just curious if there's a case that's fundamentally
>>> different from the current set of hypercalls.
>>
>> Patches coming soon, but at high level, hypercall includes list of SPAs
>> that hypevisor will map into the iommu. These can get large. We will be
>> exploring what we can do better to pass them, perhaps multiple pages, not
>> sure yet, but for now it's single page.
> 
> To be clear, if the iommu hypercall does not produce any output, this patch
> set uses the entire per-cpu hypercall arg page for input. For example,

Good

> hv_mark_gpa_visibility() uses the entire page for input, which is mostly an
> array of PFNs.
> 
> Using multiple input pages is definitely a new paradigm, on both the
> hypervisor and guest sides, and that will need additional infrastructure,
> with or without this patch set.

Right. With this patch set, every hcall is affected rather than just one
when code is modified to support that. That means one must test every
hypercall.

> I'm just trying to understand where there are real technical blockers vs.
> concern about the style and the encapsulation the helpers impose.

Well no technical blockers that can't be resolved, but style and obfuscation
that helpers impose are big concern.

Thanks,
-Mukesh


