Return-Path: <linux-arch+bounces-15439-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD28FCBF6E9
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14CF3307A9E6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA0D23D7D0;
	Mon, 15 Dec 2025 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ff2bW+dq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7SzrFFXz"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507553254A9;
	Mon, 15 Dec 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823097; cv=none; b=HUMXTY0BStERNhPOS4dptx2PvCh9aiMoisS7GdYIxxnNFVa/qoWrlCvL57dON0+h+I8DlQX3/Ihc8chey4IKfClBTOpnAEgk8SnwHBp8LRQCtsJELLg1noJ5oRFmJeNZq2RzsYVPm/Aa0mSFlK7nVnZYbiBxtf/hcGf12hhJZQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823097; c=relaxed/simple;
	bh=ksk3lXBB6m6szYrZY8vsRYqTZrbVE9s0SsFIggxJOm4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=CoX2o132d0stqM3CR+Pzha3NuKSHLMVABou9OHzkIeXzNZz7KgvBBS0Ck/6iNmELU96+FF2KSMoLQrMnn+d53iGG+KbuTpAOr8UBozgjFNmPKXTQjak9LjDRPpIEU4deHQrKRgMDnz6QD72Ufkg1peqDvh4EPTmV+FlCu52oCFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ff2bW+dq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7SzrFFXz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155709.068329497@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T74kfdoSx6I0YExuYpqY2E9AnnB+v/Tg599Py9lXJOg=;
	b=ff2bW+dq9t9GlPoHPNnFSNCuAaI8EfNcNY+4F53C2zDS3iGMOiAgCWPbo8lemlxZDNcBXF
	gQqpqAJ/SKsPLZahrcXHxQvCaE+9Ej/ZlRmT+94iyOuQPbb1l2WrLR/tojPcHI9xgJr9SL
	wIgSMqDvRjC6aj6b69P9EaQc1EpIKqlkHEPZMcQePdyguaAsUPbAuh1cadpYObbAEA+fYL
	Ht+sSHk+Y36dJSg4pG+zcv29CuK2S5aH6aPjs1hGBFY3m86Z6DVXeqa+6TwgANPLWbBSJ3
	fm2s9jK2WkJR1U3oZhqFrnhRD+Wpx3RtACoMLsUCiTrOgETSSf9+qnqShj1ZPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=T74kfdoSx6I0YExuYpqY2E9AnnB+v/Tg599Py9lXJOg=;
	b=7SzrFFXzHVSxHDb4c2xj1kIXPlZxLMA+JnoFc1N++r4EDxmwnYUp4Ja4ObSC5/zqGj6Yzu
	uuy7qyaj+fkS87Dw==
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
Subject: [patch V6 07/11] rseq: Implement time slice extension enforcement
 timer
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 19:24:50 +0100 (CET)

If a time slice extension is granted and the reschedule delayed, the kernel
has to ensure that user space cannot abuse the extension and exceed the
maximum granted time.

It was suggested to implement this via the existing hrtick() timer in the
scheduler, but that turned out to be problematic for several reasons:

   1) It creates a dependency on CONFIG_SCHED_HRTICK, which can be disabled
      independently of CONFIG_HIGHRES_TIMERS

   2) HRTICK usage in the scheduler can be runtime disabled or is only used
      for certain aspects of scheduling.

   3) The function is calling into the scheduler code and that might have
      unexpected consequences when this is invoked due to a time slice
      enforcement expiry. Especially when the task managed to clear the
      grant via sched_yield(0).

It would be possible to address #2 and #3 by storing state in the
scheduler, but that is extra complexity and fragility for no value.

Implement a dedicated per CPU hrtimer instead, which is solely used for the
purpose of time slice enforcement.

The timer is armed when an extension was granted right before actually
returning to user mode in rseq_exit_to_user_mode_restart().

It is disarmed, when the task relinquishes the CPU. This is expensive as
the timer is probably the first expiring timer on the CPU, which means it
has to reprogram the hardware. But that's less expensive than going through
a full hrtimer interrupt cycle for nothing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
V5: Document the slice extension range - PeterZ
V4: Update comment - Steven
V3: Add sysctl documentation, simplify timer cancelation - Sebastian
---
 Documentation/admin-guide/sysctl/kernel.rst |    8 +
 include/linux/rseq_entry.h                  |   38 +++++---
 include/linux/rseq_types.h                  |    2 
 kernel/rseq.c                               |  132 +++++++++++++++++++++++++++-
 4 files changed, 167 insertions(+), 13 deletions(-)

