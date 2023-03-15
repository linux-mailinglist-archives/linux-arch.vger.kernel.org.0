Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A209C6BAD14
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjCOKIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjCOKIa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:08:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E9373ADD;
        Wed, 15 Mar 2023 03:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77A3DB81BFC;
        Wed, 15 Mar 2023 10:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F81AC433A1;
        Wed, 15 Mar 2023 10:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874883;
        bh=GS3lMxONLmWS+eLW3cuLojN+5vMTrSIViV38pOJOeZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lK6TOlQdwl3qfq90VS2bo45z3Oza3rw8s+9w12v2Y1tncCgkpGT+mew6dpow6FuDi
         CoMc6/0WjcN9nGPkxx0WI9EuqbRduQyKnFpQN0YFLOXF0aLaQGXD3+iQjDG4FoJYKn
         HbbFwsIsiiO1naGk/e0ADLmUdTa3q124jqOTOq72K7e75yDwN6Q20/i2WGEOaWjd71
         EJd0W/6Jt2brDM1pl4jwE581Kktm/RhtjLjPDg5aP2v58KhK8WjJUYm8Y2FcNs+KSf
         WMkQbz6pB044FEfMSjSZNG9duTpJ3zw+z+1r6cwTYmueFiCBVuwmDn2FpOewNhZDUv
         eFxWqB5CUNrcw==
Date:   Wed, 15 Mar 2023 12:07:50 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v4 15/36] microblaze: Implement the new page table range
 API
Message-ID: <ZBGY9pn2jGiCUl8f@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-16-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-16-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:23AM +0000, Matthew Wilcox (Oracle) wrote:
> Rename PFN_SHIFT_OFFSET to PTE_PFN_SHIFT.  Change the calling
> convention for set_pte() to be the same as other architectures.  Add
> update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Simek <monstr@monstr.eu>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/microblaze/include/asm/cacheflush.h |  8 ++++++++
>  arch/microblaze/include/asm/pgtable.h    | 15 ++++-----------
>  arch/microblaze/include/asm/tlbflush.h   |  4 +++-
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
> index 39f8fb6768d8..e6641ff98cb3 100644
> --- a/arch/microblaze/include/asm/cacheflush.h
> +++ b/arch/microblaze/include/asm/cacheflush.h
> @@ -74,6 +74,14 @@ do { \
>  	flush_dcache_range((unsigned) (addr), (unsigned) (addr) + PAGE_SIZE); \
>  } while (0);
>  
> +static void flush_dcache_folio(struct folio *folio)
> +{
> +	unsigned long addr = folio_pfn(folio) << PAGE_SHIFT;
> +
> +	flush_dcache_range(addr, addr + folio_size(folio));
> +}
> +#define flush_dcache_folio flush_dcache_folio
> +
>  #define flush_cache_page(vma, vmaddr, pfn) \
>  	flush_dcache_range(pfn << PAGE_SHIFT, (pfn << PAGE_SHIFT) + PAGE_SIZE);
>  
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index d1b8272abcd9..19fcd7f8517e 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -230,12 +230,12 @@ extern unsigned long empty_zero_page[1024];
>  
>  #define pte_page(x)		(mem_map + (unsigned long) \
>  				((pte_val(x) - memory_start) >> PAGE_SHIFT))
> -#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
> +#define PTE_PFN_SHIFT		PAGE_SHIFT
>  
> -#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
> +#define pte_pfn(x)		(pte_val(x) >> PTE_PFN_SHIFT)
>  
>  #define pfn_pte(pfn, prot) \
> -	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) | pgprot_val(prot))
> +	__pte(((pte_basic_t)(pfn) << PTE_PFN_SHIFT) | pgprot_val(prot))
>  
>  #ifndef __ASSEMBLY__
>  /*
> @@ -330,14 +330,7 @@ static inline unsigned long pte_update(pte_t *p, unsigned long clr,
>  /*
>   * set_pte stores a linux PTE into the linux page table.
>   */
> -static inline void set_pte(struct mm_struct *mm, unsigned long addr,
> -		pte_t *ptep, pte_t pte)
> -{
> -	*ptep = pte;
> -}
> -
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -		pte_t *ptep, pte_t pte)
> +static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
>  	*ptep = pte;
>  }
> diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
> index 2038168ed128..1b179e5e9062 100644
> --- a/arch/microblaze/include/asm/tlbflush.h
> +++ b/arch/microblaze/include/asm/tlbflush.h
> @@ -33,7 +33,9 @@ static inline void local_flush_tlb_range(struct vm_area_struct *vma,
>  
>  #define flush_tlb_kernel_range(start, end)	do { } while (0)
>  
> -#define update_mmu_cache(vma, addr, ptep)	do { } while (0)
> +#define update_mmu_cache_range(vma, addr, ptep, nr)	do { } while (0)
> +#define update_mmu_cache(vma, addr, pte) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
>  
>  #define flush_tlb_all local_flush_tlb_all
>  #define flush_tlb_mm local_flush_tlb_mm
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
