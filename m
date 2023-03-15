Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D966BADC0
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCOKfL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjCOKfK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:35:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D58FBDF5;
        Wed, 15 Mar 2023 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Mt1/z2UrE0VK1pxUQEs3KTv8uVCQ4X++r14v6jz/7wc=; b=pBoo235zkur4RaZuoc1rRM75yh
        BNyugLz0MUtINYbC44tP27PuUyx2T5vRGVIAbdXeKK6K9yKAryfXCyubm2aQUPKO93B7b1pIkG2QY
        yUot4jozF+Cmu55ygC0QU2jjOQCcGF+6k7KfDIKczkjFyk+SSRUX+GCIVexAPtiFWb99xmGpgdAcj
        L5OsRp0l2ORDgHORepDVgsjuZaR7mQhhNxV++s6mLaxMS4sm1MS+LIFmk0yF18ca4TGklBj+8hoax
        HjUJzOorN7MCW0bxnyKNtRyzob0uxEZfecmVq03HMa2R3I/P/uRhSzGwiMhRm1bEMO6+H9eMxLhrk
        a6Rzjodw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pcOSs-0024yN-1N;
        Wed, 15 Mar 2023 10:34:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5AAFB30013F;
        Wed, 15 Mar 2023 11:34:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 369A6212CB3D8; Wed, 15 Mar 2023 11:34:36 +0100 (CET)
Date:   Wed, 15 Mar 2023 11:34:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 27/36] x86: Implement the new page table range API
Message-ID: <20230315103436.GA2006103@hirez.programming.kicks-ass.net>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-28-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:35AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT and a noop update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/include/asm/pgtable.h | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 1031025730d0..b237878061c4 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -184,6 +184,8 @@ static inline int pte_special(pte_t pte)
>  
>  static inline u64 protnone_mask(u64 val);
>  
> +#define PFN_PTE_SHIFT	PAGE_SHIFT
> +
>  static inline unsigned long pte_pfn(pte_t pte)
>  {
>  	phys_addr_t pfn = pte_val(pte);
> @@ -1019,13 +1021,6 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
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

And remove set_pte_at() apparently.. whut?!?

>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>  			      pmd_t *pmdp, pmd_t pmd)
>  {
> @@ -1291,6 +1286,10 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>  		unsigned long addr, pte_t *ptep)
>  {
>  }
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long addr, pte_t *ptep, unsigned int nr)
> +{
> +}
>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>  		unsigned long addr, pmd_t *pmd)
>  {
> -- 
> 2.39.2
> 
