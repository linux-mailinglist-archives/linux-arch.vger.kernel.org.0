Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10E745EB48
	for <lists+linux-arch@lfdr.de>; Fri, 26 Nov 2021 11:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376813AbhKZK0k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Nov 2021 05:26:40 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:59010 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhKZKYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Nov 2021 05:24:38 -0500
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mqYLv-0000d8-W8; Fri, 26 Nov 2021 10:21:15 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1mqYLq-005WHS-Pn; Fri, 26 Nov 2021 10:21:10 +0000
Subject: Re: [PATCH 4.9] hugetlbfs: flush TLBs correctly after
 huge_pmd_unshare
To:     Nadav Amit <nadav.amit@gmail.com>, Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <7a2feed4-7c73-c7ad-881e-c980235c8293@cambridgegreys.com>
Date:   Fri, 26 Nov 2021 10:21:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3BD89231-2CB9-4CE5-B0FA-5B58419D7CB8@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26/11/2021 06:08, Nadav Amit wrote:
> Below is a patch to address CVE-2021-4002 [1] that I created to backport
> to 4.9. The stable kernels of 4.14 and prior ones do not have unified
> TLB flushing code, and I managed to mess up the arch code a couple of
> times.
> 
> Now that the CVE is public, I would appreciate your review of this
> patch. I send 4.9 for review - the other ones (4.14 and prior) are
> pretty similar.
> 
> [1] https://www.openwall.com/lists/oss-security/2021/11/25/1
> 
> Thanks,
> Nadav

I do not quite see the rationale for patching um

It supports only standard size pages. You should not be able to map a huge page there (and hugetlbfs).

I have "non-standard page size" somewhere towards the end of my queue, but it keeps falling through - not enough spare time to work on it.

Brgds,

A.

