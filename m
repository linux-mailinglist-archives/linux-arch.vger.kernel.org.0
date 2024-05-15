Return-Path: <linux-arch+bounces-4429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B98C6AB0
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE251F213A5
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01A13AF2;
	Wed, 15 May 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HFuwoPQ5"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B590CA7A;
	Wed, 15 May 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790851; cv=none; b=bK8RvIBWfXTMg58VXqLpF0Vx0PJagJeZAkHaU5gQnrrZiPn3v3sCyGSZJm0WRaSvix8dWgCCsXVcTIB+1LvjUtd1TDoTFwuu6PrekG9uyZXERJ6oTFghzQjZhvokhoGDDPp7xb8/3yJO3D00XQMAtxH4+30eJhzzEQTVPFIYNFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790851; c=relaxed/simple;
	bh=GU6KJDrwVaAZGvd4YyiDXiCH4Cu0goHSX5Qv1cNq2nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhizJwOV+VEHVTu5VAFZuuUNFE3nU6frdw+R1z1yEsvhBBgoBakEUg+coTkd/Egn3x5D1vZjW5pUHZYOsycsGwPoRDQ3C8PZJqfwuy+tuvGZT4lyMjWkyT3lSvhFHJCHU8WOvLFfULtRnTv5nVduhG2PN75tEFJjKfU88lF/Xr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HFuwoPQ5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9CFD120BE54C;
	Wed, 15 May 2024 09:34:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9CFD120BE54C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715790849;
	bh=LgGoEoCHc+tmuUHwV72O4w5DS5evewRoGKEngQZTkQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFuwoPQ5g1K3tnZKOH9/B5XNG9OpwxZJVSOTlMoZAY3YUVwYJWDUpZLViiDQtOLXM
	 RF50tZekXZrLHIHIcY3x4azhgGO118LAatJ0iiSe91sxtFWwtf5g5PwaaOCZq6vrle
	 74Dv+Hu/xVGAnFlpZ8lOpSayuYNe/006pxfc5wM8=
Message-ID: <ea91140a-d0df-4efd-aef8-34f00b82cf74@linux.microsoft.com>
Date: Wed, 15 May 2024 09:34:09 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from
 DT
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, decui@microsoft.com,
 haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, mingo@redhat.com,
 mhklinux@outlook.com, rafael@kernel.org, robh@kernel.org,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-7-romank@linux.microsoft.com>
 <20240515094820.GB22844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240515094820.GB22844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 2:48 AM, Saurabh Singh Sengar wrote:
> On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
>> on arm64 thereby it won't be able to do that in the VTL mode where
>> only DeviceTree can be used.
>>
>> Update the hyperv-pci driver to discover interrupt configuration
>> via DeviceTree.
> 
> Subject prefix should be "PCI: hv:"
> 
Thanks!

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
>> +	else
>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
> 
> Upto 100 characters per line are supported now, we can have less
> line breaks.
> 
Fewer line breaks would make this look nicer, let me know if you had any 
particular style in mind.

>>   
>>   	if (!hv_msi_gic_irq_domain) {
>>   		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
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

