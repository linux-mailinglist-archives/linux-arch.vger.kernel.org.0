Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24216BA6A4
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjCOFPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjCOFPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCDA1ACFF;
        Tue, 14 Mar 2023 22:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yd+AtF2yaSW+xFWRTFWRTibzPJkXOZuPq6P0eIAoL8o=; b=E7wCVp6Av4GD+zoZ7c/7S3/z7v
        PqwgtPzVyguptcupNJIssZCLUPLp5Xw+CuqWT+4cXLmYW8Q1ctUd3oUeLnOLNBjKQff7JvkJJyAXV
        rxp3gOKcK5YxVsb0uSj2xHh49BmvUoa7kRqXBVCnPmdW9FVFt65+c/Wi0GQqp7avqmgLCiNAIf8g9
        asA7o7ZAWgPz0K1pzc/drQlelkUazhsDQYKSiy+8VVS0RsELplplySzgwbYax53YpqLDJgZzme7VG
        H7V02ate6ZbGczXZ4FDoY3Y3daTqxK7TM/vm0+oBBTPiIDjjnN8qk1zrU9Y7d6rU3ko33cD+9Qu3f
        9c2el6XQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTM-00DYBv-3Q; Wed, 15 Mar 2023 05:14:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v4 15/36] microblaze: Implement the new page table range API
Date:   Wed, 15 Mar 2023 05:14:23 +0000
Message-Id: <20230315051444.3229621-16-willy@infradead.org>
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

Rename PFN_SHIFT_OFFSET to PTE_PFN_SHIFT.  Change the calling
convention for set_pte() to be the same as other architectures.  Add
update_mmu_cache_range(), flush_icache_pages() and flush_dcache_folio().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
index d1b8272abcd9..19fcd7f8517e 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -230,12 +230,12 @@ extern unsigned long empty_zero_page[1024];
 
 #define pte_page(x)		(mem_map + (unsigned long) \
 				((pte_val(x) - memory_start) >> PAGE_SHIFT))
-#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+#define PTE_PFN_SHIFT		PAGE_SHIFT
 
-#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
+#define pte_pfn(x)		(pte_val(x) >> PTE_PFN_SHIFT)
 
 #define pfn_pte(pfn, prot) \
-	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) | pgprot_val(prot))
+	__pte(((pte_basic_t)(pfn) << PTE_PFN_SHIFT) | pgprot_val(prot))
 
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
2.39.2

