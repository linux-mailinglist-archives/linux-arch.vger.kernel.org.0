Return-Path: <linux-arch+bounces-13430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A43B49D37
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44561BC7684
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D872FC894;
	Mon,  8 Sep 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QOpIu/H6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LiNJzjRC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059013164C0;
	Mon,  8 Sep 2025 23:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372413; cv=none; b=Gz3xKLhfQFFpaDWm+vC45BKLCWwxoKi6QFbjD6p9EDft2FsRdW2FrAFrb6DCf0OR3sNbho+XkhSiTHB2OcSmCNs596kONMab2u5gtXaOHz14Adl9QRPIzCrSxzUYsOcWbC5pd2nfsRpT031TfyOBw0ifaxzEIBJIS9Q7yxHuRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372413; c=relaxed/simple;
	bh=LCzu9gsThD++K9Z4jiB9FCpsAPny/CGoSg1pucBo7VU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=E8jKiFV9iPio6/rUR2IBkbZpj3wioZmKd0PUD1Gwv8qMEaGbB/QgybuIhvC8m9GU7i4rlEQ0/98hRiTEXYCNm/eLppWHO1MbynEGEkrco8DBCqp/4+fQW2qD3Il46qUXkCSin0oMZG0Qu+7iziTm2R2/wCvRrG6k5LYHnmkoQnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QOpIu/H6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LiNJzjRC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225753.077967162@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a/EPeIza24SnyAPRjSd15cR2KiBIkb5IAQQ8qLaLMZE=;
	b=QOpIu/H6K6kGbNEdtM3K/n+rAnb+kjHeJiwZAkXQFJdOuQn9BHx4zPgjRxIpJAott/QubE
	JSWsrDsqu8YC8aI1X0sOhcZwwHxeQEc9fulOsHdI7xov1RDi2k145X3YnIA3GuwzmgQ2KK
	uf5L+Lksfp9Xhv3xgB1Z/CUsV8gKVG09eywAVGFWSl0oeOBUSI/nJijXItYMg8/W7w2fvR
	Y6lyY0o2ifVvuOAvV7iqULl4J+n7K3BF2p48B9ZgM3amYRZLHwQAO4yOA9/ZkZfER2F02W
	NoHwVx4s64Qi843wiTszZ2PJ+tPpcu9mOsAQNdLZJNn2MusT6MZbtqPjY2Rijw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a/EPeIza24SnyAPRjSd15cR2KiBIkb5IAQQ8qLaLMZE=;
	b=LiNJzjRCpQXHpas7uMEg88ZbDAN3IC/YH5r99an+663yzDFalIWBWIamfCn0c6Za2i/DUK
	LG9Qt1vmi/gI22CQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
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
Subject: [patch 08/12] rseq: Implement time slice extension enforcement timer
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 01:00:07 +0200 (CEST)

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

The timer is armed when an extenstion was granted right before actually
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
 include/linux/rseq_entry.h |   22 +++++++-
 include/linux/rseq_types.h |    2 
 kernel/rseq.c              |  119 ++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 140 insertions(+), 3 deletions(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -88,8 +88,24 @@ static __always_inline bool rseq_slice_e
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
@@ -560,8 +576,12 @@ static __always_inline void clear_tif_rs
 static __always_inline bool
 rseq_exit_to_user_mode_restart(struct pt_regs *regs, unsigned long ti_work)
 {
+	/*
+	 * Arm the slice extension timer if nothing to do anymore and the
+	 * task really goes out to user space.
+	 */
 	if (likely(!test_tif_rseq(ti_work)))
-		return false;
+		return rseq_arm_slice_extension_timer();
 
 	if (unlikely(__rseq_exit_to_user_mode_restart(regs)))
 		return true;
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -87,9 +87,11 @@ union rseq_slice_state {
 /**
  * struct rseq_slice - Status information for rseq time slice extension
  * @state:	Time slice extension state
+ * @expires:	The time when a grant expires
  */
 struct rseq_slice {
 	union rseq_slice_state	state;
+	u64			expires;
 };
 
 /**
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
@@ -489,8 +491,82 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
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
 
+static enum hrtimer_restart rseq_slice_expired(struct hrtimer *tmr)
+{
+	struct slice_timer *st = container_of(tmr, struct slice_timer, timer);
+
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
+	 * This check prevents that a granted time slice extension exceeds
+	 * the maximum scheduling latency when the grant expired before
+	 * going out to user space. Don't bother to clear the grant here,
+	 * it will be cleaned up automatically before going out to user
+	 * space.
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
+	 * timer is CPU local. The active check can obviously race with the
+	 * hrtimer interrupt, but that's better than disabling interrupts
+	 * unconditionaly right away.
+	 *
+	 * As this is most probably the first expiring timer, the cancel is
+	 * expensive as it has to reprogram the hardware, but that's less
+	 * expensive than going through a full hrtimer_interrupt() cycle
+	 * for nothing.
+	 *
+	 * hrtimer_try_to_cancel() is sufficient here as with interrupts
+	 * disabled the timer callback cannot be running and the timer base
+	 * is well determined as the timer is pinned on the local CPU.
+	 */
+	if (st->cookie == current && hrtimer_active(&st->timer)) {
+		scoped_guard(irq)
+			hrtimer_try_to_cancel(&st->timer);
+	}
+}
+
 static inline void rseq_slice_set_need_resched(struct task_struct *curr)
 {
 	/*
@@ -548,10 +624,11 @@ void rseq_syscall_enter_work(long syscal
 	rseq_stat_inc(rseq_stats.s_yielded);
 
 	/*
-	 * Required to make set_tsk_need_resched() correct on PREEMPT[RT]
-	 * kernels.
+	 * Required to stabilize the per CPU timer pointer and to make
+	 * set_tsk_need_resched() correct on PREEMPT[RT] kernels.
 	 */
 	scoped_guard(preempt) {
+		rseq_cancel_slice_extension_timer();
 		/*
 		 * Now that preemption is disabled, quickly check whether
 		 * the task was already rescheduled before arriving here.
@@ -631,6 +708,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
 	return 0;
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
@@ -643,4 +745,17 @@ static int __init rseq_slice_cmdline(cha
 	return 0;
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


