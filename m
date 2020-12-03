Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF22CCEA1
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 06:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgLCF0l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 00:26:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgLCF0l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Dec 2020 00:26:41 -0500
From:   Andy Lutomirski <luto@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        X86 ML <x86@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
Date:   Wed,  2 Dec 2020 21:25:51 -0800
Message-Id: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For context, this is part of a series here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/mm&id=7c4bcc0a464ca60be1e0aeba805a192be0ee81e5

This code compiles, but I haven't even tried to boot it.  The earlier
part of the series isn't terribly interesting -- it's a handful of
cleanups that remove all reads of ->active_mm from arch/x86.  I've
been meaning to do that for a while, and now I did it.  But, with
that done, I think we can move to a totally different lazy mm refcounting
model.

So this patch is a mockup of what this could look like.  The algorithm
involves no atomics at all in the context switch path except for a
single atomic_long_xchg() of a percpu variable when going from lazy
mode to nonlazy mode.  Even that could be optimized -- I suspect it could
be replaced with non-atomic code if mm_users > 0.  Instead, on mm exit,
there's a single loop over all CPUs on which that mm could be lazily
loaded that atomic_long_cmpxchg_relaxed()'s a remote percpu variable to
tell the CPU to kindly mmdrop() the mm when it reschedules.  All cpus
that don't have the mm lazily loaded are ignored because they can't
have lazy references, and no cpus can gain lazy references after
mm_users hits zero.  (I need to verify that all the relevant barriers
are in place.  I suspect that they are on x86 but that I'm short an
smp_mb() on arches for which _relaxed atomics are genuinely relaxed.)

Here's how I think it fits with various arches:

x86: On bare metal (i.e. paravirt flush unavailable), the loop won't do
much.  The existing TLB shootdown when user tables are freed will
empty mm_cpumask of everything but the calling CPU.  So x86 ends up
pretty close to as good as we can get short of reworking mm_cpumask() itself.

arm64: with s/for_each_cpu/for_each_online_cpu, I think it will give
good performance.  The mmgrab()/mmdrop() overhead goes away, and,
on smallish systems, the cost of the loop should be low.

