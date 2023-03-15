Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A46BAD3E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCOKNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjCOKNV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:13:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F037615B;
        Wed, 15 Mar 2023 03:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3662ECE1944;
        Wed, 15 Mar 2023 10:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8CBC433EF;
        Wed, 15 Mar 2023 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875165;
        bh=nr8ZlE8Q8BBi/3Pkb3Gm3PWjDhbkIn3BPihu88b+2RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F4uRfBz32KviIr5zPtGHLmxn7cAqoRaoK5kWMipL4M4EIHRtpmHVF0ch0320vt5R3
         HyVJAydpjGF41tWiECoCCQqCTDcbHz3lOQXNMcOaCpNfRbx5DuC1i6PqkQyrPg/7TY
         y51lkvw8q3G1tWyCnxJoJ0mos6H2MST0Nxu7kZF79w1Qzuq+4iCClVWsp7GRaY1DIO
         ejQJKMkZcUd8HKF2ACi3a3pxsvWFbAcHmVYu3X5ad514xoGBzj0bnmFAh/2ngZfQz9
         PxrLVcjuQ172WOSYpPSrsWxRE2+ZG1VUW++WRe9/3HV+YtLDkaqGGxRzOG0dhP8Mns
         dFZDG186rLYxA==
Date:   Wed, 15 Mar 2023 12:12:31 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 27/36] x86: Implement the new page table range API
Message-ID: <ZBGaD8NzwBRSRs5B@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-28-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-28-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> 

-- 
Sincerely yours,
Mike.
