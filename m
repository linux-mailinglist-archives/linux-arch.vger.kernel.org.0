Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60A7302B9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245712AbjFNPEI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 11:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245705AbjFNPEH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 11:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC219B;
        Wed, 14 Jun 2023 08:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E246434E;
        Wed, 14 Jun 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B074C433C9;
        Wed, 14 Jun 2023 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755045;
        bh=9A+PDe1vPCUMDrQYdu5z8EQPSeOjm0q+6tl+clXFAfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j5Ugc1koC28gH2KkEPLkPoTIPNK11ApEJ+qx3mv6eyx57zInMns1iK9e2ZeYWZtaS
         d6VTROxAYi4QnXIkn3k8NB95BIGVtq/48gNq3/0I/WMA49BRIKydm5cPzbMITNJFuZ
         ukIwVNbIGFF0ylO7WubZ38JabSGFDmsGB/tgUH9+2GD4DtHbeAr300i11RRFVklrjO
         zXwlgRZnQv07KKoC7y7mb9Y81PZOH2N9ueNVcmIy2/IhSmwSzwFpOrdGsiFw0fBA3k
         Xwkm0A1j+e4mOhYVoVB8lslu0VNwTEUQ6zk7ZxZcwqL0ZAjNIDJH5uFFjVn0dxTv++
         vvViLh1xvoRTQ==
Date:   Wed, 14 Jun 2023 18:03:27 +0300
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
        Hugh Dickins <hughd@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 20/34] arm: Convert various functions to use ptdescs
Message-ID: <20230614150327.GS52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-21-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-21-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:09PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> late_alloc() also uses the __get_free_pages() helper function. Convert
> this to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

One comment below.

> ---
>  arch/arm/include/asm/tlb.h | 12 +++++++-----
>  arch/arm/mm/mmu.c          |  6 +++---
>  2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
> index b8cbe03ad260..f40d06ad5d2a 100644
> --- a/arch/arm/include/asm/tlb.h
> +++ b/arch/arm/include/asm/tlb.h
> @@ -39,7 +39,9 @@ static inline void __tlb_remove_table(void *_table)
>  static inline void
>  __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>  {
> -	pgtable_pte_page_dtor(pte);
> +	struct ptdesc *ptdesc = page_ptdesc(pte);
> +
> +	pagetable_pte_dtor(ptdesc);
>  
>  #ifndef CONFIG_ARM_LPAE
>  	/*
> @@ -50,17 +52,17 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
>  	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
>  #endif
>  
> -	tlb_remove_table(tlb, pte);
> +	tlb_remove_ptdesc(tlb, ptdesc);
>  }
>  
>  static inline void
>  __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
>  {
>  #ifdef CONFIG_ARM_LPAE
> -	struct page *page = virt_to_page(pmdp);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
>  
> -	pgtable_pmd_page_dtor(page);
> -	tlb_remove_table(tlb, page);
> +	pagetable_pmd_dtor(ptdesc);
> +	tlb_remove_ptdesc(tlb, ptdesc);
>  #endif
>  }
>  
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 22292cf3381c..294518fd0240 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -737,11 +737,11 @@ static void __init *early_alloc(unsigned long sz)
>  
>  static void *__init late_alloc(unsigned long sz)
>  {
> -	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
> +	void *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, get_order(sz));
>  
> -	if (!ptr || !pgtable_pte_page_ctor(virt_to_page(ptr)))
> +	if (!ptdesc || !pagetable_pte_ctor(ptdesc))
>  		BUG();
> -	return ptr;
> +	return ptdesc;

should be

	return  ptdesc_to_virt(ptdesc);

>  }
>  
>  static pte_t * __init arm_pte_alloc(pmd_t *pmd, unsigned long addr,
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
