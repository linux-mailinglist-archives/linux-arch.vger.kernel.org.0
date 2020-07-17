Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A9223A28
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGQLO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgGQLOn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFAFC08C5C0;
        Fri, 17 Jul 2020 04:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=S8UknOxkHjh+fFZ6g8rERXF5PzCEDpVIPOf+v6XVy+E=; b=a6jjRyXa8+VsSAkTLZRRukYqZ6
        sF/rHVHvFgmcHZ2kQMPhnZVqjNxs1t3wZduvAlgEeZGgwwjdyIUHL1XjV8vRf25apeRy8T0u0LBDL
        WBzFUF7pYu0sRdQU48yeiTjaXuGdmTVZ+CPQW/fszXLSP1O1C4kwFvK6FW6X+83ZOVVAumaU/qsE2
        Z6fLJzH0bMeObAvJKwRGuKb1rn4oZeuKUjav1U2XCxVVdcYjh4wSShDvK7dQlYkNx2IOcY+q30M+P
        lir3rDJY5+14N+MhQ4r2ZdXZ8OdOFXwxGx/7flyn0th+WbXNKxKO7MjGmpiVAHad8XlBsgfFatTfB
        PUxtEjHg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-00051I-1P; Fri, 17 Jul 2020 11:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BB553060C5;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC664203D4094; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.650029395@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:10 +0200
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
Subject: [PATCH v2 05/11] parisc/tlb: Fix __p*_free_tlb()
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

Because PARISC has non-page-size PMDs, use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/Kconfig               |    1 +
 arch/parisc/include/asm/pgalloc.h |   23 ++++++++++++++++++++---
 arch/parisc/include/asm/tlb.h     |    9 +++++----
 3 files changed, 26 insertions(+), 7 deletions(-)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -63,6 +63,7 @@ config PARISC
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_COPY_THREAD_TLS
+	select MMU_GATHER_TABLE_FREE if PGTABLE_LEVELS >= 3
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -73,7 +73,7 @@ static inline pmd_t *pmd_alloc_one(struc
 	return pmd;
 }
 
-static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+static inline bool __pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
 		/*
@@ -83,11 +83,28 @@ static inline void pmd_free(struct mm_st
 		 * done by generic mm code.
 		 */
 		mm_inc_nr_pmds(mm);
-		return;
+		return false;
 	}
-	free_pages((unsigned long)pmd, PMD_ORDER);
+	return true;
+}
+
+static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
+{
+	if (__pmd_free(mm, pmd))
+		free_pages((unsigned long)pmd, PMD_ORDER);
 }
 
+static inline void __tlb_remove_table(void *table)
+{
+	free_pages((unsigned long)table, PMD_ORDER);
+}
+
+#define __pmd_free_tlb(tlb, pmd, addr)		\
+do {						\
+	if (__pmd_free((tlb)->mm, (pmd)))	\
+		tlb_remove_table((tlb), (pmd));	\
+} while (0)
+
 #endif
 
 static inline void
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -4,9 +4,10 @@
 
 #include <asm-generic/tlb.h>
 
-#if CONFIG_PGTABLE_LEVELS == 3
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
-#endif
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb,pte,addr)			\
+do {							\
+	pgtable_pte_page_dtor(pte);			\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 #endif


