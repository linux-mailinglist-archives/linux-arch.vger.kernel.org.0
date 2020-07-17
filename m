Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CA5223A1E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgGQLOl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgGQLOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE45DC08C5DC;
        Fri, 17 Jul 2020 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FUm1Ir3tUJJdB8qdXiVgRoT6pMrHP/Au+B6bLpG9yBA=; b=nyyWe7AlZtYdYSw49Sonwdxz2r
        KoQtTILVvXgJriLvasWk1Jh78FRgv6TwvxgW9OfTZnHOfpDdp0XRGhHkROr9M0rS8EE1ZWERqEZCb
        B4aLODSSNLN9BuP9VeeCsJRd1lCzDfSXB1o9kJN9xYbsbwUPyglN+NaEeeHEdZoR+6xv56usNBrAg
        E4M1ALbe2VwlUOwGw0TtgdLJDkOPtGYvMUB7f/nq3raSnihsty8lX4VKZGHH7eb7vSNthUAW4d0m3
        ClYXcabVNTdqUwUgL5MxtmMU6aZva1lf7kQ0POZDK3bIv1gmVVtN3QMYW68wBEeJlpSJOR+/z2oJT
        H3PPqaIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-0001Zl-Hw; Fri, 17 Jul 2020 11:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1525F305E21;
        Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A9E9E203D408E; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.417688532@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:06 +0200
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
Subject: [PATCH v2 01/11] asm-generic/tlb: Fix MMU_GATHER_TABLE_FREE
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The first MMU_GATHER_TABLE_FREE user showed a logic error in the
tlb_needs_table_invalidate() definition. Make sure any TABLE_FREE has
it defined.

Fixes: 0d6e24d430ef ("asm-generic/tlb: provide MMU_GATHER_TABLE_FREE")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -172,6 +172,18 @@
  *  various ptep_get_and_clear() functions.
  */
 
+#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+
+/*
+ * Only RCU table free can override this; otherwise the TLBI is needed to
+ * provide existence guarantees for software walkers.
+ */
+#ifdef tlb_needs_table_invalidate
+#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
+#endif
+
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+
 #ifdef CONFIG_MMU_GATHER_TABLE_FREE
 
 struct mmu_table_batch {
@@ -187,17 +199,6 @@ struct mmu_table_batch {
 
 extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
-#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
-
-/*
- * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
- * page directories and we can use the normal page batching to free them.
- */
-#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
-
-#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
-
-#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * This allows an architecture that does not use the linux page-tables for
  * hardware to skip the TLBI when freeing page tables.
@@ -206,13 +207,15 @@ extern void tlb_remove_table(struct mmu_
 #define tlb_needs_table_invalidate() (true)
 #endif
 
-#else
+#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
 
-#ifdef tlb_needs_table_invalidate
-#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
-#endif
+/*
+ * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have page based
+ * page directories and we can use the normal page batching to free them.
+ */
+#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
 
-#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+#endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
 
 #ifndef CONFIG_MMU_GATHER_NO_GATHER


