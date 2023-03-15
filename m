Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309B96BACC0
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCOJ4p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjCOJ40 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61F591D8;
        Wed, 15 Mar 2023 02:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A194361CAC;
        Wed, 15 Mar 2023 09:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5708BC433EF;
        Wed, 15 Mar 2023 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874079;
        bh=UPGSk+5zktSkQHlM1EsT/d9MKHUsVB44bqN+4h6y90g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC5w9ktwzv0KtrbuxuLbJTDg2kuUjk3TNktAQOjE/AOHk4SByNzVyYhHK6/cfJRkq
         wocrXxvM3dGU7M2+gQPpRiznCPhfP/hkwkH6NmxcG7Qcs7Dvg8r289VPUC21vEx1sQ
         x+3l6j3qSWvuvGcWOToYQbU8NCyFpLCnYyAvtfcREzye+03z9HGbuowCepc3S0KXA6
         d5NxGSVYNzenULUslt+gwAgAcrn7NLdM45212/qpiCoTQTJLU8wB75OYGhDd3KjnN6
         C6L6k7d6sjL4TTUnyOJuUY2GyNk+HTI11GVz/v3Vw1ORCOHMTkjwapV2l3HKJ2hHlc
         KiCO9ySnXBG2w==
Date:   Wed, 15 Mar 2023 11:54:26 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Subject: Re: [PATCH v4 11/36] hexagon: Implement the new page table range API
Message-ID: <ZBGV0lFu+1c5E5jE@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-12-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-12-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:19AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT and update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Brian Cain <bcain@quicinc.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/hexagon/include/asm/cacheflush.h | 7 +++++--
>  arch/hexagon/include/asm/pgtable.h    | 9 +--------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
> index 6eff0730e6ef..63ca314ede89 100644
> --- a/arch/hexagon/include/asm/cacheflush.h
> +++ b/arch/hexagon/include/asm/cacheflush.h
> @@ -58,12 +58,15 @@ extern void flush_cache_all_hexagon(void);
>   * clean the cache when the PTE is set.
>   *
>   */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -					unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>  {
>  	/*  generic_ptrace_pokedata doesn't wind up here, does it?  */
>  }
>  
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
> +
>  void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
>  		       unsigned long vaddr, void *dst, void *src, int len);
>  #define copy_to_user_page copy_to_user_page
> diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
> index 59393613d086..dd05dd71b8ec 100644
> --- a/arch/hexagon/include/asm/pgtable.h
> +++ b/arch/hexagon/include/asm/pgtable.h
> @@ -338,6 +338,7 @@ static inline int pte_exec(pte_t pte)
>  /* __swp_entry_to_pte - extract PTE from swap entry */
>  #define __swp_entry_to_pte(x) ((pte_t) { (x).val })
>  
> +#define PFN_PTE_SHIFT	PAGE_SHIFT
>  /* pfn_pte - convert page number and protection value to page table entry */
>  #define pfn_pte(pfn, pgprot) __pte((pfn << PAGE_SHIFT) | pgprot_val(pgprot))
>  
> @@ -345,14 +346,6 @@ static inline int pte_exec(pte_t pte)
>  #define pte_pfn(pte) (pte_val(pte) >> PAGE_SHIFT)
>  #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
>  
> -/*
> - * set_pte_at - update page table and do whatever magic may be
> - * necessary to make the underlying hardware/firmware take note.
> - *
> - * VM may require a virtual instruction to alert the MMU.
> - */
> -#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
> -
>  static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  {
>  	return (unsigned long)__va(pmd_val(pmd) & PAGE_MASK);
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
