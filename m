Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061A67300E9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjFNN6c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjFNN6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4FDE6C;
        Wed, 14 Jun 2023 06:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6BED64290;
        Wed, 14 Jun 2023 13:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0141C433C8;
        Wed, 14 Jun 2023 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751109;
        bh=zODqmBJZryq+bXrqw2+dO7/Egr05l6EFGh7EoAR+f5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lSDu5H7KOZKMWJOQe/RZf66XvE8x+eCZ2Ytzhs66p+GHx+ddxnclpSnPyGBBVOC05
         kntWJ9TrG8h428EjebftgV+rAv2YXAhTb0cmqdcy2uTjvuT0Ga5hGuS9drSzCT7vEe
         lZBUTVYDwjRpPWR0zfBUHmtTwZ2dHpcIOTvlm3uWIc27APHLBBUO1V3IJqvs3/W4hf
         V4LiUm2GDpkcLNAf56LDxlLuEAL6oO/16Aw5vUDA8I/ZMKz2QG0XPQLr9Bk8rgf5Zl
         R9Y5FHwwoN9JyP4cz6UUoLxJJznNWVeOmwWxNxC0W9lJyus9Kc2Q39K0WgkNq1Cbbd
         +hjJK6ETZawtw==
Date:   Wed, 14 Jun 2023 16:57:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 10/34] mm: Convert ptlock_init() to use ptdescs
Message-ID: <20230614135751.GI52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-11-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-11-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:59PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index daecf1db6cf1..f48e626d9c98 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2857,7 +2857,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>  }
>  
> -static inline bool ptlock_init(struct page *page)
> +static inline bool ptlock_init(struct ptdesc *ptdesc)
>  {
>  	/*
>  	 * prep_new_page() initialize page->private (and therefore page->ptl)
> @@ -2866,10 +2866,10 @@ static inline bool ptlock_init(struct page *page)
>  	 * It can happen if arch try to use slab for page table allocation:
>  	 * slab code uses page->slab_cache, which share storage with page->ptl.
>  	 */
> -	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
> -	if (!ptlock_alloc(page_ptdesc(page)))
> +	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
> +	if (!ptlock_alloc(ptdesc))
>  		return false;
> -	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
> +	spin_lock_init(ptlock_ptr(ptdesc));
>  	return true;
>  }
>  
> @@ -2882,13 +2882,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return &mm->page_table_lock;
>  }
>  static inline void ptlock_cache_init(void) {}
> -static inline bool ptlock_init(struct page *page) { return true; }
> +static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct page *page) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
>  static inline bool pgtable_pte_page_ctor(struct page *page)
>  {
> -	if (!ptlock_init(page))
> +	if (!ptlock_init(page_ptdesc(page)))
>  		return false;
>  	__SetPageTable(page);
>  	inc_lruvec_page_state(page, NR_PAGETABLE);
> @@ -2947,7 +2947,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	ptdesc->pmd_huge_pte = NULL;
>  #endif
> -	return ptlock_init(ptdesc_page(ptdesc));
> +	return ptlock_init(ptdesc);
>  }
>  
>  static inline void pmd_ptlock_free(struct page *page)
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
