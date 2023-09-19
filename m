Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0647A5A23
	for <lists+linux-arch@lfdr.de>; Tue, 19 Sep 2023 08:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjISGsh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Sep 2023 02:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjISGsh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Sep 2023 02:48:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C79100;
        Mon, 18 Sep 2023 23:48:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C45C433C8;
        Tue, 19 Sep 2023 06:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695106111;
        bh=v1PBG6Gu/3eqRITlKaenIy1Iaq3gKBzyqYlv0ai4zO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g81NpwhjgWC5UNpbUGov4u227vlRjEbZixKM1tjaZpaM/VY6T9DXSa/NEFVhg41PN
         vnrRJL/9n7SjreVQLTCw1zfG/HO8EMMJtOSa/z1D/CFbU114nEbsr06aQ520n/3u1j
         g1ERXarMOaeSRRWVrRVjkj3QcghAZT2RhMDgEx8AQqjIbY6048kFxlHKikjCWSyuLM
         iuv2rfpWoG3+m+AHxfjjzMFu11ynzIQlPTHtjh2xfDgQPFPLFv48dM8n6h4j5U4CaH
         Pokk/9WjdSFC6CHoDZa/xnP+QGd+sc3B23/ldGMkARS2g+aCBL6v5tzoijY2vKM65J
         rxr74ifBr+LMw==
Date:   Tue, 19 Sep 2023 09:47:44 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, will@kernel.org,
        aneesh.kumar@linux.ibm.com, npiggin@gmail.com,
        peterz@infradead.org, catalin.marinas@arm.com,
        chenhuacai@kernel.org, tsbogend@alpha.franken.de,
        dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arnd@arndb.de, willy@infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org
Subject: Re: [PATCH] mm: add statistics for PUD level pagetable
Message-ID: <20230919064744.GE3303@kernel.org>
References: <876c71c03a7e69c17722a690e3225a4f7b172fb2.1695017383.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876c71c03a7e69c17722a690e3225a4f7b172fb2.1695017383.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 18, 2023 at 02:31:42PM +0800, Baolin Wang wrote:
> Recently, we found that cross-die access to pagetable pages on ARM64
> machines can cause performance fluctuations in our business. Currently,
> there are no PMU events available to track this situation on our ARM64
> machines, so an accurate pagetable accounting can help to analyze this
> issue, but now the PUD level pagetable accounting is missed.
> 
> So introducing pagetable_pud_ctor/dtor() to help to get an accurate
> PUD pagetable accounting, as well as converting the architectures with
> using generic PUD pagatable allocation to add corresponding PUD pagetable
> accounting. Moreover this patch will also mark the PUD level pagetable
> with PG_table flag, which will help to do sanity validation in unpoison_memory().
> 
> On my testing machine, I can see more pagetables statistics after the patch
> with page-types tool:
> 
> Before patch:
>         flags           page-count      MB  symbolic-flags                     long-symbolic-flags
> 0x0000000004000000           27326      106  __________________________g_________________       pgtable
> After patch:
> 0x0000000004000000           27541      107  __________________________g_________________       pgtable
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/tlb.h         |  5 ++++-
>  arch/loongarch/include/asm/pgalloc.h |  1 +
>  arch/mips/include/asm/pgalloc.h      |  1 +
>  arch/x86/mm/pgtable.c                |  3 +++
>  include/asm-generic/pgalloc.h        |  7 ++++++-
>  include/linux/mm.h                   | 16 ++++++++++++++++
>  6 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 2c29239d05c3..846c563689a8 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -96,7 +96,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>  static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>  				  unsigned long addr)
>  {
> -	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pudp));
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pudp);
> +
> +	pagetable_pud_dtor(ptdesc);
> +	tlb_remove_ptdesc(tlb, ptdesc);
>  }
>  #endif
>  
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index 79470f0b4f1d..4e2d6b7ca2ee 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -84,6 +84,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  
>  	if (!ptdesc)
>  		return NULL;
> +	pagetable_pud_ctor(ptdesc);
>  	pud = ptdesc_address(ptdesc);
>  
>  	pud_init(pud);
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 40e40a7eb94a..f4440edcd8fe 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -95,6 +95,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  
>  	if (!ptdesc)
>  		return NULL;
> +	pagetable_pud_ctor(ptdesc);
>  	pud = ptdesc_address(ptdesc);
>  
>  	pud_init(pud);
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 9deadf517f14..0cbc1b8e8e3d 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -76,6 +76,9 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>  #if CONFIG_PGTABLE_LEVELS > 3
>  void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>  {
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
> +
> +	pagetable_pud_dtor(ptdesc);
>  	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
>  	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
>  }
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index c75d4a753849..879e5f8aa5e9 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -169,6 +169,8 @@ static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  	ptdesc = pagetable_alloc(gfp, 0);
>  	if (!ptdesc)
>  		return NULL;
> +
> +	pagetable_pud_ctor(ptdesc);
>  	return ptdesc_address(ptdesc);
>  }
>  
> @@ -190,8 +192,11 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  
>  static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
> +
>  	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
> -	pagetable_free(virt_to_ptdesc(pud));
> +	pagetable_pud_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_FREE
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 12335de50140..2232bfebb88a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3049,6 +3049,22 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  	return ptl;
>  }
>  
> +static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	__folio_set_pgtable(folio);
> +	lruvec_stat_add_folio(folio, NR_PAGETABLE);
> +}
> +
> +static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	__folio_clear_pgtable(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +
>  extern void __init pagecache_init(void);
>  extern void free_initmem(void);
>  
> -- 
> 2.39.3
> 
> 

-- 
Sincerely yours,
Mike.
