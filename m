Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3040B7300CA
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245239AbjFNNxQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245174AbjFNNxP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A027F106;
        Wed, 14 Jun 2023 06:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341E764259;
        Wed, 14 Jun 2023 13:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36061C433C9;
        Wed, 14 Jun 2023 13:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750793;
        bh=i+dWwopS2R2pjDCoeERaU9nBu0jCYzS/lwxwHCWXb4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGto5Dvi/HN8fU/LSHI/Xe9mWSqjuoMuAggxIeDsDpSdGjOz+OD5Q61dYnwlfUI2u
         12eC8JWZkY3dBTcv69CxtYmzohm/TspcjrDl3Zxm+eVFHQ1BuvWvblYU6lS5nHTdB4
         4jgzdRwk6I0iRkcg+lC5rT6e/+Zoj8O4Z4XMzKkrAI3Xrl//xHCT0oSrSqy8qzE0DR
         HFjNZU76vrLc90NskBD5ZmADqSbItjU5wL2oiacXptUySDzj5MWQp2048o6t9bgjHk
         3J9d7i2fEQepFckTIKlCANmHRPvvJQeN1+/+mCtl5JH8j+CkcnEmQVaXh28mzw5CiW
         A7drC/yoaT/Vw==
Date:   Wed, 14 Jun 2023 16:52:36 +0300
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
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 09/34] mm: Convert pmd_ptlock_init() to use ptdescs
Message-ID: <20230614135236.GH52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-10-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-10-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:58PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bb934d51390f..daecf1db6cf1 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2942,12 +2942,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return ptlock_ptr(pmd_ptdesc(pmd));
>  }
>  
> -static inline bool pmd_ptlock_init(struct page *page)
> +static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	page->pmd_huge_pte = NULL;
> +	ptdesc->pmd_huge_pte = NULL;
>  #endif
> -	return ptlock_init(page);
> +	return ptlock_init(ptdesc_page(ptdesc));
>  }
>  
>  static inline void pmd_ptlock_free(struct page *page)
> @@ -2967,7 +2967,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return &mm->page_table_lock;
>  }
>  
> -static inline bool pmd_ptlock_init(struct page *page) { return true; }
> +static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void pmd_ptlock_free(struct page *page) {}
>  
>  #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
> @@ -2983,7 +2983,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>  
>  static inline bool pgtable_pmd_page_ctor(struct page *page)
>  {
> -	if (!pmd_ptlock_init(page))
> +	if (!pmd_ptlock_init(page_ptdesc(page)))
>  		return false;
>  	__SetPageTable(page);
>  	inc_lruvec_page_state(page, NR_PAGETABLE);
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
