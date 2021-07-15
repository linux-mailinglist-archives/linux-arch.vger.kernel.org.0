Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48D3CA00B
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbhGONwo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGONwn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:52:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EDC06175F;
        Thu, 15 Jul 2021 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AplXofgFmj6oGBE3wtqK7qdaZsU8n7D/+VR9nSQYob4=; b=n/U2CvWTGD3wXFKQLauXQt7DBo
        Et7YSyxAA6ZOpVc0zh9P+2+cI7HyxO2SkXq5Ce4YSyJqRFxUi3YH0U0hq4tlSg2y920ppqG9kryxi
        go5Dn18LUwLSo7hgSHALSRtdzm/zIsxhbbXHeQZj2SH9fiaB06gF1CFp917qutnLGTp/Ji3vchblg
        gjUbpDErFbGxd/7NiBIeqWaqCth9bCOIEGB+1/RqV02G2i5bjhKOnjRLYwDnzw9+RFMbgyDa0eodn
        8XkSOSg7IVLPNU/TYuOs/Iy6AF3JhNKg7peAy1MzTSKnwTNj8iRVUVZTw3ixylqaFYth8pMmpqCey
        dR7vKokg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m41iH-003Oiz-P4; Thu, 15 Jul 2021 13:47:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mips: Rename PMD_ORDER to PMD_TABLE_ORDER
Date:   Thu, 15 Jul 2021 14:46:11 +0100
Message-Id: <20210715134612.809280-3-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715134612.809280-1-willy@infradead.org>
References: <20210715134612.809280-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the order of the page table allocation, not the order of a PMD.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/mips/include/asm/pgalloc.h    |  2 +-
 arch/mips/include/asm/pgtable-32.h |  2 +-
 arch/mips/include/asm/pgtable-64.h | 18 +++++++++---------
 arch/mips/kernel/asm-offsets.c     |  2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 4b2567d6b2df..795e9e2219c9 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -61,7 +61,7 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 	pmd_t *pmd = NULL;
 	struct page *pg;
 
-	pg = alloc_pages(GFP_KERNEL | __GFP_ACCOUNT, PMD_ORDER);
+	pg = alloc_pages(GFP_KERNEL | __GFP_ACCOUNT, PMD_TABLE_ORDER);
 	if (pg) {
 		pgtable_pmd_page_ctor(pg);
 		pmd = (pmd_t *)page_address(pg);
diff --git a/arch/mips/include/asm/pgtable-32.h b/arch/mips/include/asm/pgtable-32.h
index 95df9c293d8d..8d57bd5b0b94 100644
--- a/arch/mips/include/asm/pgtable-32.h
+++ b/arch/mips/include/asm/pgtable-32.h
@@ -82,7 +82,7 @@ extern int add_temporary_entry(unsigned long entrylo0, unsigned long entrylo1,
 
 #define PGD_ORDER	(__PGD_ORDER >= 0 ? __PGD_ORDER : 0)
 #define PUD_ORDER	aieeee_attempt_to_allocate_pud
-#define PMD_ORDER	aieeee_attempt_to_allocate_pmd
+#define PMD_TABLE_ORDER	aieeee_attempt_to_allocate_pmd
 #define PTE_ORDER	0
 
 #define PTRS_PER_PGD	(USER_PTRS_PER_PGD * 2)
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 41921acdc9d8..ae0d5a09064d 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -51,12 +51,12 @@
 #define PMD_MASK	(~(PMD_SIZE-1))
 
 # ifdef __PAGETABLE_PUD_FOLDED
-# define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+# define PGDIR_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_TABLE_ORDER - 3))
 # endif
 #endif
 
 #ifndef __PAGETABLE_PUD_FOLDED
-#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_ORDER - 3))
+#define PUD_SHIFT	(PMD_SHIFT + (PAGE_SHIFT + PMD_TABLE_ORDER - 3))
 #define PUD_SIZE	(1UL << PUD_SHIFT)
 #define PUD_MASK	(~(PUD_SIZE-1))
 #define PGDIR_SHIFT	(PUD_SHIFT + (PAGE_SHIFT + PUD_ORDER - 3))
@@ -91,13 +91,13 @@
 #  define PGD_ORDER		1
 #  define PUD_ORDER		aieeee_attempt_to_allocate_pud
 # endif
-#define PMD_ORDER		0
+#define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_8KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
-#define PMD_ORDER		0
+#define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_16KB
@@ -107,22 +107,22 @@
 #define PGD_ORDER               0
 #endif
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
-#define PMD_ORDER		0
+#define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_32KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
-#define PMD_ORDER		0
+#define PMD_TABLE_ORDER		0
 #define PTE_ORDER		0
 #endif
 #ifdef CONFIG_PAGE_SIZE_64KB
 #define PGD_ORDER		0
 #define PUD_ORDER		aieeee_attempt_to_allocate_pud
 #ifdef CONFIG_MIPS_VA_BITS_48
-#define PMD_ORDER		0
+#define PMD_TABLE_ORDER		0
 #else
-#define PMD_ORDER		aieeee_attempt_to_allocate_pmd
+#define PMD_TABLE_ORDER		aieeee_attempt_to_allocate_pmd
 #endif
 #define PTE_ORDER		0
 #endif
@@ -132,7 +132,7 @@
 #define PTRS_PER_PUD	((PAGE_SIZE << PUD_ORDER) / sizeof(pud_t))
 #endif
 #ifndef __PAGETABLE_PMD_FOLDED
-#define PTRS_PER_PMD	((PAGE_SIZE << PMD_ORDER) / sizeof(pmd_t))
+#define PTRS_PER_PMD	((PAGE_SIZE << PMD_TABLE_ORDER) / sizeof(pmd_t))
 #endif
 #define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
 
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 04ca75278f02..d6b89080d245 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -198,7 +198,7 @@ void output_mm_defines(void)
 	BLANK();
 	DEFINE(_PGD_ORDER, PGD_ORDER);
 #ifndef __PAGETABLE_PMD_FOLDED
-	DEFINE(_PMD_ORDER, PMD_ORDER);
+	DEFINE(_PMD_TABLE_ORDER, PMD_TABLE_ORDER);
 #endif
 	DEFINE(_PTE_ORDER, PTE_ORDER);
 	BLANK();
-- 
2.30.2

