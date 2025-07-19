Return-Path: <linux-arch+bounces-12860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E27B0AD33
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 03:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997BB1AA695E
	for <lists+linux-arch@lfdr.de>; Sat, 19 Jul 2025 01:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749A922301;
	Sat, 19 Jul 2025 01:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V+XsWpmW"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B31805A;
	Sat, 19 Jul 2025 01:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752887747; cv=none; b=QzN4110tAmisqxMsYFOcMvx3+zKoZI4qQh7rvuF0NFtvIxO6xoJjui59b4ZdaSCzSWVYZpxorXj+wfyNGQF23yVvIsIVeZaTa/lJy5B+67jo5WV8as3uDFvvmxO57pa0jBzzuCRLJ0gYCP5WM8EyKHaxgzv1jdl9dFEMbZINobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752887747; c=relaxed/simple;
	bh=7Req6mDptIYAUL61Ll2AOt1x3tSh/9XvVNzevjIM6I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuovWkN9WoZA0P3Hj63u2SBIwVa6eWM2fcQ6i7v2euYj0p2iIcEZgPANKrcqnbwTiphhMJwF5NtM4oQLFBEydf7VMd/kN15I7A9OoVQ9siqfK2YZ5k3xxxzxSSllXKTsRHlEizrhtk2TeSVUsKV/B5NfKt3Hs2CD48Q5NvBN1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V+XsWpmW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2B340211FED1;
	Fri, 18 Jul 2025 18:15:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B340211FED1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752887745;
	bh=0AvVoCC44EeutgPMUgd48ew3MUhdCUxutkpG+NXBACE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V+XsWpmWJf0i+oKQeCCPfBY2Ph+M5aXYMxkdALZ8eUPVW9SEjOTJsJ0l5X9mBy+yk
	 ASRoxNB6uegW6gIv2jIw3MuH/PepNe34cTAEAuSkWedkG6QK7QcpAVxnWSRPfxnkwL
	 mLCRIAMazLHll4/AWoKl6HsxzkDinK+Oyr8jIpRg=
Message-ID: <ed1e8508-7085-4620-af25-3a8795c1afe8@linux.microsoft.com>
Date: Fri, 18 Jul 2025 18:15:44 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
 <kw@linux.com>, "mani@kernel.org" <mani@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/2025 1:25 PM, Easwar Hariharan wrote:
> On 7/18/2025 10:13 AM, Michael Kelley wrote:
>> From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, July 18, 2025 9:33 AM
>>>
>>> On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
>>>> From: Michael Kelley <mhklinux@outlook.com>
>>>>
>>
>> [snip]
>>
>>>>
>>>> The new code compiles and runs successfully on x86 and arm64. However,
>>>> basic smoke tests cover only a limited number of hypercall call sites
>>>> that have been modified. I don't have the hardware or Hyper-V
>>>> configurations needed to test running in the Hyper-V root partition
>>>> or running in a VTL other than VTL 0. The related hypercall call sites
>>>> still need to be tested to make sure I didn't break anything. Hopefully
>>>> someone with the necessary configurations and Hyper-V versions can
>>>> help with that testing.
>>
>> Easwar --
>>
>> Thanks for reviewing.
>>
>> Any chance you (or someone else) could do a quick smoke test of this
>> patch set when running in the Hyper-V root partition, and separately,
>> when running in VTL2?  Some hypercall call sites are modified that
>> don't get called in normal VTL0 execution. It just needs a quick
>> verification that nothing is obviously broken for the root partition and
>> VTL2 cases.
>>
>> Michael
>>
> 
> I'm working almost entirely in VTL0, so I'd call on Nuno, Naman, and Roman (cc'ed) to help.
> 

Michael,

I'll try to squeeze that in during the next week. Folks should feel free
to beat me to that :) The caveat would be that there are scenarios that
are beyond the capabilities of the hardware that I have readily
available, and would need to run in test clusters in Azure, and these
are pretty busy.

VTL2 currently uses a limited number hypercalls that are set as enabled
in the OpenVMM code (`set_allowed_hypercalls`). You could take a look
and conclude if these hypercalls require any adjustments in the patches.

My opinion has been to have two pages (input and output ones). As the
new code introduces just one page I do feel a bit apprehensive, got no
hard evidence that this is a bad approach though. If we tweak the code
to have 2 pages, perhaps there would be no need to run a full-blown
validation, and even smoke tests will suffice?

> - Easwar

-- 
Thank you,
Roman


