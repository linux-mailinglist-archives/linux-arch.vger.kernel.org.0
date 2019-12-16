Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B573120962
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfLPPOt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 10:14:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39690 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfLPPOt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 10:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OKHXrTNATjlZPXKhcr313DE+lD5SFuoyRf5oQQ183G4=; b=tVhRtrRsKOrNTCSxwvYLUoNIS
        +ggKDfrOswfQ1JsLUBvEainE8YPI83zMh27ejNyuSPo6qXKMS2ju9Wm45e884AZO4e0Km7rJ1oArt
        uvhWwGx30LMavadamqPi1MMRV0F/riLtYSTpm2D+Ir2Hg5lv+Mf8tkxylguGpzSZHaOwka85GeUA4
        VgmuvehS0vALlk9Z8TQwe9CMPVk0ulrjGTpIzCOceNEfxlGpa2rJC7Yn0tluC4pKEcIx/nQVSredi
        hRovz6Cub9Hff0rtVbpqfFcwKsMyn1D9Hz0PS7pNnKXrrCmTiRNw3MrmI4Q4I/hUdZndiP58KS13u
        Bn7hb69pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igs4k-000204-Bl; Mon, 16 Dec 2019 15:14:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A46E300F29;
        Mon, 16 Dec 2019 16:12:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E7EB2B2A00EB; Mon, 16 Dec 2019 16:14:19 +0100 (CET)
Date:   Mon, 16 Dec 2019 16:14:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
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
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
Message-ID: <20191216151419.GL2871@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
 <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
 <33ed03aa-a34c-3a81-0f83-20c3e8d4eff7@linux.ibm.com>
 <20191216145041.GG2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216145041.GG2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 03:50:41PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 07:24:24PM +0530, Aneesh Kumar K.V wrote:
> 
> > So __p*_free_tlb() routines on ppc64 just mark that we need a page walk
> > cache flush and the actual flush in done in tlb_flush_mmu.
> 
> Not quite, your __p*_free_tlb() goes to pgtable_free_tlb() which call
> tlb_remove_table().
> 
> > As per
> > 
> > d86564a2f085b79ec046a5cba90188e61235280 (mm/tlb, x86/mm: Support
> > invalidating TLB caches for RCU_TABLE_FREE ) that is not sufficient?
> 
> 96bc9567cbe1 ("asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE")
> 
> And no. Since you have TABLE_NO_INVALIDATE set, tlb_remove_table() will
> not TLBI when it fails to allocate a batch page, which is an error for
> PPC-Radix.
> 
> There is also no TLBI when the batch page is full and the RCU callback
> happens, which is also a bug on PPC-Radix.

It seems to me you need something like this here patch, all you need to
add is a suitable definition of tlb_needs_table_invalidate() for Power.

---

diff --git a/arch/Kconfig b/arch/Kconfig
index c44ef15866a3..98de654b79b3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -400,10 +400,6 @@ config MMU_GATHER_RCU_TABLE_FREE
 	bool
 	select MMU_GATHER_TABLE_FREE
 
-config MMU_GATHER_NO_TABLE_INVALIDATE
-	bool
-	depends on MMU_GATHER_RCU_TABLE_FREE
-
 config MMU_GATHER_PAGE_SIZE
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3dea4c8d39f2..2ddf24822d5b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,6 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if SMP
-	select MMU_GATHER_NO_TABLE_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a76e915ab207..acf20b6c0a54 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -66,7 +66,6 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select MMU_GATHER_RCU_TABLE_FREE if SMP
-	select MMU_GATHER_NO_TABLE_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index a2f3fa61ee36..ac8e74a96122 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -28,6 +28,12 @@ void flush_tlb_pending(void);
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 #define tlb_flush(tlb)	flush_tlb_pending()
 
+/*
+ * SPARC64's hardware TLB fill does not use the Linux page-tables
+ * and therefore we don't need a TLBI when freeing page-table pages.
+ */
+#define tlb_needs_table_invalidate()	(false)
+
 #include <asm-generic/tlb.h>
 
 #endif /* _SPARC64_TLB_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fe0ea6ff3636..4108d6d18ca5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -156,13 +156,6 @@
  *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
  *  and therefore doesn't naturally serialize with software page-table walkers.
  *
- *  MMU_GATHER_NO_TABLE_INVALIDATE
- *
- *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly()
- *  before freeing the page-table pages. This can be avoided if you use
- *  MMU_GATHER_RCU_TABLE_FREE and your architecture does _NOT_ use the Linux
- *  page-tables natively.
- *
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
@@ -203,6 +196,24 @@ extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+
+/*
+ * This allows an architecture that does not use the linux page-tables for
+ * hardware to skip the TLBI when freeing page tables.
+ */
+#ifndef tlb_needs_table_invalidate
+#define tlb_needs_table_invalidate() (true)
+#endif
+
+#else
+
+#ifdef tlb_needs_table_invalidate
+#error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
+#endif
+
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
+
 #ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 9d103031568d..a3538cb2bcbe 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -177,14 +177,14 @@ static void tlb_remove_table_free(struct mmu_table_batch *batch)
  */
 static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 {
-#ifndef CONFIG_MMU_GATHER_NO_TABLE_INVALIDATE
-	/*
-	 * Invalidate page-table caches used by hardware walkers. Then we still
-	 * need to RCU-sched wait while freeing the pages because software
-	 * walkers can still be in-flight.
-	 */
-	tlb_flush_mmu_tlbonly(tlb);
-#endif
+	if (tlb_needs_table_invalidate()) {
+		/*
+		 * Invalidate page-table caches used by hardware walkers. Then
+		 * we still need to RCU-sched wait while freeing the pages
+		 * because software walkers can still be in-flight.
+		 */
+		tlb_flush_mmu_tlbonly(tlb);
+	}
 }
 
 static void tlb_remove_table_one(void *table)