--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1228,6 +1228,14 @@ reboot-cmd (SPARC only)
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
 
+rseq_slice_extension_nsec
+=========================
+
+A task can request to delay its scheduling if it is in a critical section
+via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
+allowed extension in nanoseconds before scheduling of the task is enforced.
+Default value is 30000ns (30us). The possible range is 10000ns (10us) to
+50000ns (50us).
 
 sched_energy_aware
 ==================
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -87,8 +87,24 @@ static __always_inline bool rseq_slice_e
 {
 	return static_branch_likely(&rseq_slice_extension_key);
 }
+
+extern unsigned int rseq_slice_ext_nsecs;
+bool __rseq_arm_slice_extension_timer(void);
+
+static __always_inline bool rseq_arm_slice_extension_timer(void)
+{
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	if (likely(!current->rseq.slice.state.granted))
+		return false;
+
+	return __rseq_arm_slice_extension_timer();
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
+static inline bool rseq_arm_slice_extension_timer(void) { return false; }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
@@ -543,17 +559,19 @@ static __always_inline void clear_tif_rs
 static __always_inline bool
 rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
 {
-	if (likely(!test_tif_rseq(ti_work)))
-		return false;
-
-	if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
-		current->rseq.event.slowpath = true;
-		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
-		return true;
+	if (unlikely(test_tif_rseq(ti_work))) {
+		if (unlikely(__rseq_exit_to_user_mode_restart(regs))) {
+			current->rseq.event.slowpath = true;
+			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+			return true;
+		}
+		clear_tif_rseq();
 	}
-
-	clear_tif_rseq();
-	return false;
+	/*
+	 * Arm the slice extension timer if nothing to do anymore and the
+	 * task really goes out to user space.
+	 */
+	return rseq_arm_slice_extension_timer();
 }
 
 #else /* CONFIG_GENERIC_ENTRY */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -89,10 +89,12 @@ union rseq_slice_state {
 /**
  * struct rseq_slice - Status information for rseq time slice extension
  * @state:	Time slice extension state
+ * @expires:	The time when a grant expires
  * @yielded:	Indicator for rseq_slice_yield()
  */
 struct rseq_slice {
 	union rseq_slice_state	state;
+	u64			expires;
 	u8			yielded;
 };
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -71,6 +71,8 @@
 #define RSEQ_BUILD_SLOW_PATH
 
 #include <linux/debugfs.h>
+#include <linux/hrtimer.h>
+#include <linux/percpu.h>
 #include <linux/prctl.h>
 #include <linux/ratelimit.h>
 #include <linux/rseq_entry.h>
@@ -500,8 +502,91 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 }
 
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
+struct slice_timer {
+	struct hrtimer	timer;
+	void		*cookie;
+};
+
+unsigned int rseq_slice_ext_nsecs __read_mostly = 30 * NSEC_PER_USEC;
+static DEFINE_PER_CPU(struct slice_timer, slice_timer);
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
 
