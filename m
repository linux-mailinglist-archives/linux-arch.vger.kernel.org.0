Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F973F168
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjF0DPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjF0DPT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:19 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE07E59;
        Mon, 26 Jun 2023 20:15:13 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5700401acbeso42701367b3.0;
        Mon, 26 Jun 2023 20:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835712; x=1690427712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrvvNogNsRIG83AHolsa9VCJSL8m6r0U+Sd+5GfHivE=;
        b=KFVPW/L1EGxf5onR9E38PakeUBm7Bbz4cFtahphLQ1sSUVNZGd7nER5RaL9WyA/UoL
         PgHHcs40P3f/vASt7RkKBQRHT9dThfptLWW5jKgWLlumWguDDfYLL3SZytXiaD4+4jm3
         +atBVT37Sy/bJdoy89PSRnhwLs21WCXUyqFfA474pZoTc/BYDk8coSLDXM596R5kRLhl
         TefvIuFAqXot7lehideoP0lQvT6kZ9W44JAb3vqqx0E/oORJxSklOEhBggPE04qM7hKm
         4F8j8xTI+8DdC5lHV59rBabQmofEn421JCLtxF3k9d/+4bYzPJjNOJQB3f4xHw6c3xwN
         WsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835712; x=1690427712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrvvNogNsRIG83AHolsa9VCJSL8m6r0U+Sd+5GfHivE=;
        b=ltExkpq8sJarfk+cZ2b5RxdIpkopUqaHw3FkbSJuhWaZT01oEWkKRQDfX91KjQrc6s
         gDEO91Je522v/rgxz//3co5lBhLvk8DHXJV9x0k4CGkX2+783z3Qh3Y8QCQzjR4BMVxo
         lHUarokSSIR9uHFMDX1pyJyhzS774YfnABDIqwVKAbZXsokVXcqkDWz3t4j5Na+Leu+b
         TqDeAychgcB5kTAkPQNXRlLLtvXUUM549xQkW4yNBXUlcOVkHwAm3Ozg0Z67tkVY31i0
         rhlyz6DfZ/Wq4PVXdUHKLUoj6gT70T3ZDp3hhytoe1+yQiB1qrURg7k95Iu8Fm09h6M1
         AFQQ==
X-Gm-Message-State: AC+VfDyS0qyuSbbl33ME6OxzlpboM1AzAcV35NNyXfIU26c02a7QpWjB
        Jt+kwD6jmwZO5JZKs17tib4=
X-Google-Smtp-Source: ACHHUZ4EjEEup/VuemcyzWvx8SgfEca6vpQ2dFXd0lLvBvj7yBbGJ1thxu6SdSgQ7bisiJP7oRqBcQ==
X-Received: by 2002:a81:7d84:0:b0:576:9b21:2411 with SMTP id y126-20020a817d84000000b005769b212411mr8527217ywc.20.1687835712129;
        Mon, 26 Jun 2023 20:15:12 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:11 -0700 (PDT)
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
Subject: [PATCH v6 02/33] s390: Use _pt_s390_gaddr for gmap address tracking
Date:   Mon, 26 Jun 2023 20:14:00 -0700
Message-Id: <20230627031431.29653-3-vishal.moola@gmail.com>
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

s390 uses page->index to keep track of page tables for the guest address
space. In an attempt to consolidate the usage of page fields in s390,
replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.

Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
before freeing the pages as well.

This also reverts commit 7e25de77bc5ea ("s390/mm: use pmd_pgtable_page()
helper in __gmap_segment_gaddr()") which had s390 use
pmd_pgtable_page() to get a gmap page table, as pmd_pgtable_page()
should be used for more generic process page tables.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/s390/mm/gmap.c      | 56 +++++++++++++++++++++++++++-------------
 include/linux/mm_types.h |  2 +-
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f4b6fc746fce..beb4804d9ca8 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -70,7 +70,7 @@ static struct gmap *gmap_alloc(unsigned long limit)
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		goto out_free;
-	page->index = 0;
+	page->_pt_s390_gaddr = 0;
 	list_add(&page->lru, &gmap->crst_list);
 	table = page_to_virt(page);
 	crst_table_init(table, etype);
@@ -187,16 +187,20 @@ static void gmap_free(struct gmap *gmap)
 	if (!(gmap_is_shadow(gmap) && gmap->removed))
 		gmap_flush_tlb(gmap);
 	/* Free all segment & region tables. */
-	list_for_each_entry_safe(page, next, &gmap->crst_list, lru)
+	list_for_each_entry_safe(page, next, &gmap->crst_list, lru) {
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
+	}
 	gmap_radix_tree_free(&gmap->guest_to_host);
 	gmap_radix_tree_free(&gmap->host_to_guest);
 
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
 		/* Free all page tables. */
-		list_for_each_entry_safe(page, next, &gmap->pt_list, lru)
+		list_for_each_entry_safe(page, next, &gmap->pt_list, lru) {
+			page->_pt_s390_gaddr = 0;
 			page_table_free_pgste(page);
+		}
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
 		gmap_put(gmap->parent);
@@ -318,12 +322,14 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 		list_add(&page->lru, &gmap->crst_list);
 		*table = __pa(new) | _REGION_ENTRY_LENGTH |
 			(*table & _REGION_ENTRY_TYPE_MASK);
-		page->index = gaddr;
+		page->_pt_s390_gaddr = gaddr;
 		page = NULL;
 	}
 	spin_unlock(&gmap->guest_table_lock);
