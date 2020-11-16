Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4B22B447D
	for <lists+linux-arch@lfdr.de>; Mon, 16 Nov 2020 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKPNLt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Nov 2020 08:11:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:19119 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgKPNLt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Nov 2020 08:11:49 -0500
IronPort-SDR: S5TU5M0eDnnuF9tx/CNzr8AiIoO0ieTSuR9a94zS7PiWQSIOgQj4VJLhIdatoXHGrQB2gYVQLO
 ziX7/kqiLJPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="157767082"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="157767082"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 05:11:47 -0800
IronPort-SDR: 5UI9Ir+Dyx9rYrJ8dKNHBCmRUFLwE8VIMrHyPvbcJ//m1jxTsCO4B7QjSyk0XLv47ys+X9pagN
 GVhiAQiCkeyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="329673836"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 16 Nov 2020 05:11:47 -0800
Received: from [10.252.132.192] (kliang2-MOBL.ccr.corp.intel.com [10.252.132.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1C8C2580814;
        Mon, 16 Nov 2020 05:11:45 -0800 (PST)
Subject: Re: [PATCH 3/5] perf/core: Fix arch_perf_get_page_size()
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
References: <20201113111901.743573013@infradead.org>
 <20201113113426.526012343@infradead.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bbef8555-53d0-d4ce-c20d-ee64dfb9d90b@linux.intel.com>
Date:   Mon, 16 Nov 2020 08:11:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201113113426.526012343@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 11/13/2020 6:19 AM, Peter Zijlstra wrote:
> The (new) page-table walker in arch_perf_get_page_size() is broken in
> various ways. Specifically while it is used in a locless manner, it
> doesn't depend on CONFIG_HAVE_FAST_GUP nor uses the proper _lockless
> offset methods, nor is careful to only read each entry only once.
> 
> Also the hugetlb support is broken due to calling pte_page() without
> first checking pte_special().
> 
> Rewrite the whole thing to be a proper lockless page-table walker and
> employ the new pXX_leaf_size() pgtable functions to determine the TLB
> size without looking at the page-frames.
> 
> Fixes: 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
> Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")

The issue 
(https://lkml.kernel.org/r/8e88ba79-7c40-ea32-a7ed-bdc4fc04b2af@linux.intel.com) 
has been fixed by this patch set.

Tested-by: Kan Liang <kan.liang@linux.intel.com>


> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/arm64/include/asm/pgtable.h    |    3 +
>   arch/sparc/include/asm/pgtable_64.h |   13 ++++
>   arch/sparc/mm/hugetlbpage.c         |   19 ++++--
>   include/linux/pgtable.h             |   16 +++++
>   kernel/events/core.c                |  102 +++++++++++++-----------------------
>   5 files changed, 82 insertions(+), 71 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7001,90 +7001,62 @@ static u64 perf_virt_to_phys(u64 virt)
>   	return phys_addr;
>   }
>   
> -#ifdef CONFIG_MMU
> -
>   /*
> - * Return the MMU page size of a given virtual address.
> - *
> - * This generic implementation handles page-table aligned huge pages, as well
> - * as non-page-table aligned hugetlbfs compound pages.
> - *
> - * If an architecture supports and uses non-page-table aligned pages in their
> - * kernel mapping it will need to provide it's own implementation of this
> - * function.
> + * Return the MMU/TLB page size of a given virtual address.
>    */
> -__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +static u64 perf_get_tlb_page_size(struct mm_struct *mm, unsigned long addr)
>   {
> -	struct page *page;
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> +	u64 size = 0;
>   
> -	pgd = pgd_offset(mm, addr);
> -	if (pgd_none(*pgd))
> -		return 0;
> +#ifdef CONFIG_HAVE_FAST_GUP
> +	pgd_t *pgdp, pgd;
> +	p4d_t *p4dp, p4d;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
>   
> -	p4d = p4d_offset(pgd, addr);
> -	if (!p4d_present(*p4d))
> +	pgdp = pgd_offset(mm, addr);
> +	pgd = READ_ONCE(*pgdp);
> +	if (pgd_none(pgd))
>   		return 0;
>   
> -	if (p4d_leaf(*p4d))
> -		return 1ULL << P4D_SHIFT;
> +	if (pgd_leaf(pgd))
> +		return pgd_leaf_size(pgd);
>   
> -	pud = pud_offset(p4d, addr);
> -	if (!pud_present(*pud))
> +	p4dp = p4d_offset_lockless(pgdp, pgd, addr);
> +	p4d = READ_ONCE(*p4dp);
> +	if (!p4d_present(p4d))
>   		return 0;
>   
> -	if (pud_leaf(*pud)) {
> -#ifdef pud_page
> -		page = pud_page(*pud);
> -		if (PageHuge(page))
> -			return page_size(compound_head(page));
> -#endif
> -		return 1ULL << PUD_SHIFT;
> -	}
> +	if (p4d_leaf(p4d))
> +		return p4d_leaf_size(p4d);
>   
> -	pmd = pmd_offset(pud, addr);
> -	if (!pmd_present(*pmd))
> +	pudp = pud_offset_lockless(p4dp, p4d, addr);
> +	pud = READ_ONCE(*pudp);
> +	if (!pud_present(pud))
>   		return 0;
>   
> -	if (pmd_leaf(*pmd)) {
> -#ifdef pmd_page
> -		page = pmd_page(*pmd);
> -		if (PageHuge(page))
> -			return page_size(compound_head(page));
> -#endif
> -		return 1ULL << PMD_SHIFT;
> -	}
> +	if (pud_leaf(pud))
> +		return pud_leaf_size(pud);
>   
> -	pte = pte_offset_map(pmd, addr);
> -	if (!pte_present(*pte)) {
> -		pte_unmap(pte);
> +	pmdp = pmd_offset_lockless(pudp, pud, addr);
> +	pmd = READ_ONCE(*pmdp);
> +	if (!pmd_present(pmd))
>   		return 0;
> -	}
>   
> -	page = pte_page(*pte);
> -	if (PageHuge(page)) {
> -		u64 size = page_size(compound_head(page));
> -		pte_unmap(pte);
> -		return size;
> -	}
> -
> -	pte_unmap(pte);
> -	return PAGE_SIZE;
> -}
> +	if (pmd_leaf(pmd))
> +		return pmd_leaf_size(pmd);
>   
> -#else
> +	ptep = pte_offset_map(&pmd, addr);
> +	pte = ptep_get_lockless(ptep);
> +	if (pte_present(pte))
> +		size = pte_leaf_size(pte);
> +	pte_unmap(ptep);
> +#endif /* CONFIG_HAVE_FAST_GUP */
>   
> -static u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> -{
> -	return 0;
> +	return size;
>   }
>   
> -#endif
> -
>   static u64 perf_get_page_size(unsigned long addr)
>   {
>   	struct mm_struct *mm;
> @@ -7109,7 +7081,7 @@ static u64 perf_get_page_size(unsigned l
>   		mm = &init_mm;
>   	}
>   
> -	size = arch_perf_get_page_size(mm, addr);
> +	size = perf_get_tlb_page_size(mm, addr);
>   
>   	local_irq_restore(flags);
>   
> 
> 
