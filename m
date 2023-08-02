Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252B276D17F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjHBPPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjHBPOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A884F1BFD;
        Wed,  2 Aug 2023 08:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R3CnonFRN2u5W8MlfJcV+Jd6s/k7prD5kgGz6X6tBLU=; b=eJxvofiaiVVpJGOwTLrJBXPqtx
        YeGLbjO+66A9eQXkKLJvSSgGpGRqHqJW2p6xP5A+NnqhKA35wO5us0jNM48rUxepNHyniKc/GQIRF
        T2d8QpgiQwVgyOCyCbWxM8qC7LLIxTlEBe0Bd4+sYNJZUADQTchzH4mMeybT9BDl3bzIvAUky2wzj
        G6IfdyXgo8ZqBkN9o8RGnN1AwC4ASpbysL0Ye6gA88NsKro0G0L8S25Ge4HNFQfZ1WbgEa1RRpxXV
        dGIx765omd7Rb0ty/utbJZ+C/DxmGoH0RyGv6CFLSZDOfpM0+XOp5Z55fUsDy9Djqem48uAhnQ6wy
        ppDtCirw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY9-00Ffjh-KV; Wed, 02 Aug 2023 15:14:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v6 16/38] microblaze: Implement the new page table range API
Date:   Wed,  2 Aug 2023 16:13:44 +0100
Message-Id: <20230802151406.3735276-17-willy@infradead.org>
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

Rename PFN_SHIFT_OFFSET to PTE_PFN_SHIFT.  Change the calling
convention for set_pte() to be the same as other architectures.  Add
update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/include/asm/cacheflush.h |  8 ++++++++
 arch/microblaze/include/asm/pgtable.h    | 15 ++++-----------
 arch/microblaze/include/asm/tlbflush.h   |  4 +++-
 3 files changed, 15 insertions(+), 12 deletions(-)

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
index d1b8272abcd9..6f9b99082518 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -230,12 +230,12 @@ extern unsigned long empty_zero_page[1024];
 
 #define pte_page(x)		(mem_map + (unsigned long) \
 				((pte_val(x) - memory_start) >> PAGE_SHIFT))
-#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+#define PFN_PTE_SHIFT		PAGE_SHIFT
 
-#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
+#define pte_pfn(x)		(pte_val(x) >> PFN_PTE_SHIFT)
 
 #define pfn_pte(pfn, prot) \
-	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) | pgprot_val(prot))
+	__pte(((pte_basic_t)(pfn) << PFN_PTE_SHIFT) | pgprot_val(prot))
 
 #ifndef __ASSEMBLY__
 /*
@@ -330,14 +330,7 @@ static inline unsigned long pte_update(pte_t *p, unsigned long clr,
 /*
  * set_pte stores a linux PTE into the linux page table.
  */
-static inline void set_pte(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte)
-{
-	*ptep = pte;
-}
-
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pte)
+static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	*ptep = pte;
 }
diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/include/asm/tlbflush.h
index 2038168ed128..a31ae9d44083 100644
--- a/arch/microblaze/include/asm/tlbflush.h
+++ b/arch/microblaze/include/asm/tlbflush.h
@@ -33,7 +33,9 @@ static inline void local_flush_tlb_range(struct vm_area_struct *vma,
 
 #define flush_tlb_kernel_range(start, end)	do { } while (0)
 
-#define update_mmu_cache(vma, addr, ptep)	do { } while (0)
+#define update_mmu_cache_range(vmf, vma, addr, ptep, nr) do { } while (0)
+#define update_mmu_cache(vma, addr, pte) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
 #define flush_tlb_all local_flush_tlb_all
 #define flush_tlb_mm local_flush_tlb_mm
-- 
2.40.1

