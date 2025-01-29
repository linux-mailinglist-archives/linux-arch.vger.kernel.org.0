Return-Path: <linux-arch+bounces-9948-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB729A215B9
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CA73A49D4
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jan 2025 00:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05552AE7C;
	Wed, 29 Jan 2025 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AsHySfKs"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C61802B;
	Wed, 29 Jan 2025 00:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738111548; cv=none; b=HXkOGoaSAKzQBZgJLg5Yyc5hiRdVWqOmqZafkHzeUId0bGovWMPHJkQGq3rpMkxHBuxdXXAF7dFJtGxilmn19jmwn3cfUn5KZ7C3VHJWlqP4szAwtKN1CIvQfm4Z9diRB+XkPmghB6oD8v/dimNGhK0I9bj2H/RGtAjZye58pN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738111548; c=relaxed/simple;
	bh=VquOpjQsvHYXtiJIRRb/PoV/4uz5bZNRKQYN1Gma/QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGNz+EijGQkNF3Pwa07ZPgbJWgt4USCE4fjmWpty1QTqwPYgiPyCEfNxh8Of5FX+rOfWvA5SBIpHqioVNw5b+Mnq2OyvZBmo1jSZCuTTmor5pv36hTwcKcLSPcCHZg8RK2N9Rb8w5yXcln/BvicvsvUr8h6v/xBclfqpHhDcMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AsHySfKs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id B05BA2037194;
	Tue, 28 Jan 2025 16:45:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B05BA2037194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738111546;
	bh=eNW3XwGKT8uY68/NIPIEvMVL9MQDtdvOoUBs56294+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AsHySfKs4P0rn+bXmhLBAubuo/hmBVIk34JfhyduufsQSKamabNvy43veGRjtgl/6
	 vmTZ6cUd7JH0VhJ3hojjKS1MbICggAHmveoItYOApXxoTkf0Y+abjyJrwJRNC4d6hB
	 AtU8o0HDa5aUvetEhCsbPTa2XqViDV2IYAbNZ2/c=
Message-ID: <c52ca7db-36a4-471c-8fb6-37a94d637741@linux.microsoft.com>
Date: Tue, 28 Jan 2025 16:45:42 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
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
References: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1737596851-29555-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157042605A22E40767DDC94D4EF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157042605A22E40767DDC94D4EF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/2025 10:45 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, January 22, 2025 5:48 PM
>>
>> Move hv_current_partition_id and hv_get_partition_id() to hv_common.c.
>> These aren't specific to x86_64 and will be needed by common code.
>>
>> Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.
>>
>> Use a stack variable for the output of the hypercall. This allows moving
>> the call of hv_get_partition_id() to hv_common_init() before the percpu
>> pages are initialized.
>>
>> Remove the BUG()s. Failing to get the id need not crash the machine.
>>
>> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
>> ---
>>  arch/x86/hyperv/hv_init.c       | 26 --------------------------
>>  arch/x86/include/asm/mshyperv.h |  2 --
>>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
>>  include/asm-generic/mshyperv.h  |  1 +
>>  4 files changed, 24 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index 173005e6a95d..6b9f6f9f704d 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -34,9 +34,6 @@
>>  #include <clocksource/hyperv_timer.h>
>>  #include <linux/highmem.h>
>>
>> -u64 hv_current_partition_id = ~0ull;
>> -EXPORT_SYMBOL_GPL(hv_current_partition_id);
>> -
>>  void *hv_hypercall_pg;
>>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>>
>> @@ -393,24 +390,6 @@ static void __init hv_stimer_setup_percpu_clockev(void)
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
>> @@ -605,11 +584,6 @@ void __init hyperv_init(void)
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
>> index f91ab1e75f9f..8d3ada3e8d0d 100644
>> --- a/arch/x86/include/asm/mshyperv.h
>> +++ b/arch/x86/include/asm/mshyperv.h
>> @@ -43,8 +43,6 @@ extern bool hyperv_paravisor_present;
>>
>>  extern void *hv_hypercall_pg;
>>
>> -extern u64 hv_current_partition_id;
>> -
>>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>>
>>  bool hv_isolation_type_snp(void);
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index af5d1dc451f6..1da19b64ef16 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -31,6 +31,9 @@
>>  #include <hyperv/hvhdk.h>
>>  #include <asm/mshyperv.h>
>>
>> +u64 hv_current_partition_id = HV_PARTITION_ID_SELF;
>> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
>> +
>>  /*
>>   * hv_root_partition, ms_hyperv and hv_nested are defined here with other
>>   * Hyper-V specific globals so they are shared across all architectures and are
>> @@ -283,6 +286,23 @@ static inline bool hv_output_page_exists(void)
>>  	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>>  }
>>
>> +static void __init hv_get_partition_id(void)
>> +{
>> +	/*
>> +	 * Note in this case the output can be on the stack because it is just
>> +	 * a single u64 and hence won't cross a page boundary.
>> +	 */
>> +	struct hv_get_partition_id output;
> 
> It's unfortunate that the structure name "hv_get_partition_id" is also
> the name of this function. Could the structure name be changed to
> follow the pattern of having "output" in the name, like other hypercall
> parameters? It's not a blocker if it can't be changed. I was just surprised
> to search for "hv_get_partition_id" and find both uses.
> 

