Return-Path: <linux-arch+bounces-14266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EFBFC13E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE56C5E5670
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91FD3570D2;
	Wed, 22 Oct 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aFS1tPyo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F2uVvzdp"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7A834C83D;
	Wed, 22 Oct 2025 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137863; cv=none; b=GgsbIVAoZG+gEf3HrWVbxhkYRw3KdV/kVrKaLupWGdxN1g1QaNIbzDTJeSWZSxbmbGn0Uei9GP7G1nebmv+R50ercGhMcy5PVv6iKF86CE7T6pDMOBW1QXVHRF1MR3mldKZWDwyqg8gNLsNrHDZ89TKLkbPSMfbAzGkxizhLVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137863; c=relaxed/simple;
	bh=FVt/w1tPFVwP776ZNQHgDVyZaTWq5HNF3vIwjsxVzmc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=oIGwNSIAUiyL6JRnYdNUVyQNJIKwA+SEsIofJs7MvFNU1JFwdFc5lu/f1tT8M6BLpI0lwfu0fMfvkmSHDvthD62B1F2jEwiAfxKt/pJn3xRWoq1RqgtJWAdYPbQ1cpCNeiKpJVW8nFZO6xkcNSHWRYS9HrrUTyZBfH3fzp1xYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aFS1tPyo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F2uVvzdp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.343634020@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+nxxlkQIx6Xopf7jfK2xjZglOpx9PEne0d/WjY3gK44=;
	b=aFS1tPyowZ9j3fjVwUcnzi09XobfrnRCKkIx2ZZ3p7j991OAiiviqXC5Y2u4g5mHrfYRDl
	63iF2E1/Lseu5gl0ZvB0ejbd+hDI6NZHoWyFt6QKECaKJ1iKiL3vmDUjmEeksZWZF76f8b
	+TVmb3kigFAuYtkhlCuoXKM6ikI68yrwb+2GushrzGBuYfDOEiFZ2wMXAykK8QXPFbnQFf
	LQYNzZrm8Uzl998XWBrXY9EnESY664hmJ9zPGD9nJ8oqf6CK7RAajZGGewx6eq51Af6GeB
	fPQdmzkcD4Ing8KHgVxe2/xGBFZykdK/0hpap5Bh/IcDqqxLZhFfrZbROP/JRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=+nxxlkQIx6Xopf7jfK2xjZglOpx9PEne0d/WjY3gK44=;
	b=F2uVvzdprC1YnrAEM5M0/nPp1rZscuUNa4gbex8sp5lh3e0Lrg7+TjoBndNs9a4s+8i18J
	fNLZULK0ilDGDYBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Peter Zilstra <peterz@infradead.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: [patch V2 07/12] rseq: Implement syscall entry work for time slice
 extensions
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:37 +0200 (CEST)

The kernel sets SYSCALL_WORK_RSEQ_SLICE when it grants a time slice
extension. This allows to handle the rseq_slice_yield() syscall, which is
used by user space to relinquish the CPU after finishing the critical
section for which it requested an extension.

In case the kernel state is still GRANTED, the kernel resets both kernel
and user space state with a set of sanity checks. If the kernel state is
already cleared, then this raced against the timer or some other interrupt
and just clears the work bit.

Doing it in syscall entry work allows to catch misbehaving user space,
which issues a syscall from the critical section. Wrong syscall and
inconsistent user space result in a SIGSEGV.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/entry-common.h  |    2 -
 include/linux/rseq.h          |    2 +
 include/linux/thread_info.h   |   16 ++++----
 kernel/entry/syscall-common.c |   11 ++++-
 kernel/rseq.c                 |   80 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 10 deletions(-)

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
@@ -165,8 +165,10 @@ static inline void rseq_syscall(struct p
 #endif /* !CONFIG_DEBUG_RSEQ */
 
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
+void rseq_syscall_enter_work(long syscall);
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline void rseq_syscall_enter_work(long syscall) { }
 static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 {
 	return -EINVAL;
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
@@ -501,6 +501,86 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
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
+	if (!get_user_scoped(uval, sctrl) || uval != expected)
+		force_sig(SIGSEGV);
+}
+
+/*
+ * Invoked from syscall entry if a time slice extension was granted and the
+ * kernel did not clear it before user space left the critical section.
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
+	rseq_stat_inc(rseq_stats.s_yielded);
+
+	/*
+	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
+	 * kernels.
+	 */
+	scoped_guard(preempt) {
+		/*
+		 * Now that preemption is disabled, quickly check whether
+		 * the task was already rescheduled before arriving here.
+		 */
+		if (!curr->rseq.event.sched_switch)
+			rseq_slice_set_need_resched(curr);
+	}
+
+	curr->rseq.slice.state.granted = false;
+	/*
+	 * Clear the grant in user space and check whether this was the
+	 * correct syscall to yield. If the user access fails or the task
+	 * used an arbitrary syscall, terminate it.
+	 */
+	if (!put_user_scoped(0U, &curr->rseq.usrptr->slice_ctrl.all) ||
+	    syscall != __NR_rseq_slice_yield)
+		force_sig(SIGSEGV);
+}
+
 int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
 {
 	switch (arg2) {


