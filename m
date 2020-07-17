Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19E4223A23
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgGQLOo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGQLOn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39D6C061755;
        Fri, 17 Jul 2020 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nUUfhERBps7kvabI82RVV43naTK71jo6AAVltGUbW/s=; b=tp/BH55Z/QaPl4II/4kpXNcQdv
        XDl6UXJmW/vuilqUj195qptQ8vI7Xjlkz+6fvZRtbA3aih5li6rf3HtArbX12fyCj3oHtV5B5n4x9
        pcc8tGMTIGSttnHzrRfWW0GvzPzKr+OYzu71OrB+gClwoAs8q2snBYoiufgmW5vPb/O0n7oS/VgLp
        1NhQGSuISW5KYKcEhffZD+fJUGtlP066i0gESEXqxUnAkm4l8RznaZm0krzFJi3a2czVK2nIuw55x
        OboZwga/+8b43D0SyvxLOGCPFwZjTAjdlw36TvLSKt/cw886FL9tjZ2hH7WNnF1cGZeJlxfAKWDZY
        wt8k6hUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-00051O-Og; Fri, 17 Jul 2020 11:14:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86B813074D4;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D4590203D409A; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111350.001250805@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/11] m68k/tlb: Fix __p*_free_tlb()
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

The Motorola MMU has funny PMD stuff, so use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/m68k/Kconfig                        |    1 +
 arch/m68k/include/asm/mcf_pgalloc.h      |   14 ++++++--------
 arch/m68k/include/asm/motorola_pgalloc.h |   10 ++++++----
 arch/m68k/mm/motorola.c                  |   17 +++++++++++++++++
 4 files changed, 30 insertions(+), 12 deletions(-)

--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -32,6 +32,7 @@ config M68K
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
 	select MMU_GATHER_NO_RANGE if MMU
+	select MMU_GATHER_TABLE_FREE if MMU_MOTOROLA
 
 config CPU_BIG_ENDIAN
 	def_bool y
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -34,14 +34,12 @@ extern inline pmd_t *pmd_alloc_kernel(pg
 
 #define pmd_pgtable(pmd) pfn_to_virt(pmd_val(pmd) >> PAGE_SHIFT)
 
-static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
-				  unsigned long address)
-{
-	struct page *page = virt_to_page(pgtable);
-
-	pgtable_pte_page_dtor(page);
-	__free_page(page);
-}
+#define __pte_free_tlb(tlb, pgtable, addr)		\
+do {							\
+	struct page *page = virt_to_page(pgtable);	\
+	pgtable_pte_page_dtor(page);			\
+	tlb_remove_page((tlb), page);			\
+} while (0)
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
--- a/arch/m68k/include/asm/motorola_pgalloc.h
+++ b/arch/m68k/include/asm/motorola_pgalloc.h
@@ -14,6 +14,8 @@ enum m68k_table_types {
 	TABLE_PTE = 1,
 };
 
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int type);
+extern void __tlb_remove_table(void *table);
 extern void init_pointer_table(void *table, int type);
 extern void *get_pointer_table(int type);
 extern int free_pointer_table(void *table, int type);
@@ -47,7 +49,7 @@ static inline void pte_free(struct mm_st
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pgtable,
 				  unsigned long address)
 {
-	free_pointer_table(pgtable, TABLE_PTE);
+	pgtable_free_tlb(tlb, pgtable, TABLE_PTE);
 }
 
 
@@ -61,10 +63,10 @@ static inline int pmd_free(struct mm_str
 	return free_pointer_table(pmd, TABLE_PMD);
 }
 
-static inline int __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
-				 unsigned long address)
+static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
+				  unsigned long address)
 {
-	return free_pointer_table(pmd, TABLE_PMD);
+	pgtable_free_tlb(tlb, pmd, TABLE_PMD);
 }
 
 
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -215,6 +215,23 @@ int free_pointer_table(void *table, int
 	return 0;
 }
 
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int type)
+{
+	unsigned long ptr = (unsigned long)table;
+	BUG_ON(type > 1);
+	BUG_ON(ptr  & 1);
+	ptr |= type;
+	tlb_remove_table(tlb, (void *)ptr);
+}
+
+void __tlb_remove_table(void *table)
+{
+	int type = (unsigned long)table & 1;
+	table = (void *)((unsigned long)table & ~1);
+
+	free_pointer_table(table, type);
+}
+
 /* size of memory already mapped in head.S */
 extern __initdata unsigned long m68k_init_mapped_size;
 


