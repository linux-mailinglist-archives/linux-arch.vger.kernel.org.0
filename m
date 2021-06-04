Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B06039B6D4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 12:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFDKOH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFDKOG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 06:14:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BA4C06174A;
        Fri,  4 Jun 2021 03:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BWAaUNKtK8Vbo2LYSJw2Q0bv5NAJCS8DjagAc0/+utw=; b=jPVvZUbv8Nvzkgu0QETQm2nssW
        Q5kWy7M6dAHz97Lils5B6VcwBevfUmlzh+1FhI37kVW4A2Zd3X7lli+r2kx3iLseRs4vLp52YuZ/j
        FcMaXpqwqKOtQCh3nJ5Xl8YO/h5Bh+4rsMsH5V9hLkqaF2O7WHqtAHnkCmrc8TTxBZKnzBlGUymmi
        Ah4OurqmEV/Qp722pRiQ1M8dSFqmg456CS6kpvUu9yDYVIemsUmldT8UwfeBk+gTZnRLaUH/h1SZx
        szle/zWi2h+VWYJh3AhW3LCk2bmxseTKw6yIG+EhLp5Gr4uLFyOIKErEnMSUFXteBIkIs54NshrWC
        9UUTg9VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lp6o6-003PKt-RC; Fri, 04 Jun 2021 10:12:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9E08230018A;
        Fri,  4 Jun 2021 12:12:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CD102B9D6C7B; Fri,  4 Jun 2021 12:12:07 +0200 (CEST)
Date:   Fri, 4 Jun 2021 12:12:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC] LKMM: Add volatile_if()
Message-ID: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi!

With optimizing compilers becoming more and more agressive and C so far
refusing to acknowledge the concept of control-dependencies even while
we keep growing the amount of reliance on them, things will eventually
come apart.

There have been talks with toolchain people on how to resolve this; one
suggestion was allowing the volatile qualifier on branch statements like
'if', but so far no actual compiler has made any progress on this.

Rather than waiting any longer, provide our own construct based on that
suggestion. The idea is by Alan Stern and refined by Paul and myself.

Code generation is sub-optimal (for the weak architectures) since we're
forced to convert the condition into another and use a fixed conditional
branch instruction, but shouldn't be too bad.

Usage of volatile_if requires the @cond to be headed by a volatile load
(READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
emit the load and the branch emitted will have the required
data-dependency. Furthermore, volatile_if() is a compiler barrier, which
should prohibit the compiler from lifting anything out of the selection
statement.

This construct should place control dependencies on a stronger footing
until such time that the compiler folks get around to accepting them :-)

I've converted most architectures we care about, and the rest will get
an extra smp_mb() by means of the 'generic' fallback implementation (for
now).

I've converted the control dependencies I remembered and those found
with a search for smp_acquire__after_ctrl_dep(), there might be more.

Compile tested only (alpha, arm, arm64, x86_64, powerpc, powerpc64, s390
and sparc64).

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/barrier.h      | 11 +++++++++++
 arch/arm64/include/asm/barrier.h    | 11 +++++++++++
 arch/powerpc/include/asm/barrier.h  | 13 +++++++++++++
 arch/s390/include/asm/barrier.h     |  3 +++
 arch/sparc/include/asm/barrier_64.h |  3 +++
 arch/x86/include/asm/barrier.h      | 16 ++++++++++++++++
 include/asm-generic/barrier.h       | 38 ++++++++++++++++++++++++++++++++++++-
 include/linux/refcount.h            |  2 +-
 ipc/mqueue.c                        |  2 +-
 ipc/msg.c                           |  2 +-
 kernel/events/ring_buffer.c         |  8 ++++----
 kernel/locking/rwsem.c              |  4 ++--
 kernel/sched/core.c                 |  2 +-
 kernel/smp.c                        |  2 +-
 14 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 83ae97c049d9..de8a61479268 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -97,6 +97,17 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 #define array_index_mask_nospec array_index_mask_nospec
 #endif
 
+/* Guarantee a conditional branch that depends on @cond. */
+static __always_inline _Bool volatile_cond(_Bool cond)
+{
+	asm_volatile_goto("teq %0, #0; bne %l[l_yes]"
+			  : : "r" (cond) : "cc", "memory" : l_yes);
+	return 0;
+l_yes:
+	return 1;
+}
+#define volatile_cond volatile_cond
+
 #include <asm-generic/barrier.h>
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 451e11e5fd23..2782a7013615 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -156,6 +156,17 @@ do {									\
 	(typeof(*p))__u.__val;						\
 })
 
