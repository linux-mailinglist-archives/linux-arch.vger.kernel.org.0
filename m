Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585787301F1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbjFNO3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 10:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244801AbjFNO3h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 10:29:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D97D1FE4;
        Wed, 14 Jun 2023 07:29:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF8A63FDB;
        Wed, 14 Jun 2023 14:29:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D80CC433C0;
        Wed, 14 Jun 2023 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686752973;
        bh=WTaYvuDxg6Ye+uQdifpISbANz3GG89I9p1wO2eS6L8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UUaoURE5aAUww0zdJi05OlquU80O9XL9Py3hqHO+LOlrE1dJTlcKfjr7g3Q4pa1ka
         TpdouhGFDli9Bib8omnOXLlenVR4YFqsF41fzo2fo/7p60Kvnh3A8dxKQ8r4GMkFbV
         BGnFTzUxZ9yEbmXh9kyBVd2OmMcblodskvomswYUFQH8gESMcIL7ysIdFgwhWL+oVh
         QIjWn2OGMID6DQBxMSVzgYXrYFcRz2U/pj3+bMpZDPe2q/gGOUq2fTlwvIT8+//6Dj
         UsLvzsvMCbg3XtPWJ2LFNTIRZaNTRGuIV/RWVmvm3S3QLmVzb5YF+ZcVOLYxCkW6BA
         JQ1937AG598iQ==
Date:   Wed, 14 Jun 2023 17:28:54 +0300
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
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 16/34] s390: Convert various gmap functions to use
 ptdescs
Message-ID: <20230614142854.GO52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-17-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-17-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:05PM -0700, Vishal Moola (Oracle) wrote:
> In order to split struct ptdesc from struct page, convert various
> functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

With folding

	ptdesc->_pt_s390_gaddr = 0;

into pagetable_free()

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>


