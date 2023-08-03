Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA51076F62D
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjHCXiU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Aug 2023 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjHCXiT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Aug 2023 19:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C2CE69;
        Thu,  3 Aug 2023 16:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22DB461EEC;
        Thu,  3 Aug 2023 23:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072AC433C7;
        Thu,  3 Aug 2023 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691105897;
        bh=aLQlhR8HSv2POSv3geI9bcoaAzfbwflFBUhnJPVztHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=la4NSnbiNxZ3stnWKrgOJrpkat+ogvN9qenUH8RVXH/e4czSZwcay/ddAhuE0rnue
         SrxJ8704bIwxzR6b0vvbEjlg1AzO09WwM5YIK1nmf3BC3Q9L5hLkCCnxYXn2Fro5je
         gAJiuHjyHDGtVoDZkyz9VAIEHwRL9YmUYQWfHOLKkXRrnqs/TohQZdlYrh04iDU7aa
         ejvJaBtTuKcyaeGWUPMkFIY5OYJNtHL8eglm2w+mOma2MSBmxvXHz9Ya+YZMs6bPC5
         PLr7Ns/Tc8gPKIZzSJ7S6pLtoFzM1xxGI9Nu/M1QApddPkz6G0Ut015b9OXJ7v7fGU
         fjmdWBbdiG5AQ==
Date:   Thu, 3 Aug 2023 16:38:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 21/38] powerpc: Implement the new page table range API
Message-ID: <20230803233814.GA2515372@dev-arch.thelio-3990X>
References: <20230802151406.3735276-1-willy@infradead.org>
 <20230802151406.3735276-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802151406.3735276-22-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Matthew,

On Wed, Aug 02, 2023 at 04:13:49PM +0100, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
> Change the PG_arch_1 (aka PG_dcache_dirty) flag from being per-page to
> per-folio.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: linuxppc-dev@lists.ozlabs.org
...
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index d16d80ad2ae4..b4da8514af43 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -894,7 +894,7 @@ void kvmppc_init_lpid(unsigned long nr_lpids);
>  
>  static inline void kvmppc_mmu_flush_icache(kvm_pfn_t pfn)
>  {
> -	struct page *page;
> +	struct folio *folio;
>  	/*
>  	 * We can only access pages that the kernel maps
>  	 * as memory. Bail out for unmapped ones.
> @@ -903,10 +903,10 @@ static inline void kvmppc_mmu_flush_icache(kvm_pfn_t pfn)
>  		return;
>  
>  	/* Clear i-cache for new pages */
> -	page = pfn_to_page(pfn);
> -	if (!test_bit(PG_dcache_clean, &page->flags)) {
> -		flush_dcache_icache_page(page);
> -		set_bit(PG_dcache_clean, &page->flags);
> +	folio = page_folio(pfn_to_page(pfn));
> +	if (!test_bit(PG_dcache_clean, &folio->flags)) {
> +		flush_dcache_icache_folio(folio);
> +		set_bit(PG_dcache_clean, &folio->flags);
>  	}
>  }
...
> diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
> index 0e9b4879c0f9..8760d2223abe 100644
> --- a/arch/powerpc/mm/cacheflush.c
> +++ b/arch/powerpc/mm/cacheflush.c
> @@ -148,44 +148,30 @@ static void __flush_dcache_icache(void *p)
>  	invalidate_icache_range(addr, addr + PAGE_SIZE);
>  }
>  
> -static void flush_dcache_icache_hugepage(struct page *page)
> +void flush_dcache_icache_folio(struct folio *folio)
>  {
> -	int i;
> -	int nr = compound_nr(page);
> +	unsigned int i, nr = folio_nr_pages(folio);
>  
> -	if (!PageHighMem(page)) {
> +	if (flush_coherent_icache())
> +		return;
> +
> +	if (!folio_test_highmem(folio)) {
> +		void *addr = folio_address(folio);
>  		for (i = 0; i < nr; i++)
> -			__flush_dcache_icache(lowmem_page_address(page + i));
> -	} else {
> +			__flush_dcache_icache(addr + i * PAGE_SIZE);
> +	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
>  		for (i = 0; i < nr; i++) {
> -			void *start = kmap_local_page(page + i);
> +			void *start = kmap_local_folio(folio, i * PAGE_SIZE);
>  
>  			__flush_dcache_icache(start);
>  			kunmap_local(start);
>  		}
> -	}
> -}
> -
> -void flush_dcache_icache_page(struct page *page)
> -{
> -	if (flush_coherent_icache())
> -		return;
> -
> -	if (PageCompound(page))
> -		return flush_dcache_icache_hugepage(page);
> -
> -	if (!PageHighMem(page)) {
> -		__flush_dcache_icache(lowmem_page_address(page));
> -	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
> -		void *start = kmap_local_page(page);
> -
> -		__flush_dcache_icache(start);
> -		kunmap_local(start);
>  	} else {
> -		flush_dcache_icache_phys(page_to_phys(page));
> +		unsigned long pfn = folio_pfn(folio);
> +		for (i = 0; i < nr; i++)
> +			flush_dcache_icache_phys((pfn + i) * PAGE_SIZE);
>  	}
>  }
> -EXPORT_SYMBOL(flush_dcache_icache_page);

Apologies if this has already been fixed or reported, I searched lore
and did not find anything. The dropping of this export in combination
with the conversion above appears to cause ARCH=powerpc allmodconfig to
fail with:

  ERROR: modpost: "flush_dcache_icache_folio" [arch/powerpc/kvm/kvm-pr.ko] undefined!

I don't know if this should be re-exported or not but that does
obviously resolve the issue.

Cheers,
Nathan
