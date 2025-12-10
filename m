Return-Path: <linux-arch+bounces-15327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 001FACB38CE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CCBA3014BD0
	for <lists+linux-arch@lfdr.de>; Wed, 10 Dec 2025 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B943112D0;
	Wed, 10 Dec 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="esmWhdaf"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F2C28541A;
	Wed, 10 Dec 2025 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765386203; cv=none; b=gi9cSXvJX2hEwhluK3WwteLA8GX5kauFrgzGAcIOxpXzIJNpHezW+1Tf7r4hrUABSbEp6dVxIkmLW3/efwiNLF3SqL853hxJbyf/OaJLfm/vjdGmEyy3IHVaULxzJ69xHhhnYoi6gFJjWhHXex0/ck7LAgWff067FuXZIALeNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765386203; c=relaxed/simple;
	bh=7laRfK4nZ5KNumBLo8B0Bs64gDVcnHfmlDOtuv+qdMY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UjLBT+cnozYSGkU5twZkRhEfENjHvHSKX8BSOx+nxEVkLekSOyFSq/GbmM0vMF5SCK/4L18zUXNPXf5OUzDMXyezlExzf+bMh+yYRexH3wisw2H2cYz3AaC/aPNSvJCzPvYECSPAt4MDMeElYY/2kidXqTfqx65pWrcjpIrOlCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=esmWhdaf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id E548F2120391;
	Wed, 10 Dec 2025 09:03:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E548F2120391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765386196;
	bh=89vtiRRACaQWJsakzRJrzF0HLZte8XWdUGdC8EN5Ipo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=esmWhdafmYa40uF9nWHtS8yA4fVd18d3wiB+mFkX6ErptZw63ttk/bncNxj3TjjHn
	 tqtJ2K84F0+SIfocAYPPLaRZP78wGdwTC3/osmGYtTa9CSbw2RtIdvfres4A2DxdJo
	 HqX4yJIbhQjs8smSTw6ePblrw9lW/WtGpMKi+zPA=
Message-ID: <95e7c111-c5a0-498d-ab8c-a36eca2f5edb@linux.microsoft.com>
Date: Wed, 10 Dec 2025 09:03:02 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 jacob.pan@linux.microsoft.com, nunodasneves@linux.microsoft.com,
 mrathor@linux.microsoft.com, mhklinux@outlook.com, peterz@infradead.org,
 linux-arch@vger.kernel.org
Subject: Re: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
To: Randy Dunlap <rdunlap@infradead.org>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
 <827c75e4-8e6c-4e98-9a1a-80ddba0de61a@infradead.org>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <827c75e4-8e6c-4e98-9a1a-80ddba0de61a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/2025 9:21 PM, Randy Dunlap wrote:
> Hi--
> 
> On 12/8/25 9:11 PM, Yu Zhang wrote:
>> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>>
>> Hyper-V uses a logical device ID to identify a PCI endpoint device for
>> child partitions. This ID will also be required for future hypercalls
>> used by the Hyper-V IOMMU driver.
>>
>> Refactor the logic for building this logical device ID into a standalone
>> helper function and export the interface for wider use.
>>
>> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
>> ---
>>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
>>  include/asm-generic/mshyperv.h      |  2 ++
>>  2 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 146b43981b27..4b82e06b5d93 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct irq_data *data)
>>  
>>  #define hv_msi_prepare		pci_msi_prepare
>>  
>> +/**
>> + * Build a "Device Logical ID" out of this PCI bus's instance GUID and the
>> + * function number of the device.
>> + */
> 
> Don't use kernel-doc notation "/**" unless you are using kernel-doc comments.
> You could just convert it to a kernel-doc style comment...

Thank you for the review, I will fix in a future revision.

Thanks,
Easwar (he/him)