> 
> -- >8 --
> 
> From: Nadav Amit <namit@vmware.com>
> Date: Sat, 20 Nov 2021 12:55:21 -0800
> Subject: [kernel v4.9 ] hugetlbfs: flush TLBs correctly after
>   huge_pmd_unshare
> 
> When __unmap_hugepage_range() calls to huge_pmd_unshare() succeed, a TLB
> flush is missing. This TLB flush must be performed before releasing the
> i_mmap_rwsem, in order to prevent an unshared PMDs page from being
> released and reused before the TLB flush took place.
> 
> Arguably, a comprehensive solution would use mmu_gather interface to
> batch the TLB flushes and the PMDs page release, however it is not an
> easy solution: (1) try_to_unmap_one() and try_to_migrate_one() also call
> huge_pmd_unshare() and they cannot use the mmu_gather interface; and (2)
> deferring the release of the page reference for the PMDs page until
> after i_mmap_rwsem is dropeed can confuse huge_pmd_unshare() into
> thinking PMDs are shared when they are not.
> 
> Fix __unmap_hugepage_range() by adding the missing TLB flush, and
> forcing a flush when unshare is successful.
> 
> Fixes: 24669e58477e ("hugetlb: use mmu_gather instead of a temporary linked list for accumulating pages)" # 3.6
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>   arch/arm/include/asm/tlb.h  |  8 ++++++++
>   arch/ia64/include/asm/tlb.h | 10 ++++++++++
>   arch/s390/include/asm/tlb.h | 14 ++++++++++++++
>   arch/sh/include/asm/tlb.h   | 10 ++++++++++
>   arch/um/include/asm/tlb.h   | 12 ++++++++++++
>   include/asm-generic/tlb.h   |  2 ++
>   mm/hugetlb.c                | 19 +++++++++++++++++++
>   mm/memory.c                 | 16 ++++++++++++++++
>   8 files changed, 91 insertions(+)
> 
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index 1e25cd80589e..1cee2d540956 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -278,6 +278,14 @@ tlb_remove_pmd_tlb_entry(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr
>   	tlb_add_flush(tlb, addr);
>   }
>   
> +static inline void
> +tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +		    unsigned long size)
> +{
> +	tlb_add_flush(tlb, address);
> +	tlb_add_flush(tlb, address + size - PMD_SIZE);
> +}
> +
>   #define pte_free_tlb(tlb, ptep, addr)	__pte_free_tlb(tlb, ptep, addr)
>   #define pmd_free_tlb(tlb, pmdp, addr)	__pmd_free_tlb(tlb, pmdp, addr)
>   #define pud_free_tlb(tlb, pudp, addr)	pud_free((tlb)->mm, pudp)
> diff --git a/arch/ia64/include/asm/tlb.h b/arch/ia64/include/asm/tlb.h
> index 77e541cf0e5d..34f4a5359561 100644
> --- a/arch/ia64/include/asm/tlb.h
> +++ b/arch/ia64/include/asm/tlb.h
> @@ -272,6 +272,16 @@ __tlb_remove_tlb_entry (struct mmu_gather *tlb, pte_t *ptep, unsigned long addre
>   	tlb->end_addr = address + PAGE_SIZE;
>   }
>   
> +static inline void
> +tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +		    unsigned long size)
> +{
> +	if (tlb->start_addr > address)
> +		tlb->start_addr = address;
> +	if (tlb->end_addr < address + size)
> +		tlb->end_addr = address + size;
> +}
> +
>   #define tlb_migrate_finish(mm)	platform_tlb_migrate_finish(mm)
>   
>   #define tlb_start_vma(tlb, vma)			do { } while (0)
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index 15711de10403..d2681d5a3d5a 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -116,6 +116,20 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>   	return tlb_remove_page(tlb, page);
>   }
>   
> +static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
> +				unsigned long address, unsigned long size)
> +{
> +	/*
> +	 * the range might exceed the original range that was provided to
> +	 * tlb_gather_mmu(), so we need to update it despite the fact it is
> +	 * usually not updated.
> +	 */
> +	if (tlb->start > address)
> +		tlb->start = address;
> +	if (tlb->end < address + size)
> +		tlb->end = address + size;
> +}
> +
>   /*
>    * pte_free_tlb frees a pte table and clears the CRSTE for the
>    * page table from the tlb.
> diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
> index 025cdb1032f6..7aba716fd9a5 100644
> --- a/arch/sh/include/asm/tlb.h
> +++ b/arch/sh/include/asm/tlb.h
> @@ -115,6 +115,16 @@ static inline bool __tlb_remove_page_size(struct mmu_gather *tlb,
>   	return __tlb_remove_page(tlb, page);
>   }
>   
> +static inline voide
> +tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +		    unsigned long size)
> +{
> +	if (tlb->start > address)
> +		tlb->start = address;
> +	if (tlb->end < address + size)
> +		tlb->end = address + size;
> +}
> +
>   static inline bool __tlb_remove_pte_page(struct mmu_gather *tlb,
>   					 struct page *page)
>   {
> diff --git a/arch/um/include/asm/tlb.h b/arch/um/include/asm/tlb.h
> index 821ff0acfe17..6fb47b17179f 100644
> --- a/arch/um/include/asm/tlb.h
> +++ b/arch/um/include/asm/tlb.h
> @@ -128,6 +128,18 @@ static inline void tlb_remove_page_size(struct mmu_gather *tlb,
>   	return tlb_remove_page(tlb, page);
>   }
>   
> +static inline void
> +tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +		    unsigned long size)
> +{
> +	tlb->need_flush = 1;
> +
> +	if (tlb->start > address)
> +		tlb->start = address;
> +	if (tlb->end < address + size)
> +		tlb->end = address + size;
> +}
> +
>   /**
>    * tlb_remove_tlb_entry - remember a pte unmapping for later tlb invalidation.
>    *
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index c6d667187608..e9851100c0f7 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -123,6 +123,8 @@ void tlb_finish_mmu(struct mmu_gather *tlb, unsigned long start,
>   							unsigned long end);
>   extern bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page,
>   				   int page_size);
> +void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +			 unsigned long size);
>   
>   static inline void __tlb_adjust_range(struct mmu_gather *tlb,
>   				      unsigned long address)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index de89e9295f6c..7d51211995b9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3395,6 +3395,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	unsigned long sz = huge_page_size(h);
>   	const unsigned long mmun_start = start;	/* For mmu_notifiers */
>   	const unsigned long mmun_end   = end;	/* For mmu_notifiers */
> +	bool force_flush = false;
>   
>   	WARN_ON(!is_vm_hugetlb_page(vma));
>   	BUG_ON(start & ~huge_page_mask(h));
> @@ -3411,6 +3412,8 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   		ptl = huge_pte_lock(h, mm, ptep);
>   		if (huge_pmd_unshare(mm, &address, ptep)) {
>   			spin_unlock(ptl);
> +			tlb_flush_pmd_range(tlb, address & PUD_MASK, PUD_SIZE);
> +			force_flush = true;
>   			continue;
>   		}
>   
> @@ -3467,6 +3470,22 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   	}
>   	mmu_notifier_invalidate_range_end(mm, mmun_start, mmun_end);
>   	tlb_end_vma(tlb, vma);
> +
> +	/*
> +	 * If we unshared PMDs, the TLB flush was not recorded in mmu_gather. We
> +	 * could defer the flush until now, since by holding i_mmap_rwsem we
> +	 * guaranteed that the last refernece would not be dropped. But we must
> +	 * do the flushing before we return, as otherwise i_mmap_rwsem will be
> +	 * dropped and the last reference to the shared PMDs page might be
> +	 * dropped as well.
> +	 *
> +	 * In theory we could defer the freeing of the PMD pages as well, but
> +	 * huge_pmd_unshare() relies on the exact page_count for the PMD page to
> +	 * detect sharing, so we cannot defer the release of the page either.
> +	 * Instead, do flush now.
> +	 */
> +	if (force_flush)
> +		tlb_flush_mmu(tlb);
>   }
>   
>   void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> diff --git a/mm/memory.c b/mm/memory.c
> index be592d434ad8..c2890dc104d9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -320,6 +320,22 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
>   	return false;
>   }
>   
> +void tlb_flush_pmd_range(struct mmu_gather *tlb, unsigned long address,
> +			 unsigned long size)
> +{
> +	if (tlb->page_size != 0 && tlb->page_size != PMD_SIZE)
> +		tlb_flush_mmu(tlb);
> +
> +	tlb->page_size = PMD_SIZE;
> +	tlb->start = min(tlb->start, address);
> +	tlb->end = max(tlb->end, address + size);
> +	/*
> +	 * Track the last address with which we adjusted the range. This
> +	 * will be used later to adjust again after a mmu_flush due to
> +	 * failed __tlb_remove_page
> +	 */
> +	tlb->addr = address + size - PMD_SIZE;
> +}
>   #endif /* HAVE_GENERIC_MMU_GATHER */
>   
>   #ifdef CONFIG_HAVE_RCU_TABLE_FREE
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