+/* Guarantee a conditional branch that depends on @cond. */
+static __always_inline _Bool volatile_cond(_Bool cond)
+{
+	asm_volatile_goto("cbnz %0, %l[l_yes]"
+			  : : "r" (cond) : "cc", "memory" : l_yes);
+	return 0;
+l_yes:
+	return 1;
+}
+#define volatile_cond volatile_cond
+
 #define smp_cond_load_relaxed(ptr, cond_expr)				\
 ({									\
 	typeof(ptr) __PTR = (ptr);					\
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 7ae29cfb06c0..9fdf587f059e 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -80,6 +80,19 @@ do {									\
 	___p1;								\
 })
 
+#ifndef __ASSEMBLY__
+/* Guarantee a conditional branch that depends on @cond. */
+static __always_inline bool volatile_cond(bool cond)
+{
+	asm_volatile_goto("and. %0,%0,%0; bne %l[l_yes]"
+			  : : "r" (cond) : "cc", "memory" : l_yes);
+	return false;
+l_yes:
+	return true;
+}
+#define volatile_cond volatile_cond
+#endif
+
 #ifdef CONFIG_PPC_BOOK3S_64
 #define NOSPEC_BARRIER_SLOT   nop
 #elif defined(CONFIG_PPC_FSL_BOOK3E)
diff --git a/arch/s390/include/asm/barrier.h b/arch/s390/include/asm/barrier.h
index f9eddbca79d2..fa78fc1f141b 100644
--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -49,6 +49,9 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/* TSO prohibits the LOAD->STORE reorder. */
+#define volatile_cond(cond)	({ bool __t = (cond); barrier(); __t; })
+
 /**
  * array_index_mask_nospec - generate a mask for array_idx() that is
  * ~0UL when the bounds check succeeds and 0 otherwise
diff --git a/arch/sparc/include/asm/barrier_64.h b/arch/sparc/include/asm/barrier_64.h
index 9fb148bd3c97..dd8e40ad0787 100644
--- a/arch/sparc/include/asm/barrier_64.h
+++ b/arch/sparc/include/asm/barrier_64.h
@@ -56,6 +56,9 @@ do {									\
 #define __smp_mb__before_atomic()	barrier()
 #define __smp_mb__after_atomic()	barrier()
 
+/* TSO prohibits the LOAD->STORE reorder. */
+#define volatile_cond(cond)	({ bool __t = (cond); barrier(); __t; })
+
 #include <asm-generic/barrier.h>
 
 #endif /* !(__SPARC64_BARRIER_H) */
diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index 3ba772a69cc8..2ebdf4e349ff 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -79,6 +79,22 @@ do {									\
 #define __smp_mb__before_atomic()	do { } while (0)
 #define __smp_mb__after_atomic()	do { } while (0)
 
+/* TSO prohibits the LOAD->STORE reorder. */
+#define volatile_cond(cond)	({ bool __t = (cond); barrier(); __t; })
+
+#if 0
+/* For testing the more complicated construct...  */
+static __always_inline bool volatile_cond(bool cond)
+{
+	asm_volatile_goto("test %0,%0; jnz %l[l_yes]"
+			  : : "r" (cond) : "cc", "memory" : l_yes);
+	return false;
+l_yes:
+	return true;
+}
+#define volatile_cond volatile_cond
+#endif
+
 #include <asm-generic/barrier.h>
 
 /*
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 640f09479bdf..a84833f1397b 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -187,6 +187,42 @@ do {									\
 #define virt_store_release(p, v) __smp_store_release(p, v)
 #define virt_load_acquire(p) __smp_load_acquire(p)
 
+/*
+ * 'Generic' wrapper to make volatile_if() below 'work'. Architectures are
+ * encouraged to provide their own implementation. See x86 for TSO and arm64
+ * for a weak example.
+ */
+#ifndef volatile_cond
+#define volatile_cond(cond)	({ bool __t = (cond); smp_mb(); __t; })
+#endif
+
+/**
+ * volatile_if() - Provide a control-dependency
+ *
+ * volatile_if(READ_ONCE(A))
+ *	WRITE_ONCE(B, 1);
+ *
+ * will ensure that the STORE to B happens after the LOAD of A. Normally a
+ * control dependency relies on a conditional branch having a data dependency
+ * on the LOAD and an architecture's inability to speculate STOREs. IOW, this
+ * provides a LOAD->STORE order.
+ *
+ * Due to optimizing compilers extra care is needed; as per the example above
+ * the LOAD must be 'volatile' qualified in order to ensure the compiler
+ * actually emits the load, such that the data-dependency to the conditional
+ * branch can be formed.
+ *
+ * Secondly, the compiler must be prohibited from lifting anything out of the
+ * selection statement, as this would obviously also break the ordering.
+ *
+ * Thirdly, and this is the tricky bit, architectures that allow the
+ * LOAD->STORE reorder must ensure the compiler actually emits the conditional
+ * branch instruction, this isn't possible in generic.
+ *
+ * See the volatile_cond() wrapper.
+ */
+#define volatile_if(cond) if (volatile_cond(cond))
+
 /**
  * smp_acquire__after_ctrl_dep() - Provide ACQUIRE ordering after a control dependency
  *
@@ -216,7 +252,7 @@ do {									\
 	__unqual_scalar_typeof(*ptr) VAL;			\
 	for (;;) {						\
 		VAL = READ_ONCE(*__PTR);			\
-		if (cond_expr)					\
+		volatile_if (cond_expr)				\
 			break;					\
 		cpu_relax();					\
 	}							\
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b8a6e387f8f9..c0165b4b9f1d 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -274,7 +274,7 @@ static inline __must_check bool __refcount_sub_and_test(int i, refcount_t *r, in
 	if (oldp)
 		*oldp = old;
 
-	if (old == i) {
+	volatile_if (old == i) {
 		smp_acquire__after_ctrl_dep();
 		return true;
 	}
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4e4e61111500..1c023829697c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -713,7 +713,7 @@ static int wq_sleep(struct mqueue_inode_info *info, int sr,
 		time = schedule_hrtimeout_range_clock(timeout, 0,
 			HRTIMER_MODE_ABS, CLOCK_REALTIME);
 
-		if (READ_ONCE(ewp->state) == STATE_READY) {
+		volatile_if (READ_ONCE(ewp->state) == STATE_READY) {
 			/* see MQ_BARRIER for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
 			retval = 0;
diff --git a/ipc/msg.c b/ipc/msg.c
index 6e6c8e0c9380..0b0e71fa3fbc 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1213,7 +1213,7 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 		 * signal) it will either see the message and continue ...
 		 */
 		msg = READ_ONCE(msr_d.r_msg);
-		if (msg != ERR_PTR(-EAGAIN)) {
+		volatile_if (msg != ERR_PTR(-EAGAIN)) {
 			/* see MSG_BARRIER for purpose/pairing */
 			smp_acquire__after_ctrl_dep();
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 52868716ec35..7767aabfde9f 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -192,10 +192,10 @@ __perf_output_begin(struct perf_output_handle *handle,
 	do {
 		tail = READ_ONCE(rb->user_page->data_tail);
 		offset = head = local_read(&rb->head);
-		if (!rb->overwrite) {
-			if (unlikely(!ring_buffer_has_space(head, tail,
-							    perf_data_size(rb),
-							    size, backward)))
+		if (likely(!rb->overwrite)) {
+			volatile_if (unlikely(!ring_buffer_has_space(head, tail,
+								     perf_data_size(rb),
+								     size, backward)))
 				goto fail;
 		}
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 809b0016d344..c76ba4e034ae 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -941,8 +941,8 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, int state)
 		 * exit the slowpath and return immediately as its
 		 * RWSEM_READER_BIAS has already been set in the count.
 		 */
-		if (!(atomic_long_read(&sem->count) &
-		     (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
+		volatile_if (!(atomic_long_read(&sem->count) &
+			       (RWSEM_WRITER_MASK | RWSEM_FLAG_HANDOFF))) {
 			/* Provide lock ACQUIRE */
 			smp_acquire__after_ctrl_dep();
 			raw_spin_unlock_irq(&sem->wait_lock);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d559db02e3cb..8038d76cfd56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3760,7 +3760,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
 	 */
 	smp_rmb();
-	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
+	volatile_if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 		goto unlock;
 
 #ifdef CONFIG_SMP
diff --git a/kernel/smp.c b/kernel/smp.c
index 52bf159ec400..3d87af0519c5 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -394,7 +394,7 @@ static void __csd_lock_wait(struct __call_single_data *csd)
 
 	ts1 = ts0 = sched_clock();
 	for (;;) {
-		if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
+		volatile_if (csd_lock_wait_toolong(csd, ts0, &ts1, &bug_id))
 			break;
 		cpu_relax();
 	}
