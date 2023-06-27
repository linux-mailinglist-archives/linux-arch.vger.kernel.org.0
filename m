Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8DA73F1CC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjF0DRQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjF0DQV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:16:21 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD72126;
        Mon, 26 Jun 2023 20:15:40 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5768a7e3adbso46469437b3.0;
        Mon, 26 Jun 2023 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835739; x=1690427739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnT0OuFQgSMPBMpNBMcjRtrAID2j2J/z+99kPRjsdFc=;
        b=C9lK0LHuN5lKypvu+Aj6aeuTYWXXF635p2/pwdffwMnvgLPQ5DfNtjJwGjF0xWaGtG
         k4CBfAborCW+hCWMhZ2oUELsTotpY/LgKDoPzYRghFuc0ywrV2kgKg/Bf03R4RrxER14
         8aFizXA8XvmvkijHxeK5b0ar2PYZmVlLjrBJOqZ59csukgFcxnmc3Xf5i7RxtGtOgHDV
         jxfjAgQfXU+ZB0gWRP2dwNno3Yad8q9D+y808smsM+9/wszItlWIKVHjO8VqsouceqTf
         m31MSyOhX7e2LHwarw7nCVK/K8Mtdnr1+ICaXDV8yqHnDrMeoBLMORe+kyEQDKvPPqv1
         8mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835739; x=1690427739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnT0OuFQgSMPBMpNBMcjRtrAID2j2J/z+99kPRjsdFc=;
        b=C+3/u0aPMcmziPyyHtsIysyP7bJMFPDSrCjvG255iojczTinphlYV1FE5wB/m1cFbt
         GZvnnYKocl58pNKjPbgFsXe7cVn+o1UoUtqFlZqIGIn/EoJTL4HGynQFLnj9fxigRS7S
         m46HFMNO/OoWSySCAtVyFzCR/6JIUa8ELYwEVwkX/05KCOh+FOiD1EO6RJuAQaYHUmjA
         sIOVYNVGnoOGz7Vh34Em6PoFGwZOG6wGJcbPpU9iPJqJgyYljiyFOpjw5HpuwZ9Fz7Cu
         256wVWaZqiLIX7pBWgynktYQKn2reoPHAsyMOSTXUA5fJgDPxYzYlkLtZ1IPE/at0Q64
         UUvg==
X-Gm-Message-State: AC+VfDx49Byn0V06mJiZ+PtK4+fqqBEd48kOdpOPahp+btfkbYICsDli
        iaJAPMLx3mjJKs2IavoRBvU=
X-Google-Smtp-Source: ACHHUZ4s0sSEGcPfreheHOmEbwOCo2wccO0ZlMx4KueotfvtG5g+MVgAzB4cpcvHGs8z0aON7ghJ0A==
X-Received: by 2002:a81:a191:0:b0:56d:50a:c0bb with SMTP id y139-20020a81a191000000b0056d050ac0bbmr37686199ywg.25.1687835739285;
        Mon, 26 Jun 2023 20:15:39 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:38 -0700 (PDT)
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
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 15/33] s390: Convert various gmap functions to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:13 -0700
Message-Id: <20230627031431.29653-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
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
these to use pagetable_alloc() and ptdesc_address() instead to help
standardize page tables further.

Since we're now using pagetable_free(), set _pt_s390_gaddr (which
aliases with page->mapping) to NULL in that function instead.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/s390/mm/gmap.c | 217 +++++++++++++++++++++++---------------------
 include/linux/mm.h  |   3 +
 2 files changed, 117 insertions(+), 103 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index beb4804d9ca8..8dbe0fdc0e44 100644
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
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
@@ -181,25 +181,23 @@ static void gmap_rmap_radix_tree_free(struct radix_tree_root *root)
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
+		pagetable_free(ptdesc);
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
+			page_table_free_pgste(ptdesc_page(ptdesc));
 		}
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
@@ -308,28 +306,27 @@ EXPORT_SYMBOL_GPL(gmap_get_enabled);
 static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 			    unsigned long init, unsigned long gaddr)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long *new;
 
 	/* since we dont free the gmap table until gmap_free we can unlock */
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
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
-	}
+	if (ptdesc)
+		pagetable_free(ptdesc);
+
 	return 0;
 }
 
