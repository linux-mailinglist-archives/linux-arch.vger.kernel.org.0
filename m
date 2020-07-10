Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B12D21ACCB
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgGJB5T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJB5S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38CC08C5CE;
        Thu,  9 Jul 2020 18:57:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so1934679pjb.4;
        Thu, 09 Jul 2020 18:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwlS2eNc8vtjJo38rH8WFlY5uoSZAGkDAN86Mc6lWmM=;
        b=rv3GE2kpv1OMNOx7Gg42lPkqGYaz8TTcpmrNLLpgTJ2g9M9KmS0E2/T2ZtT4HUrOmS
         SJPJQyNeczMWkZ8TlM6ck2j6CMvDn2Iih1ANCcgrcGJonxEXn+d4U4Ogir+2q354pYpK
         thcgTy0C84Gh4dWLLAFV98cyCv/B+ERj12XjLvCWIRJGGCT4UFZoNo4VRL4SvJjiaGNg
         Onh31lMgnddgZTADgiZWIpPUWVlpqZBTOEvWkMydEHtlMH55zmD01cRcDY1f4BlTCv/h
         9+2yB+IET97VVC2mCihWfPnXOxoralR+34zB/qmLD5U/wBUrm9lhn4BtTNh9ODI0WH6G
         WklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwlS2eNc8vtjJo38rH8WFlY5uoSZAGkDAN86Mc6lWmM=;
        b=iBVVnltaDcWShbGUFPqIJ5Nr5fgW/f5HemO3oRb8rijo98MP9sHHJ9E9xIDgrJo/ST
         UR84mAf+j7iNZ5KZYpQ5sl0XenxTytFrBXBAK5DAFU2TmStaFLvV57AB5siyUkaYTFKX
         YhvT00RhX09I7Av6mui1ShuuUj4it4rhJL7bjpIWaTBNs+on296CfAauJ6q8u0c1tB6g
         n/w3VT+5FlzlaGegLG+qqqMBbitkA/AZGwOXAnoWfSSJWUheGA1j1dygH+KOOh4/f3jw
         pNbtGuQmZIBBwJvuxPg0hcMn564GiWuSuRGk2ILWuZl2oL16pjU8W9bpUos9g6S6UlTy
         L7LA==
X-Gm-Message-State: AOAM532n4xJgBwAFz0PHHljlyQLHLIjBaByZv9H+7+cf4fWZm5xzMsgn
        TqpkTS9zpKtdl8f3TW06VCAMWd+Y
X-Google-Smtp-Source: ABdhPJwU12ZbJl9ZHrtQj5kqCul7c+wiqkVlgVyzPT82mYgjqhnogzj3xgQUsAP8yBn8eF26O4fliw==
X-Received: by 2002:a17:90a:3002:: with SMTP id g2mr3189393pjb.68.1594346237081;
        Thu, 09 Jul 2020 18:57:17 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:16 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 2/7] arch: use asm-generic mmu context for no-op implementations
Date:   Fri, 10 Jul 2020 11:56:41 +1000
Message-Id: <20200710015646.2020871-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch bunches all architectures together. If the general idea is
accepted I will split them individually. Some architectures can go
further e.g., with consolidating switch_mm and activate_mm but I
only did the more obvious ones.
---
 arch/alpha/include/asm/mmu_context.h         | 12 ++---
 arch/arc/include/asm/mmu_context.h           | 16 +++----
 arch/arm/include/asm/mmu_context.h           | 26 ++---------
 arch/arm64/include/asm/mmu_context.h         |  7 ++-
 arch/csky/include/asm/mmu_context.h          |  8 ++--
 arch/hexagon/include/asm/mmu_context.h       | 33 +++-----------
 arch/ia64/include/asm/mmu_context.h          | 17 ++-----
 arch/m68k/include/asm/mmu_context.h          | 47 ++++----------------
 arch/microblaze/include/asm/mmu_context_mm.h |  8 ++--
 arch/microblaze/include/asm/processor.h      |  3 --
 arch/mips/include/asm/mmu_context.h          | 11 ++---
 arch/nds32/include/asm/mmu_context.h         | 10 +----
 arch/nios2/include/asm/mmu_context.h         | 21 ++-------
 arch/nios2/mm/mmu_context.c                  |  1 +
 arch/openrisc/include/asm/mmu_context.h      |  8 ++--
 arch/openrisc/mm/tlb.c                       |  2 +
 arch/parisc/include/asm/mmu_context.h        | 12 ++---
 arch/powerpc/include/asm/mmu_context.h       | 22 +++------
 arch/riscv/include/asm/mmu_context.h         | 22 +--------
 arch/s390/include/asm/mmu_context.h          |  9 ++--
 arch/sh/include/asm/mmu_context.h            |  5 +--
 arch/sh/include/asm/mmu_context_32.h         |  9 ----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++---
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++---
 arch/um/include/asm/mmu_context.h            | 12 +++--
 arch/unicore32/include/asm/mmu_context.h     | 24 ++--------
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++---
 arch/xtensa/include/asm/nommu_context.h      | 26 +----------
 29 files changed, 106 insertions(+), 302 deletions(-)

