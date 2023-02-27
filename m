Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76866A48CC
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjB0R6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjB0R54 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:57:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A726224498;
        Mon, 27 Feb 2023 09:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jco2/brYdWe0hU6YkAHAWSfRYtcsxYQg52X9PqtqDX0=; b=ltONIFmGp2DL+cwnqaDAtcnTF7
        yZr9xg5m9G/HNIelkbXZt2N7Euxuzfpo4qmALcQ5ECJs4EiYndJZmi1vr7HlIyQ8WiMBDh+xtgUJk
        w6T5tJ3XhoYOT+/SxiJoJRVzYOTqXzjfOOfsY67/FqNBpsGzTSkIBApq1UJeUlXT4J+iXmRWkVKWv
        kT7NZjGS7yWHUI7xWMHZ7AkjSJ69dU/gsFulUF7QL3UuhK+UTYQK8h24WGtakSKwttfXo1GnVJDZZ
        GatgVC5/3PeSvKXMUrgd/xhvE9ze64jgEBPIvcAsPnAw0LRmlBt8PP5/98dvRjrrKrPxPVlhzfmwc
        pPTM0pwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhku-000IXY-OL; Mon, 27 Feb 2023 17:57:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Subject: [PATCH v2 13/30] microblaze: Implement the new page table range API
Date:   Mon, 27 Feb 2023 17:57:24 +0000
Message-Id: <20230227175741.71216-14-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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
Cc: Michal Simek <monstr@monstr.eu>
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

