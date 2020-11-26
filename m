Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409412C53B8
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbgKZMMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 07:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388957AbgKZMMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Nov 2020 07:12:20 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53024C0613D4;
        Thu, 26 Nov 2020 04:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=nQU58GhLv/YhL/CnKMq9LOU9L3P5zbRnBo0bVoBpllY=; b=g9Z7CJbvq8z03P119GJb3YyqLg
        EmSmlqKMxmwXOCV7tCdZuyjLYQPU5qUympPmdeuxtiEm0rOtIm9inAnRenSzxFpnWXgwnkvecQg3a
        9dX374bP5qWuOT1pAdIuwkrJXczu8C22p9JnORdA1jfjWLyRJ9WjGN+Y+465HKmQQiE2dO4J2Teb4
        vQ12Y+Mu8CinRUeFi+s6o4+po9G9z/A5d1CiajtXnPLZ+7/c0xcSlj6eUhtBgtDN9A9mg+ziYc785
        P2+Z1x+nIqUruVx92DW5XbwR2jxv1oZNuaVYJ2Rd18r+mTkKMGSHoRfOcvjKDfEVxkbw+0t2cYM5Q
        UUzCmQ+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiG7d-0006MA-HD; Thu, 26 Nov 2020 12:11:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 31D753070AB;
        Thu, 26 Nov 2020 13:11:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E988C200E74B0; Thu, 26 Nov 2020 13:11:33 +0100 (CET)
Message-ID: <20201126121121.036370527@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 26 Nov 2020 13:01:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org
Subject: [PATCH v2 1/6] mm/gup: Provide gup_get_pte() more generic
References: <20201126120114.071913521@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In order to write another lockless page-table walker, we need
gup_get_pte() exposed. While doing that, rename it to
ptep_get_lockless() to match the existing ptep_get() naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h |   55 +++++++++++++++++++++++++++++++++++++++++++++
 mm/gup.c                |   58 ------------------------------------------------
 2 files changed, 56 insertions(+), 57 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -258,6 +258,61 @@ static inline pte_t ptep_get(pte_t *ptep
 }
 #endif
 
+#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
+/*
+ * WARNING: only to be used in the get_user_pages_fast() implementation.
+ *
+ * With get_user_pages_fast(), we walk down the pagetables without taking any
+ * locks.  For this we would like to load the pointers atomically, but sometimes
+ * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
+ * we do have is the guarantee that a PTE will only either go from not present
+ * to present, or present to not present or both -- it will not switch to a
+ * completely different present page without a TLB flush in between; something
+ * that we are blocking by holding interrupts off.
+ *
+ * Setting ptes from not present to present goes:
+ *
+ *   ptep->pte_high = h;
+ *   smp_wmb();
+ *   ptep->pte_low = l;
+ *
+ * And present to not present goes:
+ *
+ *   ptep->pte_low = 0;
+ *   smp_wmb();
+ *   ptep->pte_high = 0;
+ *
+ * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
+ * We load pte_high *after* loading pte_low, which ensures we don't see an older
+ * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
+ * picked up a changed pte high. We might have gotten rubbish values from
+ * pte_low and pte_high, but we are guaranteed that pte_low will not have the
+ * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
+ * operates on present ptes we're safe.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte;
+
+	do {
+		pte.pte_low = ptep->pte_low;
+		smp_rmb();
+		pte.pte_high = ptep->pte_high;
+		smp_rmb();
+	} while (unlikely(pte.pte_low != ptep->pte_low));
+
+	return pte;
+}
+#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+/*
+ * We require that the PTE can be read atomically.
+ */
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	return ptep_get(ptep);
+}
+#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #ifndef __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2079,62 +2079,6 @@ static void put_compound_head(struct pag
 	put_page(page);
 }
 
-#ifdef CONFIG_GUP_GET_PTE_LOW_HIGH
-
-/*
- * WARNING: only to be used in the get_user_pages_fast() implementation.
- *
- * With get_user_pages_fast(), we walk down the pagetables without taking any
- * locks.  For this we would like to load the pointers atomically, but sometimes
- * that is not possible (e.g. without expensive cmpxchg8b on x86_32 PAE).  What
- * we do have is the guarantee that a PTE will only either go from not present
- * to present, or present to not present or both -- it will not switch to a
- * completely different present page without a TLB flush in between; something
- * that we are blocking by holding interrupts off.
- *
- * Setting ptes from not present to present goes:
- *
- *   ptep->pte_high = h;
- *   smp_wmb();
- *   ptep->pte_low = l;
- *
- * And present to not present goes:
- *
- *   ptep->pte_low = 0;
- *   smp_wmb();
- *   ptep->pte_high = 0;
- *
- * We must ensure here that the load of pte_low sees 'l' IFF pte_high sees 'h'.
- * We load pte_high *after* loading pte_low, which ensures we don't see an older
- * value of pte_high.  *Then* we recheck pte_low, which ensures that we haven't
- * picked up a changed pte high. We might have gotten rubbish values from
- * pte_low and pte_high, but we are guaranteed that pte_low will not have the
- * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
- * operates on present ptes we're safe.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	pte_t pte;
-
-	do {
-		pte.pte_low = ptep->pte_low;
-		smp_rmb();
-		pte.pte_high = ptep->pte_high;
-		smp_rmb();
-	} while (unlikely(pte.pte_low != ptep->pte_low));
-
-	return pte;
-}
-#else /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-/*
- * We require that the PTE can be read atomically.
- */
-static inline pte_t gup_get_pte(pte_t *ptep)
-{
-	return ptep_get(ptep);
-}
-#endif /* CONFIG_GUP_GET_PTE_LOW_HIGH */
-
 static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
 					    unsigned int flags,
 					    struct page **pages)
@@ -2160,7 +2104,7 @@ static int gup_pte_range(pmd_t pmd, unsi
 
 	ptem = ptep = pte_offset_map(&pmd, addr);
 	do {
-		pte_t pte = gup_get_pte(ptep);
+		pte_t pte = ptep_get_lockless(ptep);
 		struct page *head, *page;
 
 		/*