diff --git a/arch/alpha/include/asm/mmu_context.h b/arch/alpha/include/asm/mmu_context.h
index 6d7d9bc1b4b8..4eea7c616992 100644
--- a/arch/alpha/include/asm/mmu_context.h
+++ b/arch/alpha/include/asm/mmu_context.h
@@ -214,8 +214,6 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 	tbiap();
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 #ifdef CONFIG_ALPHA_GENERIC
 # define switch_mm(a,b,c)	alpha_mv.mv_switch_mm((a),(b),(c))
 # define activate_mm(x,y)	alpha_mv.mv_activate_mm((x),(y))
@@ -229,6 +227,7 @@ ev4_activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
 # endif
 #endif
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -242,12 +241,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-extern inline void
-destroy_context(struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -255,6 +249,8 @@ enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	  = ((unsigned long)mm->pgd - IDENT_ADDR) >> PAGE_SHIFT;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #ifdef __MMU_EXTERN_INLINE
 #undef __EXTERN_INLINE
 #undef __MMU_EXTERN_INLINE
diff --git a/arch/arc/include/asm/mmu_context.h b/arch/arc/include/asm/mmu_context.h
index 3a5e6a5b9ed6..586d31902a99 100644
--- a/arch/arc/include/asm/mmu_context.h
+++ b/arch/arc/include/asm/mmu_context.h
@@ -102,6 +102,7 @@ static inline void get_new_mmu_context(struct mm_struct *mm)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -113,6 +114,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	unsigned long flags;
@@ -153,13 +155,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 /*
- * Called at the time of execve() to get a new ASID
- * Note the subtlety here: get_new_mmu_context() behaves differently here
- * vs. in switch_mm(). Here it always returns a new ASID, because mm has
- * an unallocated "initial" value, while in latter, it moves to a new ASID,
- * only if it was unallocated
+ * activate_mm defaults to switch_mm and is called at the time of execve() to
+ * get a new ASID Note the subtlety here: get_new_mmu_context() behaves
+ * differently here vs. in switch_mm(). Here it always returns a new ASID,
+ * because mm has an unallocated "initial" value, while in latter, it moves to
+ * a new ASID, only if it was unallocated
  */
-#define activate_mm(prev, next)		switch_mm(prev, next, NULL)
 
 /* it seemed that deactivate_mm( ) is a reasonable place to do book-keeping
  * for retiring-mm. However destroy_context( ) still needs to do that because
@@ -168,8 +169,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * there is a good chance that task gets sched-out/in, making it's ASID valid
  * again (this teased me for a whole day).
  */
-#define deactivate_mm(tsk, mm)   do { } while (0)
 
-#define enter_lazy_tlb(mm, tsk)
+#include <asm-generic/mmu_context.h>
 
 #endif /* __ASM_ARC_MMU_CONTEXT_H */
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index f99ed524fe41..84e58956fcab 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -26,6 +26,8 @@ void __check_vmalloc_seq(struct mm_struct *mm);
 #ifdef CONFIG_CPU_HAS_ASID
 
 void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk);
