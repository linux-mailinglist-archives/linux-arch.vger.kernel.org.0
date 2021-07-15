Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF83CA015
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhGONx1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGONx1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:53:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D161C06175F;
        Thu, 15 Jul 2021 06:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F0uHGnaKYlt+4Ccxjip6cwGR1WaebuCnkA/cVWUYbK0=; b=aHD2N0CpQApz1uEx3wNPk8vTYq
        wWEkWxaMX4sVd4gm5TJ1Q3HAXnv5x/7xG93pGVbr+CQV1VrB6Xk/BbpbvPOOGDS+jOwKZFfL5D269
        d6z1j8ZSzf+QfX4D8/1nr4XXfqfyWJupUouTrF6R92Ug5xrdHNjat4j97tDJwnxqok7n+txBCGqgy
        40ZUdS4twDwiHV4rdjIBvJO01ILL3BgHSox9GBqo3zOhnW650SL71Ly124E4TxFkGrr1kJPHqgQo3
        NmdFNCfqELAWZUdncJ7SCcqnw6jV4kWVMcqW3GXmG9SR4G2zB28LF3SGcWtQmPNCaYnemPjVWZKc5
        84Yd3XyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m41jB-003Ooe-QF; Thu, 15 Jul 2021 13:48:56 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] parisc: Rename PMD_ORDER to PMD_TABLE_ORDER
Date:   Thu, 15 Jul 2021 14:46:12 +0100
Message-Id: <20210715134612.809280-4-willy@infradead.org>
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
 arch/parisc/include/asm/pgalloc.h | 6 +++---
 arch/parisc/include/asm/pgtable.h | 4 ++--
 arch/parisc/mm/init.c             | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 6a7e98e71f1d..54b63374579b 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -48,15 +48,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
 {
 	pmd_t *pmd;
 
-	pmd = (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_ORDER);
+	pmd = (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_TABLE_ORDER);
 	if (likely(pmd))
-		memset ((void *)pmd, 0, PAGE_SIZE << PMD_ORDER);
+		memset ((void *)pmd, 0, PAGE_SIZE << PMD_TABLE_ORDER);
 	return pmd;
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
-	free_pages((unsigned long)pmd, PMD_ORDER);
+	free_pages((unsigned long)pmd, PMD_TABLE_ORDER);
 }
 #endif
 
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 43937af127b1..7badd872f05a 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -112,7 +112,7 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #define KERNEL_INITIAL_SIZE	(1 << KERNEL_INITIAL_ORDER)
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define PMD_ORDER	1
+#define PMD_TABLE_ORDER	1
 #define PGD_ORDER	0
 #else
 #define PGD_ORDER	1
@@ -131,7 +131,7 @@ static inline void purge_tlb_entries(struct mm_struct *mm, unsigned long addr)
 #define PMD_SHIFT       (PLD_SHIFT + BITS_PER_PTE)
 #define PMD_SIZE	(1UL << PMD_SHIFT)
 #define PMD_MASK	(~(PMD_SIZE-1))
-#define BITS_PER_PMD	(PAGE_SHIFT + PMD_ORDER - BITS_PER_PMD_ENTRY)
+#define BITS_PER_PMD	(PAGE_SHIFT + PMD_TABLE_ORDER - BITS_PER_PMD_ENTRY)
 #define PTRS_PER_PMD    (1UL << BITS_PER_PMD)
 #else
 #define BITS_PER_PMD	0
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 591a4e939415..3f7d6d5b56ac 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -378,8 +378,8 @@ static void __init map_pages(unsigned long start_vaddr,
 
 #if CONFIG_PGTABLE_LEVELS == 3
 		if (pud_none(*pud)) {
-			pmd = memblock_alloc(PAGE_SIZE << PMD_ORDER,
-					     PAGE_SIZE << PMD_ORDER);
+			pmd = memblock_alloc(PAGE_SIZE << PMD_TABLE_ORDER,
+					     PAGE_SIZE << PMD_TABLE_ORDER);
 			if (!pmd)
 				panic("pmd allocation failed.\n");
 			pud_populate(NULL, pud, pmd);
-- 
2.30.2