+/*
+ * When the timer expires and the task is still in user space, the return
+ * from interrupt will revoke the grant and schedule. If the task already
+ * entered the kernel via a syscall and the timer fires before the syscall
+ * work was able to cancel it, then depending on the preemption model this
+ * will either reschedule on return from interrupt or in the syscall work
+ * below.
+ */
+static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
+{
+	struct slice_timer *st = container_of(tmr, struct slice_timer, timer);
+
+	/*
+	 * Validate that the task which armed the timer is still on the
+	 * CPU. It could have been scheduled out without canceling the
+	 * timer.
+	 */
+	if (st->cookie == current && current->rseq.slice.state.granted) {
+		rseq_stat_inc(rseq_stats.s_expired);
+		set_need_resched_current();
+	}
+	return HRTIMER_NORESTART;
+}
+
+bool __rseq_arm_slice_extension_timer(void)
+{
+	struct slice_timer *st = this_cpu_ptr(&slice_timer);
+	struct task_struct *curr = current;
+
+	lockdep_assert_irqs_disabled();
+
+	/*
+	 * This check prevents a task, which got a time slice extension
+	 * granted, from exceeding the maximum scheduling latency when the
+	 * grant expired before going out to user space. Don't bother to
+	 * clear the grant here, it will be cleaned up automatically before
+	 * going out to user space after being scheduled back in.
+	 */
+	if ((unlikely(curr->rseq.slice.expires < ktime_get_mono_fast_ns()))) {
+		set_need_resched_current();
+		return true;
+	}
+
+	/*
+	 * Store the task pointer as a cookie for comparison in the timer
+	 * function. This is safe as the timer is CPU local and cannot be
+	 * in the expiry function at this point.
+	 */
+	st->cookie = curr;
+	hrtimer_start(&st->timer, curr->rseq.slice.expires, HRTIMER_MODE_ABS_PINNED_HARD);
+	/* Arm the syscall entry work */
+	set_task_syscall_work(curr, SYSCALL_RSEQ_SLICE);
+	return false;
+}
+
+static void rseq_cancel_slice_extension_timer(void)
+{
+	struct slice_timer *st = this_cpu_ptr(&slice_timer);
+
+	/*
+	 * st->cookie can be safely read as preemption is disabled and the
+	 * timer is CPU local.
+	 *
+	 * As this is most probably the first expiring timer, the cancel is
+	 * expensive as it has to reprogram the hardware, but that's less
+	 * expensive than going through a full hrtimer_interrupt() cycle
+	 * for nothing.
+	 *
+	 * hrtimer_try_to_cancel() is sufficient here as the timer is CPU
+	 * local and once the hrtimer code disabled interrupts the timer
+	 * callback cannot be running.
+	 */
+	if (st->cookie == current)
+		hrtimer_try_to_cancel(&st->timer);
+}
+
 static inline void rseq_slice_set_need_resched(struct task_struct *curr)
 {
 	/*
@@ -563,11 +648,14 @@ void rseq_syscall_enter_work(long syscal
 		return;
 
 	/*
-	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
-	 * kernels. Leaving the scope will reschedule on preemption models
-	 * FULL, LAZY and RT if necessary.
+	 * Required to stabilize the per CPU timer pointer and to make
+	 * set_tsk_need_resched() correct on PREEMPT[RT] kernels.
+	 *
+	 * Leaving the scope will reschedule on preemption models FULL,
+	 * LAZY and RT if necessary.
 	 */
 	scoped_guard(preempt) {
+		rseq_cancel_slice_extension_timer();
 		/*
 		 * Now that preemption is disabled, quickly check whether
 		 * the task was already rescheduled before arriving here.
@@ -665,6 +753,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
 	return yielded;
 }
 
+#ifdef CONFIG_SYSCTL
+static const unsigned int rseq_slice_ext_nsecs_min = 10 * NSEC_PER_USEC;
+static const unsigned int rseq_slice_ext_nsecs_max = 50 * NSEC_PER_USEC;
+
+static const struct ctl_table rseq_slice_ext_sysctl[] = {
+	{
+		.procname	= "rseq_slice_extension_nsec",
+		.data		= &rseq_slice_ext_nsecs,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= (unsigned int *)&rseq_slice_ext_nsecs_min,
+		.extra2		= (unsigned int *)&rseq_slice_ext_nsecs_max,
+	},
+};
+
+static void rseq_slice_sysctl_init(void)
+{
+	if (rseq_slice_extension_enabled())
+		register_sysctl_init("kernel", rseq_slice_ext_sysctl);
+}
+#else /* CONFIG_SYSCTL */
+static inline void rseq_slice_sysctl_init(void) { }
+#endif  /* !CONFIG_SYSCTL */
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
@@ -677,4 +790,17 @@ static int __init rseq_slice_cmdline(cha
 	return 1;
 }
 __setup("rseq_slice_ext=", rseq_slice_cmdline);
+
+static int __init rseq_slice_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		hrtimer_setup(per_cpu_ptr(&slice_timer.timer, cpu), rseq_slice_expired,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED_HARD);
+	}
+	rseq_slice_sysctl_init();
+	return 0;
+}
+device_initcall(rseq_slice_init);
 #endif /* CONFIG_RSEQ_SLICE_EXTENSION */


