Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6374C6E528C
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDQUxi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjDQUxY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364526A7C;
        Mon, 17 Apr 2023 13:53:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso27917370pjp.5;
        Mon, 17 Apr 2023 13:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764786; x=1684356786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL7THI6COKAZs945t/ufo2xvJ6u97lYjYyNIJW1c0dQ=;
        b=doNd2TAUyyyVhrEHrHJgS8adO/z3uWhCb50/lQYlJdk5oqIjZwFvTJlGFJ89/QBcif
         8imrD8TFaRte2p5w0KyYL2OFgHoMnHEPcvjiPP5MaiHba2amKVAMgresLNg9DoMmTCzS
         PUuzaVsdF5ThP0OKEtKVPgORmoth5LctgfKQpFi3NQhv2sSntUA0rqVkNtUltdbMYKjo
         vztqHLhdDPahrz8LgoZyQMd0QcyNEvkeUbtOTxQhJimZ8P9c4sf1Y5B8mePYpgeVVI0l
         u553/In38aRZGgvsmj1RZFHLxXeA0/2uAaIsm3kC5sKW6TY7wXshXxHWLV3FZoGUXIIW
         7irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764786; x=1684356786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oL7THI6COKAZs945t/ufo2xvJ6u97lYjYyNIJW1c0dQ=;
        b=Tx/n4GApmN9yM4+QGzYGz8qD0S8ggZN3vYyMZd1Y27vwGhygCW8pddPru3hmfeaXvl
         XZKkvaaKLuUVzD6qN8f00B8CpQiUk1Nb0wqBU9KKM3N0DKT7SSHceOtp77lP+Il3U7Oo
         wNpuY2Dzbz3eV9Kwxim3hJ93VsS5i2eaJLvIcApgEOgCtmRVoznjjLzLLRWUojS7EgYS
         IwW+PFbjHLnRR6Mc27NQNwQr5W+IAuQ2rRVDWDZmkTDINRs6cBHJbgFYBrZsaZjEYsCA
         nsfv/hb9JJQDNF1Tr3pvf6fFDuVne6Ab2e+S6tE0tDeBYze++JzkJsyR2YAi9A7UYPL7
         zeVg==
X-Gm-Message-State: AAQBX9ejU1ldeHiVwjuSlSb4qEhKDpwlJnu7gx0SBhHafKrtqgfLymxq
        MqAWiw5FwhJcqI8qLjClFLQ=
X-Google-Smtp-Source: AKy350a3sfSYyKQBZCHGHLi0XTtVBj1S8oso+4y2+ULnoZrU3jXoGaDkpnKpDVzrixRlynGGGLFh9Q==
X-Received: by 2002:a05:6a20:7d9b:b0:f0:6d71:5f58 with SMTP id v27-20020a056a207d9b00b000f06d715f58mr1513174pzj.50.1681764786395;
        Mon, 17 Apr 2023 13:53:06 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:06 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 15/33] s390: Convert various gmap functions to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:30 -0700
Message-Id: <20230417205048.15870-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to split struct ptdesc from struct page, convert various
functions to use ptdescs.

