Return-Path: <linux-arch+bounces-14903-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB1C6E20E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A42EA34A139
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EF730C366;
	Wed, 19 Nov 2025 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mP/P3lxt"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661134574A;
	Wed, 19 Nov 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763550143; cv=none; b=LKBbzEaG/mtdFOvGVeRZw+ahFLS9366wz/ho44JfM2sViQHCmIbOzP2P3x8jbx0MoNCer7W+PlbBswn4KRKoT/tca+wCwOKT8lU4FMbYyhCjww7DvY9sp4EamASYW/wEGmjg6Q5IqwbK4eytWb75Pn0/PWmLmTIuBCBaYbWVooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763550143; c=relaxed/simple;
	bh=udimc1P+CCMn+0HXpPW/n5CllgbQhyKx2s+dwi05tCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rkzdm9P+K+469p10TA5nQD95yMmm4Al+xiCfMDhWuSzsulsE9GVSIn0+GhAB0JApq1k8se0qUu0dkA8hBUpPnOMw4NRNPuuKcY4yei849ERQovdOcIn35+cJzGpS4RCB/raR0ltfzmGcLAan4CQMau7/2irepOeA+n8TgSClcg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mP/P3lxt; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <956c7ca1-bce8-4eed-8a86-bc8adfc708b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763550129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWCjd1KJePPhJ2kBW/1JQctwuUbeN7emyFaJsPF+13s=;
	b=mP/P3lxthQRt4RBNI75YZfNBnXZAmkVQUWXJ/rGkrYoFs+cdyTatJFvEAkxHy17h5PcVU7
	Lk+c5TNjUFkOX+52zWjraznru5UeZZ0zArHNg+EAlhJsCa8P85HvXHgzZV0dRjfvL/z3qw
	3uyQEOwjBq6far+PazqEXVEHQS/Z8sg=
Date: Wed, 19 Nov 2025 19:02:01 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
 <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
 <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
 <9386032c-9840-49da-83f9-74b112f3e752@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <9386032c-9840-49da-83f9-74b112f3e752@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi David,

On 11/19/25 6:19 PM, David Hildenbrand (Red Hat) wrote:
> On 18.11.25 13:02, Qi Zheng wrote:
>>
>>
>> On 11/18/25 12:57 AM, David Hildenbrand (Red Hat) wrote:
>>> On 14.11.25 12:11, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>
>>> Subject: s/&&/&/
>>
>> will do.
>>
>>>
>>>>
>>>> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM
>>>> can
>>>> be enabled by default on all architectures that support
>>>> MMU_GATHER_RCU_TABLE_FREE.
>>>>
>>>> Considering that a large number of PTE page table pages (such as 
>>>> 100GB+)
>>>> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
>>>> 64BIT.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>    arch/x86/Kconfig | 1 -
>>>>    mm/Kconfig       | 6 +-----
>>>>    2 files changed, 1 insertion(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index eac2e86056902..96bff81fd4787 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -330,7 +330,6 @@ config X86
>>>>        select FUNCTION_ALIGNMENT_4B
>>>>        imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>>        select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>>        select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>>        select SCHED_SMT            if SMP
>>>>        select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>> index a5a90b169435d..e795fbd69e50c 100644
>>>> --- a/mm/Kconfig
>>>> +++ b/mm/Kconfig
>>>> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>>          The architecture has hardware support for userspace shadow 
>>>> call
>>>>              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>> -config ARCH_SUPPORTS_PT_RECLAIM
>>>> -    def_bool n
>>>> -
>>>>    config PT_RECLAIM
>>>>        bool "reclaim empty user page table pages"
>>>>        default y
>>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>> -    select MMU_GATHER_RCU_TABLE_FREE
>>>> +    depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
>>>
>>> Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop
>>> the MMU part)
>>
>> OK.
>>
>>>
>>> Why do we care about SMP in the first place? (can we frop SMP)
>>
>> OK.
>>
>>>
>>> But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":
>>>
>>> Would it be harmful on 32bit (sure, we might not reclaim as much, but
>>> still there is memory to be reclaimed?)?
>>
>> This is also fine on 32bit, but the benefits are not significant, So I
>> chose to enable it only on 64-bit.
> 
> Right. Address space is smaller, but also memory is smaller. Not that I 
> think we strictly *must* to support 32bit, I merely wonder why we 
> wouldn't just enable it here.
> 
> OTOH, if there is a good reason we cannot enable it, we can definitely 
> just keep it 64bit only.

The only difficulty is this:

> 
>>
>> I actually tried enabling MMU_GATHER_RCU_TABLE_FREE on all
>> architectures, and apart from sparc32 being a bit troublesome (because
>> it uses mm->page_table_lock for synchronization within
>> __pte_free_tlb()), the modifications were relatively simple.

in sparc32:

void pte_free(struct mm_struct *mm, pgtable_t ptep)
{
         struct page *page;

         page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> 
PAGE_SHIFT);
         spin_lock(&mm->page_table_lock);
         if (page_ref_dec_return(page) == 1)
                 pagetable_dtor(page_ptdesc(page));
         spin_unlock(&mm->page_table_lock);

         srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
}

#define __pte_free_tlb(tlb, pte, addr)  pte_free((tlb)->mm, pte)

To enable MMU_GATHER_RCU_TABLE_FREE on sparc32, we need to implement
__tlb_remove_table(), and call the pte_free() above in __tlb_remove_table().

However, the __tlb_remove_table() does not have an mm parameter:

void __tlb_remove_table(void *_table)

so we need to use another lock instead of mm->page_table_lock.

I have already sent the v2 [1], and perhaps after that I can enable
PT_RECLAIM on all 32-bit architectures as well.

[1]. 
https://lore.kernel.org/all/cover.1763537007.git.zhengqi.arch@bytedance.com/

>>
>>>
>>> If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously
>>> state), why can't we only check for 64BIT?
>>
>> OK, will do.
> 
> This was also more of a question for discussion:
> 
> Would it make sense to have
> 
> config PT_RECLAIM
>      def_bool y
>      depends on MMU_GATHER_RCU_TABLE_FREE

make sense.

> 
> (a) Would we want to make it configurable (why?)

No, it was just out of caution before.

> (b) Do we really care about SMP (why?)

No. Simply because the following situation is impossible to occur:

pte_offset_map
traversing the PTE page table

<preemption or hardirq>

call madvise(MADV_DONTNEED)

so there's no need to free PTE page via RCU.

> (c) Do we want to limit to 64bit (why?)

No, just because the profit is greater at 64-BIT.

> (d) Do we really need the MMU check in addition to
>      MMU_GATHER_RCU_TABLE_FREE

No, I was worried about compilation issues before, but now it seems that
my worries were unnecessary.

Thanks,
Qi

> 
> 


