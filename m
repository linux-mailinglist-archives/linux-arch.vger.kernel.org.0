Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2D6BAC29
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjCOJ3W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjCOJ3O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:29:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5359F59813;
        Wed, 15 Mar 2023 02:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21BEBB81DB7;
        Wed, 15 Mar 2023 09:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15605C433D2;
        Wed, 15 Mar 2023 09:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678872544;
        bh=1rcL64IikruPhiQiv9l8tLQu7XWsbWE/G/kTn/74R9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bn6wqHGFdPwtEEdaeZhyNMT0K21HJnI3oyGP7O78EJ9MXo9z3TUR8AuzoL6yiipYM
         e11BAhhSIGcKDqmS4WF6x8hj3OqAgEwPpOED+LnT91tUOYL0/j/JnCF9IUEUkffTnA
         xQYfhoGPLKl/Ivq/Jl52QC3N2CelbZwL8wAnYr8pU8irskCDrVsx5Qb0Pd6RiPprUR
         QX1wyhR4SaX6NomwuCAnhzQJqcXbTkRIxTbt3f0WWbFaF7L1fojwodLiiV8LrRJfEJ
         L0TIaagufD+t6Uv2ZW7jS8RLHJZKOFvQM7YxG7wGrlKhPuOz86xbazQDoRSNmxuryM
         XG16dOqJ8s6kA==
Date:   Wed, 15 Mar 2023 11:28:52 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 04/36] mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
Message-ID: <ZBGP1NZ61cDPi/Mf@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-5-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:12AM +0000, Matthew Wilcox (Oracle) wrote:
> Current best practice is to reuse the name of the function as a define
> to indicate that the function is implemented by the architecture.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  Documentation/core-api/cachetlb.rst | 24 +++++++++---------------
>  include/linux/cacheflush.h          |  4 ++--
>  mm/util.c                           |  2 +-
>  3 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
> index d4c9e2a28d36..770008afd409 100644
> --- a/Documentation/core-api/cachetlb.rst
> +++ b/Documentation/core-api/cachetlb.rst
> @@ -269,7 +269,7 @@ maps this page at its virtual address.
>  	If D-cache aliasing is not an issue, these two routines may
>  	simply call memcpy/memset directly and do nothing more.
>  
> -  ``void flush_dcache_page(struct page *page)``
> +  ``void flush_dcache_folio(struct folio *folio)``
>  
>          This routines must be called when:
>  
> @@ -277,7 +277,7 @@ maps this page at its virtual address.
>  	     and / or in high memory
>  	  b) the kernel is about to read from a page cache page and user space
>  	     shared/writable mappings of this page potentially exist.  Note
> -	     that {get,pin}_user_pages{_fast} already call flush_dcache_page
> +	     that {get,pin}_user_pages{_fast} already call flush_dcache_folio
>  	     on any page found in the user address space and thus driver
>  	     code rarely needs to take this into account.
>  
> @@ -291,7 +291,7 @@ maps this page at its virtual address.
>  
>  	The phrase "kernel writes to a page cache page" means, specifically,
>  	that the kernel executes store instructions that dirty data in that
> -	page at the page->virtual mapping of that page.  It is important to
> +	page at the kernel virtual mapping of that page.  It is important to
>  	flush here to handle D-cache aliasing, to make sure these kernel stores
>  	are visible to user space mappings of that page.
>  
> @@ -302,18 +302,18 @@ maps this page at its virtual address.
>  	If D-cache aliasing is not an issue, this routine may simply be defined
>  	as a nop on that architecture.
>  
> -        There is a bit set aside in page->flags (PG_arch_1) as "architecture
> +        There is a bit set aside in folio->flags (PG_arch_1) as "architecture
>  	private".  The kernel guarantees that, for pagecache pages, it will
>  	clear this bit when such a page first enters the pagecache.
>  
>  	This allows these interfaces to be implemented much more
>  	efficiently.  It allows one to "defer" (perhaps indefinitely) the
>  	actual flush if there are currently no user processes mapping this
> -	page.  See sparc64's flush_dcache_page and update_mmu_cache_range
> +	page.  See sparc64's flush_dcache_folio and update_mmu_cache_range
>  	implementations for an example of how to go about doing this.
>  
> -	The idea is, first at flush_dcache_page() time, if
> -	page_file_mapping() returns a mapping, and mapping_mapped on that
> +	The idea is, first at flush_dcache_folio() time, if
> +	folio_flush_mapping() returns a mapping, and mapping_mapped() on that
>  	mapping returns %false, just mark the architecture private page
>  	flag bit.  Later, in update_mmu_cache_range(), a check is made
>  	of this flag bit, and if set the flush is done and the flag bit
> @@ -327,12 +327,6 @@ maps this page at its virtual address.
>  			dirty.  Again, see sparc64 for examples of how
>  			to deal with this.
>  
> -  ``void flush_dcache_folio(struct folio *folio)``
> -	This function is called under the same circumstances as
> -	flush_dcache_page().  It allows the architecture to
> -	optimise for flushing the entire folio of pages instead
> -	of flushing one page at a time.
> -
>    ``void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
>    unsigned long user_vaddr, void *dst, void *src, int len)``
>    ``void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
> @@ -353,7 +347,7 @@ maps this page at its virtual address.
>  
>    	When the kernel needs to access the contents of an anonymous
>  	page, it calls this function (currently only
> -	get_user_pages()).  Note: flush_dcache_page() deliberately
> +	get_user_pages()).  Note: flush_dcache_folio() deliberately
>  	doesn't work for an anonymous page.  The default
>  	implementation is a nop (and should remain so for all coherent
>  	architectures).  For incoherent architectures, it should flush
> @@ -370,7 +364,7 @@ maps this page at its virtual address.
>    ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``
>  
>  	All the functionality of flush_icache_page can be implemented in
> -	flush_dcache_page and update_mmu_cache_range. In the future, the hope
> +	flush_dcache_folio and update_mmu_cache_range. In the future, the hope
>  	is to remove this interface completely.
>  
>  The final category of APIs is for I/O to deliberately aliased address
> diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
> index a6189d21f2ba..82136f3fcf54 100644
> --- a/include/linux/cacheflush.h
> +++ b/include/linux/cacheflush.h
> @@ -7,14 +7,14 @@
>  struct folio;
>  
>  #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> -#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
> +#ifndef flush_dcache_folio
>  void flush_dcache_folio(struct folio *folio);
>  #endif
>  #else
>  static inline void flush_dcache_folio(struct folio *folio)
>  {
>  }
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
> +#define flush_dcache_folio flush_dcache_folio
>  #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
>  
>  #endif /* _LINUX_CACHEFLUSH_H */
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4..98ce51b01627 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1125,7 +1125,7 @@ void page_offline_end(void)
>  }
>  EXPORT_SYMBOL(page_offline_end);
>  
> -#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
> +#ifndef flush_dcache_folio
>  void flush_dcache_folio(struct folio *folio)
>  {
>  	long i, nr = folio_nr_pages(folio);
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
