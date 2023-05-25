Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7763C7102D5
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 04:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjEYCXN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 22:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjEYCXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 22:23:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EE87D3;
        Wed, 24 May 2023 19:23:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E95831042;
        Wed, 24 May 2023 19:23:54 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314993F762;
        Wed, 24 May 2023 19:23:07 -0700 (PDT)
Message-ID: <44b2b627-7da1-19e8-2f58-0ad9003d5ded@arm.com>
Date:   Thu, 25 May 2023 07:53:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/36] mm: Add generic flush_icache_pages() and
 documentation
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-3-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> flush_icache_page() is deprecated but not yet removed, so add
> a range version of it.  Change the documentation to refer to
> update_mmu_cache_range() instead of update_mmu_cache().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  Documentation/core-api/cachetlb.rst | 35 +++++++++++++++--------------
>  include/asm-generic/cacheflush.h    |  5 +++++
>  2 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
> index 5c0552e78c58..d4c9e2a28d36 100644
> --- a/Documentation/core-api/cachetlb.rst
> +++ b/Documentation/core-api/cachetlb.rst
> @@ -88,13 +88,13 @@ changes occur:
>  
>  	This is used primarily during fault processing.
>  
> -5) ``void update_mmu_cache(struct vm_area_struct *vma,
> -   unsigned long address, pte_t *ptep)``
> +5) ``void update_mmu_cache_range(struct vm_area_struct *vma,
> +   unsigned long address, pte_t *ptep, unsigned int nr)``
>  
> -	At the end of every page fault, this routine is invoked to
> -	tell the architecture specific code that a translation
> -	now exists at virtual address "address" for address space
> -	"vma->vm_mm", in the software page tables.
> +	At the end of every page fault, this routine is invoked to tell
> +	the architecture specific code that translations now exists
> +	in the software page tables for address space "vma->vm_mm"
> +	at virtual address "address" for "nr" consecutive pages.
>  
>  	A port may use this information in any way it so chooses.
>  	For example, it could use this event to pre-load TLB
> @@ -306,17 +306,18 @@ maps this page at its virtual address.
>  	private".  The kernel guarantees that, for pagecache pages, it will
>  	clear this bit when such a page first enters the pagecache.
>  
> -	This allows these interfaces to be implemented much more efficiently.
> -	It allows one to "defer" (perhaps indefinitely) the actual flush if
> -	there are currently no user processes mapping this page.  See sparc64's
> -	flush_dcache_page and update_mmu_cache implementations for an example
> -	of how to go about doing this.
> +	This allows these interfaces to be implemented much more
> +	efficiently.  It allows one to "defer" (perhaps indefinitely) the
> +	actual flush if there are currently no user processes mapping this
> +	page.  See sparc64's flush_dcache_page and update_mmu_cache_range
> +	implementations for an example of how to go about doing this.
>  
> -	The idea is, first at flush_dcache_page() time, if page_file_mapping()
> -	returns a mapping, and mapping_mapped on that mapping returns %false,
> -	just mark the architecture private page flag bit.  Later, in
> -	update_mmu_cache(), a check is made of this flag bit, and if set the
> -	flush is done and the flag bit is cleared.
> +	The idea is, first at flush_dcache_page() time, if
> +	page_file_mapping() returns a mapping, and mapping_mapped on that
> +	mapping returns %false, just mark the architecture private page
> +	flag bit.  Later, in update_mmu_cache_range(), a check is made
> +	of this flag bit, and if set the flush is done and the flag bit
> +	is cleared.
>  
>  	.. important::
>  
> @@ -369,7 +370,7 @@ maps this page at its virtual address.
>    ``void flush_icache_page(struct vm_area_struct *vma, struct page *page)``
>  
>  	All the functionality of flush_icache_page can be implemented in
> -	flush_dcache_page and update_mmu_cache. In the future, the hope
> +	flush_dcache_page and update_mmu_cache_range. In the future, the hope
>  	is to remove this interface completely.
>  
>  The final category of APIs is for I/O to deliberately aliased address
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cacheflush.h
> index f46258d1a080..09d51a680765 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -78,6 +78,11 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>  #endif
>  
>  #ifndef flush_icache_page
> +static inline void flush_icache_pages(struct vm_area_struct *vma,
> +				     struct page *page, unsigned int nr)
> +{
> +}
> +
>  static inline void flush_icache_page(struct vm_area_struct *vma,
>  				     struct page *page)
>  {
