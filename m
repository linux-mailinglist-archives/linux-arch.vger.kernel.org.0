Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3015E698545
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 21:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjBOUJg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 15:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjBOUJe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 15:09:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F592384F
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 12:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=J8/1q6frBYGwgbqjjavZ1BISvaOhK/l8i4/4YVlRXgY=; b=RLi9F9Xz0A8fF8Tmhtavo1XYMA
        r8Xf+3tOYAmOgF7m74JMcmt6Gx/ie4sI17SorHbeiyt8M7wpxuFdtuv1d2qb1qq/QZyPcElSaUFWu
        rAt8XqS7rSk4QUgE9PT9H9Fey21K9TTAs3G0xx8gxL7ONo1tCBZuctczJUAvO7pBg0mcB35Au0qa8
        fg5e5qJdRkX6zpJHABfbuLcYwMW7PbVdxt2ruX6Lo1yY403QrceexS25viA0WVFbIQhp47/O12c0L
        QV5Xg17GQOzsyh3q1FBMKM8oRWmVLM8IwZ3zorcfVWp0zXiGRdULrrKoczXNiPqD+zf9ywi5oTV++
        /kFO+MFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSO5m-007lAY-V4; Wed, 15 Feb 2023 20:09:26 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Michal Simek <monstr@monstr.eu>,
        linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 16/17] microblaze: Implement the new page table range API
Date:   Wed, 15 Feb 2023 20:09:19 +0000
Message-Id: <20230215200920.1849567-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230215200920.1849567-1-willy@infradead.org>
References: <20230215000446.1655635-1-willy@infradead.org>
 <20230215200920.1849567-1-willy@infradead.org>
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

Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
flush_dcache_folio().  Also change the calling convention for set_pte()
to be the same as other architectures.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/microblaze/include/asm/cacheflush.h |  8 ++++++++
 arch/microblaze/include/asm/pgtable.h    | 17 ++++++++++++-----
 arch/microblaze/include/asm/tlbflush.h   |  4 +++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/include/asm/cacheflush.h b/arch/microblaze/include/asm/cacheflush.h
index 39f8fb6768d8..e6641ff98cb3 100644
--- a/arch/microblaze/include/asm/cacheflush.h
+++ b/arch/microblaze/include/asm/cacheflush.h
@@ -74,6 +74,14 @@ do { \
 	flush_dcache_range((unsigned) (addr), (unsigned) (addr) + PAGE_SIZE); \
 } while (0);
 
+static void flush_dcache_folio(struct folio *folio)
+{
+	unsigned long addr = folio_pfn(folio) << PAGE_SHIFT;
+
+	flush_dcache_range(addr, addr + folio_size(folio));
+}
+#define flush_dcache_folio flush_dcache_folio
+
 #define flush_cache_page(vma, vmaddr, pfn) \
 	flush_dcache_range(pfn << PAGE_SHIFT, (pfn << PAGE_SHIFT) + PAGE_SIZE);
 
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index d1b8272abcd9..a01e1369b486 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -330,18 +330,25 @@ static inline unsigned long pte_update(pte_t *p, unsigned long clr,
 /*
  * set_pte stores a linux PTE into the linux page table.
  */
-static inline void set_pte(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte)
+static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	*ptep = pte;
 }
 
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
 {
-	*ptep = pte;
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += 1 << PFN_SHIFT_OFFSET;
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
 static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep)
diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
index 2038168ed128..1b179e5e9062 100644
--- a/arch/microblaze/include/asm/tlbflush.h
+++ b/arch/microblaze/include/asm/tlbflush.h
@@ -33,7 +33,9 @@ static inline void local_flush_tlb_range(struct vm_area_struct *vma,
 
 #define flush_tlb_kernel_range(start, end)	do { } while (0)
 
-#define update_mmu_cache(vma, addr, ptep)	do { } while (0)
+#define update_mmu_cache_range(vma, addr, ptep, nr)	do { } while (0)
+#define update_mmu_cache(vma, addr, pte) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
 
 #define flush_tlb_all local_flush_tlb_all
 #define flush_tlb_mm local_flush_tlb_mm
-- 
2.39.1

