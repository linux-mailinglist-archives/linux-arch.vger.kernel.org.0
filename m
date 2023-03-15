Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433176BAD39
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCOKNO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjCOKMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:12:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9CD838B5;
        Wed, 15 Mar 2023 03:12:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF73B81DC0;
        Wed, 15 Mar 2023 10:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8865FC433EF;
        Wed, 15 Mar 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875142;
        bh=6RQXXi1/KCGGyz8ZwBmv1nxgyFJwq5EE1ye6AJVOLSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9WeGf+dNsLIDXsmj44sliJUdSlT29oimfqFmqZ1bscW0lX+nYLnPAz1ftMVMbbx5
         LmYHKJENlk6OCyJwDpaAQPN699B8ZjhFpIHCqzcPuFOgpfEf5TepXQvn8iWjugF0Kw
         Y7mRokzkzM1VWgwMfSp2O7qBpGyKjWvNM95R3cwORNFlYnzofCaWRxIaEi8iRykQ1k
         IWeJjNmNWebQh8m/h4tNG+Ruc3NEQ/LcypxZLLn/3YppWrsY2lUnbRVglx3dFCvYKs
         6Xk4+WY5j8jgW8EmK+wY5VGJ14seuCp+pgHEBG+w/bc39xKgNNCTSDdc3XoN+ZTzRO
         0sjzscthgxInw==
Date:   Wed, 15 Mar 2023 12:12:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 26/36] um: Implement the new page table range API
Message-ID: <ZBGZ+N2SpvZalEL8@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-27-willy@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:34AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT and update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/um/include/asm/pgtable.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index a70d1618eb35..ea5f8122f128 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -242,11 +242,7 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
>  	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *pteptr, pte_t pteval)
> -{
> -	set_pte(pteptr, pteval);
> -}
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
>  
>  #define __HAVE_ARCH_PTE_SAME
>  static inline int pte_same(pte_t pte_a, pte_t pte_b)
> @@ -290,6 +286,7 @@ struct mm_struct;
>  extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
>  
>  #define update_mmu_cache(vma,address,ptep) do {} while (0)
> +#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
>  
>  /*
>   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
