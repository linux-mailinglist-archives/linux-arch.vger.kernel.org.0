Return-Path: <linux-arch+bounces-13272-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C85B35014
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 02:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3180D1B262DD
	for <lists+linux-arch@lfdr.de>; Tue, 26 Aug 2025 00:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C6B41760;
	Tue, 26 Aug 2025 00:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aB5hVZzv"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C654739;
	Tue, 26 Aug 2025 00:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167197; cv=none; b=RWcpgxqZghhFCr3WffojoSgeySK/w8FJDNUF8kNxuF9lKrnA1rjLT0nO8BwQVonrFGzbgt//9ma5ju70f4K6demQHpAA+qmw+1FGNl1y++2mMEFCEzR9xPwCKfav18K2SqJhlziC0Zzd4brVNYnQTLp/0Rm8K7KsWY6qz/+pLCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167197; c=relaxed/simple;
	bh=jHv/1F9GOa7La/IRS5S4XDkOIibIk6bnXzeA2fLhnRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4kQ8mY4eNzHt0QPmTiNsY0u4FY1bRlsC0rVnpQxnDrHDRjpMlJMcfipS47Lv/NTylimWYmCIhtnjDyNTHVYzyB44c2+8LfSDSsKa/JGvJOPJhloMt+ym77OxvV4eb1EYMg1Y2DJiD8B6tsZuLjhQEWESZtR1+MsGoG3dEzySvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aB5hVZzv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.0.200] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F85C2118298;
	Mon, 25 Aug 2025 17:13:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F85C2118298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756167194;
	bh=CVIMP+POTkQt/GP3p59xPy3sLUuvk75n+THXeV8y3pw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aB5hVZzvUlnIrojTr3bFiFOjUX1zYvch/lRCdxmVVIKu8MQQC4RQ2ImCh3PHLYWGh
	 2eMVZwhBPyaiPbx4jjDOaopv2W2Rjl/As6wAa6oCwGLyv1Dk3Nc5nKf3ue2bREQ6dZ
	 ieJGCbeRKYrvF7cZj8xUW1MlGrA7CmYA3vxrAQgs=
Message-ID: <209e7fe9-cb5c-4e7c-8b5c-544387cf0927@linux.microsoft.com>
Date: Mon, 25 Aug 2025 17:13:01 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for
 hypercall arguments
To: Michael Kelley <mhklinux@outlook.com>,
 Mukesh R <mrathor@linux.microsoft.com>, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
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
 <133c9897-12a8-619a-6cf4-334bc2036755@linux.microsoft.com>
 <SN6PR02MB41576739C778676C009D5A86D43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576739C778676C009D5A86D43DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/2025 7:16 PM, Michael Kelley wrote:
> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Thursday, August 21, 2025 2:16 PM
>>
>> On 8/21/25 13:49, Mukesh R wrote:
>>> On 8/21/25 12:24, Michael Kelley wrote:
>>>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, August 20, 2025 7:58 PM
>>>>>
>>>>> On 8/20/25 17:31, Mukesh R wrote:
>>>>>> On 4/15/25 11:07, mhkelley58@gmail.com wrote:
>>>>>>> From: Michael Kelley <mhklinux@outlook.com>
>>>>>>>
>>>>>>>
>>> <snip>
>>>>>>
>>>>>>
>>>>>> IMHO, this is unnecessary change that just obfuscates code. With status quo
>>>>>> one has the advantage of seeing what exactly is going on, one can use the
>>>>>> args any which way, change batch size any which way, and is thus flexible.
>>>>
>>>> I started this patch set in response to some errors in open coding the
>>>> use of hyperv_pcpu_input/output_arg, to see if helper functions could
>>>> regularize the usage and reduce the likelihood of future errors. Balancing
>>>> the pluses and minuses of the result, in my view the helper functions are
>>>> an improvement, though not overwhelmingly so. Others may see the
>>>> tradeoffs differently, and as such I would not go to the mat in arguing the
>>>> patches must be taken. But if we don't take them, we need to go back and
>>>> clean up minor errors and inconsistencies in the open coding at some
>>>> existing hypercall call sites.
>>>
>>> Yes, definitely. Assuming Nuno knows what issues you are referring to,
>>> I'll work with him to get them addressed asap. Thanks for noticing them.
>>> If Nuno is not aware, I'll ping you for more info.
>>
>> Talked to Nuno, he's not aware of anything pending or details. So if you
>> can kindly list them out here, I will make sure it gets addressed right
>> away.
>>
> 
> I didn't catalog the issues as I came across them when doing this patch
> set. :-(   I don't think any are bugs that could break things now. They were
> things like not ensuring that all hypercall input fields are initialized to zero,
> duplicate initialization to zero, and unnecessary initialization of hypercall
> output memory. In general, how the hypercall args are set up is inconsistent
> across different hypercall call sites, and that inconsistency can lead to errors,
> which is what I was trying to address.
> 
> But I can go back and come up with a list if that's where we're headed.

Hi Michael and Mukesh,

Just a suggestion, how about a simpler set of macros that doesn't really change
the existing paradigm, but can be used to improve the consistency across the
various hypercall sites.

e.g. for getting and zeroing the input page:

#define hv_get_input_ptr(in_ptr) \
({ \
        static_assert(sizeof(*in_ptr) <= HV_HYP_PAGE_SIZE); \
        void *__arg = *this_cpu_ptr(hyperv_pcpu_input_arg); \
        memset(__arg, 0, sizeof(*in_ptr)); \
        __arg; \
})

(And something similar for the output arg which doesn't need memset())

And for batch size, it can be very simple, although there's both the case
of argument + array elements, and just array elements:

#define hv_arg_get_batch_size(arg_ptr, element_ptr) \
        ((HV_HYP_PAGE_SIZE - sizeof(*arg_ptr)) / sizeof(*element_ptr))

#define hv_get_batch_size(element_ptr) (HV_HYP_PAGE_SIZE / sizeof(*element_ptr))

Usage:

struct hv_input_map_gpa_pages *input_page = hv_get_input_ptr(input_page);
int batch_size = hv_arg_get_batch_size(input_page, &input_page->source_gpa_page_list[0]);



Nuno

> 
> Michael


