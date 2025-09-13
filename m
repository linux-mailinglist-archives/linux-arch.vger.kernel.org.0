Return-Path: <linux-arch+bounces-13561-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788BDB55DD4
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 04:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E61C26B9C
	for <lists+linux-arch@lfdr.de>; Sat, 13 Sep 2025 02:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A8E16EB42;
	Sat, 13 Sep 2025 02:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m21hctkB"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCC43594F;
	Sat, 13 Sep 2025 02:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757729896; cv=none; b=jp7jeHktROoJArB88XY0n8vDSICXDbBKxlsgbzYE3+gt8AHybtAnNJVmEJvPFNzJjYv4JXUrrwcDSW427ke+LsLCFsyjTF2uUX6vCi+sYAUejh+VEvLrR6CXIZVkj/hsNCsuSWfCDmFRL8L/rVZEQBWanGb1S0fl55zZ27k8HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757729896; c=relaxed/simple;
	bh=8qXiJSMEz70CJJyZBmfhphnYdJah4N8ITAV+vxiw8B0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toevmmp2HUMIO+icuToOW0b1q+beGncq9L5tUMu1YjNYEaXWan4U3ieekIzvYLGZ7vTyY0IAKteeUoIWGWl8A25TkrOYkuqLNZCIKm9YxY/GWu4MjHzF5v0iSbTzQwJW+wcTbIOqUTRFh8rpPAsOsXjKC8sHgbntge/8O5h5QwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m21hctkB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3EC6D211AD04;
	Fri, 12 Sep 2025 19:18:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3EC6D211AD04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757729893;
	bh=qOt0TBqCe0QCWONCv2pqyI3pCBn1b1ZIwH52f/TrEDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m21hctkBJpAAvPT14i0FYZtzlISv5mc1KdMdUKKQhmnzfoCElHUGBS+seT0oarMWz
	 Iot9rItOfVaGuBBzEf1dpzmTbMUw768EMx54jcKZGqo9hdfr970CkylZBj8ESJFeCq
	 A5s6IMzPUDi2A+V2R/nF+SwCQVXtZBcN3o1+C4dE=
Message-ID: <1033ff35-850c-e2f0-e2f3-1d5bf4b96a76@linux.microsoft.com>
Date: Fri, 12 Sep 2025 19:18:12 -0700
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
 <d6e63ef3-bdd2-f185-f065-76b333dd1fc3@linux.microsoft.com>
 <SN6PR02MB41575CDB3874DB0867FF9E8FD43EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB4157BF605BE8EE1777AE1860D408A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157BF605BE8EE1777AE1860D408A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/25 08:25, Michael Kelley wrote:
> From: Michael Kelley <mhklinux@outlook.com> Sent: Monday, August 25, 2025 2:01 PM
>>
>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Friday, August 22, 2025 7:25 PM
>>>
>>> On 8/21/25 19:10, Michael Kelley wrote:
>>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, August 21, 2025 1:50 PM
>>>>>
>>>>> On 8/21/25 12:24, Michael Kelley wrote:
>>>>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, August 20, 2025 7:58 PM
>>>>>>>
>>>>>>> On 8/20/25 17:31, Mukesh R wrote:
>>>>>>>> With time these functions only get more complicated and error prone. The
>>>>>>>> saving of ram is very minimal, this makes analyzing crash dumps harder,
>>>>>>>> and in some cases like in your patch 3/7 disables unnecessarily in error case:
>>>>>>>>
>>>>>>>> - if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
>>>>>>>> -  pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
>>>>>>>> -   HV_MAX_MODIFY_GPA_REP_COUNT);
>>>>>>>> + local_irq_save(flags);      <<<<<<<
>>>>>>>> ...
>>>>>>
>>>>>> FWIW, this error case is not disabled. It is checked a few lines further down as:
>>>>>
>>>>> I meant disabled interrupts. The check moves after disabling interrupts, so
>>>>> it runs "disabled" in traditional OS terminology :).
>>>>
>>>> Got it. But why is it problem to make this check with interrupts disabled?
>>>
>>> You are creating disabling overhead where that overhead previously
>>> did not exist.
>>
>> I'm not clear on what you mean by "disabling overhead". The existing code
>> does the following:
>>
>> 1) Validate that "count" is not too big, and return an error if it is.
>> 2) Disable interrupts
>> 3) Populate the per-cpu hypercall input arg
>> 4) Make the hypercall
>> 5) Re-enable interrupts
>>
>> With the patch, steps 1 and 2 are done in a different order:
>>
>> 2) Disable interrupts
>> 1) Validate that "count" is not too big. Re-enable interrupts and return an error if it is.
>> 3) Populate the per-cpu hypercall input arg
>> 4) Make the hypercall
>> 5) Re-enable interrupts
>>
>> Validating "count" with interrupts disabled is probably an additional
>> 2 or 3 instructions executed with interrupts disabled, which is negligible
>> compared to the thousands (or more) of instructions the hypercall will
>> execute with interrupts disabled.
>>
>> Or are you referring to something else as "disabling overhead"?
> 
> Mukesh -- anything further on what you see as the problem here?
> I'm just not getting what your concern is.

It increases the interrupts disabled window, does a print from
interrupts disabled (not a great idea unless it is pr_emerg and system
is crashing), and in case of actual error of (count > batch_size) 
interrupts are getting enabled and disabled that were not before.

> [snip]
> 
>>>>>>> Furthermore, this makes us lose the ability to permanently map
>>>>>>> input/output pages in the hypervisor. So, Wei kindly undo.
>>>>>>>
>>>>>>
>>>>>> Could you elaborate on "lose the ability to permanently map
>>>>>> input/output pages in the hypervisor"? What specifically can't be
>>>>>> done and why?
>>>>>
>>>>> Input and output are mapped at fixed GPA/SPA always to avoid hyp
>>>>> having to map/unmap every time.
>>>>
>>>> OK. But how does this patch set impede doing a fixed mapping?
>>>
>>> The output address can be varied depending on the hypercall, instead
>>> of it being fixed always at fixed address:
>>>
>>>           *(void **)output = space + offset; <<<<<<
>>
>> Agreed. But since mappings from GPA to SPA are page granular, having
>> such a fixed mapping means that there's a mapping for every byte in
>> the page containing the GPA to the corresponding byte in the SPA,
>> right? So even though the offset above may vary across hypercalls,
>> the output GPA still refers to the same page (since the offset is always
>> less than 4096), and that page has a fixed mapping. I would expect the
>> hypercall code in the hypervisor to look for an existing mapping based
>> on the output page, not the output address that includes the offset.
>> But I'm haven't looked at the hypervisor code. If the Hyper-V folks say
>> that a non-zero offset thwarts finding the existing mapping, what does
>> the hypervisor end up doing? Creating a 2nd mapping wouldn't seem
>> to make sense. So I'm really curious about what's going on ....
>>
> 
> Again, any further information about why we "lose the ability to
> permanently map input/output pages"? It seems doubtful to me
> that an offset within the same page would make any difference,
> but maybe Hyper-V is doing something unexpected. If so, I'd like
> to know more about what that is.
> 
> Michael


you've to pass the offset/pointer ever time, and hyp has to map
that instead of just per cpu permanent mapping.

-Mukesh


