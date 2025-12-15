Return-Path: <linux-arch+bounces-15438-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E59DCBF697
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7970D3002FDC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12968313E1D;
	Mon, 15 Dec 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xq9iDJjK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WhgLngUa"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3C932694F;
	Mon, 15 Dec 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823095; cv=none; b=Ri2Rk3GjLtrh8buoLsvI7gJr6RCnwF28YaK0bJqjnAMsIMQzsyX6d//nCEtOabDnIzRUMsbQO9QgV6iR+yy135GRA1OESpd+bT/Vmp3+xouWt6N0Ru3GrD4URVLKdRiqsdVm0UwC5cLh92/a9fV6Ew6CSD3Wo2oIUIz0d6Erk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823095; c=relaxed/simple;
	bh=lwvh2C66j2bWcWjmCzLzNMj7pjbjkd1Fb70fysY6j5E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=UyRZ1Hy1GKVpEQzLiksS5qrvcLYMenEXJwEvAOXuEs0CfZYH7VnZJJpxajJjH5DbDlD72zdl0wnRmLGVXS5wYSO9S80YptaT3+LXEr+ahjyFS22SOf61WA1RZPxvDJ/BETnmtEp5po9AX1f88lBjrkfirYwX+TBAIDIqRjFH0b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xq9iDJjK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WhgLngUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155709.005777059@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=m9XMlb/Z6i+Glqy95yaIqKRlvoH6/pHt4rtgW9j0+As=;
	b=Xq9iDJjKhY5B37HWDxrDrUiy0Wn6yUbDku7ig7tmT2ebv/Ff/BimbAy4R+XUKmgQK0OL5C
	uYKMFMYSaDUg32lxwotT3l71YUer/XD53LdcTiolkfcAHmtJfNr5NnKFSDmJD0VAUjhaIi
	cuOax3lPc5P5uXJ4ZeuBd2J+XY9YHEB87C4y4ZWoir/aS/J+vp7uJ9NIoL9+waBQNF8e6y
	d40Xs/iXKXhBLH3hBHeGlhz5GfI2uXs3MfCIj2sp9EnahHywV/B7EagVzlLDRnhk09jrEK
	I+qMNtndO/T3rI/8K4GptNWbFDmwFzSqUoiVj8TGRrk7pVU6XBMS+uqz24RnIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=m9XMlb/Z6i+Glqy95yaIqKRlvoH6/pHt4rtgW9j0+As=;
	b=WhgLngUakdg8kV0DEAwGcnmNo0gLecZILnNRrIu3biyOpWjegiSoX4NEgfVJYU21LNY+/g
	ODTDYxUgLo2V/WDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch V6 06/11] rseq: Implement syscall entry work for time slice
 extensions
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 19:24:48 +0100 (CET)

The kernel sets SYSCALL_WORK_RSEQ_SLICE when it grants a time slice
extension. This allows to handle the rseq_slice_yield() syscall, which is
used by user space to relinquish the CPU after finishing the critical
section for which it requested an extension.

In case the kernel state is still GRANTED, the kernel resets both kernel
and user space state with a set of sanity checks. If the kernel state is
already cleared, then this raced against the timer or some other interrupt
and just clears the work bit.

Doing it in syscall entry work allows to catch misbehaving user space,
which issues an arbitrary syscall, i.e. not rseq_slice_yield(), from the
critical section. Contrary to the initial strict requirement to use
rseq_slice_yield() arbitrary syscalls are not considered a violation of the
ABI contract anymore to allow onion architecture applications, which cannot
control the code inside a critical section, to utilize this as well.

If the code detects inconsistent user space that result in a SIGSEGV for
the application.

If the grant was still active and the task was not preempted yet, the work
code reschedules immediately before continuing through the syscall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
V5: Allow arbitrary syscalls
V3: Use get/put_user()
---
 include/linux/entry-common.h  |    2 
 include/linux/rseq.h          |    2 
 include/linux/thread_info.h   |   16 ++++---
 kernel/entry/syscall-common.c |   11 ++++-
 kernel/rseq.c                 |   91 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 10 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -36,8 +36,8 @@
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
+				 SYSCALL_WORK_SYSCALL_RSEQ_SLICE |	\
 				 ARCH_SYSCALL_WORK_ENTER)
