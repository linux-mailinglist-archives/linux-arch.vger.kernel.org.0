Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E2C11AAE7
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbfLKMbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfLKMbo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kmci9S6AR0FYTskb+05odp4dpXOL68/q4robJqM04t0=; b=WrnTBGtoDFlccGkA5QZK9j0uWw
        57DBHjQs0S/lsu1PhmhB9IFpejHbtD9kJq7MeSq8LN4BazpDPoWGfZgdkZid6plViTf+3YXazhJfu
        VZOZo2nvohUmKhR9bOufnk25W2mgUeXw5Tfo7KFJfoRIwMOfddpM5oPxw6nA9kwv6owTz/y4qRZ8E
        tnbT0r8MQDL8luI0zqxoflw/kl3Q0PeOEXULKaQURxxxtYHg7wZqt2vrofd2zT0vljXj+RbcexQWz
        1nYzsUwh7KcGVspUYsRZVZh2ms+UsnKRtgHlhQtz2bdo4U9wjvzXJrCMPmQtQw1R8ZzLhOaPooP6D
        nt7poLqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if193-0001Pj-2S; Wed, 11 Dec 2019 12:31:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0A57306CBC;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4BA3120137CBA; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.399804770@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:26 +0100
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 13/17] mips/tlb: Fix __p*_free_tlb()
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

MIPS has (thanks to Paul Burton for setting me straight):

 - HAVE_FAST_GUP, which means we need to consider software
   walkers (many MIPS also have software TLB-fill, which is a similar
   software walker).

 - non-page, page directories, which requires a custom table free.

 - Mostly IPI-based TLB invalidate, but it wouldn't be MIPS if it
   didn't also have broadcast TLB invalidate (I6500, GINVT).

This means that in generic MIPS needs HAVE_RCU_TABLE_FREE.

Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/mips/Kconfig               |    1 +
 arch/mips/include/asm/pgalloc.h |   13 ++++++-------
 arch/mips/mm/pgtable.c          |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -57,6 +57,7 @@ config MIPS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
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


