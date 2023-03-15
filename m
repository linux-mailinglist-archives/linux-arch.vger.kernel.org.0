Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96566BA6B1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjCOFPU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EF29162;
        Tue, 14 Mar 2023 22:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WGsuNHgtl7K1C/He2s/0y/Zy8SWDFoeWCMIkXDsJXwc=; b=NTzMM1J4/IOtu3QL2QKZxx9SKf
        FvKHZglkg/V+OAw7jgJhs6IUh8sugb4N02CL92wx+DlNtMbZam+4QFkhz1JXS9AXyos0D/MP5S0x+
        CmClNweLA/k7ogci4CxD2XEyNx9LEMpNvjMiq6U2qBz+xGRCblWEZePIbFNxjONv86bEBYsZtlH9O
        izF3K8+37JP3Y3fCMyQspB1ZbnCOtAi1KmMyVxSaugIgdyV+sfv3Ss/PxBK41WncGTxAqrbdWk+2V
        we2BJPqaAKgpN4MRk0uhZbee0ESqhOXmAO1md8iW2FED3dYnzG12wd/ydj6l64pbxfxvlX4bbiIky
        82Sw2grw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTK-00DYAr-Eo; Wed, 15 Mar 2023 05:14:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/36] mm: Convert page_table_check_pte_set() to page_table_check_ptes_set()
Date:   Wed, 15 Mar 2023 05:14:09 +0000
Message-Id: <20230315051444.3229621-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 0bd18de9fd97..9428748f4691 100644
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
index 15ae4d6ba476..1031025730d0 100644
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
2.39.2

