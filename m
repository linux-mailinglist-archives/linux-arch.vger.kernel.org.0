Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B32270CAA
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 11:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgISJvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgISJup (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2020 05:50:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2690AC0613D0;
        Sat, 19 Sep 2020 02:50:45 -0700 (PDT)
Message-Id: <20200919092617.279626264@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600509018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CYFZGC5XFXwIeIdTxBbBsuptLpgHnLvRMVVfnfU0Lek=;
        b=EmzU/Ha7VTgCHPh+OPwMMAxl1vQw2EZbgMLA0QK5w0tgoNA9cK5GrZ+iRnxTLUvFmO6uvT
        5xni0RQrFsvKWLEwnxRXfnK1ZoluDBJkq1/t4BopRLVlWdsZl8LGtkYO5VPQeJOAVh0loT
        3pxfhX7Xzg7eD/HDkG7ZRFVEUuI8wNqIatH3iT0c6USltX67MnShz/PRGAOuuY98QpJcJF
        RKzxtBefOl4frfc7PbgyYDsbLhAgIw9uUlbWv2A+h4Ox5jUUab+vAsmRMaNniDuggLqVCk
        2DATRO4G8SXRfgThVN15NoLylHOz2CDJg97svW/xOW73oUnocZFgU2gqrFZxtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600509018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=CYFZGC5XFXwIeIdTxBbBsuptLpgHnLvRMVVfnfU0Lek=;
        b=3MSiTX3/QibrqvIYfxIqARkPAbMeHtlldJHdL2IUUoOqwRf5x+Ph+DQIW8CwuSUBjdR486
        DKAgHE+Y4cwJC9Ag==
Date:   Sat, 19 Sep 2020 11:18:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Paul McKenney <paulmck@kernel.org>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [patch RFC 14/15] sched: highmem: Store temporary kmaps in task struct
References: <20200919091751.011116649@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of storing the map per CPU provide and use per task storage. That
prepares for temporary kmaps which are preemptible.

The context switch code is preparatory and not yet in use because
kmap_atomic() runs with preemption disabled. Will be made usable in the
next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/highmem.h |    1 
 include/linux/sched.h   |    9 +++++++
 kernel/sched/core.c     |   10 ++++++++
 mm/highmem.c            |   59 ++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 72 insertions(+), 7 deletions(-)

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -38,6 +38,7 @@ static inline void invalidate_kernel_vma
 void *kmap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *kmap_atomic_page_prot(struct page *page, pgprot_t prot);
 void kunmap_atomic_indexed(void *vaddr);
+void kmap_switch_temporary(struct task_struct *prev, struct task_struct *next);
 # ifndef ARCH_NEEDS_KMAP_HIGH_GET
 static inline void *arch_kmap_temporary_high_get(struct page *page)
 {
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <asm/kmap_types.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -628,6 +629,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_ATOMIC_GENERIC
+	int				idx;
+	pte_t				pteval[KM_TYPE_NR];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1280,6 +1288,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3529,6 +3529,15 @@ static inline void finish_lock_switch(st
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_temp_switch(struct task_struct *prev,
+				    struct task_struct *next)
+{
+#ifdef CONFIG_HIGHMEM
+	if (unlikely(prev->kmap_ctrl.idx || next->kmap_ctrl.idx))
+		kmap_switch_temporary(prev, next);
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -3551,6 +3560,7 @@ prepare_task_switch(struct rq *rq, struc
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_temp_switch(prev, next);
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -370,6 +370,7 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
+
 EXPORT_SYMBOL(kunmap_high);
 #else
 static inline void kmap_high_unmap_temporary(unsigned long vaddr) { }
@@ -377,11 +378,9 @@ static inline void kmap_high_unmap_tempo
 
 #ifdef CONFIG_KMAP_ATOMIC_GENERIC
 
-static DEFINE_PER_CPU(int, __kmap_atomic_idx);
-
 static inline int kmap_atomic_idx_push(void)
 {
-	int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
+	int idx = current->kmap_ctrl.idx++;
 
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
 	BUG_ON(idx >= KM_TYPE_NR);
@@ -390,14 +389,13 @@ static inline int kmap_atomic_idx_push(v
 
 static inline int kmap_atomic_idx(void)
 {
-	return __this_cpu_read(__kmap_atomic_idx) - 1;
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline void kmap_atomic_idx_pop(void)
 {
-	int idx = __this_cpu_dec_return(__kmap_atomic_idx);
-
-	BUG_ON(idx < 0);
+	current->kmap_ctrl.idx--;
+	BUG_ON(current->kmap_ctrl.idx < 0);
 }
 
 #ifndef arch_kmap_temp_post_map
@@ -447,6 +445,7 @@ static void *__kmap_atomic_pfn_prot(unsi
 	pteval = pfn_pte(pfn, prot);
 	set_pte(kmap_pte - idx, pteval);
 	arch_kmap_temp_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_atomic_idx()] = pteval;
 	preempt_enable();
 
 	return (void *)vaddr;
@@ -499,11 +498,57 @@ void kunmap_atomic_indexed(void *vaddr)
 	arch_kmap_temp_pre_unmap(addr);
 	pte_clear(&init_mm, addr, kmap_pte - idx);
 	arch_kmap_temp_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_atomic_idx()] = __pte(0);
 	kmap_atomic_idx_pop();
 	preempt_enable();
 	pagefault_enable();
 }
 EXPORT_SYMBOL(kunmap_atomic_indexed);
+
+void kmap_switch_temporary(struct task_struct *prev, struct task_struct *next)
+{
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear @prev's kmaps */
+	for (i = 0; i < prev->kmap_ctrl.idx; i++) {
+		pte_t pteval = prev->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 *
+		 * For any sane architecture that address calculation is
+		 * optimized out.
+		 */
+		idx = arch_kmap_temp_map_idx(i, pte_pfn(pteval));
+
+		arch_kmap_temp_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_temp_post_unmap(addr);
+	}
+
+	/* Restore @next's kmaps */
+	for (i = 0; i < next->kmap_ctrl.idx; i++) {
+		pte_t pteval = next->kmap_ctrl.pteval[i];
+		int idx;
+
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		idx = arch_kmap_temp_map_idx(i, pte_pfn(pteval));
+		set_pte(kmap_pte - idx, pteval);
+		arch_kmap_temp_post_map(addr, pteval);
+	}
+}
+
 #endif
 
 #if defined(HASHED_PAGE_VIRTUAL)

