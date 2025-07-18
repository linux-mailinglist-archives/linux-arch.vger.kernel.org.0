Return-Path: <linux-arch+bounces-12859-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD6B0AB1C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 22:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4218F3A3E01
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564421A92F;
	Fri, 18 Jul 2025 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GwlPHPU6"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F31A1E98F3;
	Fri, 18 Jul 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752870330; cv=none; b=ikonoS593H02WKfSfhbwHF5gsKBBMAchfLP6A/J2/tYP1QTPMkg59URpdejYOT8sPEKeRNKhjLkqpheyWQo35yDYoQljtiP3ByIJj7JvkAgo5RWNf7oQ0Ciy+ea9NvOvqhF80RqcMhpBXjBp9hDhkn+b/1G+WJ9VGJTmJYZbYuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752870330; c=relaxed/simple;
	bh=/LuV1kI0Iyd+FCiRuNAtsdvbp0nKZH03Cc+yGiEhT7o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KgyZdJR1V4VJV5ug7ZdaxhVNpZaEXvNqpfGhW4iMLM4wL3UG9K2eZcHHn5VdS+aaqS2oOkl1WW6Jztxa47GXayNmvSotHpytkNqJoivEW7RxYIMgfoGtp9B9D6XU3x1remmMKYku/RdxaxGYM77Ow235D8ZPfSLZImftFpBF4Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GwlPHPU6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.208.217] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2570C211FECC;
	Fri, 18 Jul 2025 13:25:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2570C211FECC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752870328;
	bh=K/40819+E+k+K58haOlYWaAdi71u2Yjg3RszMLQnf+k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=GwlPHPU6r/9jOGjP2StGyvwqILNLzFMl0UpAGDze2sULGhbFA6StheBjyTafNgAVm
	 muArOCcrTyP5+qiCwniNL9GZlpVuUP/lVHdBJF1vWpcNnXM+bT6e/ZhFqV79H4yRY5
	 18ipulGp/ZNioluseGtaYCShh8MsmJqYe4yUWLJE=
Message-ID: <43f8be57-a330-455f-8f9e-f5718ff1aa1a@linux.microsoft.com>
Date: Fri, 18 Jul 2025 13:25:27 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, "kys@microsoft.com" <kys@microsoft.com>,
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
Subject: Re: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
To: Michael Kelley <mhklinux@outlook.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Naman Jain <namjain@linux.microsoft.com>,
 Roman Kisel <romank@linux.microsoft.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/18/2025 10:13 AM, Michael Kelley wrote:
> From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, July 18, 2025 9:33 AM
>>
>> On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
>>> From: Michael Kelley <mhklinux@outlook.com>
>>>
> 
> [snip]
> 
>>>
>>> The new code compiles and runs successfully on x86 and arm64. However,
>>> basic smoke tests cover only a limited number of hypercall call sites
>>> that have been modified. I don't have the hardware or Hyper-V
>>> configurations needed to test running in the Hyper-V root partition
>>> or running in a VTL other than VTL 0. The related hypercall call sites
>>> still need to be tested to make sure I didn't break anything. Hopefully
>>> someone with the necessary configurations and Hyper-V versions can
>>> help with that testing.
> 
> Easwar -- 
> 
> Thanks for reviewing.
> 
> Any chance you (or someone else) could do a quick smoke test of this
> patch set when running in the Hyper-V root partition, and separately,
> when running in VTL2?  Some hypercall call sites are modified that
> don't get called in normal VTL0 execution. It just needs a quick
> verification that nothing is obviously broken for the root partition and
> VTL2 cases.
> 
> Michael
> 

I'm working almost entirely in VTL0, so I'd call on Nuno, Naman, and Roman (cc'ed) to help.

- Easwar

