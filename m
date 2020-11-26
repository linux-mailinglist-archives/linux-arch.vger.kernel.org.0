Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBD12C5404
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732982AbgKZMfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgKZMfT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:35:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4BC0613D4;
        Thu, 26 Nov 2020 04:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ejhLH5luSTjMivR8iBYSZAH/Td+wNgIzWpOtcETQ6g=; b=FXZZHVTpXmN6oW30ah+VdZoImZ
        r0gdA4IuETmU07lnHrKQyWFWueUkBOKhmc9k2unLHzbEK+BQLqnERF8pGBN9seyfPC64GVcPrbiJW
        K6hTKulAQXrVVZza5zeIwRjiiOcG1jEAgjqT2XLHdduiFxUxp3aKPSyH9wAohbr5niFIJZRi+0Vgb
        pf/Q/nFuDLIr4e4qeeWW7rE7oW8CnCBDvokxVk+dDS7909dW10l2XWVu3kI+IXyizvkYF2X+qYpZ6
        b6XUF2rL1joGwLOOBnfqdTTid6nkGyHh3XR7fxFTy5BlrNqlArurE9wejW7fxoGnqqyKLVK1YrRdP
        g1GM83Iw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiGUE-0001rB-D8; Thu, 26 Nov 2020 12:34:58 +0000
Date:   Thu, 26 Nov 2020 12:34:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, will@kernel.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 3/6] perf/core: Fix arch_perf_get_page_size()
Message-ID: <20201126123458.GO4327@casper.infradead.org>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.164675154@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126121121.164675154@infradead.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 01:01:17PM +0100, Peter Zijlstra wrote:
> The (new) page-table walker in arch_perf_get_page_size() is broken in
> various ways. Specifically while it is used in a lockless manner, it
> doesn't depend on CONFIG_HAVE_FAST_GUP nor uses the proper _lockless
> offset methods, nor is careful to only read each entry only once.
> 
> Also the hugetlb support is broken due to calling pte_page() without
> first checking pte_special().
> 
> Rewrite the whole thing to be a proper lockless page-table walker and
> employ the new pXX_leaf_size() pgtable functions to determine the
> pagetable size without looking at the page-frames.
> 
> Fixes: 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
> Fixes: 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/arm64/include/asm/pgtable.h    |    3 +
>  arch/sparc/include/asm/pgtable_64.h |   13 ++++
>  arch/sparc/mm/hugetlbpage.c         |   19 ++++--
>  include/linux/pgtable.h             |   16 +++++
>  kernel/events/core.c                |  102 +++++++++++++-----------------------
>  5 files changed, 82 insertions(+), 71 deletions(-)

This diffstat doesn't match the patch in this email ...

> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -52,6 +52,7 @@
>  #include <linux/mount.h>
>  #include <linux/min_heap.h>
>  #include <linux/highmem.h>
> +#include <linux/pgtable.h>
>  
>  #include "internal.h"
>  
> @@ -7001,90 +7001,62 @@ static u64 perf_virt_to_phys(u64 virt)
>  	return phys_addr;
>  }
>  
> -#ifdef CONFIG_MMU
> -
>  /*
> - * Return the MMU page size of a given virtual address.
> - *
> - * This generic implementation handles page-table aligned huge pages, as well
> - * as non-page-table aligned hugetlbfs compound pages.
> - *
> - * If an architecture supports and uses non-page-table aligned pages in their
> - * kernel mapping it will need to provide it's own implementation of this
> - * function.
> + * Return the pagetable size of a given virtual address.
>   */
> -__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
>  {
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
>  		return 0;
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
>  		return 0;
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
>  		return 0;
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
>  		return 0;
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
>  }
>  
> -#endif
> -
>  static u64 perf_get_page_size(unsigned long addr)
>  {
>  	struct mm_struct *mm;
> @@ -7109,7 +7081,7 @@ static u64 perf_get_page_size(unsigned l
>  		mm = &init_mm;
>  	}
>  
> -	size = arch_perf_get_page_size(mm, addr);
> +	size = perf_get_pgtable_size(mm, addr);
>  
>  	local_irq_restore(flags);
>  
> 
> 