@@ -341,15 +338,15 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
  */
 static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	unsigned long offset, mask;
 
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
 	mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	page = virt_to_page((void *)((unsigned long) entry & mask));
+	ptdesc = virt_to_ptdesc((void *)((unsigned long) entry & mask));
 
-	return page->_pt_s390_gaddr + offset;
+	return ptdesc->_pt_s390_gaddr + offset;
 }
 
 /**
@@ -1345,6 +1342,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	unsigned long *ste;
 	phys_addr_t sto, pgt;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
@@ -1358,9 +1356,10 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 	/* Free page table */
 	page = phys_to_page(pgt);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	page_table_free_pgste(page);
+
+	ptdesc = page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	page_table_free_pgste(ptdesc_page(ptdesc));
 }
 
 /**
@@ -1374,9 +1373,10 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
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
@@ -1387,9 +1387,10 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 		/* Free page table */
 		page = phys_to_page(pgt);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		page_table_free_pgste(page);
+
+		ptdesc = page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		page_table_free_pgste(ptdesc_page(ptdesc));
 	}
 }
 
@@ -1405,6 +1406,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	unsigned long r3o, *r3e;
 	phys_addr_t sgt;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r3e = gmap_table_walk(sg, raddr, 2); /* get region-3 pointer */
@@ -1418,9 +1420,10 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 	/* Free segment table */
 	page = phys_to_page(sgt);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	ptdesc = page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1434,9 +1437,10 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
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
@@ -1447,9 +1451,10 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_sgt(sg, raddr, __va(sgt));
 		/* Free segment table */
 		page = phys_to_page(sgt);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		ptdesc = page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1465,6 +1470,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	unsigned long r2o, *r2e;
 	phys_addr_t r3t;
 	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r2e = gmap_table_walk(sg, raddr, 3); /* get region-2 pointer */
@@ -1478,9 +1484,10 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 	/* Free region 3 table */
 	page = phys_to_page(r3t);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	ptdesc = page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1495,8 +1502,9 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 				unsigned long *r2t)
 {
 	phys_addr_t r3t;
-	struct page *page;
 	int i;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	for (i = 0; i < _CRST_ENTRIES; i++, raddr += _REGION2_SIZE) {
@@ -1507,9 +1515,10 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 		__gmap_unshadow_r3t(sg, raddr, __va(r3t));
 		/* Free region 3 table */
 		page = phys_to_page(r3t);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		ptdesc = page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1525,6 +1534,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	unsigned long r1o, *r1e;
 	struct page *page;
 	phys_addr_t r2t;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	r1e = gmap_table_walk(sg, raddr, 4); /* get region-1 pointer */
@@ -1538,9 +1548,10 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	__gmap_unshadow_r2t(sg, raddr, __va(r2t));
 	/* Free region 2 table */
 	page = phys_to_page(r2t);
-	list_del(&page->lru);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+
+	ptdesc = page_ptdesc(page);
+	list_del(&ptdesc->pt_list);
+	pagetable_free(ptdesc);
 }
 
 /**
@@ -1558,6 +1569,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 	struct page *page;
 	phys_addr_t r2t;
 	int i;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	asce = __pa(r1t) | _ASCE_TYPE_REGION1;
@@ -1571,9 +1583,10 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 		r1t[i] = _REGION1_ENTRY_EMPTY;
 		/* Free region 2 table */
 		page = phys_to_page(r2t);
-		list_del(&page->lru);
-		page->_pt_s390_gaddr = 0;
-		__free_pages(page, CRST_ALLOC_ORDER);
+
+		ptdesc = page_ptdesc(page);
+		list_del(&ptdesc->pt_list);
+		pagetable_free(ptdesc);
 	}
 }
 
