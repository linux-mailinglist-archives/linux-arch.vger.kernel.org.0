Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B726F6BAC00
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjCOJVh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjCOJV0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:21:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A21B557;
        Wed, 15 Mar 2023 02:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8441B81D76;
        Wed, 15 Mar 2023 09:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FA7C433EF;
        Wed, 15 Mar 2023 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678872081;
        bh=bma7awM6tHmIC3wO1SvO/FynqdjWMUbMRsUs73RSibM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CC1f8HDMk5mh+yXoQO1uNb2ErxcZr3nYdhbeGeShrB7B8SPUSY5lo6sgP/daZztup
         6y8laGWeuU9XvN3WtrzW4cLbE0a2HI7AxD7wt+AwU5G2+0HR+tGdoYQ0Juz8jYcJ6B
         KOVVw+v8fgCble4wjy6cZ7w6r8pQoomkWZeJxzEvtSXwKDVr8sv62+C4FSV7jWN9J+
         oSSA/DK9S61JTIG8STBS+nZfPaFyQgnpAOX+2rcS23+3+34kR5z49qkql/GBBBsY6s
         pw33RsU4qQjKGcgAyWEN/7lMBTu/ecLfn4OtAHATzidnNHxKgiP3VsxP4tKcUklT6O
         Bqo+5xyOsjaFg==
Date:   Wed, 15 Mar 2023 11:21:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/36] mm: Convert page_table_check_pte_set() to
 page_table_check_ptes_set()
Message-ID: <ZBGOBIOwFexlEfdx@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-2-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:09AM +0000, Matthew Wilcox (Oracle) wrote:
> Tell the page table check how many PTEs & PFNs we want it to check.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/arm64/include/asm/pgtable.h |  2 +-
>  arch/riscv/include/asm/pgtable.h |  2 +-
>  arch/x86/include/asm/pgtable.h   |  2 +-
>  include/linux/page_table_check.h | 14 +++++++-------
>  mm/page_table_check.c            | 14 ++++++++------
>  5 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 0bd18de9fd97..9428748f4691 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -358,7 +358,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
> -	page_table_check_pte_set(mm, addr, ptep, pte);
> +	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
>  	return __set_pte_at(mm, addr, ptep, pte);
>  }
>  
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index ab05f892d317..b516f3b59616 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -459,7 +459,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
>  static inline void set_pte_at(struct mm_struct *mm,
>  	unsigned long addr, pte_t *ptep, pte_t pteval)
>  {
> -	page_table_check_pte_set(mm, addr, ptep, pteval);
> +	page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
>  	__set_pte_at(mm, addr, ptep, pteval);
>  }
>  
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 15ae4d6ba476..1031025730d0 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1022,7 +1022,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
>  static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
> -	page_table_check_pte_set(mm, addr, ptep, pte);
> +	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
>  	set_pte(ptep, pte);
>  }
>  
> diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
> index 01e16c7696ec..ba269c7009e4 100644
> --- a/include/linux/page_table_check.h
> +++ b/include/linux/page_table_check.h
> @@ -20,8 +20,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
>  				  pmd_t pmd);
>  void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>  				  pud_t pud);
> -void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
> -				pte_t *ptep, pte_t pte);
> +void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte, unsigned int nr);
>  void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>  				pmd_t *pmdp, pmd_t pmd);
>  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
> @@ -73,14 +73,14 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm,
>  	__page_table_check_pud_clear(mm, addr, pud);
>  }
>  
> -static inline void page_table_check_pte_set(struct mm_struct *mm,
> +static inline void page_table_check_ptes_set(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep,
> -					    pte_t pte)
> +					    pte_t pte, unsigned int nr)
>  {
>  	if (static_branch_likely(&page_table_check_disabled))
>  		return;
>  
> -	__page_table_check_pte_set(mm, addr, ptep, pte);
> +	__page_table_check_ptes_set(mm, addr, ptep, pte, nr);
>  }
>  
>  static inline void page_table_check_pmd_set(struct mm_struct *mm,
> @@ -138,9 +138,9 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm,
>  {
>  }
>  
> -static inline void page_table_check_pte_set(struct mm_struct *mm,
> +static inline void page_table_check_ptes_set(struct mm_struct *mm,
>  					    unsigned long addr, pte_t *ptep,
> -					    pte_t pte)
> +					    pte_t pte, unsigned int nr)
>  {
>  }
>  
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 25d8610c0042..e6f4d40caaa2 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -184,20 +184,22 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(__page_table_check_pud_clear);
>  
> -void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
> -				pte_t *ptep, pte_t pte)
> +void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte, unsigned int nr)
>  {
> +	unsigned int i;
> +
>  	if (&init_mm == mm)
>  		return;
>  
> -	__page_table_check_pte_clear(mm, addr, *ptep);
> +	for (i = 0; i < nr; i++)
> +		__page_table_check_pte_clear(mm, addr, ptep[i]);
>  	if (pte_user_accessible_page(pte)) {
> -		page_table_check_set(mm, addr, pte_pfn(pte),
> -				     PAGE_SIZE >> PAGE_SHIFT,
> +		page_table_check_set(mm, addr, pte_pfn(pte), nr,
>  				     pte_write(pte));
>  	}
>  }
> -EXPORT_SYMBOL(__page_table_check_pte_set);
> +EXPORT_SYMBOL(__page_table_check_ptes_set);
>  
>  void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
>  				pmd_t *pmdp, pmd_t pmd)
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
