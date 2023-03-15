Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50E6BAD2A
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 11:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCOKLq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 06:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCOKLU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 06:11:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284636189C;
        Wed, 15 Mar 2023 03:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87EF4CE1988;
        Wed, 15 Mar 2023 10:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBEAC433D2;
        Wed, 15 Mar 2023 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678875047;
        bh=efFtqZ85QX1KX7IpsyvuE1LJJUr1EdgVSqdLZFKpjgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETB3fwhzyOBxjmWjhd6GP0MOWk31jImdIVBTbC7Z04hYLFly3I1Jton6V0u8oF8ta
         f+w8D3yvxNWf3oScfsd71NxHO8IF6+tqxDyLfoJW00GuNBDeevod+iajjRKwWy6MzA
         G7o9c2SlS6A4Hb//fxXtYpdTOSTgV6cau/yTf45BEAAKFtuKMCz3zrJRHBYvl6kQZh
         m2wkIYSImRD+VCWBr7fthwCgTj8W9MZOQ7qB6uzzILdSi6wYbHYtotmpYXbPvdjRpX
         8ldIQ3JJ1GH8ky/Ffphfuztmapb4uYh4BECD94Iw2blkIcfjOntHDAQ5uF7qU9k+Od
         yzyL3J0lp5uXA==
Date:   Wed, 15 Mar 2023 12:10:34 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 22/36] s390: Implement the new page table range API
Message-ID: <ZBGZmpf0n+KyyJNU@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-23-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-23-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:30AM +0000, Matthew Wilcox (Oracle) wrote:
> Add set_ptes() and update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/s390/include/asm/pgtable.h | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index c1f6b46ec555..fea678c67e51 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -50,6 +50,7 @@ void arch_report_meminfo(struct seq_file *m);
>   * tables contain all the necessary information.
>   */
>  #define update_mmu_cache(vma, address, ptep)     do { } while (0)
> +#define update_mmu_cache_range(vma, addr, ptep, nr)	do { } while (0)
>  #define update_mmu_cache_pmd(vma, address, ptep) do { } while (0)
>  
>  /*
> @@ -1319,20 +1320,34 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
>  pgprot_t pgprot_writethrough(pgprot_t prot);
>  
>  /*
> - * Certain architectures need to do special things when PTEs
> - * within a page table are directly modified.  Thus, the following
> - * hook is made available.
> + * Set multiple PTEs to consecutive pages with a single call.  All PTEs
> + * are within the same folio, PMD and VMA.
>   */
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t entry)
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t entry, unsigned int nr)
>  {
>  	if (pte_present(entry))
>  		entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
> -	if (mm_has_pgste(mm))
> -		ptep_set_pte_at(mm, addr, ptep, entry);
> -	else
> -		set_pte(ptep, entry);
> +	if (mm_has_pgste(mm)) {
> +		for (;;) {
> +			ptep_set_pte_at(mm, addr, ptep, entry);
> +			if (--nr == 0)
> +				break;
> +			ptep++;
> +			entry = __pte(pte_val(entry) + PAGE_SIZE);
> +			addr += PAGE_SIZE;
> +		}
> +	} else {
> +		for (;;) {
> +			set_pte(ptep, entry);
> +			if (--nr == 0)
> +				break;
> +			ptep++;
> +			entry = __pte(pte_val(entry) + PAGE_SIZE);
> +		}
> +	}
>  }
> +#define set_ptes set_ptes
>  
>  /*
>   * Conversion functions: convert a page and protection to a page entry,
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.
