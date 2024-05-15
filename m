Return-Path: <linux-arch+bounces-4438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0AA8C6C3A
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 20:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAB1C21BC4
	for <lists+linux-arch@lfdr.de>; Wed, 15 May 2024 18:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBD63BBF6;
	Wed, 15 May 2024 18:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="p8SOsXVL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7714A1A2C25;
	Wed, 15 May 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715798060; cv=none; b=eiUatLe7LRal+NzoW4s5xLfVmCUwAvFR4UPGAZfrVGXCnMd0V3Q708+6kE4y2EAwexTXeJ2/N6DetatVO25J5+fpqnkh5E9Vzk5nltMIbEicSlOHhzuMEaAPflr5HAT0bUxz95rTC5CSX0Nr5hxR7jhOoV1qpxEpp3ZTqS+jBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715798060; c=relaxed/simple;
	bh=sVFWQ3rZirwUblV0GqRO7ybwI1ENyv2jLFYloxY1tmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyPffUBWhVknt11LaPpbF1xT4yRD2a9+H9uVf/hqmVfjPFYOqr8sW9au7jG6P22rvVHksioxWoQUt2IdDHAU+JIr+Sdfx2LfedPETgCookOU7DDyzC3VIFbLpNb3KuiMU04p0I337+2NKhKanf19ME1PTEHGZxbCg0LWOLSeovc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=p8SOsXVL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9D84D20BE54C;
	Wed, 15 May 2024 11:34:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9D84D20BE54C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715798058;
	bh=JiwxcyFZZClm27jDeVD6FIAV+REMJpfpKthMKDFCly0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p8SOsXVLkMI2Zft0K4DraVsV0y+WEJsal72i3x0CZg20yVIxWlMoY9QnXl/e4VRfL
	 CynzwiLkyK7flTJa5nq6tKqobEnw+ItmBztAYQmDwZwcdLuW++rDwgHKOgNWc6JI0z
	 RmQezDUgoy2YpxvDGh75BWkF17gPGFvK66iqhepM=
Message-ID: <a9adee06-b5d5-4b07-bfa5-68a0153699f3@linux.microsoft.com>
Date: Wed, 15 May 2024 11:34:18 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain from
 DT
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240515181238.GA2129352@bhelgaas>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20240515181238.GA2129352@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/15/2024 11:12 AM, Bjorn Helgaas wrote:
> On Wed, May 15, 2024 at 09:34:09AM -0700, Roman Kisel wrote:
>>
>>
>> On 5/15/2024 2:48 AM, Saurabh Singh Sengar wrote:
>>> On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
>>>> The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
>>>> on arm64 thereby it won't be able to do that in the VTL mode where
>>>> only DeviceTree can be used.
>>>>
>>>> Update the hyperv-pci driver to discover interrupt configuration
>>>> via DeviceTree.
>>>
>>> Subject prefix should be "PCI: hv:"
>>>
>> Thanks!
> 
> "git log --oneline <file>" is a good guide in general and could be
> used for other patches in this series as well.
> 
Many thanks for suggesting that :)

>>>> +		hv_msi_gic_irq_domain = acpi_irq_create_hierarchy(0, HV_PCI_MSI_SPI_NR,
>>>> +			fn, &hv_pci_domain_ops,
>>>> +			chip_data);
>>>
>>> Upto 100 characters per line are supported now, we can have less
>>> line breaks.
>>>
>> Fewer line breaks would make this look nicer, let me know if you had any
>> particular style in mind.
> 
> Let's not use the checkpatch "$max_line_length = 100" as a guide.
> 
> The pci-hyperv.c file as a whole is obviously formatted to fit in 80
> columns with few exceptions.
> 
> IMO it would not be an improvement to scatter random 100-column lines
> throughout.  That would just mean the file would look bad in an
> 80-column terminal and there would be a lot of wasted space in a
> 100-column terminal.
> 
Appreciate showing me the data-driven way of reasoning about that very much!

> Bjorn

-- 
Thank you,
Roman

