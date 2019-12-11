Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1957711AADA
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfLKMb1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51020 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfLKMb0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wcM6hHyLxjZAtwtLpkncfN6HnampEr2pkXBPL1E/TmU=; b=oZmgj+/Pkg+g0RJKKS5g+ihq3R
        uDsRRT0AoQJzUjVUL1pYLVCx9BCVk6XY7gfyAccgOh0Ej2lIztN0dKreB7jWSjuCXi7lMgCqGYrZG
        TgHTpm8ThK53nuiRUySztt4P6zXFrMXByN/wVS2YAGGPDza88P+ZkBLbyjlarLL31MjrUG4Xi4d2P
        3gRHKJJ0ONAaBM+sDXaCNUhOuKvoXcKxp/QfnXJuhBCiiBWDPz23iC/GBnr8ajUDU2TBou+cOWr6I
        skKWWLLaYR1bVdUG/z7iSmslwrnfDxXILIkd2T7gny36JqS2b4OQrlFcUhQwS7n66geYcSSJy3qw9
        ZcKWqiGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if191-0001PZ-LC; Wed, 11 Dec 2019 12:31:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82AA8305FFF;
        Wed, 11 Dec 2019 13:29:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2757D20137CAF; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122955.883347160@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:17 +0100
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
Subject: [PATCH 04/17] asm-generic/tlb: Rename HAVE_RCU_TABLE_FREE
References: <20191211120713.360281197@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig               |    2 +-
 arch/arm/Kconfig           |    2 +-
 arch/arm/include/asm/tlb.h |    2 +-
 arch/arm64/Kconfig         |    2 +-
 arch/powerpc/Kconfig       |    4 ++--
 arch/s390/Kconfig          |    2 +-
 arch/sparc/Kconfig         |    4 ++--
 arch/x86/Kconfig           |    2 +-
 arch/x86/include/asm/tlb.h |    4 ++--
 include/asm-generic/tlb.h  |   10 +++++-----
 mm/gup.c                   |    2 +-
 mm/mmu_gather.c            |    8 ++++----
 12 files changed, 22 insertions(+), 22 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -393,7 +393,7 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_ARCH_JUMP_LABEL_RELATIVE
 	bool
 
-config HAVE_RCU_TABLE_FREE
+config MMU_GATHER_RCU_TABLE_FREE
 	bool
 
 config HAVE_RCU_TABLE_NO_INVALIDATE
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -101,7 +101,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE if SMP && ARM_LPAE
+	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -37,7 +37,7 @@ static inline void __tlb_remove_table(vo
 
 #include <asm-generic/tlb.h>
 
-#ifndef CONFIG_HAVE_RCU_TABLE_FREE
+#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 #define tlb_remove_table(tlb, entry) tlb_remove_page(tlb, entry)
 #endif
 
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -161,7 +161,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_FUNCTION_ARG_ACCESS_API
-	select HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -222,8 +222,8 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE		if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE	if HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE		if SMP
+	select HAVE_RCU_TABLE_NO_INVALIDATE	if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -168,7 +168,7 @@ config S390
 	select HAVE_OPROFILE
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
-	select HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,8 +64,8 @@ config SPARC64
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
-	select HAVE_RCU_TABLE_FREE if SMP
-	select HAVE_RCU_TABLE_NO_INVALIDATE if HAVE_RCU_TABLE_FREE
+	select MMU_GATHER_RCU_TABLE_FREE if SMP
+	select HAVE_RCU_TABLE_NO_INVALIDATE if MMU_GATHER_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -200,7 +200,7 @@ config X86
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_FUNCTION_ARG_ACCESS_API
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -29,8 +29,8 @@ static inline void tlb_flush(struct mmu_
  * shootdown, enablement code for several hypervisors overrides
  * .flush_tlb_others hook in pv_mmu_ops and implements it by issuing
  * a hypercall. To keep software pagetable walkers safe in this case we
- * switch to RCU based table free (HAVE_RCU_TABLE_FREE). See the comment
- * below 'ifdef CONFIG_HAVE_RCU_TABLE_FREE' in include/asm-generic/tlb.h
+ * switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the comment
+ * below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
  * for more details.
  */
 static inline void __tlb_remove_table(void *table)
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -126,7 +126,7 @@
  *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
- *  HAVE_RCU_TABLE_FREE
+ *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
  *  for page directores (__p*_free_tlb()). This provides separate freeing of
@@ -139,9 +139,9 @@
  *
  *  HAVE_RCU_TABLE_NO_INVALIDATE
  *
- *  This makes HAVE_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
+ *  This makes MMU_GATHER_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
  *  freeing the page-table pages. This can be avoided if you use
- *  HAVE_RCU_TABLE_FREE and your architecture does _NOT_ use the Linux
+ *  MMU_GATHER_RCU_TABLE_FREE and your architecture does _NOT_ use the Linux
  *  page-tables natively.
  *
  *  MMU_GATHER_NO_RANGE
@@ -149,7 +149,7 @@
  *  Use this if your architecture lacks an efficient flush_tlb_range().
  */
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 /*
  * Semi RCU freeing of the page directories.
  *
@@ -227,7 +227,7 @@ extern bool __tlb_remove_page_size(struc
 struct mmu_gather {
 	struct mm_struct	*mm;
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	struct mmu_table_batch	*batch;
 #endif
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1729,7 +1729,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
  * Before activating this code, please be aware that the following assumptions
  * are currently made:
  *
- *  *) Either HAVE_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
+ *  *) Either MMU_GATHER_RCU_TABLE_FREE is enabled, and tlb_remove_table() is used to
  *  free pages containing page tables or TLB flushing requires IPI broadcast.
  *
  *  *) ptes can be read atomically by the architecture.
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,7 +91,7 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 
 /*
  * See the comment near struct mmu_table_batch.
@@ -173,11 +173,11 @@ void tlb_remove_table(struct mmu_gather
 		tlb_table_flush(tlb);
 }
 
-#endif /* CONFIG_HAVE_RCU_TABLE_FREE */
+#endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
 #ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
@@ -220,7 +220,7 @@ void tlb_gather_mmu(struct mmu_gather *t
 	tlb->batch_count = 0;
 #endif
 
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
 #ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE


