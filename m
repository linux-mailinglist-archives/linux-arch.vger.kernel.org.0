Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9576D14F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjHBPOb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjHBPOT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A652D6A;
        Wed,  2 Aug 2023 08:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5otL2xfi5fq8beqcNQO018MOMk9VZAnogawmcQkO95A=; b=W9UdzekKdA4eNBMudYVz4/3g59
        eFMFALpM104qYTLYM3rs/SU/i4NE8rLpF7TKGXeBJ/H7hsL3eblOQjHX/wwFdSitbk5kgfTH0ijy3
        Q5zhEC9UeW+wWJgexOrM+ndfv/tCsTOOfejOmyj4Uw1mK8YV6ShnWWhKRd8uCiAcq/0OPX//HRByZ
        AA72KqfC4oIWt+KiHcehLjK7+QmMJcl+qaTRfRpBCcqIkkg1ofYbMjFMdgx2AcUhXRw4LUvbwtTB0
        PE0kPwYjf4pflBECZryuEsv97ccMioO81DH+r3PO25wFt397UVl+sst7znklIhzsRRP0RTFZ+rEta
        QO4KxADA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffie-3z; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 02/38] mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
Date:   Wed,  2 Aug 2023 16:13:30 +0100
Message-Id: <20230802151406.3735276-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tell the page table check how many PTEs & PFNs we want it to check.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/x86/include/asm/pgtable.h   |  2 +-
 include/linux/page_table_check.h | 13 +++++++------
 mm/page_table_check.c            | 16 +++++++++-------
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index fe4b913589ee..445b18d7a47c 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -348,7 +348,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	page_table_check_pte_set(mm, ptep, pte);
+	page_table_check_ptes_set(mm, ptep, pte, 1);
 	return __set_pte_at(mm, addr, ptep, pte);
 }
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 44377f0d7c35..01e4aabc8898 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -499,7 +499,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
 static inline void set_pte_at(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep, pte_t pteval)
 {
-	page_table_check_pte_set(mm, ptep, pteval);
+	page_table_check_ptes_set(mm, ptep, pteval, 1);
 	__set_pte_at(mm, addr, ptep, pteval);
 }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index ada1bbf12961..cd0b6337d03c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1023,7 +1023,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	page_table_check_pte_set(mm, ptep, pte);
+	page_table_check_ptes_set(mm, ptep, pte, 1);
 	set_pte(ptep, pte);
 }
 
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 7f6b9bf926c5..6722941c7cb8 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -17,7 +17,8 @@ void __page_table_check_zero(struct page *page, unsigned int order);
 void __page_table_check_pte_clear(struct mm_struct *mm, pte_t pte);
 void __page_table_check_pmd_clear(struct mm_struct *mm, pmd_t pmd);
 void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud);
-void __page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep, pte_t pte);
+void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
+		unsigned int nr);
 void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd);
 void __page_table_check_pud_set(struct mm_struct *mm, pud_t *pudp, pud_t pud);
 void __page_table_check_pte_clear_range(struct mm_struct *mm,
@@ -64,13 +65,13 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 	__page_table_check_pud_clear(mm, pud);
 }
 
-static inline void page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep,
-					    pte_t pte)
+static inline void page_table_check_ptes_set(struct mm_struct *mm,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
 	if (static_branch_likely(&page_table_check_disabled))
 		return;
 
-	__page_table_check_pte_set(mm, ptep, pte);
+	__page_table_check_ptes_set(mm, ptep, pte, nr);
 }
 
 static inline void page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp,
@@ -123,8 +124,8 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 {
 }
 
-static inline void page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep,
-					    pte_t pte)
+static inline void page_table_check_ptes_set(struct mm_struct *mm,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 46e77c12c81e..af69c3c8f7c2 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -182,18 +182,20 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
-void __page_table_check_pte_set(struct mm_struct *mm, pte_t *ptep, pte_t pte)
+void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
+		unsigned int nr)
 {
+	unsigned int i;
+
 	if (&init_mm == mm)
 		return;
 
-	__page_table_check_pte_clear(mm, ptep_get(ptep));
-	if (pte_user_accessible_page(pte)) {
-		page_table_check_set(pte_pfn(pte), PAGE_SIZE >> PAGE_SHIFT,
-				     pte_write(pte));
-	}
+	for (i = 0; i < nr; i++)
+		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
+	if (pte_user_accessible_page(pte))
+		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
-EXPORT_SYMBOL(__page_table_check_pte_set);
+EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
 {
-- 
2.40.1

