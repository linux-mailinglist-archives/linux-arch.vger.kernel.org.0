Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8D66A959C
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 11:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCCKxw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 05:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCCKxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 05:53:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271872056E;
        Fri,  3 Mar 2023 02:53:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DC1617BF;
        Fri,  3 Mar 2023 10:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F53C433D2;
        Fri,  3 Mar 2023 10:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677840829;
        bh=w8bVEjNmmpcCdUSpTF4pm+yv3cQRnWlsr/TO0HBqoKs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHZGHuUr/EyNad2GdIvN+jIYv694EHBC8SK7iWSGuc6TD2VA8BSa7JvRg3fZRA04J
         in7CQhOFImFiUpBDVoa2GNuSt8Uno6p5cP/602wGfuWnuM+mB6F2TNXsujIGHxkZ7R
         CrB+GG5INVjguKxZB5iI7Sr+ddCsjbso6ZI8q39p0g6rl8duItq+VinjCeQ+HA7ZQi
         T4W6J3jt3o4SCpw5hC0TbJ2Js/dpQUwOyYWh8fbPTUwnCLvXvpobmxdXAFFylIhUCW
         IQN5GAODUWFi/oiBnNmWOzgFSbEZsfQmlzk1wq9bDLMzT7MNKcaQJHt5XEP/V8Va5c
         iojwTAkcY250Q==
Date:   Fri, 3 Mar 2023 12:53:36 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCH v3 14/34] microblaze: Implement the new page table range
 API
Message-ID: <ZAHRsPm89stqHDE5@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-15-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-15-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:17PM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().  Also change the calling convention for set_pte()
> to be the same as other architectures.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Simek <monstr@monstr.eu>
> ---
>  arch/microblaze/include/asm/cacheflush.h |  8 ++++++++
>  arch/microblaze/include/asm/pgtable.h    | 17 ++++++++++++-----
>  arch/microblaze/include/asm/tlbflush.h   |  4 +++-
>  3 files changed, 23 insertions(+), 6 deletions(-)
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
> index d1b8272abcd9..a01e1369b486 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -330,18 +330,25 @@ static inline unsigned long pte_update(pte_t *p, unsigned long clr,
>  /*
>   * set_pte stores a linux PTE into the linux page table.
>   */
> -static inline void set_pte(struct mm_struct *mm, unsigned long addr,
> -		pte_t *ptep, pte_t pte)
> +static inline void set_pte(pte_t *ptep, pte_t pte)
>  {
>  	*ptep = pte;
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -		pte_t *ptep, pte_t pte)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> -	*ptep = pte;
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += 1 << PFN_SHIFT_OFFSET;

This is the same as

		pte_val(pte) += PAGE_SIZE;

isn't it?

> +	}
>  }
>  
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  		unsigned long address, pte_t *ptep)
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
> 2.39.1
> 
> 

-- 
Sincerely yours,
Mike.
