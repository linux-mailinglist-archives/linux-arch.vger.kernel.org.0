Return-Path: <linux-arch+bounces-15539-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CDDCD9116
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 12:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43697303C280
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 11:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF532E732;
	Tue, 23 Dec 2025 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJTxNHGq"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB26E2BE058;
	Tue, 23 Dec 2025 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766488410; cv=none; b=BDdXSVNiIbcJ5uTjoQ9xRYFZa6jf21CLxBiOmGZegGRdPQs6zS4m+Jc/N+k5j8s7TRImVcoEnO8lE+iM9ao2wF/RWMAKhivqF1ugCv218XjUgNd158in0bfZGfXiVMP4iIcQgAiX9I3zl2RDR1Pu3u9hPP0BOPCOebQkoT90umk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766488410; c=relaxed/simple;
	bh=G7/C9/rO7ScpJXIbezmrJniAvV1BqDLKj7YzY62dxBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt5sD0dxKbVd6z1a7IKM7wcmRfX9i2haqBLTG1/uB/UMXlG80D+scJihbu64hQssVXszI862Nh72HLtulrtvrfhstyyI4MluVf1XoKmj427TsmQ0sDlgoQJQ0Wj5jMAInYBJyXkD+JEhPwLq7UR7fhzj8s1KUGerX+J9QUusBrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJTxNHGq; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5071efdf-8260-43dc-8042-69414b124009@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766488405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhIVvsl+kpzgEGwl1JWdZa1JAIXGwZgZsmRbZEGTNGk=;
	b=eJTxNHGqd0zgRdGACW7l9uVB91p+hd7jUu8xLNxdY88PLcL/Ox23THWP7GIWdP9wPpRiVK
	IVda/s6snYL6blU82ENpfx/RRVXo65APAzlVgxSQYOdkwWDF8iWlAwFHkvCuIIomaJcSI4
	dtkn2kjl8ImwtxZQD0hjSC52AQ7LQ94=
Date: Tue, 23 Dec 2025 19:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 2/3] x86/mm: implement redundant IPI elimination for
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, arnd@arndb.de, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, bp@alien8.de, dave.hansen@linux.intel.com,
 dev.jain@arm.com, hpa@zytor.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, mingo@redhat.com,
 npache@redhat.com, npiggin@gmail.com, peterz@infradead.org,
 riel@surriel.com, ryan.roberts@arm.com, shy828301@gmail.com,
 tglx@linutronix.de, will@kernel.org, x86@kernel.org, ziy@nvidia.com,
 Lance Yang <ioworker0@gmail.com>
References: <c36501bc-2690-4ed2-b85e-13e64c41baaf@kernel.org>
 <20251222031919.41964-1-ioworker0@gmail.com>
 <ad5563b6-95d9-4f3a-9f6f-ad7afe72c846@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ad5563b6-95d9-4f3a-9f6f-ad7afe72c846@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/23 17:44, David Hildenbrand (Red Hat) wrote:
