Return-Path: <linux-arch+bounces-13248-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD032B3082A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 23:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06C95A3A14
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 21:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE32C0298;
	Thu, 21 Aug 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MmbzMTXj"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18C2C027F;
	Thu, 21 Aug 2025 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810959; cv=none; b=l6WS5qCxnyrWfGZ/odq+nk4NxdONgOQohNkPKDATVGZkPfXHF0Vk/wNlOUxLPFUfr1Yc4gtfF83ADfwxf7w6l5ffPBkX0kluJjDmUjPZEjsDEjfBK4Feo5abWzI3XTfLWa8yGPYEd5mVkcRoxrji+5ZnDK06nOBbZVNUnSIrapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810959; c=relaxed/simple;
	bh=/LtxeeKPRImp78W2TR6vIVSLcbv7tvKQoP6i1qODnso=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NgBYU4BdWjyNcncEdOuUXYA5fkUc9XMRrFvllXooyVrb8zY5wc2wyui95/WOd0+D/UZQSw4MkrnWw36rU4tzMhZV2NANcb8C9XqLqzKndlZ0nLR+CJyUuB/28eSFzJ0gbzn2VMms8JHO6PsVzGmMb8Kmj7M3nVq6jDIrPqVrhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MmbzMTXj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0396C2116DDF;
	Thu, 21 Aug 2025 14:15:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0396C2116DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755810957;
	bh=9k/HBrc2eL3SVYbPGTnCn1yplm2kaM62dC/fS9pAUa0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=MmbzMTXjeeXoXX4DnWVqX+lPzZnKSDli4hJbpJkvWyRsdM2OBNVZQTHhGsoEN03iU
	 lvRSuL7xZNu7G4xgDY6jn6xTQt8Lfj+8iknipsuvNyYSsL2PnnIXxQpWESRUw04ueE
	 P6aACUQXi7gr+NRboSNAO7S/+6c7YHyi8v/FrKDk=
Message-ID: <133c9897-12a8-619a-6cf4-334bc2036755@linux.microsoft.com>
Date: Thu, 21 Aug 2025 14:15:56 -0700
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
From: Mukesh R <mrathor@linux.microsoft.com>
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
In-Reply-To: <833a0c96-470f-acff-72e7-cc82995fbc2f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 13:49, Mukesh R wrote:
> On 8/21/25 12:24, Michael Kelley wrote:
>> From: Mukesh R <mrathor@linux.microsoft.com> Sent: Wednesday, August 20, 2025 7:58 PM
>>>
>>> On 8/20/25 17:31, Mukesh R wrote:
>>>> On 4/15/25 11:07, mhkelley58@gmail.com wrote:
>>>>> From: Michael Kelley <mhklinux@outlook.com>
>>>>>
>>>>>
> <snip>
>>>>
>>>>
>>>> IMHO, this is unnecessary change that just obfuscates code. With status quo
>>>> one has the advantage of seeing what exactly is going on, one can use the
>>>> args any which way, change batch size any which way, and is thus flexible.
>>
>> I started this patch set in response to some errors in open coding the
>> use of hyperv_pcpu_input/output_arg, to see if helper functions could
>> regularize the usage and reduce the likelihood of future errors. Balancing
>> the pluses and minuses of the result, in my view the helper functions are
>> an improvement, though not overwhelmingly so. Others may see the
>> tradeoffs differently, and as such I would not go to the mat in arguing the
>> patches must be taken. But if we don't take them, we need to go back and
>> clean up minor errors and inconsistencies in the open coding at some
>> existing hypercall call sites.
> 
> Yes, definitely. Assuming Nuno knows what issues you are referring to,
> I'll work with him to get them addressed asap. Thanks for noticing them.
> If Nuno is not aware, I'll ping you for more info.

Talked to Nuno, he's not aware of anything pending or details. So if you
can kindly list them out here, I will make sure it gets addressed right
away.

Thanks,
-Mukesh


>>
<deleted>
>>