+
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -92,32 +94,10 @@ static inline void finish_arch_post_lock_switch(void)
 
 #endif	/* CONFIG_MMU */
 
-static inline int
-init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
 #endif	/* CONFIG_CPU_HAS_ASID */
 
-#define destroy_context(mm)		do { } while(0)
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -149,6 +129,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #endif
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #endif
diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index b0bd9b55594c..0f5e351f586a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -174,7 +174,6 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  * Setting a reserved TTBR0 or EPD0 would work, but it all gets ugly when you
  * take CPU migration into account.
  */
-#define destroy_context(mm)		do { } while(0)
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.id, 0); 0; })
@@ -202,6 +201,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void
 enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
@@ -244,12 +244,11 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	update_saved_ttbr0(tsk, next);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, current)
-
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* !__ASM_MMU_CONTEXT_H */
diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index abdf1f1cb6ec..b227d29393a8 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -24,11 +24,6 @@
 #define cpu_asid(mm)		(atomic64_read(&mm->context.asid) & ASID_MASK)
 
 #define init_new_context(tsk,mm)	({ atomic64_set(&(mm)->context.asid, 0); 0; })
-#define activate_mm(prev,next)		switch_mm(prev, next, current)
-
-#define destroy_context(mm)		do {} while (0)
-#define enter_lazy_tlb(mm, tsk)		do {} while (0)
-#define deactivate_mm(tsk, mm)		do {} while (0)
 
 void check_and_switch_context(struct mm_struct *mm, unsigned int cpu);
 
@@ -46,4 +41,7 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 	flush_icache_deferred(next);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif /* __ASM_CSKY_MMU_CONTEXT_H */
diff --git a/arch/hexagon/include/asm/mmu_context.h b/arch/hexagon/include/asm/mmu_context.h
index cdc4adc0300a..81947764c47d 100644
--- a/arch/hexagon/include/asm/mmu_context.h
+++ b/arch/hexagon/include/asm/mmu_context.h
@@ -15,39 +15,13 @@
 #include <asm/pgalloc.h>
 #include <asm/mem-layout.h>
 
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 /*
  * VM port hides all TLB management, so "lazy TLB" isn't very
  * meaningful.  Even for ports to architectures with visble TLBs,
  * this is almost invariably a null function.
+ *
+ * mm->context is set up by pgd_alloc, so no init_new_context required.
  */
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *tsk)
-{
-}
-
-/*
- * Architecture-specific actions, if any, for memory map deactivation.
- */
-static inline void deactivate_mm(struct task_struct *tsk,
-	struct mm_struct *mm)
-{
-}
-
-/**
- * init_new_context - initialize context related info for new mm_struct instance
- * @tsk: pointer to a task struct
- * @mm: pointer to a new mm struct
- */
-static inline int init_new_context(struct task_struct *tsk,
-					struct mm_struct *mm)
-{
-	/* mm->context is set up by pgd_alloc */
-	return 0;
-}
 
 /*
  *  Switch active mm context
@@ -74,6 +48,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 /*
  *  Activate new memory map for task
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	unsigned long flags;
@@ -86,4 +61,6 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 /*  Generic hooks for arch_dup_mmap and arch_exit_mmap  */
 #include <asm-generic/mm_hooks.h>
 
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/ia64/include/asm/mmu_context.h b/arch/ia64/include/asm/mmu_context.h
index 2da0e2eb036b..87a0d5bc11ef 100644
--- a/arch/ia64/include/asm/mmu_context.h
+++ b/arch/ia64/include/asm/mmu_context.h
@@ -49,11 +49,6 @@ DECLARE_PER_CPU(u8, ia64_need_tlb_flush);
 extern void mmu_context_init (void);
 extern void wrap_mmu_context (struct mm_struct *mm);
 