power: same as ARM, except that the loop may be rather larger since
the systems are bigger.  But I imagine it's still faster than Nick's
approach -- a cmpxchg to a remote cacheline should still be faster than
an IPI shootdown.  (Nick, don't benchmark this patch -- at least the
mm_users optimization mentioned above should be done, but also the
mmgrab() and mmdrop() aren't actually removed.)

Other arches: I don't know.  Further research is required.

What do you all think?


As mentioned, there are several things blatantly wrong with this patch:

The coding stype is not up to kernel standars.  I have prototypes in the
wrong places and other hacks.

mms are likely to be freed with IRQs off.  I think this is safe, but it's
suboptimal.

This whole thing is in arch/x86.  The core algorithm ought to move outside
arch/, but doing so without making a mess might take some thought.  It
doesn't help that different architectures have very different ideas
of what mm_cpumask() does.

Finally, this patch has no benefit by itself.  I didn't remove the
active_mm refounting, so the big benefit of removing mmgrab() and
mmdrop() calls on transitions to and from lazy mode isn't there.
There is no point at all in benchmarking this patch as is.  That
being said, getting rid of the active_mm refcounting shouldn't be
so hard, since x86 (in this tree) no longer uses active_mm at all.

I should contemplate whether the calling CPU is special in
arch_fixup_lazy_mm_refs().  On a very very quick think, it's not, but
it needs more thought.

Signed-off-by: Andy Lutomirski <luto@kernel.org>

 arch/x86/include/asm/tlbflush.h | 20 ++++++++
 arch/x86/mm/tlb.c               | 81 +++++++++++++++++++++++++++++++--
 kernel/fork.c                   |  5 ++
 3 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..efcd4f125f2c 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -124,6 +124,26 @@ struct tlb_state {
 	 */
 	unsigned short user_pcid_flush_mask;
 
+	/*
+	 * Lazy mm tracking.
+	 *
+	 *  - If this is NULL, it means that any mm_struct referenced by
+	 *    this CPU is kept alive by a real reference count.
+	 *
+	 *  - If this is nonzero but the low bit is clear, it points to
+	 *    an mm_struct that must not be freed out from under this
+	 *    CPU.
+	 *
+	 *  - If the low bit is set, it still points to an mm_struct,
+	 *    but some other CPU has mmgrab()'d it on our behalf, and we
+	 *    must mmdrop() it when we're done with it.
+	 *
+	 * See lazy_mm_grab() and related functions for the precise
+	 * access rules.
+	 */
+	atomic_long_t		lazy_mm;
+
+
 	/*
 	 * Access to this CR4 shadow and to H/W CR4 is protected by
 	 * disabling interrupts when modifying either one.
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e27300fc865b..00f5bace534b 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/mm.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -420,6 +421,64 @@ void cr4_update_pce(void *ignored)
 static inline void cr4_update_pce_mm(struct mm_struct *mm) { }
 #endif
 
+static void lazy_mm_grab(struct mm_struct *mm)
+{
+	atomic_long_t *lazy_mm = this_cpu_ptr(&cpu_tlbstate.lazy_mm);
+
+	WARN_ON_ONCE(atomic_long_read(lazy_mm) != 0);
+	atomic_long_set(lazy_mm, (unsigned long)mm);
+}
+
+static void lazy_mm_drop(void)
+{
+	atomic_long_t *lazy_mm = this_cpu_ptr(&cpu_tlbstate.lazy_mm);
+
+	unsigned long prev = atomic_long_xchg(lazy_mm, 0);
+	if (prev & 1)
+		mmdrop((struct mm_struct *)(prev & ~1UL));
+}
+
+void arch_fixup_lazy_mm_refs(struct mm_struct *mm)
+{
+	int cpu;
+
+	/*
+	 * mm_users is zero, so no new lazy refs will be taken.
+	 */
+	WARN_ON_ONCE(atomic_read(&mm->mm_users) != 0);
+
+	for_each_cpu(cpu, mm_cpumask(mm)) {
+		atomic_long_t *lazy_mm = per_cpu_ptr(&cpu_tlbstate.lazy_mm, cpu);
+		unsigned long old;
+
+		// Hmm, is this check actually useful?
+		if (atomic_long_read(lazy_mm) != (unsigned long)mm)
+			continue;
+
+		// XXX: we could optimize this by adding a bunch to
+		// mm_count at the beginning and subtracting the unused refs
+		// back off at the end.
+		mmgrab(mm);
+
+		// XXX: is relaxed okay here?  We need to be sure that the
+		// remote CPU has observed mm_users == 0.  This is just
+		// x86 for now, but we might want to move it into a library
+		// and use it elsewhere.
+		old = atomic_long_cmpxchg_relaxed(lazy_mm, (unsigned long)mm,
+						  (unsigned long)mm | 1);
+		if (old == (unsigned long)mm) {
+			/* The remote CPU now owns the reference we grabbed. */
+		} else {
+			/*
+			 * We raced!  The remote CPU switched mms and no longer
+			 * needs its reference.  We didn't transfer ownership
+			 * of the reference, so drop it.
+			 */
+			mmdrop(mm);
+		}
+	}
+}
+
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
@@ -587,16 +646,24 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		cr4_update_pce_mm(next);
 		switch_ldt(real_prev, next);
 	}
+
+	// XXX: this can end up in __mmdrop().  Is this okay with IRQs off?
+	// It might be nicer to defer this to a later stage in the scheduler
+	// with IRQs on.
+	if (was_lazy)
+		lazy_mm_drop();
 }
 
 /*
- * Please ignore the name of this function.  It should be called
- * switch_to_kernel_thread().
+ * Please don't think too hard about the name of this function.  It
+ * should be called something like switch_to_kernel_mm().
  *
  * enter_lazy_tlb() is a hint from the scheduler that we are entering a
- * kernel thread or other context without an mm.  Acceptable implementations
- * include doing nothing whatsoever, switching to init_mm, or various clever
- * lazy tricks to try to minimize TLB flushes.
+ * kernel thread or other context without an mm.  Acceptable
+ * implementations include switching to init_mm, or various clever lazy
+ * tricks to try to minimize TLB flushes.  We are, however, required to
+ * either stop referencing the previous mm or to take some action to
+ * keep it from being freed out from under us.
  *
  * The scheduler reserves the right to call enter_lazy_tlb() several times
  * in a row.  It will notify us that we're going back to a real mm by
@@ -607,7 +674,11 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
+	if (this_cpu_read(cpu_tlbstate.is_lazy))
+		return;  /* nothing to do */
+
 	this_cpu_write(cpu_tlbstate.is_lazy, true);
+	lazy_mm_grab(mm);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..4d68162c1d02 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1066,6 +1066,9 @@ struct mm_struct *mm_alloc(void)
 	return mm_init(mm, current, current_user_ns());
 }
 
+// XXX: move to a header
+extern void arch_fixup_lazy_mm_refs(struct mm_struct *mm);
+
 static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
@@ -1084,6 +1087,8 @@ static inline void __mmput(struct mm_struct *mm)
 	}
 	if (mm->binfmt)
 		module_put(mm->binfmt->module);
+
+	arch_fixup_lazy_mm_refs(mm);
 	mmdrop(mm);
 }
 
-- 
2.28.0

