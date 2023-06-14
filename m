Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32210730104
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 16:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbjFNOAa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 10:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbjFNOA2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 10:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11DC2106;
        Wed, 14 Jun 2023 07:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67E063FA5;
        Wed, 14 Jun 2023 14:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67061C433C8;
        Wed, 14 Jun 2023 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686751225;
        bh=uKraQGeV6CHflKMTQULlWthGg679fqUnVunPDgo/6HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PDvLwogGgBD7itA4KpDmMOz5f6z6VH2iaHunkUOmJGb2CV9/5MwRPKrP111EYXtEb
         UEqH+CWzIgF1Rc6XrQFIv/yMpYEmEBGoEuDURlPd52I/fGmF+q5wVqQlIl9KpU5+Uk
         bgdwaGWMrQOsCsKhPDLR53apMHeHe+9FdmAd1a7miKQKkWiXMpItAY3NijXk99Jluh
         Pxd9FqKP+sLyI/lOsBPezf8JoB5Fqp5Gg8oE7VA+UHq8nk2Bo7G2Cvf5IS4Aq32CvE
         s4FZBegGotMSVk+KfyEvDwvHHiHE5HW4dc9hJuLo8yp+W1/X4mVZFqgnWQ8kmzqF33
         SBYFIqusV7nCA==
Date:   Wed, 14 Jun 2023 16:59:47 +0300
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
Subject: Re: [PATCH v4 12/34] mm: Convert ptlock_free() to use ptdescs
Message-ID: <20230614135947.GK52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-13-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-13-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:01PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 10 +++++-----
>  mm/memory.c        |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3b54bb4c9753..a1af7983e1bd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2826,7 +2826,7 @@ static inline void pagetable_clear(void *x)
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
>  bool ptlock_alloc(struct ptdesc *ptdesc);
> -extern void ptlock_free(struct page *page);
> +void ptlock_free(struct ptdesc *ptdesc);
>  
>  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>  {
> @@ -2842,7 +2842,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -static inline void ptlock_free(struct page *page)
> +static inline void ptlock_free(struct ptdesc *ptdesc)
>  {
>  }
>  
> @@ -2883,7 +2883,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  }
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
> -static inline void ptlock_free(struct page *page) {}
> +static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
>  static inline bool pgtable_pte_page_ctor(struct page *page)
> @@ -2897,7 +2897,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
>  
>  static inline void pgtable_pte_page_dtor(struct page *page)
>  {
> -	ptlock_free(page);
> +	ptlock_free(page_ptdesc(page));
>  	__ClearPageTable(page);
>  	dec_lruvec_page_state(page, NR_PAGETABLE);
>  }
> @@ -2955,7 +2955,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
>  #endif
> -	ptlock_free(ptdesc_page(ptdesc));
> +	ptlock_free(ptdesc);
>  }
>  
>  #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
> diff --git a/mm/memory.c b/mm/memory.c
> index ba9579117686..d4d2ea5cf0fd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5945,8 +5945,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -void ptlock_free(struct page *page)
> +void ptlock_free(struct ptdesc *ptdesc)
>  {
> -	kmem_cache_free(page_ptl_cachep, page->ptl);
> +	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
>  }
>  #endif
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