-	if (page)
+	if (page) {
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
+	}
 	return 0;
 }
 
@@ -336,12 +342,14 @@ static int gmap_alloc_table(struct gmap *gmap, unsigned long *table,
 static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 {
 	struct page *page;
-	unsigned long offset;
+	unsigned long offset, mask;
 
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
-	page = pmd_pgtable_page((pmd_t *) entry);
-	return page->index + offset;
+	mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
+	page = virt_to_page((void *)((unsigned long) entry & mask));
+
+	return page->_pt_s390_gaddr + offset;
 }
 
 /**
@@ -1351,6 +1359,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	/* Free page table */
 	page = phys_to_page(pgt);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	page_table_free_pgste(page);
 }
 
@@ -1379,6 +1388,7 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		/* Free page table */
 		page = phys_to_page(pgt);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		page_table_free_pgste(page);
 	}
 }
@@ -1409,6 +1419,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	/* Free segment table */
 	page = phys_to_page(sgt);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1437,6 +1448,7 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 		/* Free segment table */
 		page = phys_to_page(sgt);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1467,6 +1479,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	/* Free region 3 table */
 	page = phys_to_page(r3t);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1495,6 +1508,7 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 		/* Free region 3 table */
 		page = phys_to_page(r3t);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1525,6 +1539,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	/* Free region 2 table */
 	page = phys_to_page(r2t);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1557,6 +1572,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 		/* Free region 2 table */
 		page = phys_to_page(r2t);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1762,9 +1778,9 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
-	page->index = r2t & _REGION_ENTRY_ORIGIN;
+	page->_pt_s390_gaddr = r2t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
+		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
 	s_r2t = page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1814,6 +1830,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -1846,9 +1863,9 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
-	page->index = r3t & _REGION_ENTRY_ORIGIN;
+	page->_pt_s390_gaddr = r3t & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
+		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
 	s_r3t = page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1898,6 +1915,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -1930,9 +1948,9 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
-	page->index = sgt & _REGION_ENTRY_ORIGIN;
+	page->_pt_s390_gaddr = sgt & _REGION_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
+		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
 	s_sgt = page_to_phys(page);
 	/* Install shadow region second table */
 	spin_lock(&sg->guest_table_lock);
@@ -1982,6 +2000,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -2014,9 +2033,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
 	if (table && !(*table & _SEGMENT_ENTRY_INVALID)) {
 		/* Shadow page tables are full pages (pte+pgste) */
 		page = pfn_to_page(*table >> PAGE_SHIFT);
-		*pgt = page->index & ~GMAP_SHADOW_FAKE_TABLE;
+		*pgt = page->_pt_s390_gaddr & ~GMAP_SHADOW_FAKE_TABLE;
 		*dat_protection = !!(*table & _SEGMENT_ENTRY_PROTECT);
-		*fake = !!(page->index & GMAP_SHADOW_FAKE_TABLE);
+		*fake = !!(page->_pt_s390_gaddr & GMAP_SHADOW_FAKE_TABLE);
 		rc = 0;
 	} else  {
 		rc = -EAGAIN;
@@ -2054,9 +2073,9 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	page = page_table_alloc_pgste(sg->mm);
 	if (!page)
 		return -ENOMEM;
-	page->index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	page->_pt_s390_gaddr = pgt & _SEGMENT_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
+		page->_pt_s390_gaddr |= GMAP_SHADOW_FAKE_TABLE;
 	s_pgt = page_to_phys(page);
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
@@ -2101,6 +2120,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	page_table_free_pgste(page);
 	return rc;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..fbbe4e93a9ba 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -144,7 +144,7 @@ struct page {
 		struct {	/* Page table pages */
 			unsigned long _pt_pad_1;	/* compound_head */
 			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			unsigned long _pt_pad_2;	/* mapping */
+			unsigned long _pt_s390_gaddr;	/* mapping */
 			union {
 				struct mm_struct *pt_mm; /* x86 pgds only */
 				atomic_t pt_frag_refcount; /* powerpc */
-- 
2.40.1

