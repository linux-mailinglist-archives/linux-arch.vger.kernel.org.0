Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC1E311AAEB
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfLKMcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:32:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbfLKMb6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jViyJyc27KPeg0UifOYoPRTZbieI85V/fY78N3x1I9Q=; b=SBq4aNiEimiVT923ThYU5T1BWY
        1WNnRyNYHvP1B55z03gtpKtRHJrKE3sDnwyC18/WB2fa0c5zoyj7LRl1xxxuH96nlcXzvKUozyFBQ
        mMNNucnRFKyqNGv6M4ytMrNGLAOfH6CBHfZvSuR6lCMu4KyI9xagC5pKzO8do81f2ZOlvGuEMp5Kn
        GEdrD4AlyxqDBgDNVVTr9+yIUK+01uWon5q2BFxFAjACCOnhnIqnB7C7ff1U0F8OOeD8Lb9NJqNWp
        3WHFrNTCKMuDW6Af4PkXTSSefss8rQ+YyYORfzaadXfM/l9DDICk9KCGu6VUN1Y3iV+fRJ5Ua9GKm
        RvNrOqMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0003sm-AO; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB92F306BB9;
        Wed, 11 Dec 2019 13:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4206520137CB5; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.285169327@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:24 +0100
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
Subject: [PATCH 11/17] parisc/tlb: Fix __p*_free_tlb()
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

Because PARISC has non-page-size PMDs, use a custom table freeer.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/parisc/Kconfig               |    1 +
 arch/parisc/include/asm/pgalloc.h |   25 ++++++++++++++++++++++---
 arch/parisc/include/asm/tlb.h     |    7 +++++--
 3 files changed, 28 insertions(+), 5 deletions(-)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -62,6 +62,7 @@ config PARISC
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
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
 #else
 
 /* Two Level Page Table Support for pmd's */
@@ -101,6 +118,8 @@ static inline void pmd_free(struct mm_st
 #define pmd_free(mm, x)			do { } while (0)
 #define pgd_populate(mm, pmd, pte)	BUG()
 
+#define __pmd_free_tlb(tlb, pmd, addr)	do { } while (0)
+
 #endif
 
 static inline void
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -4,7 +4,10 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tlb)->mm, pmd)
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb,pte,addr)			\
+do {							\
+	pgtable_pte_page_dtor(pte);			\
+	tlb_remove_page((tlb), (pte));			\
+} while (0)
 
 #endif


