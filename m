Return-Path: <linux-arch+bounces-15670-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2D2CF8FED
	for <lists+linux-arch@lfdr.de>; Tue, 06 Jan 2026 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DB6730A73C6
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jan 2026 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE00A33FE2A;
	Tue,  6 Jan 2026 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik9S8YpN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9916533F8CE;
	Tue,  6 Jan 2026 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712055; cv=none; b=s9zkLeQUP9e3CICc1EP2GVN4oNvJm3JssCW7TnM4wXDn1lplvudHO5HOBUkHRDrwEEgaaY8puzKuafiUYntKN8757JRxeBpiz28vJokRqo8oZE9kXeEA/MDBBYLHVidxyg6pH2FjSE8/+yZ3NW57mLBoZT0frnKOQIHMtz+hYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712055; c=relaxed/simple;
	bh=8qG/+V95KgS0mZQXBDQS4rA76GBhdjSGltajL1KP3uM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqHT1SuPjsHm+ZLTMCJp4lGgSrksWY925Rav4f+DtdKbjC7Nke7Qzef7h9KlhKeHhH09YkUng8ie+EhaI6xz1BOd3NR8IiZgZPvZssk7CpMqjzDDEa4p2cc1FePubvcsOi2QUjokXtHU+abhQJ2DvKgmQ7nyOb5zkguyn8aLMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik9S8YpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C23C116C6;
	Tue,  6 Jan 2026 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767712054;
	bh=8qG/+V95KgS0mZQXBDQS4rA76GBhdjSGltajL1KP3uM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ik9S8YpNULD6Yr7Z5c6FjldYO0LXnp8CcBy8uPubZKpLZMSuOwhQ3g+s7DLfdYf/J
	 uBlp/ogoYVroHmuF23LGkqgRmR0mkAaaAavIEV9HSlg4rvUk8535XYsFEZAFhtdFR3
	 blFTH1Lth7yBClD5NaKVLgPZ5aCy/lmat8Idqa0T7PZo8BCsdd6a8y5jliRtvvk/ej
	 B0Lmk/KVLLDODqRzmuNr2fJqmIILfq64JNz1JLO2WMo5AqIAo6G4yOJ62eTYbDBzkt
	 Qw8T8Y3PWIAQx1wpQ0okdbSpWDV0pfmgc9dS0+7ibU1W3HjcaEgqvIvp+V+GMsdkWv
	 SwXP8ZhXr8VsQ==
Message-ID: <86ab8a1f-f6a3-4523-8ccc-f99edfd30a7e@kernel.org>
Date: Tue, 6 Jan 2026 16:07:24 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/2] mm: introduce pmdp_collapse_flush_sync() to
 skip redundant IPI
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: dave.hansen@intel.com, dave.hansen@linux.intel.com, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260106120303.38124-1-lance.yang@linux.dev>
 <20260106120303.38124-3-lance.yang@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
In-Reply-To: <20260106120303.38124-3-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/6/26 13:03, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> pmdp_collapse_flush() may already send IPIs to flush TLBs, and then
> callers send another IPI via tlb_remove_table_sync_one() or
> pmdp_get_lockless_sync() to synchronize with concurrent GUP-fast walkers.
> 
> However, since GUP-fast runs with IRQs disabled, the TLB flush IPI already
> provides the necessary synchronization. We can avoid the redundant second
> IPI.
> 
> Introduce pmdp_collapse_flush_sync() which combines flush and sync:
> 
> - For architectures using the generic pmdp_collapse_flush() implementation
>    (e.g., x86): Use mmu_gather to track IPI sends. If the TLB flush sent
>    an IPI, tlb_gather_remove_table_sync_one() will skip the redundant one.
> 
> - For architectures with custom pmdp_collapse_flush() (s390, riscv,
>    powerpc): Fall back to calling pmdp_collapse_flush() followed by
>    tlb_remove_table_sync_one(). No behavior change.
> 
> Update khugepaged to use pmdp_collapse_flush_sync() instead of separate
> flush and sync calls. Remove the now-unused pmdp_get_lockless_sync() macro.
> 
> Suggested-by: David Hildenbrand (Red Hat) <david@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   include/linux/pgtable.h | 13 +++++++++----
>   mm/khugepaged.c         |  9 +++------
>   mm/pgtable-generic.c    | 34 ++++++++++++++++++++++++++++++++++
>   3 files changed, 46 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index eb8aacba3698..69e290dab450 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -755,7 +755,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>   	return pmd;
>   }
>   #define pmdp_get_lockless pmdp_get_lockless
> -#define pmdp_get_lockless_sync() tlb_remove_table_sync_one()
>   #endif /* CONFIG_PGTABLE_LEVELS > 2 */
>   #endif /* CONFIG_GUP_GET_PXX_LOW_HIGH */
>   
> @@ -774,9 +773,6 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>   {
>   	return pmdp_get(pmdp);
>   }
> -static inline void pmdp_get_lockless_sync(void)
> -{
> -}
>   #endif
>   
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -1174,6 +1170,8 @@ static inline void pudp_set_wrprotect(struct mm_struct *mm,
>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>   extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   				 unsigned long address, pmd_t *pmdp);
> +extern pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
> +				 unsigned long address, pmd_t *pmdp);
>   #else
>   static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   					unsigned long address,
> @@ -1182,6 +1180,13 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>   	BUILD_BUG();
>   	return *pmdp;
>   }
> +static inline pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma,
> +					unsigned long address,
> +					pmd_t *pmdp)
> +{
> +	BUILD_BUG();
> +	return *pmdp;
> +}
>   #define pmdp_collapse_flush pmdp_collapse_flush
>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>   #endif
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 9f790ec34400..0a98afc85c50 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1177,10 +1177,9 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long a
>   	 * Parallel GUP-fast is fine since GUP-fast will back off when
>   	 * it detects PMD is changed.
>   	 */
> -	_pmd = pmdp_collapse_flush(vma, address, pmd);
> +	_pmd = pmdp_collapse_flush_sync(vma, address, pmd);
>   	spin_unlock(pmd_ptl);
>   	mmu_notifier_invalidate_range_end(&range);
> -	tlb_remove_table_sync_one();

Now you issue the IPI under PTL.

[...]

> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index d3aec7a9926a..be2ee82e6fc4 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -233,6 +233,40 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
>   	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>   	return pmd;
>   }
> +
> +pmd_t pmdp_collapse_flush_sync(struct vm_area_struct *vma, unsigned long address,
> +			       pmd_t *pmdp)
> +{
> +	struct mmu_gather tlb;
> +	pmd_t pmd;
> +
> +	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
> +	VM_BUG_ON(pmd_trans_huge(*pmdp));
> +
> +	tlb_gather_mmu(&tlb, vma->vm_mm);

Should we be using the new tlb_gather_mmu_vma(), and do we have to set 
the TLB pagesize to PMD?

-- 
Cheers

David

