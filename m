Return-Path: <linux-arch+bounces-14403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB354C1AD55
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0192B663CC3
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E26B3451CB;
	Wed, 29 Oct 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfop2Pyk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1KDDDduN"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540034575E;
	Wed, 29 Oct 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744150; cv=none; b=umLhWe4egpI7+W/0HQzdDElqr37155E74qJk0dL/NbnIhMaVHi8sdBaRPbIpQF1NsNUNCbY1u6fW630Xrlb/yorpXicXri+8JdJhSLAQxgzFArCH5hf0yfB7dD43QnQOaPqoXNm94K2vDV0l4TtmLeWJNgOujpvOO8jz+B7OjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744150; c=relaxed/simple;
	bh=UHXmiBMTC62xAL06thle+HBDfXTrPUw4Yw673HAQL2M=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dxc9tZsjoVhXtszGmiG1qWH2Iz8+4xlzGWIhid1XUOJA6SsFC1JUoasO0N+cdLVrqBl/qxc//ldEdfObTPei/wqGbjbFmxN1B6y/x4bw+RWVmUvCmGm+Ffb6khLkaYVf40GtrUPUrszpRR5iNZxRWa3yYmeVP9IL9vw/BpcWdRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfop2Pyk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1KDDDduN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.923191772@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i/n+PXsZpikXhoZ//1ckNeYYWN4uNlkPxDCb8KzeydQ=;
	b=pfop2PykaDRSZ+cSCGAMqz9qtoUM9zbL9n3sfkgbJF33PbrFBfiHeMDEERFre2mJi5Dc9n
	9t1pmsYQ79SaOijXAJ5iJOWkib/0ndcjH0Cp4tYDFbVQhghmCeHkQ2Z6HyqfOJc+smmzmn
	AZ0ofHH5Cim7JEixnwmNrvavwib8LLvhFj5zB0VCSFFP8LmzL/259Y0NOIG42rBf7HL4cU
	cK2fn/gX6yTjOzpaQLtsqhFlkaLM2bQMJSCgqJzNjXnrMPAvOzXtnZ+z7xSRn359BxZxjo
	Q6DlyO+ngilggngk0PRUD1b6ZGqdJvEDMPuYtnB8pb4aYsisohFSKJI4thfH8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=i/n+PXsZpikXhoZ//1ckNeYYWN4uNlkPxDCb8KzeydQ=;
	b=1KDDDduN8oX1MO9KqJ1I55L/792QuK0YZhmkUVunh7WG8moeiDveG9R5O3owCTjjS6gUIE
	ifQCJDiZXdDHv8DQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
Subject: [patch V3 08/12] rseq: Implement time slice extension enforcement
 timer
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:26 +0100 (CET)

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
V3: Add sysctl documentation, simplify timer cancelation - Sebastian
---
 Documentation/admin-guide/sysctl/kernel.rst |    6 +
 include/linux/rseq_entry.h                  |   38 ++++++---
 include/linux/rseq_types.h                  |    2 
 kernel/rseq.c                               |  115 +++++++++++++++++++++++++++-
 4 files changed, 149 insertions(+), 12 deletions(-)

--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1228,6 +1228,12 @@ reboot-cmd (SPARC only)
 ROM/Flash boot loader. Maybe to tell it what to do after
 rebooting. ???
 
+rseq_slice_extension_nsec
+=========================
+
+A task can request to delay its scheduling if it is in a critical section
+via the prctl(PR_RSEQ_SLICE_EXTENSION_SET) mechanism. This sets the maximum
+allowed extension in nanoseconds before scheduling of the task is enforced.
 
 sched_energy_aware
 ==================
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -86,8 +86,24 @@ static __always_inline bool rseq_slice_e
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
@@ -542,17 +558,19 @@ static __always_inline void clear_tif_rs
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
 
 #endif /* CONFIG_GENERIC_ENTRY */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -89,9 +89,11 @@ union rseq_slice_state {
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
@@ -499,8 +501,78 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
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
@@ -558,10 +630,11 @@ void rseq_syscall_enter_work(long syscal
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
@@ -652,6 +725,31 @@ SYSCALL_DEFINE0(rseq_slice_yield)
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
@@ -664,4 +762,17 @@ static int __init rseq_slice_cmdline(cha
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