-static inline void
-enter_lazy_tlb (struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * When the context counter wraps around all TLBs need to be flushed because
  * an old context number might have been reused. This is signalled by the
@@ -116,6 +111,7 @@ get_mmu_context (struct mm_struct *mm)
  * Initialize context number to some sane value.  MM is guaranteed to be a
  * brand-new address-space, so no TLB flushing is needed, ever.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context (struct task_struct *p, struct mm_struct *mm)
 {
@@ -123,12 +119,6 @@ init_new_context (struct task_struct *p, struct mm_struct *mm)
 	return 0;
 }
 
-static inline void
-destroy_context (struct mm_struct *mm)
-{
-	/* Nothing to do.  */
-}
-
 static inline void
 reload_context (nv_mm_context_t context)
 {
@@ -178,11 +168,10 @@ activate_context (struct mm_struct *mm)
 	} while (unlikely(context != mm->context));
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /*
  * Switch from address space PREV to address space NEXT.
  */
+#define activate_mm activate_mm
 static inline void
 activate_mm (struct mm_struct *prev, struct mm_struct *next)
 {
@@ -196,5 +185,7 @@ activate_mm (struct mm_struct *prev, struct mm_struct *next)
 
 #define switch_mm(prev_mm,next_mm,next_task)	activate_mm(prev_mm, next_mm)
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* ! __ASSEMBLY__ */
 #endif /* _ASM_IA64_MMU_CONTEXT_H */
diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index cac9f289d1f6..56ae27322178 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -5,10 +5,6 @@
 #include <asm-generic/mm_hooks.h>
 #include <linux/mm_types.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 #ifdef CONFIG_MMU
 
 #if defined(CONFIG_COLDFIRE)
@@ -58,6 +54,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -79,19 +76,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	set_context(tsk->mm->context, next->pgd);
 }
 
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *active_mm,
-	struct mm_struct *mm)
-{
-	get_mmu_context(mm);
-	set_context(mm->context, mm->pgd);
-}
-
-#define deactivate_mm(tsk, mm) do { } while (0)
-
 #define prepare_arch_switch(next) load_ksp_mmu(next)
 
 static inline void load_ksp_mmu(struct task_struct *task)
@@ -176,6 +160,7 @@ extern unsigned long get_free_context(struct mm_struct *mm);
 extern void clear_context(unsigned long context);
 
 /* set the context for a new task to unmapped */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -210,8 +195,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	activate_context(tsk->mm);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -224,6 +208,7 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 #include <asm/page.h>
 #include <asm/pgalloc.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -231,8 +216,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)		do { } while(0)
