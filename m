Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5380D223A19
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQLOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQLOi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF6EC061755;
        Fri, 17 Jul 2020 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fCoot8j0cWA9ciC5yvURdWvuq4otc5g+z9FwRrkMqPI=; b=i1mn0vBQKBaNacLXDfsoK+7QG6
        g0aa0ADr+4bhdnmt9IAIw4EPzJLymoj2ob/Pya5sBqVBjtTrLs5vxWkeWzIq7rGnfwzBQO0abZ1Uj
        BuR8IUQ0Ml0ePeFrjIt+l0gsm+yIU4UoeY5S/I68dX4EeXb+RtLM/VFN4c/WB11lJSyBJ/1GN29F3
        yGhK/yyH5IZPFpfHrT6WRUl9WY0rbD0MfUTCczycRrvJeXpzl0OT0EXN7kuPWC6KR61BCLR5PDDTJ
        8OmSei+N/7sTQS1KghadHxTFf1CdjVubg7GAgPWtYzeluEq1AZ7yh7NnFu/4QSNEOEyQqJLXEsnwH
        dBXDZN6w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJb-0001eW-7I; Fri, 17 Jul 2020 11:14:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E5B3304B90;
        Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B515C203D4093; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.591934380@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:09 +0200
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
Subject: [PATCH v2 04/11] sparc32/tlb: Fix __p*_free_tlb()
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
 
 #define pmd_populate(mm, pmd, pte)	pmd_set(pmd, pte)
 #define pmd_pgtable(pmd)		(pgtable_t)__pmd_page(pmd)
@@ -73,6 +76,6 @@ static inline void free_pte_fast(pte_t *
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
@@ -1831,3 +1832,30 @@ void __init load_mmu(void)
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