> On 12/22/25 04:19, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>>
>> On Thu, 18 Dec 2025 14:08:07 +0100, David Hildenbrand (Red Hat) wrote:
>>> On 12/13/25 09:00, Lance Yang wrote:
>>>> From: Lance Yang <lance.yang@linux.dev>
>>>>
>>>> Pass both freed_tables and unshared_tables to flush_tlb_mm_range() to
>>>> ensure lazy-TLB CPUs receive IPIs and flush their paging-structure 
>>>> caches:
>>>>
>>>>     flush_tlb_mm_range(..., freed_tables || unshared_tables);
>>>>
>>>> Implement tlb_table_flush_implies_ipi_broadcast() for x86: on native 
>>>> x86
>>>> without paravirt or INVLPGB, the TLB flush IPI already provides 
>>>> necessary
>>>> synchronization, allowing the second IPI to be skipped. For paravirt 
>>>> with
>>>> non-native flush_tlb_multi and for INVLPGB, conservatively keep both 
>>>> IPIs.
>>>>
>>>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>>>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>>>> ---
>>>>    arch/x86/include/asm/tlb.h | 17 ++++++++++++++++-
>>>>    1 file changed, 16 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>>>> index 866ea78ba156..96602b7b7210 100644
>>>> --- a/arch/x86/include/asm/tlb.h
>>>> +++ b/arch/x86/include/asm/tlb.h
>>>> @@ -5,10 +5,24 @@
>>>>    #define tlb_flush tlb_flush
>>>>    static inline void tlb_flush(struct mmu_gather *tlb);
>>>> +#define tlb_table_flush_implies_ipi_broadcast 
>>>> tlb_table_flush_implies_ipi_broadcast
>>>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void);
>>>> +
>>>>    #include <asm-generic/tlb.h>
>>>>    #include <linux/kernel.h>
>>>>    #include <vdso/bits.h>
>>>>    #include <vdso/page.h>
>>>> +#include <asm/paravirt.h>
>>>> +
>>>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>>>> +{
>>>> +#ifdef CONFIG_PARAVIRT
>>>> +    /* Paravirt may use hypercalls that don't send real IPIs. */
>>>> +    if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
>>>> +        return false;
>>>> +#endif
>>>> +    return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
>>>
>>> Right, here I was wondering whether we should have a new pv_ops callback
>>> to indicate that instead.
>>>
>>> pv_ops.mmu.tlb_table_flush_implies_ipi_broadcast()
>>>
>>> Or a simple boolean property that pv init code properly sets.
>>
>> Cool!
>>
>>>
>>> Something for x86 folks to give suggestions for. :)
>>
>> I prefer to use a boolean property instead of comparing function 
>> pointers.
>> Something like this:
>>
>> ----8<----
>> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
>> index cfcb60468b01..90e9da33f2c7 100644
>> --- a/arch/x86/hyperv/mmu.c
>> +++ b/arch/x86/hyperv/mmu.c
>> @@ -243,4 +243,5 @@ void hyperv_setup_mmu_ops(void)
>>
>>       pr_info("Using hypercall for remote TLB flush\n");
>>       pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
>> +    pv_ops.mmu.tlb_flush_implies_ipi_broadcast = false;
>>   }
>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/ 
>> asm/paravirt_types.h
>> index 3502939415ad..f9756df6f3f6 100644
>> --- a/arch/x86/include/asm/paravirt_types.h
>> +++ b/arch/x86/include/asm/paravirt_types.h
>> @@ -133,6 +133,19 @@ struct pv_mmu_ops {
>>       void (*flush_tlb_multi)(const struct cpumask *cpus,
>>                   const struct flush_tlb_info *info);
>>
>> +    /*
>> +     * Indicates whether TLB flush IPIs provide sufficient 
>> synchronization
>> +     * for GUP-fast when freeing or unsharing page tables.
>> +     *
>> +     * Set to true only when the TLB flush guarantees:
>> +     * - IPIs reach all CPUs with potentially stale paging-structure 
>> caches
>> +     * - Synchronization with IRQ-disabled code like GUP-fast
>> +     *
>> +     * Paravirt implementations that use hypercalls (which may not send
>> +     * real IPIs) should set this to false.
>> +     */
>> +    bool tlb_flush_implies_ipi_broadcast;
>> +
>>       /* Hook for intercepting the destruction of an mm_struct. */
>>       void (*exit_mmap)(struct mm_struct *mm);
>>       void (*notify_page_enc_status_changed)(unsigned long pfn, int 
>> npages, bool enc);
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 96602b7b7210..9d20ad4786cc 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>> @@ -18,7 +18,7 @@ static inline bool 
>> tlb_table_flush_implies_ipi_broadcast(void)
>>   {
>>   #ifdef CONFIG_PARAVIRT
>>       /* Paravirt may use hypercalls that don't send real IPIs. */
>> -    if (pv_ops.mmu.flush_tlb_multi != native_flush_tlb_multi)
>> +    if (!pv_ops.mmu.tlb_flush_implies_ipi_broadcast)
>>           return false;
>>   #endif
>>       return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
> 
> I'd have thought that the X86_FEATURE_INVLPGB heck should then also be 
> taken care of by whoever sets tlb_flush_implies_ipi_broadcast.

Makes sense!

Let's have the INVLPGB check happen at setup time, not at use time :P

Cheers,
Lance

