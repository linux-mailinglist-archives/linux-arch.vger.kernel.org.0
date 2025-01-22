Return-Path: <linux-arch+bounces-9858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3534A19B03
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 23:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA363AB4B9
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2025 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040831C5D60;
	Wed, 22 Jan 2025 22:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jV0bdZ8M"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB4184A3E;
	Wed, 22 Jan 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585636; cv=none; b=bsYBb9OZjIkYczIiF9NqFnCKHfKn7ERJxqhYZcrgh8qx0xYOKXtWFCdTS3K48dnADyYvzA1s64DDJDNxn3uOcOtZkxR4ECtlu7QwRtxPH+SqTcDEA+jRflBH2ouh1Sq1zFVk8g5DQ8FYmtfmvaMYJIES5D7hnDNboRraZzGtcHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585636; c=relaxed/simple;
	bh=DfOoImGS49SecjwyGHy9jCkUVy3sQULVJUEly4q2zrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dhFOTrttAA4ONp4Ttzt0OzJfMJvXJKPwV3udkzqtoAs3pUSKKFa18QeJeZlPQhKyukqx8jVW6QuRg3mK94YMKMYYWHGDEapjcj7/fdJizZAvWQSgHVd24tifi2Tfu4LtsRl9eHSnuiOr2A7bRiQq5SKEoMz3PWr2ytzF6GMFewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jV0bdZ8M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.115] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5D1320460B2;
	Wed, 22 Jan 2025 14:40:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5D1320460B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737585629;
	bh=hCnqJ7SE7al4Vf7tPnRzZDoKUhMbtBFVu0ZhtEEKigc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jV0bdZ8MWiaF7fwCD5m/9rSCTR1iGYtuscbstQLeZAkO3oP0iczLr9QrORaMuJpl3
	 Zk8dsXz6bMqvTOrsg4blv1v+drOvsa4cv1XB6w5+lYACNmkPx12WAdvegg6g5t0Mek
	 gsBCoQzMP398BFpkMx7EM3kX3F4pBkUtLwknx4uc=
Message-ID: <3e684fba-bf73-4c6c-806f-19fba74eb3f3@linux.microsoft.com>
Date: Wed, 22 Jan 2025 14:40:29 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic
 code
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, jinankjain@linux.microsoft.com,
 muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
 mukeshrathor@microsoft.com
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
 <Z1P69tl2qMNH-xmg@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <Z1P69tl2qMNH-xmg@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/6/2024 11:36 PM, Wei Liu wrote:
> On Fri, Dec 06, 2024 at 02:21:46PM -0800, Nuno Das Neves wrote:
>> From: Nuno Das Neves <nudasnev@microsoft.com>
>>
>> Make hv_current_partition_id available in both x86_64 and arm64.
>> This feature isn't specific to x86_64 and will be needed by common
>> code.
>>
>> While at it, replace the BUG()s with WARN()s. Failing to get the id
>> need not crash the machine (although it is a very bad sign).
>>
> 
> A lot of things have changed since it was introduced. I don't remember
> why I decided to use BUG() instead of WARN() in the first place.
> 
> If the system can still function without knowing its partition id, then
> can this be removed completely? We can always use the SELF id.
> 

Missed this earlier, sorry.

I checked the code and it seems that HV_PARTITION_ID_SELF may be sufficient.
However, I'm not sure if there is some case where it is actually needed,
so I'm hesitant to remove it at the moment.

Nuno

> Thanks,
> Wei.
> 
>> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> ---
>>  arch/arm64/hyperv/mshyperv.c    |  3 +++
>>  arch/x86/hyperv/hv_init.c       | 25 +------------------------
>>  arch/x86/include/asm/mshyperv.h |  2 --
>>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
>>  include/asm-generic/mshyperv.h  |  2 ++
>>  5 files changed, 29 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index b1a4de4eee29..5050e748d266 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -19,6 +19,9 @@
>>  
>>  static bool hyperv_initialized;
>>  
>> +u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
>> +
>>  int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>  {
>>  	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 95eada2994e1..950f5ccdb9d9 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -35,7 +35,7 @@
>>  #include <clocksource/hyperv_timer.h>
>>  #include <linux/highmem.h>
>>  
>> -u64 hv_current_partition_id = ~0ull;
>> +u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>>  EXPORT_SYMBOL_GPL(hv_current_partition_id);
>>  
>>  void *hv_hypercall_pg;
>> @@ -394,24 +394,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
>>  		old_setup_percpu_clockev();
>>  }
>>  
>> -static void __init hv_get_partition_id(void)
>> -{
>> -	struct hv_get_partition_id *output_page;
>> -	u64 status;
>> -	unsigned long flags;
>> -
>> -	local_irq_save(flags);
>> -	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> -	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
>> -	if (!hv_result_success(status)) {
>> -		/* No point in proceeding if this failed */
>> -		pr_err("Failed to get partition ID: %lld\n", status);
>> -		BUG();
>> -	}
>> -	hv_current_partition_id = output_page->partition_id;
>> -	local_irq_restore(flags);
>> -}
>> -
>>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>>  static u8 __init get_vtl(void)
>>  {
>> @@ -606,11 +588,6 @@ void __init hyperv_init(void)
>>  
>>  	register_syscore_ops(&hv_syscore_ops);
>>  
>> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
>> -		hv_get_partition_id();
>> -
>> -	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
>> -
>>  #ifdef CONFIG_PCI_MSI
>>  	/*
>>  	 * If we're running as root, we want to create our own PCI MSI domain.
>> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
>> index 5f0bc6a6d025..9eeca2a6d047 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -44,8 +44,6 @@ extern bool hyperv_paravisor_present;
>>  
>>  extern void *hv_hypercall_pg;
>>  
>> -extern u64 hv_current_partition_id;
>> -
>>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>>  
>>  bool hv_isolation_type_snp(void);
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 7a35c82976e0..819bcfd2b149 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -278,11 +278,34 @@ static void hv_kmsg_dump_register(void)
>>  	}
>>  }
>>  
>> +static void __init hv_get_partition_id(void)
>> +{
>> +	struct hv_get_partition_id *output_page;
>> +	u64 status;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
>> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
>> +	if (!hv_result_success(status)) {
>> +		local_irq_restore(flags);
>> +		WARN(true, "Failed to get partition ID: %lld\n", status);
>> +		return;
>> +	}
>> +	hv_current_partition_id = output_page->partition_id;
>> +	local_irq_restore(flags);
>> +}
>> +
>>  int __init hv_common_init(void)
>>  {
>>  	int i;
>>  	union hv_hypervisor_version_info version;
>>  
>> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>> +		hv_get_partition_id();
>> +
>> +	WARN_ON(hv_root_partition && hv_current_partition_id == HV_PARTITION_ID_SELF);
>> +
>>  	/* Get information about the Hyper-V host version */
>>  	if (!hv_get_hypervisor_version(&version))
>>  		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index 8fe7aaab2599..8c4ff6e9aae7 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -60,6 +60,8 @@ struct ms_hyperv_info {
>>  extern struct ms_hyperv_info ms_hyperv;
>>  extern bool hv_nested;
>>  
>> +extern u64 hv_current_partition_id;
>> +
>>  extern void * __percpu *hyperv_pcpu_input_arg;
>>  extern void * __percpu *hyperv_pcpu_output_arg;
>>  
>> -- 
>> 2.34.1
>>