> ---
>  arch/s390/mm/gmap.c | 230 ++++++++++++++++++++++++--------------------
>  1 file changed, 128 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 81c683426b49..010e87df7299 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -34,7 +34,7 @@
>  static struct gmap *gmap_alloc(unsigned long limit)
>  {
>  	struct gmap *gmap;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	unsigned long *table;
>  	unsigned long etype, atype;
>  
> @@ -67,12 +67,12 @@ static struct gmap *gmap_alloc(unsigned long limit)
>  	spin_lock_init(&gmap->guest_table_lock);
>  	spin_lock_init(&gmap->shadow_lock);
>  	refcount_set(&gmap->ref_count, 1);
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		goto out_free;
> -	page->_pt_s390_gaddr = 0;
> -	list_add(&page->lru, &gmap->crst_list);
> -	table = page_to_virt(page);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	list_add(&ptdesc->pt_list, &gmap->crst_list);
> +	table = ptdesc_to_virt(ptdesc);
>  	crst_table_init(table, etype);
>  	gmap->table = table;
>  	gmap->asce = atype | _ASCE_TABLE_LENGTH |
> @@ -181,25 +181,25 @@ static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
>   */
>  static void gmap_free(struct gmap *gmap)
>  {
> -	struct page *page, *next;
> +	struct ptdesc *ptdesc, *next;
>  
>  	/* Flush tlb of all gmaps (if not already done for shadows) */
>  	if (!(gmap_is_shadow(gmap) && gmap->removed))
>  		gmap_flush_tlb(gmap);
>  	/* Free all segment & region tables. */
> -	list_for_each_entry_safe(page, next, &gmap->crst_list, lru) {
> -		page->_pt_s390_gaddr = 0;
> -		__free_pages(page, CRST_ALLOC_ORDER);
> +	list_for_each_entry_safe(ptdesc, next, &gmap->crst_list, pt_list) {
> +		ptdesc->_pt_s390_gaddr = 0;
> +		pagetable_free(ptdesc);
>  	}
>  	gmap_radix_tree_free(&gmap->guest_to_host);
>  	gmap_radix_tree_free(&gmap->host_to_guest);
>  
>  	/* Free additional data for a shadow gmap */
>  	if (gmap_is_shadow(gmap)) {
> -		/* Free all page tables. */
> -		list_for_each_entry_safe(page, next, &gmap->pt_list, lru) {
> -			page->_pt_s390_gaddr = 0;
> -			page_table_free_pgste(page);
> +		/* Free all ptdesc tables. */
> +		list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list) {
> +			ptdesc->_pt_s390_gaddr = 0;
> +			page_table_free_pgste(ptdesc_page(ptdesc));
>  		}
>  		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
>  		/* Release reference to the parent */
> @@ -308,27 +308,27 @@ EXPORT_SYMBOL_GPL(gmap_get_enabled);
>  static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
>  			    unsigned long init, unsigned long gaddr)
>  {
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	unsigned long *new;
>  
>  	/* since we dont free the gmap table until gmap_free we can unlock */
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	new = page_to_virt(page);
> +	new = ptdesc_to_virt(ptdesc);
>  	crst_table_init(new, init);
>  	spin_lock(&gmap->guest_table_lock);
>  	if (*table & _REGION_ENTRY_INVALID) {
> -		list_add(&page->lru, &gmap->crst_list);
> +		list_add(&ptdesc->pt_list, &gmap->crst_list);
>  		*table = __pa(new) | _REGION_ENTRY_LENGTH |
>  			(*table & _REGION_ENTRY_TYPE_MASK);
> -		page->_pt_s390_gaddr = gaddr;
> -		page = NULL;
> +		ptdesc->_pt_s390_gaddr = gaddr;
> +		ptdesc = NULL;
>  	}
>  	spin_unlock(&gmap->guest_table_lock);
> -	if (page) {
> -		page->_pt_s390_gaddr = 0;
> -		__free_pages(page, CRST_ALLOC_ORDER);
> +	if (ptdesc) {
> +		ptdesc->_pt_s390_gaddr = 0;
> +		pagetable_free(ptdesc);
>  	}
>  	return 0;
>  }
> @@ -341,15 +341,15 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
>   */
>  static unsigned long __gmap_segment_gaddr(unsigned long *entry)
>  {
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	unsigned long offset, mask;
>  
>  	offset = (unsigned long) entry / sizeof(unsigned long);
>  	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
>  	mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
> -	page = virt_to_page((void *)((unsigned long) entry & mask));
> +	ptdesc = virt_to_ptdesc((void *)((unsigned long) entry & mask));
>  
> -	return page->_pt_s390_gaddr + offset;
> +	return ptdesc->_pt_s390_gaddr + offset;
>  }
>  
>  /**
> @@ -1345,6 +1345,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
>  	unsigned long *ste;
>  	phys_addr_t sto, pgt;
>  	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
> @@ -1358,9 +1359,11 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
>  	__gmap_unshadow_pgt(sg, raddr, __va(pgt));
>  	/* Free page table */
>  	page = phys_to_page(pgt);
> -	list_del(&page->lru);
> -	page->_pt_s390_gaddr = 0;
> -	page_table_free_pgste(page);
> +
> +	ptdesc = page_ptdesc(page);
> +	list_del(&ptdesc->pt_list);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	page_table_free_pgste(ptdesc_page(ptdesc));
>  }
>  
>  /**
> @@ -1374,9 +1377,10 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
>  static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
>  				unsigned long *sgt)
>  {
> -	struct page *page;
>  	phys_addr_t pgt;
>  	int i;
> +	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _SEGMENT_SIZE) {
> @@ -1387,9 +1391,11 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
>  		__gmap_unshadow_pgt(sg, raddr, __va(pgt));
>  		/* Free page table */
>  		page = phys_to_page(pgt);
> -		list_del(&page->lru);
> -		page->_pt_s390_gaddr = 0;
> -		page_table_free_pgste(page);
> +
> +		ptdesc = page_ptdesc(page);
> +		list_del(&ptdesc->pt_list);
> +		ptdesc->_pt_s390_gaddr = 0;
> +		page_table_free_pgste(ptdesc_page(ptdesc));
>  	}
>  }
>  
> @@ -1405,6 +1411,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
>  	unsigned long r3o, *r3e;
>  	phys_addr_t sgt;
>  	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
> @@ -1418,9 +1425,11 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
>  	__gmap_unshadow_sgt(sg, raddr, __va(sgt));
>  	/* Free segment table */
>  	page = phys_to_page(sgt);
> -	list_del(&page->lru);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +
> +	ptdesc = page_ptdesc(page);
> +	list_del(&ptdesc->pt_list);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  }
>  
>  /**
> @@ -1434,9 +1443,10 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
>  static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
>  				unsigned long *r3t)
>  {
> -	struct page *page;
>  	phys_addr_t sgt;
>  	int i;
> +	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _REGION3_SIZE) {
> @@ -1447,9 +1457,11 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
>  		__gmap_unshadow_sgt(sg, raddr, __va(sgt));
>  		/* Free segment table */
>  		page = phys_to_page(sgt);
> -		list_del(&page->lru);
> -		page->_pt_s390_gaddr = 0;
> -		__free_pages(page, CRST_ALLOC_ORDER);
> +
> +		ptdesc = page_ptdesc(page);
> +		list_del(&ptdesc->pt_list);
> +		ptdesc->_pt_s390_gaddr = 0;
> +		pagetable_free(ptdesc);
>  	}
>  }
>  
> @@ -1465,6 +1477,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
>  	unsigned long r2o, *r2e;
>  	phys_addr_t r3t;
>  	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
> @@ -1478,9 +1491,11 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
>  	__gmap_unshadow_r3t(sg, raddr, __va(r3t));
>  	/* Free region 3 table */
>  	page = phys_to_page(r3t);
> -	list_del(&page->lru);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +
> +	ptdesc = page_ptdesc(page);
> +	list_del(&ptdesc->pt_list);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  }
>  
>  /**
> @@ -1495,8 +1510,9 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
>  				unsigned long *r2t)
>  {
>  	phys_addr_t r3t;
> -	struct page *page;
>  	int i;
> +	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _REGION2_SIZE) {
> @@ -1507,9 +1523,11 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
>  		__gmap_unshadow_r3t(sg, raddr, __va(r3t));
>  		/* Free region 3 table */
>  		page = phys_to_page(r3t);
> -		list_del(&page->lru);
> -		page->_pt_s390_gaddr = 0;
> -		__free_pages(page, CRST_ALLOC_ORDER);
> +
> +		ptdesc = page_ptdesc(page);
> +		list_del(&ptdesc->pt_list);
> +		ptdesc->_pt_s390_gaddr = 0;
> +		pagetable_free(ptdesc);
>  	}
>  }
>  
> @@ -1525,6 +1543,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
>  	unsigned long r1o, *r1e;
>  	struct page *page;
>  	phys_addr_t r2t;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	r1e = gmap_table_walk(sg, raddr, 4); /* get region-1 pointer */
> @@ -1538,9 +1557,11 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
>  	__gmap_unshadow_r2t(sg, raddr, __va(r2t));
>  	/* Free region 2 table */
>  	page = phys_to_page(r2t);
> -	list_del(&page->lru);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +
> +	ptdesc = page_ptdesc(page);
> +	list_del(&ptdesc->pt_list);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  }
>  
>  /**
> @@ -1558,6 +1579,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
>  	struct page *page;
>  	phys_addr_t r2t;
>  	int i;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	asce = __pa(r1t) | _ASCE_TYPE_REGION1;
> @@ -1571,9 +1593,11 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
>  		r1t[i] = _REGION1_ENTRY_EMPTY;
>  		/* Free region 2 table */
>  		page = phys_to_page(r2t);
> -		list_del(&page->lru);
> -		page->_pt_s390_gaddr = 0;
> -		__free_pages(page, CRST_ALLOC_ORDER);
> +
> +		ptdesc = page_ptdesc(page);
> +		list_del(&ptdesc->pt_list);
> +		ptdesc->_pt_s390_gaddr = 0;
> +		pagetable_free(ptdesc);
>  	}
>  }
>  
> @@ -1770,18 +1794,18 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
>  	unsigned long raddr, origin, offset, len;
>  	unsigned long *table;
>  	phys_addr_t s_r2t;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	int rc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	/* Allocate a shadow region second table */
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	page->_pt_s390_gaddr = r2t & _REGION_ENTRY_ORIGIN;
> +	ptdesc->_pt_s390_gaddr = r2t & _REGION_ENTRY_ORIGIN;
>  	if (fake)
> -		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> -	s_r2t = page_to_phys(page);
> +		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> +	s_r2t = page_to_phys(ptdesc_page(ptdesc));
>  	/* Install shadow region second table */
>  	spin_lock(&sg->guest_table_lock);
>  	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
> @@ -1802,7 +1826,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
>  		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
>  	if (sg->edat_level >= 1)
>  		*table |= (r2t & _REGION_ENTRY_PROTECT);
> -	list_add(&page->lru, &sg->crst_list);
> +	list_add(&ptdesc->pt_list, &sg->crst_list);
>  	if (fake) {
>  		/* nothing to protect for fake tables */
>  		*table &= ~_REGION_ENTRY_INVALID;
> @@ -1830,8 +1854,8 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
>  	return rc;
>  out_free:
>  	spin_unlock(&sg->guest_table_lock);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
> @@ -1855,18 +1879,18 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
>  	unsigned long raddr, origin, offset, len;
>  	unsigned long *table;
>  	phys_addr_t s_r3t;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	int rc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	/* Allocate a shadow region second table */
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	page->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
> +	ptdesc->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
>  	if (fake)
> -		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> -	s_r3t = page_to_phys(page);
> +		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> +	s_r3t = page_to_phys(ptdesc_page(ptdesc));
>  	/* Install shadow region second table */
>  	spin_lock(&sg->guest_table_lock);
>  	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
> @@ -1887,7 +1911,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
>  		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
>  	if (sg->edat_level >= 1)
>  		*table |= (r3t & _REGION_ENTRY_PROTECT);
> -	list_add(&page->lru, &sg->crst_list);
> +	list_add(&ptdesc->pt_list, &sg->crst_list);
>  	if (fake) {
>  		/* nothing to protect for fake tables */
>  		*table &= ~_REGION_ENTRY_INVALID;
> @@ -1915,8 +1939,8 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
>  	return rc;
>  out_free:
>  	spin_unlock(&sg->guest_table_lock);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
> @@ -1940,18 +1964,18 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
>  	unsigned long raddr, origin, offset, len;
>  	unsigned long *table;
>  	phys_addr_t s_sgt;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	int rc;
>  
>  	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
>  	/* Allocate a shadow segment table */
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	page->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
> +	ptdesc->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
>  	if (fake)
> -		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> -	s_sgt = page_to_phys(page);
> +		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> +	s_sgt = page_to_phys(ptdesc_page(ptdesc));
>  	/* Install shadow region second table */
>  	spin_lock(&sg->guest_table_lock);
>  	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
> @@ -1972,7 +1996,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
>  		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
>  	if (sg->edat_level >= 1)
>  		*table |= sgt & _REGION_ENTRY_PROTECT;
> -	list_add(&page->lru, &sg->crst_list);
> +	list_add(&ptdesc->pt_list, &sg->crst_list);
>  	if (fake) {
>  		/* nothing to protect for fake tables */
>  		*table &= ~_REGION_ENTRY_INVALID;
> @@ -2000,8 +2024,8 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
>  	return rc;
>  out_free:
>  	spin_unlock(&sg->guest_table_lock);
> -	page->_pt_s390_gaddr = 0;
> -	__free_pages(page, CRST_ALLOC_ORDER);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	pagetable_free(ptdesc);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
> @@ -2024,8 +2048,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
>  			   int *fake)
>  {
>  	unsigned long *table;
> -	struct page *page;
>  	int rc;
> +	struct page *page;
> +	struct ptdesc *ptdesc;
>  
>  	BUG_ON(!gmap_is_shadow(sg));
>  	spin_lock(&sg->guest_table_lock);
> @@ -2033,9 +2058,10 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
>  	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
>  		/* Shadow page tables are full pages (pte+pgste) */
>  		page = pfn_to_page(*table >> PAGE_SHIFT);
> -		*pgt = page->_pt_s390_gaddr & ~GMAP_SHADOW_FAKE_TABLE;
> +		ptdesc = page_ptdesc(page);
> +		*pgt = ptdesc->_pt_s390_gaddr & ~GMAP_SHADOW_FAKE_TABLE;
>  		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
> -		*fake = !!(page->_pt_s390_gaddr & GMAP_SHADOW_FAKE_TABLE);
> +		*fake = !!(ptdesc->_pt_s390_gaddr & GMAP_SHADOW_FAKE_TABLE);
>  		rc = 0;
>  	} else  {
>  		rc = -EAGAIN;
> @@ -2064,19 +2090,19 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
>  {
>  	unsigned long raddr, origin;
>  	unsigned long *table;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	phys_addr_t s_pgt;
>  	int rc;
>  
>  	BUG_ON(!gmap_is_shadow(sg) || (pgt & _SEGMENT_ENTRY_LARGE));
>  	/* Allocate a shadow page table */
> -	page = page_table_alloc_pgste(sg->mm);
> -	if (!page)
> +	ptdesc = page_ptdesc(page_table_alloc_pgste(sg->mm));
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	page->_pt_s390_gaddr = pgt & _SEGMENT_ENTRY_ORIGIN;
> +	ptdesc->_pt_s390_gaddr = pgt & _SEGMENT_ENTRY_ORIGIN;
>  	if (fake)
> -		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> -	s_pgt = page_to_phys(page);
> +		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
> +	s_pgt = page_to_phys(ptdesc_page(ptdesc));
>  	/* Install shadow page table */
>  	spin_lock(&sg->guest_table_lock);
>  	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
> @@ -2094,7 +2120,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
>  	/* mark as invalid as long as the parent table is not protected */
>  	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
>  		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
> -	list_add(&page->lru, &sg->pt_list);
> +	list_add(&ptdesc->pt_list, &sg->pt_list);
>  	if (fake) {
>  		/* nothing to protect for fake tables */
>  		*table &= ~_SEGMENT_ENTRY_INVALID;
> @@ -2120,8 +2146,8 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
>  	return rc;
>  out_free:
>  	spin_unlock(&sg->guest_table_lock);
> -	page->_pt_s390_gaddr = 0;
> -	page_table_free_pgste(page);
> +	ptdesc->_pt_s390_gaddr = 0;
> +	page_table_free_pgste(ptdesc_page(ptdesc));
>  	return rc;
>  
>  }
> @@ -2814,11 +2840,11 @@ EXPORT_SYMBOL_GPL(__s390_uv_destroy_range);
>   */
>  void s390_unlist_old_asce(struct gmap *gmap)
>  {
> -	struct page *old;
> +	struct ptdesc *old;
>  
> -	old = virt_to_page(gmap->table);
> +	old = virt_to_ptdesc(gmap->table);
>  	spin_lock(&gmap->guest_table_lock);
> -	list_del(&old->lru);
> +	list_del(&old->pt_list);
>  	/*
>  	 * Sometimes the topmost page might need to be "removed" multiple
>  	 * times, for example if the VM is rebooted into secure mode several
> @@ -2833,7 +2859,7 @@ void s390_unlist_old_asce(struct gmap *gmap)
>  	 * pointers, so list_del can work (and do nothing) without
>  	 * dereferencing stale or invalid pointers.
>  	 */
> -	INIT_LIST_HEAD(&old->lru);
> +	INIT_LIST_HEAD(&old->pt_list);
>  	spin_unlock(&gmap->guest_table_lock);
>  }
>  EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
> @@ -2854,7 +2880,7 @@ EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
>  int s390_replace_asce(struct gmap *gmap)
>  {
>  	unsigned long asce;
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	void *table;
>  
>  	s390_unlist_old_asce(gmap);
> @@ -2863,10 +2889,10 @@ int s390_replace_asce(struct gmap *gmap)
>  	if ((gmap->asce & _ASCE_TYPE_MASK) == _ASCE_TYPE_SEGMENT)
>  		return -EINVAL;
>  
> -	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> -	if (!page)
> +	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
> +	if (!ptdesc)
>  		return -ENOMEM;
> -	table = page_to_virt(page);
> +	table = ptdesc_to_virt(ptdesc);
>  	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
>  
>  	/*
> @@ -2875,7 +2901,7 @@ int s390_replace_asce(struct gmap *gmap)
>  	 * it will be freed when the VM is torn down.
>  	 */
>  	spin_lock(&gmap->guest_table_lock);
> -	list_add(&page->lru, &gmap->crst_list);
> +	list_add(&ptdesc->pt_list, &gmap->crst_list);
>  	spin_unlock(&gmap->guest_table_lock);
>  
>  	/* Set new table origin while preserving existing ASCE control bits */
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
