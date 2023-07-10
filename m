Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC4A74DF81
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGJUoF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGJUn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:43:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDBE6B;
        Mon, 10 Jul 2023 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=5+4G9ihnAATxhE+mN/TPHluvKQf1KT1lzbSAkqtjj8A=; b=l4H0Sp2I2O9RCZTb8AEFCido2i
        /8+Ddvb+sUKF9z6mUxpBDYoYWqmnn4aOWQoC7IexYAgrTe0or6WgViwvP1KZrum7pKC0NOyGJMjKc
        jS3v+NHyWt+f7/mkUsWrCpSYRHNryr7mAx2T4t4pn1KFR9CzjiR8sVoYxSpyp2I8S0LcdEgx28c8P
        FTRsQ/uuPuwZVhuPDfVoBpNPH5Htib4iP2kNco+O4QZOTn2boDt/9vMQrP9jZcj11dptab20jY6Vo
        gIYwsr6sUvBHhjFaYk8ylIhtnJewm+KSd+85pjtQ6UTRdq3blHrsC3Q/rhYDK9ngjZGucFuR3KFwq
        4E6+Do7A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjS-00Euoz-H5; Mon, 10 Jul 2023 20:43:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Brian Cain <bcain@quicinc.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 12/38] hexagon: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:13 +0100
Message-Id: <20230710204339.3554919-13-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add PFN_PTE_SHIFT and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Brian Cain <bcain@quicinc.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/hexagon/include/asm/cacheflush.h | 8 ++++++--
 arch/hexagon/include/asm/pgtable.h    | 9 +--------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/hexagon/include/asm/cacheflush.h b/arch/hexagon/include/asm/cacheflush.h
index 6eff0730e6ef..dc3f500a5a01 100644
--- a/arch/hexagon/include/asm/cacheflush.h
+++ b/arch/hexagon/include/asm/cacheflush.h
@@ -58,12 +58,16 @@ extern void flush_cache_all_hexagon(void);
  * clean the cache when the PTE is set.
  *
  */
-static inline void update_mmu_cache(struct vm_area_struct *vma,
-					unsigned long address, pte_t *ptep)
+static inline void update_mmu_cache_range(struct vm_fault *vmf,
+		struct vm_area_struct *vma, unsigned long address,
+		pte_t *ptep, unsigned int nr)
 {
 	/*  generic_ptrace_pokedata doesn't wind up here, does it?  */
 }
 
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
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

