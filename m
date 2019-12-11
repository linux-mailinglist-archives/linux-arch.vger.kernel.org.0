Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C309611AAE9
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfLKMbz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfLKMbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ms24ZH5KSAe8YqglSclvMlUcqKf59iwRs7IAhQbihiw=; b=l1m7Gu9a4Q2E3VAhtFH0Vp6pEx
        7EKYlfQaoYSG5yxKZAShvCgoRjLQLsCVedrCySOZcv6m5VGUW/XMk4JyEIv+2kdPEoFbrZBhEmU8/
        sWx5LLMB2Ga23SlgeQXhLty27LpTfHyB27BJYG9fH0adgzixITKepoNnnkINnwB8yaevGHnAQbFL3
        Py5E6bYHv7SO0HuoKwzAv1DtGWUwjCu2q1YuH6L4xT82EeEC9n9gMLQBk+3m7oamydC1AagQQynhU
        n0o5I6r+eRnMLPrTGoDkI2fSRDgs5EURT1qY7MZkiJl+4Zh1PcEwBoNz5PAFyBp/H8FH+rZvIszY3
        u223hRVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0001Pa-Lc; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6C323061E6;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3FD7920137CB6; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.227316370@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 10/17] sparc32/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
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

Because Sparc32 has non-page based page directories, use a custom
table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/Kconfig                  |    1 +
 arch/sparc/include/asm/pgalloc_32.h |    7 +++++--
 arch/sparc/mm/srmmu.c               |   28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -57,6 +57,7 @@ config SPARC32
 	select CLZ_TAB
 	select HAVE_UID16
 	select OLD_SIGACTION
+	select MMU_GATHER_TABLE_FREE
 
 config SPARC64
 	def_bool 64BIT
--- a/arch/sparc/include/asm/pgalloc_32.h
+++ b/arch/sparc/include/asm/pgalloc_32.h
@@ -12,6 +12,9 @@
 
 struct page;
 
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int idx);
+extern void __tlb_remove_table(void *table);
+
 void *srmmu_get_nocache(int size, int align);
 void srmmu_free_nocache(void *addr, int size);
 
@@ -48,7 +51,7 @@ static inline void free_pmd_fast(pmd_t *
 }
 
 #define pmd_free(mm, pmd)		free_pmd_fast(pmd)
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
+#define __pmd_free_tlb(tlb, pmd, addr)	pgtable_free_tlb((tlb), (pmd), 1)
 
 void pmd_populate(struct mm_struct *mm, pmd_t *pmdp, struct page *ptep);
 #define pmd_pgtable(pmd) pmd_page(pmd)
@@ -72,6 +75,6 @@ static inline void free_pte_fast(pte_t *
 #define pte_free_kernel(mm, pte)	free_pte_fast(pte)
 
 void pte_free(struct mm_struct * mm, pgtable_t pte);
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, addr)	pgtable_free_tlb((tlb), (pte), 0)
 
 #endif /* _SPARC_PGALLOC_H */
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -38,6 +38,7 @@
 #include <asm/page.h>
 #include <asm/asi.h>
 #include <asm/smp.h>
+#include <asm/tlb.h>
 #include <asm/io.h>
 
 /* Now the cpu specific definitions. */
@@ -1849,3 +1850,30 @@ void __init load_mmu(void)
 		sun4m_init_smp();
 #endif
 }
+
+#define TLB_IDX_MASK	1UL
+
+void __tlb_remove_table(void *table)
+{
+	void *dir = (void *)((unsigned long)table & ~TLB_IDX_MASK);
+	int idx = (unsigned long)table & TLB_IDX_MASK;
+
+	switch (idx) {
+	case 1: /* PMD */
+		pmd_free(NULL, dir);
+		break;
+	case 0: /* PTE */
+		pte_free(NULL, dir);
+		break;
+	}
+}
+
+void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int idx)
+{
+	unsigned long pgf = (unsigned long)table;
+	BUG_ON(idx > TLB_IDX_MASK);
+	BUG_ON(pgf & TLB_IDX_MASK);
+	pgf |= idx;
+	tlb_remove_table(tlb, (void *)pgf);
+}
+


