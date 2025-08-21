Return-Path: <linux-arch+bounces-13247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7907B307D4
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF37AC75C3
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 20:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083F352FDB;
	Thu, 21 Aug 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iR3TX5Di"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CE350838;
	Thu, 21 Aug 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755809375; cv=none; b=ZORQHJkJMRhyegkrIwL8Kyfwcher9GLy+TJTN5K1mrHHZR8z7hpjvKW/Kd5BxOCYWSodOIYasz0WTydnCRuSP3esu5ip7nUkU80AE1+FtbUn6GvBaxsTWRkeRfFHTiiQPs35qSM/3FYOpxqDodiAoMVZUqvIS/vrnEsvjEa9Lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755809375; c=relaxed/simple;
	bh=I59Q4gykP3nqMoFvbLVoMlB+6BLq+OxabvM5FCSpuBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ik10Wqi66LwAGIaQ3u9mhj+33P59ZsoV4PKPtxUHFpFekF/UuHVXCSFfLJKvruLHNOXjO3k/8ZnEHH/pGB6hjYTngsL/Tm7JoAluXexRCxrU+zptPZqpwxHWCR1eT3VASMzV5u50yfWjy00rgPCq0nl5CfKSNdxzs5BlgZlcoDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iR3TX5Di; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B6E12116B43;
	Thu, 21 Aug 2025 13:49:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B6E12116B43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755809372;
	bh=Ycm3d82ILDOuIJ8hMr//WBLCYjeAS3iT+HhalDzwCNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iR3TX5DiGU2T6HNdy0NyHU9wj0GRO2W5G3OV225D12mX2KOmTjLtgX2+5IhENQPBS
	 utB1IDBbW5XdAHUpTfZ3L0C/r6omtOW19xtz+y3tZXaGqv9OAdk64qkagySMgyEkJ4
	 GZRhM2RwnihXW1mGMP7Uf0vsEP1GXDlH22bl6DO4=
Message-ID: <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
Date: Thu, 21 Aug 2025 13:49:31 -0700
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
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157376DD06C1DC2E28A76B7D432A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 12:24, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, August 20, 2025 7:58 PM
>>
>> On 8/20/25 17:31, Mukesh R wrote:
>>> On 4/15/25 11:07, mhkelley58@gmail.com wrote:
>>>> From: Michael Kelley <mhklinux@outlook.com>
>>>>
>>>>
<snip>
>>>
>>>
>>> IMHO, this is unnecessary change that just obfuscates code. With status quo
>>> one has the advantage of seeing what exactly is going on, one can use the
>>> args any which way, change batch size any which way, and is thus flexible.
> 
> I started this patch set in response to some errors in open coding the
> use of hyperv_pcpu_input/output_arg, to see if helper functions could
> regularize the usage and reduce the likelihood of future errors. Balancing
> the pluses and minuses of the result, in my view the helper functions are
> an improvement, though not overwhelmingly so. Others may see the
> tradeoffs differently, and as such I would not go to the mat in arguing the
> patches must be taken. But if we don't take them, we need to go back and
> clean up minor errors and inconsistencies in the open coding at some
> existing hypercall call sites.

Yes, definitely. Assuming Nuno knows what issues you are referring to,
I'll work with him to get them addressed asap. Thanks for noticing them.
If Nuno is not aware, I'll ping you for more info.


>>> With time these functions only get more complicated and error prone. The
>>> saving of ram is very minimal, this makes analyzing crash dumps harder,
>>> and in some cases like in your patch 3/7 disables unnecessarily in error case:
>>>
>>> - if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
>>> -  pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
>>> -   HV_MAX_MODIFY_GPA_REP_COUNT);
>>> + local_irq_save(flags);      <<<<<<<
>>> ...
> 
> FWIW, this error case is not disabled. It is checked a few lines further down as:

I meant disabled interrupts. The check moves after disabling interrupts, so
it runs "disabled" in traditional OS terminology :).

> 
> +       if (count > batch_size) {
> +               pr_err("Hyper-V: GPA count:%d exceeds supported:%u\n", count,
> +                      batch_size);
> 
>>>
>>> So, this is a nak from me. sorry.
>>>
>>
>> Furthermore, this makes us lose the ability to permanently map
>> input/output pages in the hypervisor. So, Wei kindly undo.
>>
> 
> Could you elaborate on "lose the ability to permanently map
> input/output pages in the hypervisor"? What specifically can't be
> done and why?

Input and output are mapped at fixed GPA/SPA always to avoid hyp
having to map/unmap every time.

> <snip>
> 
>>>
>>>> +/*
>>>> + * Allocate one page that is shared between input and output args, which is
>>>> + * sufficient for all current hypercalls. If a future hypercall requires
>>>
>>> That is incorrect. We've iommu map hypercalls that will use up entire page
>>> for input. More coming as we implement ram withdrawl from the hypervisor.
> 
> At least some form of ram withdrawal is already implemented upstream as
> hv_call_withdraw_memory(). The hypercall has a very small input using the
> hv_setup_in() helper, but the output list of PFNs must go to a separately
> allocated page so it can be retained with interrupts enabled while
> __free_page() is called. The use of this separate output page predates the
> introduction of the hv_setup_in() helper.

Yeah, I am talking about hyp memory that loader gives it, and during the
lifetime it accumulates for VMs. We are opening the flood gates, so you
will see lots patches very soon.


> For iommu map hypercalls, what do the input and output look like? Is the
> paradigm different from the typical small fixed portion plus a variable size
> array of values that are fed into a rep hypercall? Is there also a large amount
> of output from the hypercall? Just curious if there's a case that's fundamentally
> different from the current set of hypercalls.

Patches coming soon, but at high level, hypercall includes list of SPAs
that hypevisor will map into the iommu. These can get large. We will be
exploring what we can do better to pass them, perhaps multiple pages, not
sure yet, but for now it's single page.

Thanks,
-Mukesh


