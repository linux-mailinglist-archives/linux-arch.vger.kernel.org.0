Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1576720C693
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jun 2020 09:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgF1HAQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Jun 2020 03:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgF1HAM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Jun 2020 03:00:12 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D042720702;
        Sun, 28 Jun 2020 06:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593327604;
        bh=hu/tW2f/lIs0zzXJSvCrgwdLd0PRG2JIRHvUCcaAjqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qm3qqF3d78J/gFOwv6YVJb71itb3mymeRhGcaLrkXQY5dETAmGwNnfv+uXEMscIi2
         mPZsATFBdJNygr2fnTWo/ejLleXfIjFaiD5KXp/1ygh8w33HlLwG0oN/C/qRCb8sbq
         bU6JOX1KtJfeNxxfnsJIYZnBX1A1gh84k+HeVxCY=
Date:   Sun, 28 Jun 2020 09:59:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 9/8] mm: Account PMD tables like PTE tables
Message-ID: <20200628065951.GB576120@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
 <20200627184642.GF25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627184642.GF25039@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 07:46:42PM +0100, Matthew Wilcox wrote:
> We account the PTE level of the page tables to the process in order to
> make smarter OOM decisions and help diagnose why memory is fragmented.
> For these same reasons, we should account pages allocated for PMDs.
> With larger process address spaces and ASLR, the number of PMDs in use
> is higher than it used to be so the inaccuracy is starting to matter.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/mm.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dc7b87310c10..b283e25fcffa 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2271,7 +2271,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return ptlock_ptr(pmd_to_page(pmd));
>  }
>  
> -static inline bool pgtable_pmd_page_ctor(struct page *page)
> +static inline bool pmd_ptlock_init(struct page *page)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	page->pmd_huge_pte = NULL;
> @@ -2279,7 +2279,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>  	return ptlock_init(page);
>  }
>  
> -static inline void pgtable_pmd_page_dtor(struct page *page)
> +static inline void pmd_ptlock_free(struct page *page)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
> @@ -2296,8 +2296,8 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return &mm->page_table_lock;
>  }
>  
> -static inline bool pgtable_pmd_page_ctor(struct page *page) { return true; }
> -static inline void pgtable_pmd_page_dtor(struct page *page) {}
> +static inline bool pmd_ptlock_init(struct page *page) { return true; }
> +static inline void pmd_ptlock_free(struct page *page) {}
>  
>  #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
>  
> @@ -2310,6 +2310,22 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>  	return ptl;
>  }
>  
> +static inline bool pgtable_pmd_page_ctor(struct page *page)
> +{
> +	if (!pmd_ptlock_init(page))
> +		return false;
> +	__SetPageTable(page);
> +	inc_zone_page_state(page, NR_PAGETABLE);
> +	return true;
> +}
> +
> +static inline void pgtable_pmd_page_dtor(struct page *page)
> +{
> +	pmd_ptlock_free(page);
> +	__ClearPageTable(page);
> +	dec_zone_page_state(page, NR_PAGETABLE);
> +}
> +
>  /*
>   * No scalability reason to split PUD locks yet, but follow the same pattern
>   * as the PMD locks to make it easier if we decide to.  The VM should not be
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
