Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29506BA6A2
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCOFPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCOFPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2737523A54;
        Tue, 14 Mar 2023 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kYj+qH1/7tSlgOsrYtaH9bSHy1IP4XWRsGSUxqRkHdw=; b=qCXSPv+75+CZqxylF5+9tiMWXb
        QUPFEm/uOKR8S+KHFCVONuqmgQrens6os069ChSrooiIRS9f5rxzkyGLUSk/MZYVcRUOh6MV2V7Z0
        qer/Cjb1yxa/DMCzHV5SR234J8FlMvpWzn2UT0qPNx2AR/TGRiU2FoIiVGotwI4w34DCRkaAEKjij
        CChK9b6ELKvMw2K/DnQwRkvBuVmdBOZbFWrwilne9ogqHbz2VUJ7fAwZlBEbEdkkAlZbI4JQ03Y2D
        PPww1Dcby4qBwBeLYqY1fxrtY6fTphNabVIbFZBzUTaY+EpXYXYL8u/1kFb5L3QAEm4Q8r1SBBPjA
        +S2Z8bkg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTL-00DYBY-Kj; Wed, 15 Mar 2023 05:14:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 11/36] hexagon: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:19 +0000
Message-Id: <20230315051444.3229621-12-willy@infradead.org>
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

Add PFN_PTE_SHIFT and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Brian Cain <bcain@quicinc.com>
---
 arch/hexagon/include/asm/cacheflush.h | 7 +++++--
 arch/hexagon/include/asm/pgtable.h    | 9 +--------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index 6eff0730e6ef..63ca314ede89 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -58,12 +58,15 @@ extern void flush_cache_all_hexagon(void);
  * clean the cache when the PTE is set.
  *
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-					unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr)
 {
 	/*  generic_ptrace_pokedata doesn't wind up here, does it?  */
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
+
 void copy_to_user_page(struct vm_area_struct *vma, struct page *page,
 		       unsigned long vaddr, void *dst, void *src, int len);
 #define copy_to_user_page copy_to_user_page
diff --git a/arch/hexagon/include/asm/pgtable.h b/arch/hexagon/include/asm/pgtable.h
index 59393613d086..dd05dd71b8ec 100644
--- a/arch/hexagon/include/asm/pgtable.h
+++ b/arch/hexagon/include/asm/pgtable.h
@@ -338,6 +338,7 @@ static inline int pte_exec(pte_t pte)
 /* __swp_entry_to_pte - extract PTE from swap entry */
 #define __swp_entry_to_pte(x) ((pte_t) { (x).val })
 
+#define PFN_PTE_SHIFT	PAGE_SHIFT
 /* pfn_pte - convert page number and protection value to page table entry */
 #define pfn_pte(pfn, pgprot) __pte((pfn << PAGE_SHIFT) | pgprot_val(pgprot))
 
@@ -345,14 +346,6 @@ static inline int pte_exec(pte_t pte)
 #define pte_pfn(pte) (pte_val(pte) >> PAGE_SHIFT)
 #define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
 
-/*
- * set_pte_at - update page table and do whatever magic may be
- * necessary to make the underlying hardware/firmware take note.
- *
- * VM may require a virtual instruction to alert the MMU.
- */
-#define set_pte_at(mm, addr, ptep, pte) set_pte(ptep, pte)
-
 static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 {
 	return (unsigned long)__va(pmd_val(pmd) & PAGE_MASK);
-- 
2.39.2

