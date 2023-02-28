Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7486C6A6177
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjB1Vih (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjB1ViF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC8F3403B;
        Tue, 28 Feb 2023 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ohh0hBicoR9cEJC1f0QXvtIvk3E2NGoKfRsPDD6eKkI=; b=C4l9hofg4rXftyXEerYvPHhQWb
        dfQB5LKm+FDa6C47uGBFnFC3zM3BryxXu8sj/gjDOY2O+D49YhfYWpVTZxEV/shabx37cO1Dva5zN
        D3mCsa9NIAKTpB7OrGAFf8e+244BialSZcSfy1ocAy27AG1DniLnfMQPg8aRpFWr/OMM6UK1Mkpxv
        W0As55hUkjr87Ho6l/vHOgFkeKR8CsjU1Un3j625SmEIZ3v+hTCZK+nvQnTAQOlaNV29QcYwvG8zF
        YfTNGdH3SPPddEAtGGWqWC+fugeAGBF4tEhu7ueNcMRAbblnJOP5ra5PWDQ3HUsUpBnaOyHqPvSza
        PlHdlyag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fH-0018oU-J8; Tue, 28 Feb 2023 21:37:39 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/34] mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
Date:   Tue, 28 Feb 2023 21:37:04 +0000
Message-Id: <20230228213738.272178-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Tell the page table check how many PTEs & PFNs we want it to check.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm64/include/asm/pgtable.h |  2 +-
 arch/riscv/include/asm/pgtable.h |  2 +-
 arch/x86/include/asm/pgtable.h   |  2 +-
 include/linux/page_table_check.h | 14 +++++++-------
 mm/page_table_check.c            | 14 ++++++++------
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b6ba466e2e8a..69765dc697af 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -358,7 +358,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	page_table_check_pte_set(mm, addr, ptep, pte);
+	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
 	return __set_pte_at(mm, addr, ptep, pte);
 }
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index ab05f892d317..b516f3b59616 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -459,7 +459,7 @@ static inline void __set_pte_at(struct mm_struct *mm,
 static inline void set_pte_at(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep, pte_t pteval)
 {
-	page_table_check_pte_set(mm, addr, ptep, pteval);
+	page_table_check_ptes_set(mm, addr, ptep, pteval, 1);
 	__set_pte_at(mm, addr, ptep, pteval);
 }
 
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 7425f32e5293..84be3e07b112 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1022,7 +1022,7 @@ static inline pud_t native_local_pudp_get_and_clear(pud_t *pudp)
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t pte)
 {
-	page_table_check_pte_set(mm, addr, ptep, pte);
+	page_table_check_ptes_set(mm, addr, ptep, pte, 1);
 	set_pte(ptep, pte);
 }
 
diff --git a/include/linux/page_table_check.h b/include/linux/page_table_check.h
index 01e16c7696ec..ba269c7009e4 100644
--- a/include/linux/page_table_check.h
+++ b/include/linux/page_table_check.h
@@ -20,8 +20,8 @@ void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
 				  pmd_t pmd);
 void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 				  pud_t pud);
-void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte);
+void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr);
 void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd);
 void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
@@ -73,14 +73,14 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm,
 	__page_table_check_pud_clear(mm, addr, pud);
 }
 
-static inline void page_table_check_pte_set(struct mm_struct *mm,
+static inline void page_table_check_ptes_set(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep,
-					    pte_t pte)
+					    pte_t pte, unsigned int nr)
 {
 	if (static_branch_likely(&page_table_check_disabled))
 		return;
 
-	__page_table_check_pte_set(mm, addr, ptep, pte);
+	__page_table_check_ptes_set(mm, addr, ptep, pte, nr);
 }
 
 static inline void page_table_check_pmd_set(struct mm_struct *mm,
@@ -138,9 +138,9 @@ static inline void page_table_check_pud_clear(struct mm_struct *mm,
 {
 }
 
-static inline void page_table_check_pte_set(struct mm_struct *mm,
+static inline void page_table_check_ptes_set(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep,
-					    pte_t pte)
+					    pte_t pte, unsigned int nr)
 {
 }
 
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index 25d8610c0042..e6f4d40caaa2 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -184,20 +184,22 @@ void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
-void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
-				pte_t *ptep, pte_t pte)
+void __page_table_check_ptes_set(struct mm_struct *mm, unsigned long addr,
+				pte_t *ptep, pte_t pte, unsigned int nr)
 {
+	unsigned int i;
+
 	if (&init_mm == mm)
 		return;
 
-	__page_table_check_pte_clear(mm, addr, *ptep);
+	for (i = 0; i < nr; i++)
+		__page_table_check_pte_clear(mm, addr, ptep[i]);
 	if (pte_user_accessible_page(pte)) {
-		page_table_check_set(mm, addr, pte_pfn(pte),
-				     PAGE_SIZE >> PAGE_SHIFT,
+		page_table_check_set(mm, addr, pte_pfn(pte), nr,
 				     pte_write(pte));
 	}
 }
-EXPORT_SYMBOL(__page_table_check_pte_set);
+EXPORT_SYMBOL(__page_table_check_ptes_set);
 
 void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
 				pmd_t *pmdp, pmd_t pmd)
-- 
2.39.1

