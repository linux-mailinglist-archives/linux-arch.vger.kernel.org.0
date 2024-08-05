Return-Path: <linux-arch+bounces-5982-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C9947E9A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A346D2865CD
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A465589B;
	Mon,  5 Aug 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WAZUEdvv"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DD14901F;
	Mon,  5 Aug 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722872995; cv=none; b=Hy9AZ/kCK9l/gvGssrbVQPWHewadvMZL64KlXD9wmgkpwwGzVcyL8DIMGfQOW94UvcmtjyfqHDd4yeZBIhhYJQVjl8y1Ad0NPN88IfAyhCdfVsvPrdcea1Rp34juDDdMe24xBvxQtLVchqDOXsGQLTUB6U+LaoqdPlOeyFPVVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722872995; c=relaxed/simple;
	bh=yeFaGTSoFXsGEPZhEcE2BIMYKcjXEqnShBHbeVyeeYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmGJ25FBUWBoNmz51ULTuZg9FSJ8alX+aROhyOi1Fd2VBPQeobmTkBY4QvbOrwUYSOh8FSEpbtiOdNY0WDazXkE4Mxgd+/X8LYCE4wPrdJeGXNvF4nXBLhtXljrLC2E+f24dajkK88OxnObUL0CfcUyNBOFvMXTWrBLueOoPCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WAZUEdvv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5C8520B7177;
	Mon,  5 Aug 2024 08:49:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5C8520B7177
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722872994;
	bh=/vZFiGEaRCK52F8dlOLL/ikJJjWqQULFOAlwfCZtB2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAZUEdvvplp9Kz9DnN3K1N7AnKVUJSClgxvtv1KR134wKpshpUYQPaVLBnCg5d4s9
	 6dtcZ71qsNM6vRC7M/WJ5MuXFXCAtc80nH4ZX3BUKjCch7p1HYqnKS+IZ/LSHT77RN
	 m8PBDBuvrEe9ZdT5NtLDT0zvyY4AQld/+GxIX8Xs=
Message-ID: <2db03d90-55d8-440c-b90a-de421b6929ff@linux.microsoft.com>
Date: Mon, 5 Aug 2024 08:49:54 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
To: Michael Kelley <mhklinux@outlook.com>,
 Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "apais@microsoft.com"
 <apais@microsoft.com>, "benhill@microsoft.com" <benhill@microsoft.com>,
 "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <20240805083024.GB31897@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB415701C313BD5E296393A29DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415701C313BD5E296393A29DD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/5/2024 7:12 AM, Michael Kelley wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Monday, August 5, 2024 1:30 AM
>>
>> On Fri, Jul 26, 2024 at 03:59:09PM -0700, Roman Kisel wrote:
>>> The VMBus driver uses ACPI for interrupt assignment on
>>> arm64 hence it won't function in the VTL mode where only
>>> DeviceTree can be used.
>>>
>>> Update the VMBus driver to discover interrupt configuration
>>> via DeviceTree and indicate DMA cache coherency.
>>>
>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>> ---
>>>   drivers/hv/vmbus_drv.c | 49 ++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 49 insertions(+)
>>>
>>> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
>>> index 12a707ab73f8..7eee7caff5f6 100644
>>> --- a/drivers/hv/vmbus_drv.c
>>> +++ b/drivers/hv/vmbus_drv.c
>>> @@ -2306,6 +2306,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>>>   }
>>>   #endif
>>>
>>> +static int __maybe_unused vmbus_set_irq(struct platform_device *pdev)
>>> +{
>>> +	struct irq_desc *desc;
>>> +	int irq;
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq == 0) {
>>> +		pr_err("VMBus interrupt mapping failure\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	if (irq < 0) {
>>> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
>>> +		return irq;
>>> +	}
>>> +
>>> +	desc = irq_to_desc(irq);
>>
>> irq_to_desc is not an exported symbol if CONFIG_SPARSE_IRQ is enabled. This will
>> break the builds for HYPERV as module.
>>
> 
> Instead, use irq_get_irq_data(), then irqd_to_hwirq().
> 
Couldn't appreciate enough your indispensable advice, folks!

> Michael

-- 
Thank you,
Roman


