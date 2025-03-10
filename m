Return-Path: <linux-arch+bounces-10645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77205A59CCB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1955016F197
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC7C231A2A;
	Mon, 10 Mar 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="izQvo7Lt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CC22FACA;
	Mon, 10 Mar 2025 17:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626915; cv=none; b=Z1NFjbDJKobfe8QCTeIa7UvUFOVJaGcVdlCX2H5/4nQHovwW9A6sVGhKYJ4gCTNRBnap05v/24zcS3EFX1SmWl41/67AoA/swHTHNtsVF66KEAqnA9PG+f6tAgDj4qcyi8o6Fnj0wI7SBG/taAi76KApjGPvOkeAN+z+IVbgwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626915; c=relaxed/simple;
	bh=bWqJ4FD0rh4Jv7wGJ1mKbUp1hDMD5nvjAYgteY/Eo4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/7QbO8GnHje7q1Y7SlMMFPHc2fvlb0VnuoC2Zrq4kp/eM+/a2jaCAGLYL+mPiOLpUIHuLBgXdRuh0fh1/YXDd7wGQeQpPkOVu4ARSZOr7t3m2cMVlE9InNsX6IUpVBECv3i+8xN9X3J/PRcqqdEorGgefqukTd3QyojLrF/iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=izQvo7Lt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BFF802038F32;
	Mon, 10 Mar 2025 10:15:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFF802038F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741626913;
	bh=eME4gRmjVE3w6nzuhE7xqtEmYJ+fLHcjVchsKhgalL8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=izQvo7LtPEn8QdsyQJfUA53eTxUOuoeOz82pbmQ0wQaG1gObJiMFAQaBdi4A4iWNR
	 uP46JGVDaO3cRF/G9lVcXt9kOcQnz5el35Sjj0jweE8RV1fyt3eecjS3tkMovWnNwm
	 xH3wS8Mi9wqAyRiK3OyMT3uXWKNOYhhn5jgty0K8=
Message-ID: <319aac20-229e-4a81-b2c5-e870453634bb@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:15:12 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250310164122.GA551965@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250310164122.GA551965@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 9:41 AM, Bjorn Helgaas wrote:
> On Fri, Mar 07, 2025 at 02:03:03PM -0800, Roman Kisel wrote:
>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration on
>> arm64. It won't be able to do that in the VTL mode where only DeviceTree
>> can be used.
>>
>> Update the hyperv-pci driver to get vPCI MSI IRQ domain in the DeviceTree
>> case, too.
>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> 
> A couple minor comments below, but I don't have any objection to this,
> so if it's OK with the pci-hyperv.c folks, it's OK with me.
> 

Bjorn, thanks a lot for your help and guidance! I'll be most happy to
incorporate your suggestions into the next version of the series :)

>> +#ifdef CONFIG_OF
>> +
>> +static struct irq_domain *hv_pci_of_irq_domain_parent(void)
>> +{
>> +	struct device_node *parent;
>> +	struct irq_domain *domain;
>> +
>> +	parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
>> +	domain = NULL;
>> +	if (parent) {
>> +		domain = irq_find_host(parent);
>> +		of_node_put(parent);
>> +	}
>> +
>> +	return domain;
> 
> I think this would be a little simpler as:
> 
>    parent = of_irq_find_parent(hv_get_vmbus_root_device()->of_node);
>    if (!parent)
>      return NULL;
> 
>    domain = irq_find_host(parent);
>    of_node_put(parent);
>    return domain;
> 
>> +}
>> +
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +
>> +static struct irq_domain *hv_pci_acpi_irq_domain_parent(void)
>> +{
>> +	struct irq_domain *domain;
>> +	acpi_gsi_domain_disp_fn gsi_domain_disp_fn;
>> +
>> +	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
>> +		return NULL;
>> +	gsi_domain_disp_fn = acpi_get_gsi_dispatcher();
>> +	if (!gsi_domain_disp_fn)
>> +		return NULL;
>> +	domain = irq_find_matching_fwnode(gsi_domain_disp_fn(0),
>> +				     DOMAIN_BUS_ANY);
>> +
>> +	if (!domain)
>> +		return NULL;
>> +
>> +	return domain;
> 
>    if (!domain)
>      return NULL;
> 
>    return domain;
> 
> is the same as:
> 
>    return domain;
> 
> or even just:
> 
>    return irq_find_matching_fwnode(gsi_domain_disp_fn(0), DOMAIN_BUS_ANY);
> 
>> +}

-- 
Thank you,
Roman