Some of the functions use the *get*page*() helper functions. Convert
these to use ptdesc_alloc() and ptdesc_address() instead to help
standardize page tables further.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/gmap.c | 230 ++++++++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 102 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a61ea1a491dc..9c6ea1d16e09 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -34,7 +34,7 @@
 static struct gmap *gmap_alloc(unsigned long limit)
 {
 	struct gmap *gmap;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long *table;
 	unsigned long etype, atype;
 
@@ -67,12 +67,12 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	spin_lock_init(&gmap->guest_table_lock);
 	spin_lock_init(&gmap->shadow_lock);
 	refcount_set(&gmap->ref_count, 1);
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		goto out_free;
-	page->_pt_s390_gaddr = 0;
-	list_add(&page->lru, &gmap->crst_list);
-	table = page_to_virt(page);
+	ptdesc->_pt_s390_gaddr = 0;
+	list_add(&ptdesc->pt_list, &gmap->crst_list);
+	table = ptdesc_to_virt(ptdesc);
 	crst_table_init(table, etype);
 	gmap->table = table;
 	gmap->asce = atype | _ASCE_TABLE_LENGTH |
@@ -181,25 +181,25 @@ static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
  */
 static void gmap_free(struct gmap *gmap)
 {
-	struct page *page, *next;
+	struct ptdesc *ptdesc, *next;
 
 	/* Flush tlb of all gmaps (if not already done for shadows) */
 	if (!(gmap_is_shadow(gmap) && gmap->removed))
 		gmap_flush_tlb(gmap);
 	/* Free all segment & region tables. */
-	list_for_each_entry_safe(page, next, &gmap->crst_list, lru) {
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+	list_for_each_entry_safe(ptdesc, next, &gmap->crst_list, pt_list) {
+		ptdesc->_pt_s390_gaddr = 0;
+		ptdesc_free(ptdesc);
 	}
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
-		/* Free all page tables. */
-		list_for_each_entry_safe(page, next, &gmap->pt_list, lru) {
-			page->_pt_s390_gaddr = 0;
-			page_table_free_pgste(page);
+		/* Free all ptdesc tables. */
+		list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list) {
+			ptdesc->_pt_s390_gaddr = 0;
+			page_table_free_pgste(ptdesc_page(ptdesc));
 		}
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
@@ -308,27 +308,27 @@ EXPORT_SYMBOL_GPL(gmap_get_enabled);
 static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 			    unsigned long init, unsigned long gaddr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long *new;
 
 	/* since we dont free the gmap table until gmap_free we can unlock */
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	new = page_to_virt(page);
+	new = ptdesc_to_virt(ptdesc);
 	crst_table_init(new, init);
 	spin_lock(&gmap->guest_table_lock);
 	if (*table & _REGION_ENTRY_INVALID) {
-		list_add(&page->lru, &gmap->crst_list);
+		list_add(&ptdesc->pt_list, &gmap->crst_list);
 		*table = __pa(new) | _REGION_ENTRY_LENGTH |
 			(*table & _REGION_ENTRY_TYPE_MASK);
-		page->_pt_s390_gaddr = gaddr;
-		page = NULL;
+		ptdesc->_pt_s390_gaddr = gaddr;
+		ptdesc = NULL;
 	}
 	spin_unlock(&gmap->guest_table_lock);
-	if (page) {
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+	if (ptdesc) {
+		ptdesc->_pt_s390_gaddr = 0;
+		ptdesc_free(ptdesc);
 	}
 	return 0;
 }
@@ -341,13 +341,13 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
  */
 static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long offset;
 
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
-	page = pmd_pgtable_page((pmd_t *) entry);
-	return page->_pt_s390_gaddr + offset;
+	ptdesc = pmd_ptdesc((pmd_t *) entry);
+	return ptdesc->_pt_s390_gaddr + offset;
 }
 
 /**
@@ -1343,6 +1343,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	unsigned long *ste;
 	phys_addr_t sto, pgt;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
@@ -1356,9 +1357,11 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 	/* Free page table */
 	page = phys_to_page(pgt);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	page_table_free_pgste(page);
+
+	page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	ptdesc->_pt_s390_gaddr = 0;
+	page_table_free_pgste(ptdesc_page(ptdesc));
 }
 
 /**
@@ -1372,9 +1375,10 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 				unsigned long *sgt)
 {
-	struct page *page;
 	phys_addr_t pgt;
 	int i;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _SEGMENT_SIZE) {
@@ -1385,9 +1389,11 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 		/* Free page table */
 		page = phys_to_page(pgt);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		page_table_free_pgste(page);
+
+		page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		ptdesc->_pt_s390_gaddr = 0;
+		page_table_free_pgste(ptdesc_page(ptdesc));
 	}
 }
 
@@ -1403,6 +1409,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	unsigned long r3o, *r3e;
 	phys_addr_t sgt;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
@@ -1416,9 +1423,11 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 	/* Free segment table */
 	page = phys_to_page(sgt);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 }
 
 /**
@@ -1432,9 +1441,10 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r3t)
 {
-	struct page *page;
 	phys_addr_t sgt;
 	int i;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _REGION3_SIZE) {
@@ -1445,9 +1455,11 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 		/* Free segment table */
 		page = phys_to_page(sgt);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		ptdesc->_pt_s390_gaddr = 0;
+		ptdesc_free(ptdesc);
 	}
 }
 
@@ -1463,6 +1475,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	unsigned long r2o, *r2e;
 	phys_addr_t r3t;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
@@ -1476,9 +1489,11 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 	/* Free region 3 table */
 	page = phys_to_page(r3t);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 }
 
 /**
@@ -1493,8 +1508,9 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r2t)
 {
 	phys_addr_t r3t;
-	struct page *page;
 	int i;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _REGION2_SIZE) {
@@ -1505,9 +1521,11 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 		/* Free region 3 table */
 		page = phys_to_page(r3t);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		ptdesc->_pt_s390_gaddr = 0;
+		ptdesc_free(ptdesc);
 	}
 }
 
@@ -1523,6 +1541,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	unsigned long r1o, *r1e;
 	struct page *page;
 	phys_addr_t r2t;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r1e = gmap_table_walk(sg, raddr, 4); /* get region-1 pointer */
@@ -1536,9 +1555,11 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_r2t(sg, raddr, __va(r2t));
 	/* Free region 2 table */
 	page = phys_to_page(r2t);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 }
 
 /**
@@ -1556,6 +1577,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 	struct page *page;
 	phys_addr_t r2t;
 	int i;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = __pa(r1t) | _ASCE_TYPE_REGION1;
@@ -1569,9 +1591,11 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 		r1t[i] = _REGION1_ENTRY_EMPTY;
 		/* Free region 2 table */
 		page = phys_to_page(r2t);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		ptdesc->_pt_s390_gaddr = 0;
