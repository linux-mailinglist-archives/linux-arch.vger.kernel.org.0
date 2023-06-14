Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D07300B1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245275AbjFNNwZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbjFNNwU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:52:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1751FFA;
        Wed, 14 Jun 2023 06:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4F3E60F06;
        Wed, 14 Jun 2023 13:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C7AC433CB;
        Wed, 14 Jun 2023 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750736;
        bh=VwaE4ixu2oYgT8bWCqZd/sCxt5Vr7LA6FKY2uA7+iKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pvu46WaEl54YKxvYrg17S6Us5Z+6jc6ZyxloGDXNG3sVbWCAn8khJSWsZ739VwfPP
         KwSYnW5Cb22U/hoqAU+3FM5yWaAmL/GvAe5O+LdrEw3/pZtxxI5c7cLPpLdtEqXk8T
         Fbh9NCB++t1sBODF7SprarK+tEpzTtUTE1tfwFFFrABefWFeIYBfx1eKkeOd7kHivF
         njsBTw00M7iYLOdiQBjB3A+VyNpSzWxaS2T8NQnbhp/VhP28ksnHBcMgphMjijMkdr
         wBr5rhU0/C9m5DU9+5BLMiU/dcdSlTsxTG9cV+YRjI8bVXWZYj/RDtOKkEZB/GxHIp
         Of8H4nZJFOgvQ==
Date:   Wed, 14 Jun 2023 16:51:38 +0300
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
Subject: Re: [PATCH v4 07/34] mm: Convert ptlock_alloc() to use ptdescs
Message-ID: <20230614135138.GF52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-8-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-8-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:56PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 6 +++---
>  mm/memory.c        | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 088b7664f897..e6f1be2a405e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2825,7 +2825,7 @@ static inline void pagetable_clear(void *x)
>  #if USE_SPLIT_PTE_PTLOCKS
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> -extern bool ptlock_alloc(struct page *page);
> +bool ptlock_alloc(struct ptdesc *ptdesc);
>  extern void ptlock_free(struct page *page);
>  
>  static inline spinlock_t *ptlock_ptr(struct page *page)
> @@ -2837,7 +2837,7 @@ static inline void ptlock_cache_init(void)
>  {
>  }
>  
> -static inline bool ptlock_alloc(struct page *page)
> +static inline bool ptlock_alloc(struct ptdesc *ptdesc)
>  {
>  	return true;
>  }
> @@ -2867,7 +2867,7 @@ static inline bool ptlock_init(struct page *page)
>  	 * slab code uses page->slab_cache, which share storage with page->ptl.
>  	 */
>  	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
> -	if (!ptlock_alloc(page))
> +	if (!ptlock_alloc(page_ptdesc(page)))
>  		return false;
>  	spin_lock_init(ptlock_ptr(page));
>  	return true;
> diff --git a/mm/memory.c b/mm/memory.c
> index 80ce9dda2779..ba9579117686 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5934,14 +5934,14 @@ void __init ptlock_cache_init(void)
>  			SLAB_PANIC, NULL);
>  }
>  
> -bool ptlock_alloc(struct page *page)
> +bool ptlock_alloc(struct ptdesc *ptdesc)
>  {
>  	spinlock_t *ptl;
>  
>  	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
>  	if (!ptl)
>  		return false;
> -	page->ptl = ptl;
> +	ptdesc->ptl = ptl;
>  	return true;
>  }
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
