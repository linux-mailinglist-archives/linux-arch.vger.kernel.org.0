Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E37102C3
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 04:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjEYCQd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 22:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjEYCQb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 22:16:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111F3E47;
        Wed, 24 May 2023 19:16:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3BD1042;
        Wed, 24 May 2023 19:16:49 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52CB33F762;
        Wed, 24 May 2023 19:16:03 -0700 (PDT)
Message-ID: <3a777e9c-8a84-7ecb-8b19-606e7692eabe@arm.com>
Date:   Thu, 25 May 2023 07:46:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v4 01/36] mm: Convert page_table_check_pte_set() to
 page_table_check_ptes_set()
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-2-willy@infradead.org>
Content-Language: en-US
In-Reply-To: <20230315051444.3229621-2-willy@infradead.org>
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
> Tell the page table check how many PTEs & PFNs we want it to check.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

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
