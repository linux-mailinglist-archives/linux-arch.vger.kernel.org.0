Return-Path: <linux-arch+bounces-4437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E688C6C2C
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B581C20F85
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4296438FA5;
	Wed, 15 May 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Tc3R7BFI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63B2E622;
	Wed, 15 May 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797905; cv=none; b=j+lnVpBXSe/8fy+BLCmpuCHtzSE6ASSU1j+HuCpBebUINQLUb6VvmWIUUEFrHcCoCsyLvIm6m9NxpIOArGfzDTCPl2p2PdkiXXRlWdJbrTCLls4/pr66DEr3RgtgAhn2ERpF/g4VfAEfAqfduqK57hTDiy3h3nEwMm8Dr6AGgHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797905; c=relaxed/simple;
	bh=0s166d8ThyJRF0LtvNv+ynksW8/S0kyDn4niUSmV/iA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3u1k1GIcOJKSD+ddbjGnUOvMpCbR7UfFBxqcAgS8S1+nNOSskTIqkpO8tUV5EqcbKVD/a2l37fRoqZG8jokoF19Ce28GgCjOeMrjDlp8+JAnvYiPNmoRZjTe7Ft4qkPwjB35zx4ztgLVdUewWaS1N5vHIBKGR5YL7ZMaFCE/Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Tc3R7BFI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 34AC020B915A;
	Wed, 15 May 2024 11:31:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34AC020B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715797903;
	bh=82+zV7NnktZKrrYz3USZfplzcKttP0Idb0GycX7Cnns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tc3R7BFIR2JNViaO9qjq3uMvYmVM1AuZf2gw+k3NhgatKmiADz5GUQr/Eq9W1WBlL
	 ZXrQASe7tJ9ID2ozV8S8j/EYA8Hw4l8d6prnBSoHJqPPMI/maKBH/REjqXQEALiFL4
	 BYGxZ6oMD949FeCXUzspRET6wJZbMOQE7S14v4Ag=
Message-ID: <9bd0f136-40d0-460f-8d40-39f33511e3cf@linux.microsoft.com>
Date: Wed, 15 May 2024 11:31:43 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from
 DT
To: Michael Kelley <mhklinux@outlook.com>, "arnd@arndb.de" <arnd@arndb.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
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
 "x86@kernel.org" <x86@kernel.org>
Cc: "ssengar@microsoft.com" <ssengar@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "vdso@hexbites.dev" <vdso@hexbites.dev>
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-7-romank@linux.microsoft.com>
 <SN6PR02MB4157EDCF4C5989F155EA8DA1D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157EDCF4C5989F155EA8DA1D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 6:47 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, May 14, 2024 3:44 PM
>>
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
>> on arm64 thereby it won't be able to do that in the VTL mode where
>> only DeviceTree can be used.
> 
> That sentence seems a bit weird.  How about:
> 
>     The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on arm64.
>     It won't be able to do that in the VTL mode where only DeviceTree can be used.
> 
Agreed, appreciate your wordsmithing :)

>>
>> Update the hyperv-pci driver to discover interrupt configuration
>> via DeviceTree.
> 
> "discover interrupt configuration"?   I think that's a cut-and-paste error
> from the previous patch.
> 
Guilty as charged :) Will fix.

>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 13 ++++++++++---
>>   include/linux/acpi.h                |  9 +++++++++
>>   2 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 1eaffff40b8d..ccc2b54206f4 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -906,9 +906,16 @@ static int hv_pci_irqchip_init(void)
>>   	 * way to ensure that all the corresponding devices are also gone and
>>   	 * no interrupts will be generated.
>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +	if (acpi_disabled)
>> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +			irq_find_matching_fwnode(fn, DOMAIN_BUS_ANY),
>> +			0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
> 
> Does the above really work?  It seems doubtful to me that irq_find_matching_fwnode()
> always finds the parent domain that you want.  But I don't have a deep understanding
> of how this works or is supposed to work, so I don't know for sure.
> 
> If the above *does* actually work for all cases, then should it also work for the ACPI
> case?  Then you could avoid the messiness when acpi_irq_create_hierarchy() doesn't
> exist.
> 
Have not got a system to validate this on. Conceptually (at my level of 
ignorance) didn't look very off... Will use the "collapsed" version 
you're suggesting as the litmus test.

>> +	else
>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>>
>>   	if (!hv_msi_gic_irq_domain) {
>>   		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
> 
> I'm wondering if these are the only changes needed to make vPCI work on
> arm64 with DeviceTree.  The DMA coherence issue I mentioned in the previous patch
> definitely affects vPCI devices, so it needs to be fully understood and verified to work
> correctly.
> 
Likely not all as the code is venturing into the new territory composed 
of the pieces never snapped in place together before. Will work on the 
previous patch to resolve as many concerns as possible.

>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index b7165e52b3c6..498cbb2c40a1 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1077,6 +1077,15 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>>   	return false;
>>   }
>>
>> +static inline struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
>> +					     unsigned int size,
>> +					     struct fwnode_handle *fwnode,
>> +					     const struct irq_domain_ops *ops,
>> +					     void *host_data)
>> +{
>> +	return NULL;
>> +}
>> +
>>   #endif	/* !CONFIG_ACPI */
>>
>>   extern void arch_post_acpi_subsys_init(void);
>> --
>> 2.45.0
>>

-- 
Thank you,
Roman

