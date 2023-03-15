Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05D96BAC3B
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjCOJeW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjCOJeV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:34:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556DB24118;
        Wed, 15 Mar 2023 02:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98428CE17AD;
        Wed, 15 Mar 2023 09:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465A2C43442;
        Wed, 15 Mar 2023 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678872855;
        bh=ftvE27r2/itndnDYpSpSUlELYAs7KQyhYOcfR2cSXm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4ngLAyp46uvRxKkXnrXn2FaR3WldO5fW0F/L8VxsgD1shNgw3jYXgmAVe3BWPv1O
         PmYW4sx83vwcX4Oj5XSF89eJ+ynndqSnSd4IWkBHpnhrCCm5edJDs7x4hJ2rAp4Oxc
         5/Qa/JrXRbuMzCGebjqUBVqcAtObJwy0aKVN6RMRIkahcJkSD+IK6vcgNE+Q2XkosG
         VrnK0bOvRtLXqt0XX8KCffezYqtO0zVDcOlp7TdrC3fNVRzqnmZwJmIZQC+qdl/zIK
         1Akt4WLf7pGxYDMWfB6MnEXJMSgQXwbWbNae4eCggFkszKVwH58hZeZTMN4re+lWZ/
         f9bTYstrDbLRQ==
Date:   Wed, 15 Mar 2023 11:34:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/36] mm: Add default definition of set_ptes()
Message-ID: <ZBGRC6FtlFf0hEm0@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-6-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-6-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:13AM +0000, Matthew Wilcox (Oracle) wrote:
> Most architectures can just define set_pte() and PFN_PTE_SHIFT to
> use this definition.  It's also a handy spot to document the guarantees
> provided by the MM.
> 
> Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..a755fe94b4b4 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -172,6 +172,43 @@ static inline int pmd_young(pmd_t pmd)
>  }
>  #endif
>  
> +#ifndef set_ptes
> +#ifdef PFN_PTE_SHIFT
> +/**
> + * set_ptes - Map consecutive pages to a contiguous range of addresses.
> + * @mm: Address space to map the pages into.
> + * @addr: Address to map the first page at.
> + * @ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @nr: Number of pages to map.
> + *
> + * May be overridden by the architecture, or the architecture can define
> + * set_pte() and PFN_PTE_SHIFT.
> + *
> + * Context: The caller holds the page table lock.  The pages all belong
> + * to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
> +
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
> +	}
> +}
> +#ifndef set_pte_at
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +#endif
> +#endif
> +#else
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  extern int ptep_set_access_flags(struct vm_area_struct *vma,
>  				 unsigned long address, pte_t *ptep,
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
