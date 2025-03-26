Return-Path: <linux-arch+bounces-11139-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A4A71AE0
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3B47A82FD
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 15:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A11FCFEF;
	Wed, 26 Mar 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QCZ/1a3p"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B661F583A;
	Wed, 26 Mar 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003451; cv=none; b=mb5wpHfIPA4SXVCIBHKF2mKgvRd2GrJrWsL74VkfCPCJHERZDsMZai/ylB5ZffV9Ngd6gRAs7ZgnWIAtAoP7EXFTmUktTAd18+sAYTSa/ZI51bCO6pBwa4X9EDni4nVKnC/wLDwf+8iww7eS1Xlo/x8M7ZjfoMDCBqi9svLvbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003451; c=relaxed/simple;
	bh=X7FAEgRsV2xbboJ7QKOztmy6O5MW3v9XOfceR4QGwks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYVB6x44gE4rKHzJcLxHvMSuDeclHUqkTGg/jvU3+nLvr8vyqHP7p99TFhf5XEokWIkzBXOQxNfKOucxfZtRiVz5VV4EC6sFsZEj8hAE/6iBPrHOaYm+ajIWrTr50hSupHUXteVvbhX7/sExJtTx1DkEUKy97HwLA4qJHFuuq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QCZ/1a3p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 204B22036597;
	Wed, 26 Mar 2025 08:37:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 204B22036597
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743003449;
	bh=WjzFIgjV9jVjkAChBrIFVJQnAYd6k3ZAKIpA/MaT4yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QCZ/1a3p+ZIUFWcAhkJvic5IwY8U0ufXEKXOuGNNCfYPOL2C8wZRVb0oHeZ26p7MN
	 55ghDNm1zZbkc7h9pH8j0WaY5qfjqpwdKTYWPi2UX1+7ck4WlgOZl7f4IIiSvY3N3U
	 3LSW1a2/cC6In4mf7262M02Vm2HMR/pY2ogrm5bY=
Message-ID: <83b983a4-064e-4a81-9c58-239b630eb299@linux.microsoft.com>
Date: Wed, 26 Mar 2025 08:37:28 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 11/11] PCI: hv: Get vPCI MSI IRQ domain
 from DeviceTree
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com,
 kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, maz@kernel.org,
 mingo@redhat.com, oliver.upton@linux.dev, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-12-romank@linux.microsoft.com>
 <CAJZ5v0jNEO2VcwmMXLZaS+Kqg3iBgHcWb65f90HKUADtPuvgqA@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAJZ5v0jNEO2VcwmMXLZaS+Kqg3iBgHcWb65f90HKUADtPuvgqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/26/2025 7:56 AM, Rafael J. Wysocki wrote:
> On Sat, Mar 15, 2025 at 1:19 AM Roman Kisel <romank@linux.microsoft.com> wrote:

[...]

>> -                                                         chip_data);
>> +#ifdef CONFIG_ACPI
>> +       if (!acpi_disabled)
>> +               irq_domain_parent = hv_pci_acpi_irq_domain_parent();
>> +#endif
>> +#if defined(CONFIG_OF)
> 
> Why don't you do
> 
> #ifdef CONFIG_OF
> 
> here for consistency?
> 

Agree, that'd be easier on the eyes :) Will fix in the next version,
thanks for the suggestion!

>> +       if (!irq_domain_parent)
>> +               irq_domain_parent = hv_pci_of_irq_domain_parent();
>> +#endif
>> +       if (!irq_domain_parent) {
>> +               WARN_ONCE(1, "Invalid firmware configuration for VMBus interrupts\n");
>> +               ret = -EINVAL;
>> +               goto free_chip;
>> +       }
>> +
>> +       hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +               irq_domain_parent, 0, HV_PCI_MSI_SPI_NR,
>> +               fn, &hv_pci_domain_ops,
>> +               chip_data);
>>
>>          if (!hv_msi_gic_irq_domain) {
>>                  pr_err("Failed to create Hyper-V arm64 vPCI MSI IRQ domain\n");
>> --

-- 
Thank you,
Roman


