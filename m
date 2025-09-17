Return-Path: <linux-arch+bounces-13664-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA92B7F0A7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 15:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3913A1C04ECB
	for <lists+linux-arch@lfdr.de>; Wed, 17 Sep 2025 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F24186284;
	Wed, 17 Sep 2025 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PV+ZIDLE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0FAA927;
	Wed, 17 Sep 2025 01:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071757; cv=none; b=nDpsKM+DSZjy1ZuX0IcF/umoXGcQYehuuxGBJZj6Ok0WBlSCQmZASivXbN/BfkoLQGcwFKNN5A/eTXjLzZ7KogmHwoSMKEwwRUInUj25qzWnJvndHFwRfYE9yG+KLkQik/uFlXz2NbXtZBngq6qY1nrjA2Em/Rainn3ZAYwBqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071757; c=relaxed/simple;
	bh=hLNR4qSs+UZrdhX2W8OhIZq5QWL0kQ2yWTx1GTmNdGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTiH1IakDFDuqckyLzNsFafMOKfgBOCK5nJOZP0Zf1QdrDxCGBrAXMoPK0wqHlwazSsCnnBvvXZylhj8fDpOrahNDw2JgtmM5Q3UPtzZ6eKvmAPCoCWe8sHnJBDa9FirQXPZs9CADq9LLCpP8KZeMvyVgoXmDcFi5WozZtVGDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PV+ZIDLE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95D1A201551B;
	Tue, 16 Sep 2025 18:15:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95D1A201551B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758071755;
	bh=AnTAbgWQ7bR2imyjU3rdx8HeKLIeOoLAOyiSKAE/CQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PV+ZIDLERhEKpBWY0bfAD3iqcg1D48QP0SHIaSzElhidM1lp7iCvQzmp9ElhhuxBM
	 5208fBxSVuCBvpzFT6Kof1jQYr1Ve4ZO1Cfn13nhJJvhvhh+xTWBdN8uw65FruA4bE
	 Eb5WOrg3lizbZMKuPwM9oEe9LX3eL1THaU8tQ7/A=
Message-ID: <daa1e607-26ca-887c-b32c-d39addd6fa44@linux.microsoft.com>
Date: Tue, 16 Sep 2025 18:15:53 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 6/6] x86/hyperv: Enable build of hypervisor crashdump
 collection files
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-7-mrathor@linux.microsoft.com>
 <SN6PR02MB415730C50D722D289E33296ED415A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415730C50D722D289E33296ED415A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 10:56, Michael Kelley wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>
>> Enable build of the new files introduced in the earlier commits and add
>> call to do the setup during boot.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  arch/x86/hyperv/Makefile       | 6 ++++++
>>  arch/x86/hyperv/hv_init.c      | 1 +
>>  include/asm-generic/mshyperv.h | 9 +++++++++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
>> index d55f494f471d..6f5d97cddd80 100644
>> --- a/arch/x86/hyperv/Makefile
>> +++ b/arch/x86/hyperv/Makefile
>> @@ -5,4 +5,10 @@ obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
>>
>>  ifdef CONFIG_X86_64
>>  obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
>> +
>> + ifdef CONFIG_MSHV_ROOT
>> +  CFLAGS_REMOVE_hv_trampoline.o += -pg
>> +  CFLAGS_hv_trampoline.o        += -fno-stack-protector
>> +  obj-$(CONFIG_CRASH_DUMP)      += hv_crash.o hv_trampoline.o
>> + endif
>>  endif
>> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
>> index afdbda2dd7b7..577bbd143527 100644
>> --- a/arch/x86/hyperv/hv_init.c
>> +++ b/arch/x86/hyperv/hv_init.c
>> @@ -510,6 +510,7 @@ void __init hyperv_init(void)
>>  		memunmap(src);
>>
>>  		hv_remap_tsc_clocksource();
>> +		hv_root_crash_init();
>>  	} else {
>>  		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
>>  		wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index dbd4c2f3aee3..952c221765f5 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -367,6 +367,15 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32
>> num_pages);
>>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
>>  int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
>>
>> +#if CONFIG_CRASH_DUMP
>> +void hv_root_crash_init(void);
>> +void hv_crash_asm32(void);
>> +void hv_crash_asm64_lbl(void);
>> +void hv_crash_asm_end(void);
>> +#else   /* CONFIG_CRASH_DUMP */
>> +static inline void hv_root_crash_init(void) {}
>> +#endif  /* CONFIG_CRASH_DUMP */
>> +
> 
> The hv_crash_asm* functions are x86 specific. Seems like their
> declarations should go in arch/x86/include/asm/mshyperv.h, not in
> the architecture-neutral include/asm-generic/mshyperv.h.

well, arm port is going on. i suppose i could move it to x86 and
they can move it back  here in their patch submissions. hopefully
they will remember or someone will catch it.

>>  #else /* CONFIG_MSHV_ROOT */
>>  static inline bool hv_root_partition(void) { return false; }
>>  static inline bool hv_l1vh_partition(void) { return false; }
>> --
>> 2.36.1.vfs.0.0
>>