-
 static inline void switch_mm_0230(struct mm_struct *mm)
 {
 	unsigned long crp[2] = {
@@ -300,8 +283,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, str
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev_mm,
 			       struct mm_struct *next_mm)
 {
@@ -315,24 +297,11 @@ static inline void activate_mm(struct mm_struct *prev_mm,
 
 #endif
 
-#else /* !CONFIG_MMU */
+#include <asm-generic/mmu_context.h>
 
-static inline int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
-{
-	return 0;
-}
-
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, struct task_struct *tsk)
-{
-}
-
-#define destroy_context(mm)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
+#else /* !CONFIG_MMU */
 
-static inline void activate_mm(struct mm_struct *prev_mm, struct mm_struct *next_mm)
-{
-}
+#include <asm-generic/nommu_context.h>
 
 #endif /* CONFIG_MMU */
 #endif /* __M68K_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index a1c7dd48454c..c2c77f708455 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -33,10 +33,6 @@
    to represent all kernel pages as shared among all contexts.
  */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 # define NO_CONTEXT	256
 # define LAST_CONTEXT	255
 # define FIRST_CONTEXT	1
@@ -105,6 +101,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 /*
  * We're finished using the context for an address space.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != NO_CONTEXT) {
@@ -126,6 +123,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *active_mm,
 			struct mm_struct *mm)
 {
@@ -136,5 +134,7 @@ static inline void activate_mm(struct mm_struct *active_mm,
 
 extern void mmu_context_init(void);
 
+#include <asm-generic/mmu_context.h>
+
 # endif /* __KERNEL__ */
 #endif /* _ASM_MICROBLAZE_MMU_CONTEXT_H */
diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/include/asm/processor.h
index 1ff5a82b76b6..616211871a6e 100644
--- a/arch/microblaze/include/asm/processor.h
+++ b/arch/microblaze/include/asm/processor.h
@@ -122,9 +122,6 @@ unsigned long get_wchan(struct task_struct *p);
 #  define KSTK_EIP(task)	(task_pc(task))
 #  define KSTK_ESP(task)	(task_sp(task))
 
-/* FIXME */
-#  define deactivate_mm(tsk, mm)	do { } while (0)
-
 #  define STACK_TOP	TASK_SIZE
 #  define STACK_TOP_MAX	STACK_TOP
 
diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index cddead91acd4..ed9f2d748f63 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -124,10 +124,6 @@ static inline void set_cpu_context(unsigned int cpu,
 #define cpu_asid(cpu, mm) \
 	(cpu_context((cpu), (mm)) & cpu_asid_mask(&cpu_data[cpu]))
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 extern void get_new_mmu_context(struct mm_struct *mm);
 extern void check_mmu_context(struct mm_struct *mm);
 extern void check_switch_mmu_context(struct mm_struct *mm);
@@ -136,6 +132,7 @@ extern void check_switch_mmu_context(struct mm_struct *mm);
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -180,14 +177,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	dsemul_mm_cleanup(mm);
 }
 
-#define activate_mm(prev, next)	switch_mm(prev, next, current)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 static inline void
 drop_mmu_context(struct mm_struct *mm)
 {
@@ -237,4 +232,6 @@ drop_mmu_context(struct mm_struct *mm)
 	local_irq_restore(flags);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_MMU_CONTEXT_H */
diff --git a/arch/nds32/include/asm/mmu_context.h b/arch/nds32/include/asm/mmu_context.h
index b8fd3d189fdc..c651bc8cacdc 100644
--- a/arch/nds32/include/asm/mmu_context.h
+++ b/arch/nds32/include/asm/mmu_context.h
@@ -9,6 +9,7 @@
 #include <asm/proc-fns.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -16,8 +17,6 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
-#define destroy_context(mm)	do { } while(0)
-
 #define CID_BITS	9
 extern spinlock_t cid_lock;
 extern unsigned int cpu_last_cid;
@@ -47,10 +46,6 @@ static inline void check_context(struct mm_struct *mm)
 		__new_context(mm);
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
@@ -62,7 +57,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-#define activate_mm(prev,next)	switch_mm(prev, next, NULL)
+#include <asm-generic/mmu_context.h>
 
 #endif
diff --git a/arch/nios2/include/asm/mmu_context.h b/arch/nios2/include/asm/mmu_context.h
index 78ab3dacf579..4f99ed09b5a7 100644
--- a/arch/nios2/include/asm/mmu_context.h
+++ b/arch/nios2/include/asm/mmu_context.h
@@ -26,16 +26,13 @@ extern unsigned long get_pid_from_context(mm_context_t *ctx);
  */
 extern pgd_t *pgd_current;
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * Initialize the context related info for a new mm_struct instance.
  *
  * Set all new contexts to 0, that way the generation will never match
  * the currently running generation when this context is switched in.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 					struct mm_struct *mm)
 {
@@ -43,26 +40,16 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		struct task_struct *tsk);
 
-static inline void deactivate_mm(struct task_struct *tsk,
-				struct mm_struct *mm)
-{
-}
-
 /*
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_NIOS2_MMU_CONTEXT_H */
diff --git a/arch/nios2/mm/mmu_context.c b/arch/nios2/mm/mmu_context.c
index 45d6b9c58d67..d77aa542deb2 100644
--- a/arch/nios2/mm/mmu_context.c
+++ b/arch/nios2/mm/mmu_context.c
@@ -103,6 +103,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
+#define activate_mm activate_mm
 void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	next->context = get_new_context();
diff --git a/arch/openrisc/include/asm/mmu_context.h b/arch/openrisc/include/asm/mmu_context.h
index ced577542e29..a6702384c77d 100644
--- a/arch/openrisc/include/asm/mmu_context.h
+++ b/arch/openrisc/include/asm/mmu_context.h
@@ -17,13 +17,13 @@
 
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		      struct task_struct *tsk);
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 #define activate_mm(prev, next) switch_mm((prev), (next), NULL)
 
 /* current active pgd - this is similar to other processors pgd
@@ -32,8 +32,6 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 
 extern volatile pgd_t *current_pgd[]; /* defined in arch/openrisc/mm/fault.c */
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index 4b680aed8f5f..821aab4cf3be 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -159,6 +159,7 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * instance.
  */
 
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
 	mm->context = NO_CONTEXT;
@@ -170,6 +171,7 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
  * drops it.
  */
 
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm)
 {
 	flush_tlb_mm(mm);
diff --git a/arch/parisc/include/asm/mmu_context.h b/arch/parisc/include/asm/mmu_context.h
index 07b89c74abeb..71f8a3679b83 100644
--- a/arch/parisc/include/asm/mmu_context.h
+++ b/arch/parisc/include/asm/mmu_context.h
@@ -8,16 +8,13 @@
 #include <asm/pgalloc.h>
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* on PA-RISC, we actually have enough contexts to justify an allocator
  * for them.  prumpf */
 
 extern unsigned long alloc_sid(void);
 extern void free_sid(unsigned long);
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
@@ -27,6 +24,7 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	return 0;
 }
 
