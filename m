Return-Path: <linux-arch+bounces-10202-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC33A3ABB7
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 23:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FCF16A3AB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2025 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67DC1C5486;
	Tue, 18 Feb 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nbqb+bYN"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39F2862A5;
	Tue, 18 Feb 2025 22:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917928; cv=none; b=R65xx/QPrgWdIj1YtQrUr4JGIKxUkOoScT/ahj0k3wcH/V5wmeYr4spzJpFPj1Plr7LHQ5LZsuPRPq9KnTgjazbbAY5OoqluSJtYHCvpmZ/HyCzJjTPfWvoBtq9upwjG1EjIKzYo1VkD+hrU+NV3Kq7hGhH5fvZhR1O+AiqYPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917928; c=relaxed/simple;
	bh=MNyQrzrM2hdZD5RtjbM9UexD/z0IBigwTDdl/68TcTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qJ6On1smVG+oGVh3LPxLmvHp+1orsAewBXnYKstYH27uNbgcg8N50C3Rz7MjnACQ6AM+7xsnzkBs1vPydZHj1PdZfsmcTcM/iq/ihgqH20iWeWKU54Mq0BWwVzWGBnkD84fmBEUWd2qFhAdwFeaf6kl/Gu+kWk2oBiFT7ijuy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nbqb+bYN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4E96820376ED;
	Tue, 18 Feb 2025 14:32:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E96820376ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739917926;
	bh=wkHtF8Q1p9OLsyZ01ZxOlGG224lrcQMUsc6UkXJicro=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nbqb+bYNVQ0gup+rvq/dhImqOWkwYohvkh5vvpwNHfMeSwBVbDosoWWE57JaQtoSf
	 SCCcRwRTFnVYwSEG2WcM2hfuquEeiOufFJUpLjad8c4/n4jB+k1nw8BbzOsEFrced2
	 0YoLSIqvXbVccqXXco4HoZ+xIZRWRpOZkJdTff94=
Message-ID: <19435dae-89b5-4c23-af1e-c8917e29c857@linux.microsoft.com>
Date: Tue, 18 Feb 2025 14:32:06 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 6/6] PCI: hv: Get vPCI MSI IRQ domain from
 DeviceTree
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mingo@redhat.com, robh@kernel.org,
 ssengar@linux.microsoft.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250212174203.GA81135@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250212174203.GA81135@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/2025 9:42 AM, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 05:43:21PM -0800, Roman Kisel wrote:

[...]

>> +	 * function called later.
> 
> The rest of this file fits in 80 columns; please wrap this to match.
> 

Will fix, thank you for taking the time to review that!

>> +	 */
>> +	if (!domain)
>> +		WARN_ONCE(1, "No interrupt-parent found, check the DeviceTree data.\n");
> 
> Is there a way to include a hint about what specific part of the
> devicetree to look at, e.g., the node that lacks a parent?

I'll improve this, will mention the bus, thanks!

[...]

>> +	 * the messy ifdef below.
> 
> Add a blank line if you intend a new paragraph here.  Otherwise, wrap
> to fill 78 columns or so.

Will fix this, appreciate noticing that!

> 
>> +	 * There is apparently no such default in the OF subsystem, and
>> +	 * `hv_pci_of_irq_domain_parent` finds the parent IRQ domain that
>> +	 * points to the GIC as well.
> 
> And here.

Will fix, thanks!

>> +	 * None of these two cases reaches for the MSI parent domain.
> 
> I don't know what "reaches for the MSI parent domain" means.  Neither
> "searches for"?
> 

My bad, sorry about the incomprehensible phrasing! Will fix this, thank
you!

>>   	 */
>> -	hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> -							  fn, &hv_pci_domain_ops,
>> -							  chip_data);
>> +#ifdef CONFIG_ACPI
>> +	if (!acpi_disabled)
>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
>> +#if defined(CONFIG_OF)
>> +	if (!hv_msi_gic_irq_domain)
>> +		hv_msi_gic_irq_domain = irq_domain_create_hierarchy(
>> +			hv_pci_of_irq_domain_parent(), 0, HV_PCI_MSI_SPI_NR,
>> +			fn, &hv_pci_domain_ops,
>> +			chip_data);
>> +#endif
> 
> I don't know if acpi_irq_create_hierarchy() is helping or hurting
> here.  It obscures the fact that the only difference is the first
> argument to irq_domain_create_hierarchy().  If we could open-code or
> have a helper to figure out that irq_domain "parent" argument for the
> ACPI case, then we'd only have one call of
> irq_domain_create_hierarchy() here and it seems like it might be
> simpler.
> 

That looks quite dirty, no dispute over that... The root device was
static/provate for the ACPI case, and I didn't go for changing the ACPI
subsystem code to improve this patch, thought the only user wouldn't
justify tinkering with the whole ACPI subsystem. Maybe I also will
need to see if that can be used from a module/builti-in, locking,
bogus usage, i.e. all that normally comes with promoting a private
interface to public.

Let me work out the details and post the change here to see what
feedback that receives.

Last but certainly not least: owing a great debt of gratitude to you
(and all other folks) for helping in bringing this to the best shape
possible!

-- 
Thank you,
Roman


