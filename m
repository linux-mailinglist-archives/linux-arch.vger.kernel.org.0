Return-Path: <linux-arch+bounces-9353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82129EB6B5
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 17:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104B7166833
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD64234976;
	Tue, 10 Dec 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qaAvYq7l"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09984234960;
	Tue, 10 Dec 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848851; cv=none; b=pweoQsT80nT9wadjYq1TqKAi/Jg/MTlvv2FHpb6qJ/uIb3fpuj23yPrnI5kBtIjfr9tD563Y+WbdIQP6Zuhj1whzoQB5XeVDBzTMdnG+XForB6SoHI4cPpHTdoD4ZR6GDX8nfDr/Q5VQZTqhllPM59ejKIGPBJ5iExeQ9jafyY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848851; c=relaxed/simple;
	bh=bNrc3/QIRuMRADX4i6xidePb7Se8rnZoHFgWuntFk6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFCpfv8qG8c8jO7gPWUGOy46hsi4Cvj5OLubgtaa4VigQlAnJG2D/0JX00wI6U6zUG600ZXsKVOagBRzOoc08pZJlhMpbNTEtnELf2g/AzNlZM50ryBOpyY1WMFPgZsoQwL3JD0ngSDGwJZ4pQV8ZGPOO2pO8OXU7uc6B34DNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qaAvYq7l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.16.84.29] (unknown [131.107.8.93])
	by linux.microsoft.com (Postfix) with ESMTPSA id 564502047222;
	Tue, 10 Dec 2024 08:40:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 564502047222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733848849;
	bh=jrmNUEzHaPbfzPastsRVKoN7SSf1AJHpgCYDuVUBkcs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qaAvYq7lyqspuQZ7OkIAAqOTvmA+2X29R4IObrDpeT1/2dvBSeRobjCAh6lzuXTIB
	 mCRwtak/ZzDJ5+IqnZv+ZWmlbSk5oi8gPenZI/luDYlvBia7HUu+Z7kvfxa3KjhD8E
	 TnsRBHVn/f7nO8STVaJc0gW220fXwfN8VhaB3pdg=
Message-ID: <fec1aeb7-ea07-4363-9e6a-50b0c778e855@linux.microsoft.com>
Date: Tue, 10 Dec 2024 08:40:49 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hyperv: Move hv_current_partition_id to arch-generic
 code
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1733523707-15954-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157E39FBEFB18EB9A695EECD4332@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157E39FBEFB18EB9A695EECD4332@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/2024 7:01 PM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, December 6, 2024 2:22 PM
>>
>> Make hv_current_partition_id available in both x86_64 and arm64.
>> This feature isn't specific to x86_64 and will be needed by common
>> code.
>>
>> While at it, replace the BUG()s with WARN()s. Failing to get the id
>> need not crash the machine (although it is a very bad sign).
>>
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
> 
> Instead of adding a definition of hv_current_partition_id on
> the arm64 side, couldn't the definition on the x86 side in
> hv_init.c be moved to hv_common.c (or maybe somewhere
> else that is specific to running in the root partition, per my
> comments in the cover letter), so there is only one definition
> shared by both architectures?
> 
Yes, that's a better idea.

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
> 
> hv_get_partition_id() uses the hyperv_pcpu_output_arg, and at
> this point, hyperv_pcpu_output_arg isn't set. That setup
> is done later in hv_common_init().
> 
>> +
>> +	WARN_ON(hv_root_partition && hv_current_partition_id == HV_PARTITION_ID_SELF);
>> +
> 
> Since the hypercall will fail cleanly if the calling VM doesn't
> have the HV_ACCESS_PARTITION_ID privilege, could the
> above be simplified to just this?
> 
> 	if (hv_root_partition)
> 		hv_get_partition_id():
> 
> A non-root partition VM doesn't need to get the partition ID, while a
> root partition should have the privilege. If the hypercall fails, there's
> already a WARN, so there's no value in doing another WARN. Also if
> the hypercall succeeds, it presumably returns a specific partitionID, not
> HV_PARTITION_ID_SELF, so we know we have what we want.
> 
> There's already an "if (hv_root_partition)" statement for setting up
> the hyperv_pcpu_output_arg. The call to hv_get_partition_id() could
> go under that existing "if" *after* the hyperv_pcpu_output_arg is
> set. :-)
> 
Thank you, that makes sense. I'll make the changes you suggested for v2.

Nuno

> Michael
> 
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