+#define destroy_context destroy_context
 static inline void
 destroy_context(struct mm_struct *mm)
 {
@@ -72,8 +70,7 @@ static inline void switch_mm(struct mm_struct *prev,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 {
 	/*
@@ -91,4 +88,7 @@ static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
 
 	switch_mm(prev,next,current);
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1a474f6b1992..242bd987247b 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -14,7 +14,9 @@
 /*
  * Most if the context management is out of line
  */
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 struct mm_iommu_table_group_mem_t;
@@ -237,27 +239,15 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 #define switch_mm_irqs_off switch_mm_irqs_off
 
-
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
-/*
- * After we have set current->mm to a new value, this activates
- * the context for the new mm so we see the new mappings.
- */
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	switch_mm(prev, next, current);
-}
-
-/* We don't currently use enter_lazy_tlb() for anything */
+#ifdef CONFIG_PPC_BOOK3E_64
+#define enter_lazy_tlb enter_lazy_tlb
 static inline void enter_lazy_tlb(struct mm_struct *mm,
 				  struct task_struct *tsk)
 {
 	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
 	get_paca()->pgd = NULL;
-#endif
 }
+#endif
 
 extern void arch_exit_mmap(struct mm_struct *mm);
 
@@ -300,5 +290,7 @@ static inline int arch_dup_mmap(struct mm_struct *oldmm,
 	return 0;
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 67c463812e2d..250defa06f3a 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -13,34 +13,16 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm,
-	struct task_struct *task)
-{
-}
-
-/* Initialize context-related info for a new mm_struct */
-static inline int init_new_context(struct task_struct *task,
-	struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	struct task_struct *task);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
 	switch_mm(prev, next, NULL);
 }
 
-static inline void deactivate_mm(struct task_struct *task,
-	struct mm_struct *mm)
-{
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index c9f3d8a52756..66f9cf0a07e3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -15,6 +15,7 @@
 #include <asm/ctl_reg.h>
 #include <asm-generic/mm_hooks.h>
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -69,8 +70,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-#define destroy_context(mm)             do { } while (0)
-
 static inline void set_user_asce(struct mm_struct *mm)
 {
 	S390_lowcore.user_asce = mm->context.asce;
@@ -125,9 +124,7 @@ static inline void finish_arch_post_lock_switch(void)
 	set_fs(current->thread.mm_segment);
 }
 
-#define enter_lazy_tlb(mm,tsk)	do { } while (0)
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
@@ -136,4 +133,6 @@ static inline void activate_mm(struct mm_struct *prev,
 	set_user_asce(next);
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* __S390_MMU_CONTEXT_H */
diff --git a/arch/sh/include/asm/mmu_context.h b/arch/sh/include/asm/mmu_context.h
index 9470d17c71c2..ce40147d4a7d 100644
--- a/arch/sh/include/asm/mmu_context.h
+++ b/arch/sh/include/asm/mmu_context.h
@@ -85,6 +85,7 @@ static inline void get_mmu_context(struct mm_struct *mm, unsigned int cpu)
  * Initialize the context related info for a new mm_struct
  * instance.
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -121,9 +122,7 @@ static inline void switch_mm(struct mm_struct *prev,
 			activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)		switch_mm((prev),(next),NULL)
-#define deactivate_mm(tsk,mm)		do { } while (0)
-#define enter_lazy_tlb(mm,tsk)		do { } while (0)
+#include <asm-generic/mmu_context.h>
 
 #else
 
diff --git a/arch/sh/include/asm/mmu_context_32.h b/arch/sh/include/asm/mmu_context_32.h
index 71bf12ef1f65..bc5034fa6249 100644
--- a/arch/sh/include/asm/mmu_context_32.h
+++ b/arch/sh/include/asm/mmu_context_32.h
@@ -2,15 +2,6 @@
 #ifndef __ASM_SH_MMU_CONTEXT_32_H
 #define __ASM_SH_MMU_CONTEXT_32_H
 
-/*
- * Destroy context related info for an mm_struct that is about
- * to be put to rest.
- */
-static inline void destroy_context(struct mm_struct *mm)
-{
-	/* Do nothing */
-}
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 static inline void set_asid(unsigned long asid)
 {
diff --git a/arch/sparc/include/asm/mmu_context_32.h b/arch/sparc/include/asm/mmu_context_32.h
index 7ddcb8badf70..509043f81560 100644
--- a/arch/sparc/include/asm/mmu_context_32.h
+++ b/arch/sparc/include/asm/mmu_context_32.h
@@ -6,13 +6,10 @@
 
 #include <asm-generic/mm_hooks.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /* Initialize a new mmu context.  This is invoked when a new
  * address space instance (unique or shared) is instantiated.
  */
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
 
 /* Destroy a dead context.  This occurs when mmput drops the
@@ -20,17 +17,18 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
  * all the page tables have been flushed.  Our job is to destroy
  * any remaining processor-specific state.
  */
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 /* Switch the current MM context. */
 void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm,
 	       struct task_struct *tsk);
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 /* Activate a new MM instance for the current task. */
 #define activate_mm(active_mm, mm) switch_mm((active_mm), (mm), NULL)
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC_MMU_CONTEXT_H) */
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 312fcee8df2b..7a8380c63aab 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -16,17 +16,16 @@
 #include <asm-generic/mm_hooks.h>
 #include <asm/percpu.h>
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 extern spinlock_t ctx_alloc_lock;
 extern unsigned long tlb_context_cache;
 extern unsigned long mmu_context_bmap[];
 
 DECLARE_PER_CPU(struct mm_struct *, per_cpu_secondary_mm);
 void get_new_mmu_context(struct mm_struct *mm);
+
+#define init_new_context init_new_context
 int init_new_context(struct task_struct *tsk, struct mm_struct *mm);
+#define destroy_context destroy_context
 void destroy_context(struct mm_struct *mm);
 
 void __tsb_context_switch(unsigned long pgd_pa,
@@ -136,7 +135,6 @@ static inline void switch_mm(struct mm_struct *old_mm, struct mm_struct *mm, str
 	spin_unlock_irqrestore(&mm->context.lock, flags);
 }
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(active_mm, mm) switch_mm(active_mm, mm, NULL)
 
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
@@ -187,6 +185,8 @@ static inline void finish_arch_post_lock_switch(void)
 	}
 }
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(__SPARC64_MMU_CONTEXT_H) */
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index 17ddd4edf875..f8a100770691 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -37,10 +37,9 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
  * end asm-generic/mm_hooks.h functions
  */
 
-#define deactivate_mm(tsk,mm)	do { } while (0)
-
 extern void force_flush_all(void);
 
+#define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
 {
 	/*
@@ -66,13 +65,12 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	}
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, 
-				  struct task_struct *tsk)
-{
-}
-
+#define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
+#define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
 
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/unicore32/include/asm/mmu_context.h b/arch/unicore32/include/asm/mmu_context.h
index 388c0c811c68..e1751cb5439c 100644
--- a/arch/unicore32/include/asm/mmu_context.h
+++ b/arch/unicore32/include/asm/mmu_context.h
@@ -18,24 +18,6 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu-single.h>
 
-#define init_new_context(tsk, mm)	0
-
-#define destroy_context(mm)		do { } while (0)
-
-/*
- * This is called when "tsk" is about to enter lazy TLB mode.
- *
- * mm:  describes the currently active mm context
- * tsk: task which is entering lazy tlb
- * cpu: cpu number which is entering lazy tlb
- *
- * tsk->mm will be NULL
- */
-static inline void
-enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
 /*
  * This is the actual mm switch as far as the scheduler
  * is concerned.  No registers are touched.  We avoid
@@ -52,9 +34,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		cpu_switch_mm(next->pgd, next);
 }
 
-#define deactivate_mm(tsk, mm)	do { } while (0)
-#define activate_mm(prev, next)	switch_mm(prev, next, NULL)
-
 /*
  * We are inserting a "fake" vma for the user-accessible vector page so
  * gdb and friends can get to it through ptrace and /proc/<pid>/mem.
@@ -95,4 +74,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 	/* by default, allow everything */
 	return true;
 }
+
+#include <asm-generic/mmu_context.h>
+
 #endif
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 47562147e70b..255750548433 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -92,12 +92,14 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 }
 #endif
 
