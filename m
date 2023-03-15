Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15586BAC1D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCOJ1Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCOJ1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:27:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177CC52F75;
        Wed, 15 Mar 2023 02:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A599861ABD;
        Wed, 15 Mar 2023 09:27:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B76AC433D2;
        Wed, 15 Mar 2023 09:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678872441;
        bh=w+J8gucSlfSu3xi4ruapy/hNtDvk5NYHt9AxAbkHP2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D18IvsKQQ9L5V4uTkOLzo7MrZqxnmEgzsXlep3LHdUJh+J07Tpiv8BkZUf/NZ99G2
         RppyUvZKVA773EwBQT1DchLMTboYO/75iEoxXenBf1n64UZBzxJXQ+iF+Yf5OnALwy
         n4Cz1QNywLpftpwOghTcDxmArWpaLoP44WvKPG+zmt8mFMNjXWW+jJROzwlr3yAmJr
         l4DDII8x2NlaDlIqL1TC2fijEJNksy9lrYYhtJcyWjFSuRObeKSyYW3gRKhtj41IDZ
         /gLtH0JaOqgHMx2CIlaNhtF9B925CBeWVFsha0VHVk6TlTsiv8xBftlNFsi8mKMtkB
         z67Z53tc/o6Hw==
Date:   Wed, 15 Mar 2023 11:27:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/34] mm: Add generic flush_icache_pages() and
 documentation
Message-ID: <ZBGPbCcUDFBQOx3W@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-3-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:05PM +0000, Matthew Wilcox (Oracle) wrote:
> flush_icache_page() is deprecated but not yet removed, so add
> a range version of it.  Change the documentation to refer to
> update_mmu_cache_range() instead of update_mmu_cache().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.39.1
> 
> 

-- 
Sincerely yours,
Mike.
