Return-Path: <linux-arch+bounces-10686-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36733A5E4B3
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E0C3AF540
	for <lists+linux-arch@lfdr.de>; Wed, 12 Mar 2025 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADDE259C91;
	Wed, 12 Mar 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KY6veRW/"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C1258CF5;
	Wed, 12 Mar 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741808706; cv=none; b=D+QObN6Ii+OlqB6qSr8ajSH4IoyijZbjmBKsb0Zu7YMqjnqKiBnwGNz4XIDVAVvKo6ep3h6b6lsv/MeUwDHXXgj8j2U1+e50RRnSz1rBPvc/0Isy7R8O1BqmYVjsfxjqvOgUqMTdaOvAnwmYcHOS/Ci+OdtZJoODQAvAZlyCK3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741808706; c=relaxed/simple;
	bh=hNYjTn6zdVR9mjDQJg9s/8yzeDoJWMMYD7pocvfTf7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+xjceRXjtw3tRzHmh/p7N/zNbC2VH7gYvZpcTV/ffskeIRSFUrmTEE7dBGjnbccIYwtys62WWg7KQJ4JZGjGGtfO032aXDflFqncB5J6/mhXoWbsIh8vqeovNtJn9QB6exfd++D7Glx5Kuw9nQCS/gSLrM81LCyrEqgcS6zNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KY6veRW/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 54861210B155;
	Wed, 12 Mar 2025 12:45:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54861210B155
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741808704;
	bh=VPZyhneTbQ5N9T3+s+eAs9kmLhZ3O/aRW/7FQa9FcNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KY6veRW/TYvXYRqlrieko87RB02NPbqemVQu9wxZBtiO6QjiU/jl4VJVIXKn+Qbmp
	 KpAwxXbEdKbtO9dv8eLqZC9Td03MtvGs74WCxdYf1T7Bp+epAKWMipnCA5JUxKkrav
	 rtBkKkfD6I461kYIQ4heEXnpybyaQIEDWL4XSiiY=
Message-ID: <5e3e8c30-912c-4fe3-bfac-1ae21242473b@linux.microsoft.com>
Date: Wed, 12 Mar 2025 12:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
To: Tianyu Lan <ltykernel@gmail.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
 <CAMvTesAW-9Mo0oY6UUh2anp6DQCSsVCUhBiV2-bKp2VD_N0DYw@mail.gmail.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <CAMvTesAW-9Mo0oY6UUh2anp6DQCSsVCUhBiV2-bKp2VD_N0DYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/10/2025 6:01 AM, Tianyu Lan wrote:
> On Thu, Feb 27, 2025 at 7:09 AM Nuno Das Neves
> <nunodasneves@linux.microsoft.com> wrote:
>>
>> Add a pointer hv_synic_eventring_tail to track the tail pointer for the
>> SynIC event ring buffer for each SINT.
>>
>> This will be used by the mshv driver, but must be tracked independently
>> since the driver module could be removed and re-inserted.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> 
> It's better to expose a function to check the tail instead of exposing
> hv_synic_eventring_tail directly.
> 
What is the advantage of using a function for this? We need to both set
and get the tail.

> BTW, how does mshv driver use hv_synic_eventring_tail? Which patch
> uses it in this series?
>
This variable stores indices into the synic eventring page (one for each
SINT, and per-cpu). Each SINT has a ringbuffer of u32 messages. The tail
index points to the latest one.

This is only used for doorbell messages today. The message in this case is
a port number which is used to lookup and invoke a callback, which signals
ioeventfd(s), to notify the VMM of a guest MMIO write.

It is used in patch 10.

Thanks
Nuno
 
> Thanks.
> 
> 
>> ---
>>  drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 252fd66ad4db..2763cb6d3678 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
>>
>>  static struct ctl_table_header *hv_ctl_table_hdr;
>>
>> +/*
>> + * Per-cpu array holding the tail pointer for the SynIC event ring buffer
>> + * for each SINT.
>> + *
>> + * We cannot maintain this in mshv driver because the tail pointer should
>> + * persist even if the mshv driver is unloaded.
>> + */
>> +u8 __percpu **hv_synic_eventring_tail;
>> +EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
>> +
>>  /*
>>   * Hyper-V specific initialization and shutdown code that is
>>   * common across all architectures.  Called from architecture
>> @@ -90,6 +100,9 @@ void __init hv_common_free(void)
>>
>>         free_percpu(hyperv_pcpu_input_arg);
>>         hyperv_pcpu_input_arg = NULL;
>> +
>> +       free_percpu(hv_synic_eventring_tail);
>> +       hv_synic_eventring_tail = NULL;
>>  }
>>
>>  /*
>> @@ -372,6 +385,11 @@ int __init hv_common_init(void)
>>                 BUG_ON(!hyperv_pcpu_output_arg);
>>         }
>>
>> +       if (hv_root_partition()) {
>> +               hv_synic_eventring_tail = alloc_percpu(u8 *);
>> +               BUG_ON(hv_synic_eventring_tail == NULL);
>> +       }
>> +
>>         hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
>>                                     GFP_KERNEL);
>>         if (!hv_vp_index) {
>> @@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
>>  int hv_common_cpu_init(unsigned int cpu)
>>  {
>>         void **inputarg, **outputarg;
>> +       u8 **synic_eventring_tail;
>>         u64 msr_vp_index;
>>         gfp_t flags;
>>         const int pgcount = hv_output_page_exists() ? 2 : 1;
>> @@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
>>         inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>>
>>         /*
>> -        * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
>> -        * allocated if this CPU was previously online and then taken offline
>> +        * The per-cpu memory is already allocated if this CPU was previously
>> +        * online and then taken offline
>>          */
>>         if (!*inputarg) {
>>                 mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
>> @@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
>>                         *outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
>>                 }
>>
>> +               if (hv_root_partition()) {
>> +                       synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>> +                       *synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
>> +                                                       sizeof(u8), flags);
>> +
>> +                       if (unlikely(!*synic_eventring_tail)) {
>> +                               kfree(mem);
>> +                               return -ENOMEM;
>> +                       }
>> +               }
>> +
>>                 if (!ms_hyperv.paravisor_present &&
>>                     (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
>>                         ret = set_memory_decrypted((unsigned long)mem, pgcount);
>> --
>> 2.34.1
>>
>>
> 
> 


