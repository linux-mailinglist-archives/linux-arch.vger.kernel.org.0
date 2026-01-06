Return-Path: <linux-arch+bounces-15672-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C34F5CF9265
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 16:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE6130ADE15
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C4031AA8D;
	Tue,  6 Jan 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sD2z4exr"
X-Original-To: linux-arch@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951833508A
	for <linux-arch@vger.kernel.org>; Tue,  6 Jan 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767714120; cv=none; b=qU+LfoFVldsm8DLH3Kw4h8mykj+yWlxl3g8wQiNr0dQJSiELBPyRjKt8shLDTdlGIInmBpPqL9M5ZVQ6P/7tA1wC8t/QMskfd4dusg6y6u8x9GqTMisSqtz1niKZQtQMpnAlgjfgkNVSrZRc3bUubzIZGu2kI0anpviQgf21x+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767714120; c=relaxed/simple;
	bh=KoY0VfzuOI1+/Gg8dqWQtgux1BeoquZK9NkVafuYw3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQyPjhvVLXmTTCbY7iTg8IgTQpM60+dzW2JWO0Idm7IODI6dQXQM/tZjS9NQCPz/jnUKgTCDEoLNrC5f2w9uiUfOQc0FGHaoXxcF7hWnliU+Bd547nyGnA09EoLktLM3XmgectWQFaWdoS8qeeCGWkxunWHtP5eg1ZCNN8p8NvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sD2z4exr; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3e9b27dd-1051-4e40-bd80-0fbbda957f0a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767714111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iByVDmD38s5JhKFTtjPltcBnKNB8pZjXuWFjepg4AvA=;
	b=sD2z4exrVkndcJilqghsE+zBxBQlO4GkU6WEAENU2y/YSmHFjdi3JTPErwJYLi/S6hOC5g
	K3Tj5j/A4Vgiw8fOP7YZy+k0Gct6uXHjin7ywdKBTxxMx1USdipaMVe0zKaSfDKvUeKywG
	BI6f+S2C2Miu+O/fpieSq1/S8e9OOns=
Date: Tue, 6 Jan 2026 23:41:05 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND v3 2/2] mm: introduce pmdp_collapse_flush_sync() to
 skip redundant IPI
Content-Language: en-US
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: dave.hansen@intel.com, dave.hansen@linux.intel.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, shy828301@gmail.com, riel@surriel.com,
 jannh@google.com, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-3-lance.yang@linux.dev>
 <86ab8a1f-f6a3-4523-8ccc-f99edfd30a7e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <86ab8a1f-f6a3-4523-8ccc-f99edfd30a7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/6 23:07, David Hildenbrand (Red Hat) wrote:
> On 1/6/26 13:03, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>> pmdp_collapse_flush() may already send IPIs to flush TLBs, and then
>> callers send another IPI via tlb_remove_table_sync_one() or
>> pmdp_get_lockless_sync() to synchronize with concurrent GUP-fast walkers.
>>
>> However, since GUP-fast runs with IRQs disabled, the TLB flush IPI 
>> already
>> provides the necessary synchronization. We can avoid the redundant second
>> IPI.
>>
>> Introduce pmdp_collapse_flush_sync() which combines flush and sync:
>>
>> - For architectures using the generic pmdp_collapse_flush() 
>> implementation
>>    (e.g., x86): Use mmu_gather to track IPI sends. If the TLB flush sent
>>    an IPI, tlb_gather_remove_table_sync_one() will skip the redundant 
>> one.
>>
>> - For architectures with custom pmdp_collapse_flush() (s390, riscv,
>>    powerpc): Fall back to calling pmdp_collapse_flush() followed by
>>    tlb_remove_table_sync_one(). No behavior change.
>>
>> Update khugepaged to use pmdp_collapse_flush_sync() instead of separate
>> flush and sync calls. Remove the now-unused pmdp_get_lockless_sync() 
>> macro.
>>
>> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
>> Signed-off-by: Lance Yang <lance.yang@linux.dev>
>> ---
>>   include/linux/pgtable.h | 13 +++++++++----
>>   mm/khugepaged.c         |  9 +++------
>>   mm/pgtable-generic.c    | 34 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index eb8aacba3698..69e290dab450 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -755,7 +755,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>>       return pmd;
>>   }
>>   #define pmdp_get_lockless pmdp_get_lockless
>> -#define pmdp_get_lockless_sync() tlb_remove_table_sync_one()
>>   #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>>   #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
>> @@ -774,9 +773,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>>   {
>>       return pmdp_get(pmdp);
>>   }
>> -static inline void pmdp_get_lockless_sync(void)
>> -{
>> -}
>>   #endif
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> @@ -1174,6 +1170,8 @@ static inline void pudp_set_wrprotect(struct 
>> mm_struct *mm,
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>                    unsigned long address, pmd_t *pmdp);
>> +extern pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
>> +                 unsigned long address, pmd_t *pmdp);
>>   #else
>>   static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>                       unsigned long address,
>> @@ -1182,6 +1180,13 @@ static inline pmd_t pmdp_collapse_flush(struct 
>> vm_area_struct *vma,
>>       BUILD_BUG();
>>       return *pmdp;
>>   }
>> +static inline pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
>> +                    unsigned long address,
>> +                    pmd_t *pmdp)
>> +{
>> +    BUILD_BUG();
>> +    return *pmdp;
>> +}
>>   #define pmdp_collapse_flush pmdp_collapse_flush
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   #endif
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 9f790ec34400..0a98afc85c50 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -1177,10 +1177,9 @@ static enum scan_result 
>> collapse_huge_page(struct mm_struct *mm, unsigned long a
>>        * Parallel GUP-fast is fine since GUP-fast will back off when
>>        * it detects PMD is changed.
>>        */
>> -    _pmd = pmdp_collapse_flush(vma, address, pmd);
>> +    _pmd = pmdp_collapse_flush_sync(vma, address, pmd);
>>       spin_unlock(pmd_ptl);
>>       mmu_notifier_invalidate_range_end(&range);
>> -    tlb_remove_table_sync_one();
> 
> Now you issue the IPI under PTL.
We do send TLB flush IPI under PTL before, e.g. in 
try_collapse_pte_mapped_thp():

	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
	pmdp_get_lockless_sync();
	pte_unmap_unlock(start_pte, ptl);

But anyway, we can do better by passing ptl in and unlocking
before the sync IPI ;)
> 
> [...]
> 
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index d3aec7a9926a..be2ee82e6fc4 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -233,6 +233,40 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct 
>> *vma, unsigned long address,
>>       flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>>       return pmd;
>>   }
>> +
>> +pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned 
>> long address,
>> +                   pmd_t *pmdp)
>> +{
>> +    struct mmu_gather tlb;
>> +    pmd_t pmd;
>> +
>> +    VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> +    VM_BUG_ON(pmd_trans_huge(*pmdp));
>> +
>> +    tlb_gather_mmu(&tlb, vma->vm_mm);
> 
> Should we be using the new tlb_gather_mmu_vma(), and do we have to set 
> the TLB pagesize to PMD?

Yes, good point on tlb_gather_mmu_vma()!

So, the sequence will be:

	tlb_gather_mmu_vma(&tlb, vma);
	pmd = pmdp_huge_get_and_clear(...);
	flush_tlb_mm_range(..., &tlb);
	if (ptl)
		spin_unlock(ptl);
	tlb_gather_remove_table_sync_one(&tlb);
	tlb_finish_mmu(&tlb);Thanks,
Lance

