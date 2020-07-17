Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41B7223A30
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgGQLPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgGQLOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7945C08C5DD;
        Fri, 17 Jul 2020 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=gOQYLPqlkXaE5f1BcTQenQfqzoyHPAVuIDnigWhSoRE=; b=Y/MXDI0tbjGV1H6k+/3UUA8Lu5
        zcG4hZO3jyz9bLcRi2dIJysN79dO3dnN/J6fbvIK4gxxQiyBlOKQuuCn0E4ddYCbGpPOTo3VVtlki
        b8indkgQ/FVRbEsFBMBPCZcy3KunV3UanWjKfz3yzA2GvqjF7q6418pyW6NM0aW8XTHtuYN9wNG74
        sxLzg+HiCTzpnr/zc2fq3XNvfm31YDJdhEXKopYgPN6tBPKbu/nVWCyNI6khi3A9VUpNMTP2aF7eI
        3elFTvXbPIuOkzZ1J7mS4tlF7nVaUtIA8IAJ8rLPZMHlzNolSp/mIGsc5xtO6SOhkwzpM6jWmaDOb
        UHPdiS5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-0001Zn-LT; Fri, 17 Jul 2020 11:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F914306CCF;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C0DDF203D4095; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.708289813@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:11 +0200
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
Subject: [PATCH v2 06/11] mips/tlb: Fix __p*_free_tlb()
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

MIPS has (thanks to Paul Burton for setting me straight):

 - HAVE_FAST_GUP, which means we need to consider software
   walkers (many MIPS also have software TLB-fill, which is a similar
   software walker).

 - non-page, page directories, which requires a custom table free.

 - Mostly IPI-based TLB invalidate, but it wouldn't be MIPS if it
   didn't also have broadcast TLB invalidate (I6500, GINVT).

This means that in generic MIPS needs HAVE_RCU_TABLE_FREE.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/include/asm/pgalloc.h |   13 ++++++-------
 arch/mips/mm/pgtable.c          |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -84,6 +84,7 @@ config MIPS
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if 64BIT || !SMP
 	select IRQ_FORCED_THREADING
 	select ISA if EISA
+	select MMU_GATHER_RCU_TABLE_FREE
 	select MODULES_USE_ELF_REL if MODULES
 	select MODULES_USE_ELF_RELA if MODULES && 64BIT
 	select PERF_USE_VMALLOC
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -41,6 +41,9 @@ static inline void pud_populate(struct m
 }
 #endif
 
+extern void __tlb_remove_table(void *table);
+extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int idx);
+
 /*
  * Initialize a new pgd / pmd table with invalid pointers.
  */
@@ -52,11 +55,7 @@ static inline void pgd_free(struct mm_st
 	free_pages((unsigned long)pgd, PGD_ORDER);
 }
 
-#define __pte_free_tlb(tlb,pte,address)			\
-do {							\
-	pgtable_pte_page_dtor(pte);			\
-	tlb_remove_page((tlb), pte);			\
-} while (0)
+#define __pte_free_tlb(tlb,pte,address)	pgtable_free_tlb((tlb), (pte), 0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
@@ -75,7 +74,7 @@ static inline void pmd_free(struct mm_st
 	free_pages((unsigned long)pmd, PMD_ORDER);
 }
 
-#define __pmd_free_tlb(tlb, x, addr)	pmd_free((tlb)->mm, x)
+#define __pmd_free_tlb(tlb, x, addr)	pgtable_free_tlb((tlb), (x), 1)
 
 #endif
 
@@ -101,7 +100,7 @@ static inline void p4d_populate(struct m
 	set_p4d(p4d, __p4d((unsigned long)pud));
 }
 
-#define __pud_free_tlb(tlb, x, addr)	pud_free((tlb)->mm, x)
+#define __pud_free_tlb(tlb, x, addr)	pgtable_free_tlb((tlb), (x), 2)
 
 #endif /* __PAGETABLE_PUD_FOLDED */
 
--- a/arch/mips/mm/pgtable.c
+++ b/arch/mips/mm/pgtable.c
@@ -7,6 +7,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <asm/pgalloc.h>
+#include <asm-generic/tlb.h>
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
@@ -23,3 +24,36 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pgd_alloc);
+
+#define TLB_IDX_MASK	0x3
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
+void __tlb_remove_table(void *table)
+{
+	void *dir = (void *)((unsigned long)table & ~TLB_IDX_MASK);
+	int idx = (unsigned long)table & TLB_IDX_MASK;
+
+	switch (idx) {
+#ifndef __PAGETABLE_PUD_FOLDED
+	case 2: /* PUD */
+		pud_free(NULL, dir);
+		break;
+#endif
+#ifndef __PAGETABLE_PMD_FOLDED
+	case 1: /* PMD */
+		pmd_free(NULL, dir);
+		break;
+#endif
+	case 0: /* PTE */
+		pte_free(NULL, dir);
+		break;
+	}
+}