-
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -164,8 +164,10 @@ static inline void rseq_syscall(struct p
 #endif /* !CONFIG_DEBUG_RSEQ */
 
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
+void rseq_syscall_enter_work(long syscall);
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline void rseq_syscall_enter_work(long syscall) { }
 static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 {
 	return -ENOTSUPP;
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -46,15 +46,17 @@ enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SYSCALL_AUDIT,
 	SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH,
 	SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP,
+	SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE,
 };
 
-#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
-#define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
-#define SYSCALL_WORK_SYSCALL_TRACE	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
-#define SYSCALL_WORK_SYSCALL_EMU	BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
-#define SYSCALL_WORK_SYSCALL_AUDIT	BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
-#define SYSCALL_WORK_SYSCALL_USER_DISPATCH BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
-#define SYSCALL_WORK_SYSCALL_EXIT_TRAP	BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+#define SYSCALL_WORK_SECCOMP			BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SYSCALL_TRACEPOINT		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
+#define SYSCALL_WORK_SYSCALL_TRACE		BIT(SYSCALL_WORK_BIT_SYSCALL_TRACE)
+#define SYSCALL_WORK_SYSCALL_EMU		BIT(SYSCALL_WORK_BIT_SYSCALL_EMU)
+#define SYSCALL_WORK_SYSCALL_AUDIT		BIT(SYSCALL_WORK_BIT_SYSCALL_AUDIT)
+#define SYSCALL_WORK_SYSCALL_USER_DISPATCH	BIT(SYSCALL_WORK_BIT_SYSCALL_USER_DISPATCH)
+#define SYSCALL_WORK_SYSCALL_EXIT_TRAP		BIT(SYSCALL_WORK_BIT_SYSCALL_EXIT_TRAP)
+#define SYSCALL_WORK_SYSCALL_RSEQ_SLICE		BIT(SYSCALL_WORK_BIT_SYSCALL_RSEQ_SLICE)
 #endif
 
 #include <asm/thread_info.h>
--- a/kernel/entry/syscall-common.c
+++ b/kernel/entry/syscall-common.c
@@ -17,8 +17,7 @@ static inline void syscall_enter_audit(s
 	}
 }
 
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-				unsigned long work)
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work)
 {
 	long ret = 0;
 
@@ -32,6 +31,14 @@ long syscall_trace_enter(struct pt_regs
 			return -1L;
 	}
 
+	/*
+	 * User space got a time slice extension granted and relinquishes
+	 * the CPU. The work stops the slice timer to avoid an extra round
+	 * through hrtimer_interrupt().
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_RSEQ_SLICE)
+		rseq_syscall_enter_work(syscall);
+
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = ptrace_report_syscall_entry(regs);
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -502,6 +502,97 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
 
+static inline void rseq_slice_set_need_resched(struct task_struct *curr)
+{
+	/*
+	 * The interrupt guard is required to prevent inconsistent state in
+	 * this case:
+	 *
+	 * set_tsk_need_resched()
+	 * --> Interrupt
+	 *       wakeup()
+	 *        set_tsk_need_resched()
+	 *	  set_preempt_need_resched()
+	 *     schedule_on_return()
+	 *        clear_tsk_need_resched()
+	 *	  clear_preempt_need_resched()
+	 * set_preempt_need_resched()		<- Inconsistent state
+	 *
+	 * This is safe vs. a remote set of TIF_NEED_RESCHED because that
+	 * only sets the already set bit and does not create inconsistent
+	 * state.
+	 */
+	scoped_guard(irq)
+		set_need_resched_current();
+}
+
+static void rseq_slice_validate_ctrl(u32 expected)
+{
+	u32 __user *sctrl = &current->rseq.usrptr->slice_ctrl.all;
+	u32 uval;
+
+	if (get_user(uval, sctrl) || uval != expected)
+		force_sig(SIGSEGV);
+}
+
+/*
+ * Invoked from syscall entry if a time slice extension was granted and the
+ * kernel did not clear it before user space left the critical section.
+ *
+ * While the recommended way to relinquish the CPU side effect free is
+ * rseq_slice_yield(2), any syscall within a granted slice terminates the
+ * grant and immediately reschedules if required. This supports onion layer
+ * applications, where the code requesting the grant cannot control the
+ * code within the critical section.
+ */
+void rseq_syscall_enter_work(long syscall)
+{
+	struct task_struct *curr = current;
+	struct rseq_slice_ctrl ctrl = { .granted = curr->rseq.slice.state.granted };
+
+	clear_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		rseq_slice_validate_ctrl(ctrl.all);
+
+	/*
+	 * The kernel might have raced, revoked the grant and updated
+	 * userspace, but kept the SLICE work set.
+	 */
+	if (!ctrl.granted)
+		return;
+
+	/*
+	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
+	 * kernels. Leaving the scope will reschedule on preemption models
+	 * FULL, LAZY and RT if necessary.
+	 */
+	scoped_guard(preempt) {
+		/*
+		 * Now that preemption is disabled, quickly check whether
+		 * the task was already rescheduled before arriving here.
+		 */
+		if (!curr->rseq.event.sched_switch) {
+			rseq_slice_set_need_resched(curr);
+
+			if (syscall == __NR_rseq_slice_yield) {
+				rseq_stat_inc(rseq_stats.s_yielded);
+				/* Update the yielded state for syscall return */
+				curr->rseq.slice.yielded = 1;
+			} else {
+				rseq_stat_inc(rseq_stats.s_aborted);
+			}
+		}
+	}
+	/* Reschedule on NONE/VOLUNTARY preemption models */
+	cond_resched();
+
+	/* Clear the grant in kernel state and user space */
+	curr->rseq.slice.state.granted = false;
+	if (put_user(0U, &curr->rseq.usrptr->slice_ctrl.all))
+		force_sig(SIGSEGV);
+}
+
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 {
 	switch (arg2) {


