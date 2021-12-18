Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FDD479C2E
	for <lists+linux-arch@lfdr.de>; Sat, 18 Dec 2021 19:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhLRSxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Dec 2021 13:53:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:47180 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhLRSxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 18 Dec 2021 13:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
        Content-Type; bh=CUK8G9h0txM8jg4Wz5XNPXV2nob8NVpfVEBWSB3/xEU=; b=OIU36YHibQgf
        TDfD6o7/it4Px2shvKg7iSEUx59OCAjQlPuA31Rn6zjj9sGqwswHK3L/UyiypKWaL3ff3+wiO9BvG
        z5909AfCcIelZ4EQGEW2uV1Uvqqccttotd11JD8MWYcPIcs6nq1m9DY5MNfXBY7Xlq1+vbDgWMDMn
        YJxXQ=;
Received: from [192.168.15.79] (helo=cobook.home)
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <nikita.yushchenko@virtuozzo.com>)
        id 1myepD-003qf7-O5; Sat, 18 Dec 2021 21:52:55 +0300
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, kernel@openvz.org
Subject: [PATCH/RFC v2 1/3] tlb: mmu_gather: introduce CONFIG_MMU_GATHER_TABLE_FREE_COMMON
Date:   Sat, 18 Dec 2021 21:52:04 +0300
Message-Id: <20211218185205.1744125-2-nikita.yushchenko@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
References: <20211218185205.1744125-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For architectures that use free_page_and_swap_cache() as their
__tlb_remove_table(), place that common implementation into
mm/mmu_gather.c, ifdef'ed by CONFIG_MMU_GATHER_TABLE_FREE_COMMON.

Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
---
 arch/Kconfig                 |  3 +++
 arch/arm/Kconfig             |  1 +
 arch/arm/include/asm/tlb.h   |  5 -----
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/tlb.h |  5 -----
 arch/x86/Kconfig             |  1 +
 arch/x86/include/asm/tlb.h   | 14 --------------
 include/asm-generic/tlb.h    |  5 +++++
 mm/mmu_gather.c              | 10 ++++++++++
 9 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d3c4ab249e9c..9eba553cd86f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -415,6 +415,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
 config MMU_GATHER_TABLE_FREE
 	bool
 
+config MMU_GATHER_TABLE_FREE_COMMON
+	bool
+
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
 	select MMU_GATHER_TABLE_FREE
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c2724d986fa0..cc272e1ad12c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -110,6 +110,7 @@ config ARM
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
+	select MMU_GATHER_TABLE_FREE_COMMON
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index b8cbe03ad260..9d9b21649ca0 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -29,11 +29,6 @@
 #include <linux/swap.h>
 #include <asm/tlbflush.h>
 
-static inline void __tlb_remove_table(void *_table)
-{
-	free_page_and_swap_cache((struct page *)_table);
-}
-
 #include <asm-generic/tlb.h>
 
 static inline void
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..0f99f30d99f6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,7 @@ config ARM64
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select MMU_GATHER_RCU_TABLE_FREE
+	select MMU_GATHER_TABLE_FREE_COMMON
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index c995d1f4594f..401826260a5c 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -11,11 +11,6 @@
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 
-static inline void __tlb_remove_table(void *_table)
-{
-	free_page_and_swap_cache((struct page *)_table);
-}
-
 #define tlb_flush tlb_flush
 static void tlb_flush(struct mmu_gather *tlb);
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..379d6832d3de 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -235,6 +235,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE		if PARAVIRT
+	select MMU_GATHER_TABLE_FREE_COMMON
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 1bfe979bb9bc..96e3b4f922c9 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -23,18 +23,4 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
 }
 
-/*
- * While x86 architecture in general requires an IPI to perform TLB
- * shootdown, enablement code for several hypervisors overrides
- * .flush_tlb_others hook in pv_mmu_ops and implements it by issuing
- * a hypercall. To keep software pagetable walkers safe in this case we
- * switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the comment
- * below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h
- * for more details.
- */
-static inline void __tlb_remove_table(void *table)
-{
-	free_page_and_swap_cache(table);
-}
-
 #endif /* _ASM_X86_TLB_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..877431da21cf 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -158,6 +158,11 @@
  *  Useful if your architecture doesn't use IPIs for remote TLB invalidates
  *  and therefore doesn't naturally serialize with software page-table walkers.
  *
+ *  MMU_GATHER_TABLE_FREE_COMMON
+ *
+ *  Provide default implementation of __tlb_remove_table() based on
+ *  free_page_and_swap_cache().
+ *
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 1b9837419bf9..eb2f30a92462 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -93,6 +93,13 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 #ifdef CONFIG_MMU_GATHER_TABLE_FREE
 
+#ifdef CONFIG_MMU_GATHER_TABLE_FREE_COMMON
+static inline void __tlb_remove_table(void *table)
+{
+	free_page_and_swap_cache((struct page *)table);
+}
+#endif
+
 static void __tlb_remove_table_free(struct mmu_table_batch *batch)
 {
 	int i;
@@ -132,6 +139,9 @@ static void __tlb_remove_table_free(struct mmu_table_batch *batch)
  * pressure. To guarantee progress we fall back to single table freeing, see
  * the implementation of tlb_remove_table_one().
  *
+ * This is also used to keep software pagetable walkers safe when architecture
+ * natively uses IPIs for TLB flushes, but hypervisor enablement code replaced
+ * that by issuing a hypercall.
  */
 
 static void tlb_remove_table_smp_sync(void *arg)
-- 
2.30.2