@@ -1770,18 +1783,18 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
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
@@ -1802,7 +1815,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 		 _REGION_ENTRY_TYPE_R1 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r2t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1830,8 +1843,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r2t);
@@ -1855,18 +1867,18 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_r3t = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_r3t = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 3); /* get region-2 pointer */
@@ -1887,7 +1899,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 		 _REGION_ENTRY_TYPE_R2 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= (r3t & _REGION_ENTRY_PROTECT);
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -1915,8 +1927,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_r3t);
@@ -1940,18 +1951,18 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
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
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
+	ptdesc->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
-	s_sgt = page_to_phys(page);
+		ptdesc->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
+	s_sgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 2); /* get region-3 pointer */
@@ -1972,7 +1983,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 		 _REGION_ENTRY_TYPE_R3 | _REGION_ENTRY_INVALID;
 	if (sg->edat_level >= 1)
 		*table |= sgt & _REGION_ENTRY_PROTECT;
-	list_add(&page->lru, &sg->crst_list);
+	list_add(&ptdesc->pt_list, &sg->crst_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_REGION_ENTRY_INVALID;
@@ -2000,8 +2011,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	__free_pages(page, CRST_ALLOC_ORDER);
+	pagetable_free(ptdesc);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(gmap_shadow_sgt);
@@ -2024,8 +2034,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 			   int *fake)
 {
 	unsigned long *table;
-	struct page *page;
 	int rc;
+	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	spin_lock(&sg->guest_table_lock);
@@ -2033,9 +2044,10 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
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
@@ -2064,19 +2076,19 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
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
@@ -2094,7 +2106,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
 		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
-	list_add(&page->lru, &sg->pt_list);
+	list_add(&ptdesc->pt_list, &sg->pt_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_SEGMENT_ENTRY_INVALID;
@@ -2120,8 +2132,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page->_pt_s390_gaddr = 0;
-	page_table_free_pgste(page);
+	page_table_free_pgste(ptdesc_page(ptdesc));
 	return rc;
 
 }
@@ -2821,11 +2832,11 @@ EXPORT_SYMBOL_GPL(__s390_uv_destroy_range);
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
@@ -2840,7 +2851,7 @@ void s390_unlist_old_asce(struct gmap *gmap)
 	 * pointers, so list_del can work (and do nothing) without
 	 * dereferencing stale or invalid pointers.
 	 */
-	INIT_LIST_HEAD(&old->lru);
+	INIT_LIST_HEAD(&old->pt_list);
 	spin_unlock(&gmap->guest_table_lock);
 }
 EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
@@ -2861,7 +2872,7 @@ EXPORT_SYMBOL_GPL(s390_unlist_old_asce);
 int s390_replace_asce(struct gmap *gmap)
 {
 	unsigned long asce;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	void *table;
 
 	s390_unlist_old_asce(gmap);
@@ -2870,10 +2881,10 @@ int s390_replace_asce(struct gmap *gmap)
 	if ((gmap->asce & _ASCE_TYPE_MASK) == _ASCE_TYPE_SEGMENT)
 		return -EINVAL;
 
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
-	if (!page)
+	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
+	if (!ptdesc)
 		return -ENOMEM;
-	table = page_to_virt(page);
+	table = ptdesc_to_virt(ptdesc);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
 	/*
@@ -2882,7 +2893,7 @@ int s390_replace_asce(struct gmap *gmap)
 	 * it will be freed when the VM is torn down.
 	 */
 	spin_lock(&gmap->guest_table_lock);
-	list_add(&page->lru, &gmap->crst_list);
+	list_add(&ptdesc->pt_list, &gmap->crst_list);
 	spin_unlock(&gmap->guest_table_lock);
 
 	/* Set new table origin while preserving existing ASCE control bits */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 356e79984cf9..0e4d5f6d10e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2792,6 +2792,9 @@ static inline void pagetable_free(struct ptdesc *pt)
 {
 	struct page *page = ptdesc_page(pt);
 
+	/* set page->mapping to NULL since s390 gmap may have used it */
+	pt->_pt_s390_gaddr = 0;
+
 	__free_pages(page, compound_order(page));
 }
 
-- 
2.40.1

