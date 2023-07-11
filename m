Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D209F74ED45
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjGKLvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jul 2023 07:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjGKLvb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jul 2023 07:51:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1439711D;
        Tue, 11 Jul 2023 04:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PH6oczCY2S48OMHioiU/D8QJo1+dj2ecfu0k752Tjj4=; b=wRboR8jjgvVd53fKMCoUzQJhAv
        UQg72sFHXt/ZytZ49FJZOtXcj8j0NFIrz/oEIzSAxkrZUYtTXxZ+ur3YI3Ykm9ajtTdyfCknWelDq
        FN2K77ByWsqtnsWWD8MK71e4Jezf11ZM2i47WZNCz7mfSpJUl75xQvzq8T8VTbbUIza6zlPCNNcN5
        txA1/+XtTFP+MazM7XYSBh04hR24n7PIJzoAlfjocivkjaqWKTAUKSZDrzS/C3y3yuPqIKq3GXlkW
        p6PB2D80HvcliTu/Vqw3t7VvDxVFdGC0MsemgAy8IqVjJFCAfI4zYdClvlnxVWX+vkuR2xvWbGfnw
        udGnAVeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qJBtm-00FgYd-Oo; Tue, 11 Jul 2023 11:51:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36BB0300222;
        Tue, 11 Jul 2023 13:51:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F640243429D0; Tue, 11 Jul 2023 13:51:17 +0200 (CEST)
Date:   Tue, 11 Jul 2023 13:51:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 28/38] x86: Implement the new page table range API
Message-ID: <20230711115117.GL3062772@hirez.programming.kicks-ass.net>
References: <20230710204339.3554919-1-willy@infradead.org>
 <20230710204339.3554919-29-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710204339.3554919-29-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 10, 2023 at 09:43:29PM +0100, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT and a noop update_mmu_cache_range().

And it silently removes set_pte_at() :/ What's happening here ?!?

-ENOCONTEXT

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/pgtable.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index c6242bc58a71..9818f13bfa09 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -185,6 +185,8 @@ static inline int pte_special(pte_t pte)
>  
>  static inline u64 protnone_mask(u64 val);
>  
> +#define PFN_PTE_SHIFT	PAGE_SHIFT
> +
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
>  	phys_addr_t pfn = pte_val(pte);
> @@ -1020,13 +1022,6 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
>  	return res;
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pte)
> -{
> -	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
> -	set_pte(ptep, pte);
> -}
> -
>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  			      pmd_t *pmdp, pmd_t pmd)
>  {
> @@ -1292,6 +1287,11 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t *ptep)
>  {
>  }
> +static inline void update_mmu_cache_range(struct vm_fault *vmf,
> +		struct vm_area_struct *vma, unsigned long addr,
> +		pte_t *ptep, unsigned int nr)
> +{
> +}
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmd)
>  {
> -- 
> 2.39.2
> 