+		ptdesc_free(ptdesc);
 	}
 }
 
@@ -1768,18 +1792,18 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_r2t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = r2t & _REGION_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = r2t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_r2t = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_r2t = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 4); /* get region-1 pointer */
@@ -1800,7 +1824,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r2t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1828,8 +1852,8 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
@@ -1853,18 +1877,18 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_r3t;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	/* Allocate a shadow region second table */
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_r3t = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_r3t = page_to_phys(ptdesc);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
@@ -1885,7 +1909,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r3t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1913,8 +1937,8 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
@@ -1938,18 +1962,18 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	unsigned long raddr, origin, offset, len;
 	unsigned long *table;
 	phys_addr_t s_sgt;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg) || (sgt & _REGION3_ENTRY_LARGE));
 	/* Allocate a shadow segment table */
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_sgt = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_sgt = page_to_phys(ptdesc);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
@@ -1970,7 +1994,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= sgt & _REGION_ENTRY_PROTECT;
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1998,8 +2022,8 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	ptdesc->_pt_s390_gaddr = 0;
+	ptdesc_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
@@ -2022,8 +2046,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 			   int *fake)
 {
 	unsigned long *table;
-	struct page *page;
 	int rc;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	spin_lock(&sg->guest_table_lock);
@@ -2031,9 +2056,10 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
 		/* Shadow page tables are full pages (pte+pgste) */
 		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->_pt_s390_gaddr & ~GMAP_SHADOW_FAKE_TABLE;
+		ptdesc = page_ptdesc(page);
+		*pgt = ptdesc->_pt_s390_gaddr & ~GMAP_SHADOW_FAKE_TABLE;
 		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
-		*fake = !!(page->_pt_s390_gaddr & GMAP_SHADOW_FAKE_TABLE);
+		*fake = !!(ptdesc->_pt_s390_gaddr & GMAP_SHADOW_FAKE_TABLE);
 		rc = 0;
 	} else  {
 		rc = -EAGAIN;
@@ -2062,19 +2088,19 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 {
 	unsigned long raddr, origin;
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t s_pgt;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg) || (pgt & _SEGMENT_ENTRY_LARGE));
 	/* Allocate a shadow page table */
-	page = page_table_alloc_pgste(sg->mm);
-	if (!page)
+	ptdesc = page_ptdesc(page_table_alloc_pgste(sg->mm));
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = pgt & _SEGMENT_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = pgt & _SEGMENT_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_pgt = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_pgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
@@ -2092,7 +2118,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
 		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
-	list_add(&page->lru, &sg->pt_list);
+	list_add(&ptdesc->pt_list, &sg->pt_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_SEGMENT_ENTRY_INVALID;
@@ -2118,8 +2144,8 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	page_table_free_pgste(page);
+	ptdesc->_pt_s390_gaddr = 0;
+	page_table_free_pgste(ptdesc_page(ptdesc));
 	return rc;
 
 }
@@ -2823,11 +2849,11 @@ EXPORT_SYMBOL_GPL(__s390_uv_destroy_range);
  */
 void s390_unlist_old_asce(struct gmap *gmap)
 {
-	struct page *old;
+	struct ptdesc *old;
 
-	old = virt_to_page(gmap->table);
+	old = virt_to_ptdesc(gmap->table);
 	spin_lock(&gmap->guest_table_lock);
-	list_del(&old->lru);
+	list_del(&old->pt_list);
 	/*
 	 * Sometimes the topmost page might need to be "removed" multiple
 	 * times, for example if the VM is rebooted into secure mode several
@@ -2842,7 +2868,7 @@ void s390_unlist_old_asce(struct gmap *gmap)
 	 * pointers, so list_del can work (and do nothing) without
 	 * dereferencing stale or invalid pointers.
 	 */
-	INIT_LIST_HEAD(&old->lru);
+	INIT_LIST_HEAD(&old->pt_list);
 	spin_unlock(&gmap->guest_table_lock);
 }
 EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
@@ -2860,15 +2886,15 @@ EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
 int s390_replace_asce(struct gmap *gmap)
 {
 	unsigned long asce;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	void *table;
 
 	s390_unlist_old_asce(gmap);
 
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = ptdesc_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	table = page_to_virt(page);
+	table = ptdesc_to_virt(ptdesc);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
 	/*
@@ -2877,7 +2903,7 @@ int s390_replace_asce(struct gmap *gmap)
 	 * it will be freed when the VM is torn down.
 	 */
 	spin_lock(&gmap->guest_table_lock);
-	list_add(&page->lru, &gmap->crst_list);
+	list_add(&ptdesc->pt_list, &gmap->crst_list);
 	spin_unlock(&gmap->guest_table_lock);
 
 	/* Set new table origin while preserving existing ASCE control bits */
-- 
2.39.2

