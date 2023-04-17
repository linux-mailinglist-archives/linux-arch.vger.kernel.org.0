Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903B36E5232
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDQUwy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjDQUwv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:52:51 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75934559A;
        Mon, 17 Apr 2023 13:52:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso27915611pjp.5;
        Mon, 17 Apr 2023 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764767; x=1684356767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUQ9/pimfaGXNi0CjQ5OYjWOczKCpE//S8xnkPc78yU=;
        b=FAf7Q7K913ZX6r/eLsy+yAUsXKMRxOHj1fLyHB9UIaactpRsuyZTxwm6yr9/0kHhuJ
         4Vp9zU5n5/h6vSIOmrhOIkQhtsXJjouneV7ATDr91jNlm1HLz9ERQ9iZEYmxf7IWZXzO
         7Bjl99gPzEex4CTscD2JLBVlVfqL8/78eXbRp1C2OSneg1gvPPXFUCS8B+INtmwbneb1
         7xu84pfQjybA5JWgsxDb5XtXBfw3JMpB/K4/MrDjwMi52JjctUf0w80qqRetA0UVkDY9
         /WMnuBxaObETeplAy+OYgYm1cMdR/MAIyIhp1m3TGneur/zdkE7Srlujs8An47+1uBTa
         DS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764767; x=1684356767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUQ9/pimfaGXNi0CjQ5OYjWOczKCpE//S8xnkPc78yU=;
        b=BO1xYJ/QeDIGesHOCmPISYYsl7B1utoGHCcdGrpzgbwdJh60nFFUE/ycPvHSVkzz9R
         QhBDD9evQNB8TYxKtGa/Fy6DOjWYlRX6DCOdWDEwNV+PuVk1tSgFE9CRPTwC1Y3m6kz2
         uvLKTV3+LSip/pWEUqNvqhzcrYGvFUjh6dsJSdgl9gSz8+2Aw0RklYKTLrlHAvPKWtEk
         Jmx4L8reYXLjw9CwiNBZlIVlpghjpx/t210Ud/8UrY2bz1xhFfEfHAY0U2CRRDSxF/M5
         avDRhgD30jo1ldQOgbqonF6jTJ6IybxkI8YKc/jdy6ivhsRMq5qiBnLSRgcrYPPFKmBV
         MxSw==
X-Gm-Message-State: AAQBX9ednN5mfA6uLHjpwISfQBVHPhWtiD7rAIHRtFpGCkoK9NFho/0L
        SPPtZHbmU6KftNnFcC2vWr8=
X-Google-Smtp-Source: AKy350bJ+z7DqyQlo/Tq9sm7RhBTmVNaq1jAeXkgM2fHwXUjj/5Rwh13YNUG3IxyilUJQDR+HGgjBw==
X-Received: by 2002:a17:90a:e642:b0:247:83fe:12b6 with SMTP id ep2-20020a17090ae64200b0024783fe12b6mr5579845pjb.43.1681764766744;
        Mon, 17 Apr 2023 13:52:46 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:46 -0700 (PDT)
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
Subject: [PATCH 01/33] s390: Use _pt_s390_gaddr for gmap address tracking
Date:   Mon, 17 Apr 2023 13:50:16 -0700
Message-Id: <20230417205048.15870-2-vishal.moola@gmail.com>
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

s390 uses page->index to keep track of page tables for the guest address
space. In an attempt to consolidate the usage of page fields in s390,
replace _pt_pad_2 with _pt_s390_gaddr to replace page->index in gmap.

This will help with the splitting of struct ptdesc from struct page, as
well as allow s390 to use _pt_frag_refcount for fragmented page table
tracking.

Since page->_pt_s390_gaddr aliases with mapping, ensure its set to NULL
before freeing the pages as well.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/gmap.c      | 50 +++++++++++++++++++++++++++-------------
 include/linux/mm_types.h |  2 +-
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 5a716bdcba05..a61ea1a491dc 100644
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
 
@@ -341,7 +347,7 @@ static unsigned long __gmap_segment_gaddr(unsigned long *entry)
 	offset = (unsigned long) entry / sizeof(unsigned long);
 	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
 	page = pmd_pgtable_page((pmd_t *) entry);
-	return page->index + offset;
+	return page->_pt_s390_gaddr + offset;
 }
 
 /**
@@ -1351,6 +1357,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	/* Free page table */
 	page = phys_to_page(pgt);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	page_table_free_pgste(page);
 }
 
@@ -1379,6 +1386,7 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		/* Free page table */
 		page = phys_to_page(pgt);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		page_table_free_pgste(page);
 	}
 }
@@ -1409,6 +1417,7 @@ static void gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr)
 	/* Free segment table */
 	page = phys_to_page(sgt);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1437,6 +1446,7 @@ static void __gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr,
 		/* Free segment table */
 		page = phys_to_page(sgt);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1467,6 +1477,7 @@ static void gmap_unshadow_r3t(struct gmap *sg, unsigned long raddr)
 	/* Free region 3 table */
 	page = phys_to_page(r3t);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1495,6 +1506,7 @@ static void __gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr,
 		/* Free region 3 table */
 		page = phys_to_page(r3t);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1525,6 +1537,7 @@ static void gmap_unshadow_r2t(struct gmap *sg, unsigned long raddr)
 	/* Free region 2 table */
 	page = phys_to_page(r2t);
 	list_del(&page->lru);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 }
 
@@ -1557,6 +1570,7 @@ static void __gmap_unshadow_r1t(struct gmap *sg, unsigned long raddr,
 		/* Free region 2 table */
 		page = phys_to_page(r2t);
 		list_del(&page->lru);
+		page->_pt_s390_gaddr = 0;
 		__free_pages(page, CRST_ALLOC_ORDER);
 	}
 }
@@ -1762,9 +1776,9 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
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
@@ -1814,6 +1828,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned long saddr, unsigned long r2t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -1846,9 +1861,9 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
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
@@ -1898,6 +1913,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned long saddr, unsigned long r3t,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -1930,9 +1946,9 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
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
@@ -1982,6 +1998,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned long saddr, unsigned long sgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	__free_pages(page, CRST_ALLOC_ORDER);
 	return rc;
 }
@@ -2014,9 +2031,9 @@ int gmap_shadow_pgt_lookup(struct gmap *sg, unsigned long saddr,
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
@@ -2054,9 +2071,9 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
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
@@ -2101,6 +2118,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
+	page->_pt_s390_gaddr = 0;
 	page_table_free_pgste(page);
 	return rc;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 3fc9e680f174..2616d64c0e8c 100644
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
2.39.2