hv_output_get_partition_id is really the "correct" name from the Hyper-V code,
so it makes sense to just change it to that in this patch.

> Also, see the comment at the beginning of hv_query_ext_cap() regarding
> using a local stack variable as hypercall input or output. The comment
> originated here [1]. At that time, I didn't investigate Sunil's assertion any
> further, and I'm still unsure whether it is really true. But perhaps for
> consistency and safety we should follow what it says.
> 
> [1] https://lore.kernel.org/linux-hyperv/SN4PR2101MB0880DB0606A5A0B72AD244B4C06A9@SN4PR2101MB0880.namprd21.prod.outlook.com/
> 
Hmm, from some cursory research it does look like stack variables can't be
used with virt_to_phys().

I thought about just using &hv_current_partition directly - I *think* that
will work - but in the end I think it's just simpler to just move calls so the
percpu output page can be used as normal. That may save some additional
back-and-forth as well as explanatory comments in the code.

I will also add a check for hv_output_page_exists() here, as a precaution in
case the HV_ACCESS_PARTITION_ID privilege ever becomes decoupled from
that (as it stands, I believe that permission is only for the root
partition, but you never know).

>> +	u64 status;
>> +
>> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
>> +	if (!hv_result_success(status)) {
>> +		pr_err("Hyper-V: failed to get partition ID: %#lx\n", status);
>> +		return;
>> +	}
>> +	hv_current_partition_id = output.partition_id;
>> +}
>> +
>>  int __init hv_common_init(void)
>>  {
>>  	int i;
>> @@ -298,6 +318,9 @@ int __init hv_common_init(void)
>>  	if (hv_is_isolation_supported())
>>  		sysctl_record_panic_msg = 0;
>>
>> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
>> +		hv_get_partition_id();
> 
> I don't see how this works. On the x86 side, hv_common_init()
> is called before the guest ID is set and the hypercall page is setup.
> So the hypercall in hv_get_partition_id() should fail.
> 

Oh, I tried to get too clever. I will put it back where it was and
add it on the arm64 side to hyperv_init() after the per-cpu init as
I mentioned above.

Thanks for the comments,
Nuno

> Michael
> 
>> +
>>  	/*
>>  	 * Hyper-V expects to get crash register data or kmsg when
>>  	 * crash enlightment is available and system crashes. Set
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index a7bbe504e4f3..98100466e0b2 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -58,6 +58,7 @@ struct ms_hyperv_info {
>>  };
>>  extern struct ms_hyperv_info ms_hyperv;
>>  extern bool hv_nested;
>> +extern u64 hv_current_partition_id;
>>
>>  extern void * __percpu *hyperv_pcpu_input_arg;
>>  extern void * __percpu *hyperv_pcpu_output_arg;
>> --
>> 2.34.1


