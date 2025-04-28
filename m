Return-Path: <linux-arch+bounces-11667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7434BA9F966
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 21:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85CFD3B1812
	for <lists+linux-arch@lfdr.de>; Mon, 28 Apr 2025 19:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D181B296D32;
	Mon, 28 Apr 2025 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c5/deyEm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594282951B5;
	Mon, 28 Apr 2025 19:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745868273; cv=none; b=UPLO3T/0PtNivbcbPZ+aG15AOabmoSAUSa/PSJptLPgDWUNC2BQ1hmA3pF2bav5H352vQoFrwZCFSO8i19jYE45MfpF5lNHK3XLBs1yhaUEDtV09ik6AuFuxcA2VpOOXWI8ymiCTWNLFJUU5Bt1/AGBsZwYMOMVZ3aZhZGCaxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745868273; c=relaxed/simple;
	bh=0R0wWZcT22Gz5EwOhZRf10HdVpYb17+fZ1v8MSKm+aA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAD0PIhZk9fX1fd9beJWNcyjbvHb29Ez1tOW8iYTSTa80xP+EptaBwrEESwWdE2av5r1NTomuZxTq1tjG5c2esv1w5sq6PclS02X0wYJS9WwwuMlZKK+tksFhD1yijoELLE4QGByJLdjaFujiCw0SgH3yAUp9jDeoyZbEDI+ctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c5/deyEm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 864AA211AD01;
	Mon, 28 Apr 2025 12:24:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 864AA211AD01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745868271;
	bh=fak+f+kHYzS1+ypKlrkk0dMyzj3faU9pGBD9R0QixDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c5/deyEmjVX/7FlQ0FNHaDjnA6mqRGNSfHEiYzB4HTuBiubadDnAWmtlp7N1NP4g7
	 1sWbdlpdDh385PrncF6gy/1MtXwt6smPEIrtWgLe0NiGQpkJ4v6/b0eX9stfd9pZpe
	 TQe5YY7qT1JqkwkgPMaRBOVGpYcxkV5u5GyXdMNo=
Message-ID: <cea3a58f-a251-4100-a614-1576876e5eca@linux.microsoft.com>
Date: Mon, 28 Apr 2025 12:24:31 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v8 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
To: Michael Kelley <mhklinux@outlook.com>
Cc: "apais@microsoft.com" <apais@microsoft.com>,
 "benhill@microsoft.com" <benhill@microsoft.com>,
 "bperkins@microsoft.com" <bperkins@microsoft.com>,
 "sunilmut@microsoft.com" <sunilmut@microsoft.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>,
 "kys@microsoft.com" <kys@microsoft.com>, "lenb@kernel.org"
 <lenb@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "maz@kernel.org" <maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "rafael@kernel.org" <rafael@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "rafael.j.wysocki@intel.com"
 <rafael.j.wysocki@intel.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
 "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
 <will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-12-romank@linux.microsoft.com>
 <SN6PR02MB41572F24DCB9247E74876E41D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41572F24DCB9247E74876E41D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/17/2025 8:28 AM, Michael Kelley wrote:
> From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 14, 2025 3:47 PM
[...]

>> +	if (acpi_irq_model != ACPI_IRQ_MODEL_GIC)
>> +		return NULL;
> 
> This causes a build error on arm64 if pci-hyperv.c is built as a
> module because acpi_irq_model is not exported.

Will fix that! Appreciate your reviews very much!

> 
> Michael
> 
>> +	gsi_domain_disp_fn = acpi_get_gsi_dispatcher();
>> +	if (!gsi_domain_disp_fn)
>> +		return NULL;
>> +	return irq_find_matching_fwnode(gsi_domain_disp_fn(0),
>> +				     DOMAIN_BUS_ANY);
>> +}
>> +
>> +#endif
>> +
>>   static int hv_pci_irqchip_init(void)
>>   {
>>   	static struct hv_pci_chip_data *chip_data;
>>   	struct fwnode_handle *fn = NULL;
>> +	struct irq_domain *irq_domain_parent = NULL;
>>   	int ret = -ENOMEM;
>>
>>   	chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
>> @@ -907,9 +952,24 @@ static int hv_pci_irqchip_init(void)
>>   	 * way to ensure that all the corresponding devices are also gone and
>>   	 * no interrupts will be generated.
>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +#ifdef CONFIG_ACPI
>> +	if (!acpi_disabled)
>> +		irq_domain_parent = hv_pci_acpi_irq_domain_parent();
>> +#endif
>> +#ifdef CONFIG_OF
>> +	if (!irq_domain_parent)
>> +		irq_domain_parent = hv_pci_of_irq_domain_parent();
>> +#endif
>> +	if (!irq_domain_parent) {
>> +		WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
>> +		ret = -EINVAL;
>> +		goto free_chip;
>> +	}
>> +
>> +	hv_msi_gic_irq_domain = irq_domain_create_hierarchy(irq_domain_parent, 0,
>> +		HV_PCI_MSI_SPI_NR,
>> +		fn, &hv_pci_domain_ops,
>> +		chip_data);
>>
>>   	if (!hv_msi_gic_irq_domain) {
>>   		pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
>> --
>> 2.43.0
>>
> 

-- 
Thank you,
Roman