+#define enter_lazy_tlb enter_lazy_tlb
 extern void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk);
 
 /*
  * Init a new mm.  Used on mm copies, like at fork()
  * and on mm's that are brand-new, like at execve().
  */
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
@@ -117,6 +119,8 @@ static inline int init_new_context(struct task_struct *tsk,
 	init_new_context_ldt(mm);
 	return 0;
 }
+
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	destroy_context_ldt(mm);
@@ -215,4 +219,6 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 unsigned long __get_current_cr3_fast(void);
 
+#include <asm-generic/mmu_context.h>
+
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/xtensa/include/asm/mmu_context.h b/arch/xtensa/include/asm/mmu_context.h
index 74923ef3b228..e337ba9686e9 100644
--- a/arch/xtensa/include/asm/mmu_context.h
+++ b/arch/xtensa/include/asm/mmu_context.h
@@ -111,6 +111,7 @@ static inline void activate_context(struct mm_struct *mm, unsigned int cpu)
  * to -1 says the process has never run on any core.
  */
 
+#define init_new_context init_new_context
 static inline int init_new_context(struct task_struct *tsk,
 		struct mm_struct *mm)
 {
@@ -136,24 +137,18 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		activate_context(next, cpu);
 }
 
-#define activate_mm(prev, next)	switch_mm((prev), (next), NULL)
-#define deactivate_mm(tsk, mm)	do { } while (0)
-
 /*
  * Destroy context related info for an mm_struct that is about
  * to be put to rest.
  */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	invalidate_page_directory();
 }
 
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-	/* Nothing to do. */
-
-}
+#include <asm-generic/mmu_context.h>
 
 #endif /* CONFIG_MMU */
 #endif /* _XTENSA_MMU_CONTEXT_H */
diff --git a/arch/xtensa/include/asm/nommu_context.h b/arch/xtensa/include/asm/nommu_context.h
index 37251b2ef871..7c9d1918dc41 100644
--- a/arch/xtensa/include/asm/nommu_context.h
+++ b/arch/xtensa/include/asm/nommu_context.h
@@ -7,28 +7,4 @@ static inline void init_kio(void)
 {
 }
 
-static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
-{
-}
-
-static inline int init_new_context(struct task_struct *tsk,struct mm_struct *mm)
-{
-	return 0;
-}
-
-static inline void destroy_context(struct mm_struct *mm)
-{
-}
-
-static inline void activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-}
-
-static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
-				struct task_struct *tsk)
-{
-}
-
-static inline void deactivate_mm(struct task_struct *tsk, struct mm_struct *mm)
-{
-}
+#include <asm-generic/nommu_context.h>
-- 
2.23.0

