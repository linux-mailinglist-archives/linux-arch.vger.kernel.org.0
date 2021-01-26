Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B83036C3
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 07:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbhAZGnR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 01:43:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11190 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbhAZGly (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 01:41:54 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DPxst15TDzl9tD;
        Tue, 26 Jan 2021 14:39:30 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 14:40:50 +0800
Subject: Re: [PATCH v11 01/13] mm/vmalloc: fix HUGE_VMAP regression by
 enabling huge pages in vmalloc_to_page
To:     Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210126044510.2491820-1-npiggin@gmail.com>
 <20210126044510.2491820-2-npiggin@gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <76f6c211-c383-51d2-7c5a-575f0d51b82d@huawei.com>
Date:   Tue, 26 Jan 2021 14:40:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126044510.2491820-2-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi:
On 2021/1/26 12:44, Nicholas Piggin wrote:
> vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
> Whether or not a vmap is huge depends on the architecture details,
> alignments, boot options, etc., which the caller can not be expected
> to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.
> 
> This change teaches vmalloc_to_page about larger pages, and returns
> the struct page that corresponds to the offset within the large page.
> This makes the API agnostic to mapping implementation details.
> 
> [*] As explained by commit 029c54b095995 ("mm/vmalloc.c: huge-vmap:
>     fail gracefully on unexpected huge vmap mappings")
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  mm/vmalloc.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e6f352bf0498..62372f9e0167 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -34,7 +34,7 @@
>  #include <linux/bitops.h>
>  #include <linux/rbtree_augmented.h>
>  #include <linux/overflow.h>
> -
> +#include <linux/pgtable.h>
>  #include <linux/uaccess.h>
>  #include <asm/tlbflush.h>
>  #include <asm/shmparam.h>
> @@ -343,7 +343,9 @@ int is_vmalloc_or_module_addr(const void *x)
>  }
>  
>  /*
> - * Walk a vmap address to the struct page it maps.
> + * Walk a vmap address to the struct page it maps. Huge vmap mappings will
> + * return the tail page that corresponds to the base page address, which
> + * matches small vmap mappings.
>   */
>  struct page *vmalloc_to_page(const void *vmalloc_addr)
>  {
> @@ -363,25 +365,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>  
>  	if (pgd_none(*pgd))
>  		return NULL;
> +	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
> +		return NULL; /* XXX: no allowance for huge pgd */
> +	if (WARN_ON_ONCE(pgd_bad(*pgd)))
> +		return NULL;
> +
>  	p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d))
>  		return NULL;
> -	pud = pud_offset(p4d, addr);
> +	if (p4d_leaf(*p4d))
> +		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
> +	if (WARN_ON_ONCE(p4d_bad(*p4d)))
> +		return NULL;
>  
> -	/*
> -	 * Don't dereference bad PUD or PMD (below) entries. This will also
> -	 * identify huge mappings, which we may encounter on architectures
> -	 * that define CONFIG_HAVE_ARCH_HUGE_VMAP=y. Such regions will be
> -	 * identified as vmalloc addresses by is_vmalloc_addr(), but are
> -	 * not [unambiguously] associated with a struct page, so there is
> -	 * no correct value to return for them.
> -	 */
> -	WARN_ON_ONCE(pud_bad(*pud));
> -	if (pud_none(*pud) || pud_bad(*pud))
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return NULL;
> +	if (pud_leaf(*pud))
> +		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> +	if (WARN_ON_ONCE(pud_bad(*pud)))
>  		return NULL;
> +
>  	pmd = pmd_offset(pud, addr);
> -	WARN_ON_ONCE(pmd_bad(*pmd));
> -	if (pmd_none(*pmd) || pmd_bad(*pmd))
> +	if (pmd_none(*pmd))
> +		return NULL;
> +	if (pmd_leaf(*pmd))
> +		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> +	if (WARN_ON_ONCE(pmd_bad(*pmd)))
>  		return NULL;
>  
>  	ptep = pte_offset_map(pmd, addr);
> @@ -389,6 +399,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
>  	if (pte_present(pte))
>  		page = pte_page(pte);
>  	pte_unmap(ptep);
> +
>  	return page;
>  }
>  EXPORT_SYMBOL(vmalloc_to_page);
> 

LGTM. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
