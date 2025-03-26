Return-Path: <linux-arch+bounces-11138-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F3A71A80
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CC684055D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250031F4165;
	Wed, 26 Mar 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h9CXDAO1"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8431F2369;
	Wed, 26 Mar 2025 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003176; cv=none; b=hUQXm4FDE3TSnkqysZJ6rmZR/N+xmxESqrZqGDOQeqyGSy3GJQvcTSh+3gZGTAscYdXDBtG5uKD7StB8stB+1scZf78j7uvOBdmpFSL2bv0L9+JeEsGT/nI/4f04dbYw/KnqhAT32w/vfgqgCX66hkKqrUx0Xm3vSchqE35Rt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003176; c=relaxed/simple;
	bh=QfFKHtPjhnsVEIyS3XzuUBPioCudwzrqL/GSdI3aKa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrR3+R4CLs0PFi1jp19GbhXBjZyEif48CJhoGDk2avP0TCepY6sHjgKngSInTbbjmRLWH1VBUrd1zBuEKfEjQFDFluG+SROraYYlaasND8PED7opOLEfB3Y3UCD5JWsrOsTK6VKaaVwTciv45zDo+HKzvWrGCfQFSes9nk2sCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h9CXDAO1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id A914B210C320;
	Wed, 26 Mar 2025 08:32:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A914B210C320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743003174;
	bh=5dEhZXpJIQDYjKp44/xRbSpFUSHWMuuE2+/dnL6k/lU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h9CXDAO1ZrAH2QmyDPeZh9D575YKdAtnwcuvQxr+2h+cWYYQEZjW0lE1GdOfjm8h0
	 WTL8D4VFuAxQbfVPl4CANyl7MImvzKVJrV1UkEJ6ZDQRtMcF1/oXVnUIM04GP/33qq
	 SoTHHkrgirDlGx5JlRlVXulkrfzJWIihHsu4hJNE=
Message-ID: <f8ccc874-e153-4b78-8159-9923dfa77fc3@linux.microsoft.com>
Date: Wed, 26 Mar 2025 08:32:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v6 10/11] ACPI: irq: Introduce
 acpi_get_gsi_dispatcher()
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
 <20250315001931.631210-11-romank@linux.microsoft.com>
 <CAJZ5v0g1bX_3zRUUf-=euuvhm1dPB6bjEXPH9O-kMGcZjRspcw@mail.gmail.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <CAJZ5v0g1bX_3zRUUf-=euuvhm1dPB6bjEXPH9O-kMGcZjRspcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/26/2025 7:55 AM, Rafael J. Wysocki wrote:
> On Sat, Mar 15, 2025 at 1:19 AM Roman Kisel <romank@linux.microsoft.com> wrote:
[...]
> 
> This basically looks OK to me except for a couple of coding style
> related nits below.
> 

Appreciate taking time to review this very much! Will squash the nits in
the next version.

>> ---
>>   drivers/acpi/irq.c   | 15 +++++++++++++--
>>   include/linux/acpi.h |  5 ++++-
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
>> index 1687483ff319..8eb09e45e5c5 100644
>> --- a/drivers/acpi/irq.c
>> +++ b/drivers/acpi/irq.c
>> @@ -12,7 +12,7 @@
>>
>>   enum acpi_irq_model_id acpi_irq_model;
>>
>> -static struct fwnode_handle *(*acpi_get_gsi_domain_id)(u32 gsi);
>> +static acpi_gsi_domain_disp_fn acpi_get_gsi_domain_id;
>>   static u32 (*acpi_gsi_to_irq_fallback)(u32 gsi);
>>
>>   /**
>> @@ -307,12 +307,23 @@ EXPORT_SYMBOL_GPL(acpi_irq_get);
>>    *     for a given GSI
>>    */
>>   void __init acpi_set_irq_model(enum acpi_irq_model_id model,
>> -                              struct fwnode_handle *(*fn)(u32))
> 
> Please retain the indentation here and analogously below.
> 
>> +       acpi_gsi_domain_disp_fn fn)
>>   {
>>          acpi_irq_model = model;
>>          acpi_get_gsi_domain_id = fn;
>>   }
>>
>> +/**
>> + * acpi_get_gsi_dispatcher - Returns dispatcher function that
>> + *                           computes the domain fwnode for a
>> + *                           given GSI.
>> + */
> 
> I would format this kerneldoc comment a bit differently:
> 
> /*
>   * acpi_get_gsi_dispatcher() - Get the GSI dispatcher function
>   *
>   * Return the dispatcher function that computes the domain fwnode for
> a given GSI.
>   */
> 
>> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void)
>> +{
>> +       return acpi_get_gsi_domain_id;
>> +}
>> +EXPORT_SYMBOL_GPL(acpi_get_gsi_dispatcher);
>> +
>>   /**
>>    * acpi_set_gsi_to_irq_fallback - Register a GSI transfer
>>    * callback to fallback to arch specified implementation.
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index 4e495b29c640..abc51288e867 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -336,8 +336,11 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
>>   int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
>>   int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
>>
>> +typedef struct fwnode_handle *(*acpi_gsi_domain_disp_fn)(u32);
>> +
>>   void acpi_set_irq_model(enum acpi_irq_model_id model,
>> -                       struct fwnode_handle *(*)(u32));
>> +       acpi_gsi_domain_disp_fn fn);
>> +acpi_gsi_domain_disp_fn acpi_get_gsi_dispatcher(void);
>>   void acpi_set_gsi_to_irq_fallback(u32 (*)(u32));
>>
>>   struct irq_domain *acpi_irq_create_hierarchy(unsigned int flags,
>> --
> 
> With the above addressed, please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch and route it along with the rest of the series.
> 

Will do, thanks!

> Thanks!

-- 
Thank you,
Roman


