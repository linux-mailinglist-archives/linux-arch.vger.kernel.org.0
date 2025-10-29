Return-Path: <linux-arch+bounces-14396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EBC1AF20
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B533F561CCC
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB316330303;
	Wed, 29 Oct 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtHfZZ2W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDIchJJi"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763B2FFFA9;
	Wed, 29 Oct 2025 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744139; cv=none; b=fW+r1Y/Ht3VPbXjNb+r5ePHyUTNxyYdANz+qkAW2BeB4JeaQlUrdP5q7faZPoVkUoeOOWWbvCWctu4amN4NSYhNjIiQY+hSGeb6WVEVculHuG3mJxd2r5CJSipa1D83cSq1mYwR1/8zlu4krV+mxhf/EN1CDhAsb8zc6W1PHlQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744139; c=relaxed/simple;
	bh=9hKJ62qRumSYPajdKUalFip3RljCJYdn2MyOAH/gVzA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=b+nY2g3Y7L/gaD7Bxydjtw3mVZC2Qh3/xoT9k24Z8RKcQTgTk+FadpivbwfGK+hOR7IzEL4D4m6BPq1dsMfPyfRLGLPZCadprTRW75Ivw/L5IDyBcOTuZVUf9s18IqIJR/dgZkoe8VxZt0xo02Ra70FfljkRXGG5g2U9TFYjS84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtHfZZ2W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDIchJJi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.478719754@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2g38H2t97CfuEItSmZo2neOje1ClgHPr6tKCh0GHxNk=;
	b=UtHfZZ2WSxYsxH1YSW1Me9uvRZU6s7C3FVAbHuk5NoTfHrRjWuibUGYKkc0Dr4wRiV4m+g
	e/syHXk1a4co6VMtewvGfvykbdBOmsSCQnV6xLyeF0hr8c3HKoFNLfCmbw5WNi/1i+OSWp
	ezI8P96bd9WbcImW9YSxp/fDi1vcAhJU3ZX+sCk9UsvzVAluvbem05UOuwuhcN846YfHOr
	drvuBQkTC6jZkOSIdP8wDrwyqO5quOcr0sPbif3w1SfX0tbnnBAsUVrzGBtbp8tFDGIEIg
	5nS0ElyO3KCn8X4IMd7RgR+Rwcy8JrRQMWYcKdiAbEg/9Q9/hSUlphbfPqG8IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=2g38H2t97CfuEItSmZo2neOje1ClgHPr6tKCh0GHxNk=;
	b=bDIchJJidLFMyph+JHmL7nIR/1UhYxvKx1l8tq00+K/mU7tIOka+CJx3vPKC9K9gnTxFs4
	/Cc8vByT/lBuJ4CA==
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
Subject: [patch V3 01/12] sched: Provide and use set_need_resched_current()
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:12 +0100 (CET)

From: Peter Zijlstra <peterz@infradead.org>

set_tsk_need_resched(current) requires set_preempt_need_resched(current) to
work correctly outside of the scheduler.

Provide set_need_resched_current() which wraps this correctly and replace
all the open coded instances.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/s390/mm/pfault.c    |    3 +--
 include/linux/sched.h    |    7 +++++++
 kernel/rcu/tiny.c        |    8 +++-----
 kernel/rcu/tree.c        |   14 +++++---------
 kernel/rcu/tree_exp.h    |    3 +--
 kernel/rcu/tree_plugin.h |    9 +++------
 kernel/rcu/tree_stall.h  |    3 +--
 7 files changed, 21 insertions(+), 26 deletions(-)

--- a/arch/s390/mm/pfault.c
+++ b/arch/s390/mm/pfault.c
@@ -199,8 +199,7 @@ static void pfault_interrupt(struct ext_
 			 * return to userspace schedule() to block.
 			 */
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			set_tsk_need_resched(tsk);
-			set_preempt_need_resched();
+			set_need_resched_current();
 		}
 	}
 out:
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2033,6 +2033,13 @@ static inline int test_tsk_need_resched(
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
+static inline void set_need_resched_current(void)
+{
+	lockdep_assert_irqs_disabled();
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -70,12 +70,10 @@ void rcu_qs(void)
  */
 void rcu_sched_clock_irq(int user)
 {
-	if (user) {
+	if (user)
 		rcu_qs();
-	} else if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
-	}
+	else if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail)
+		set_need_resched_current();
 }
 
 /*
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2696,10 +2696,8 @@ void rcu_sched_clock_irq(int user)
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
-		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
-		}
+		if (!rcu_is_cpu_rrupt_from_idle() && !user)
+			set_need_resched_current();
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
 	rcu_flavor_sched_clock_irq(user);
@@ -2824,7 +2822,6 @@ static void strict_work_handler(struct w
 /* Perform RCU core processing work for the current CPU.  */
 static __latent_entropy void rcu_core(void)
 {
-	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -2837,8 +2834,8 @@ static __latent_entropy void rcu_core(vo
 	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
+		guard(irqsave)();
+		set_need_resched_current();
 	}
 
 	/* Update RCU state based on any recent quiescent states. */
@@ -2847,10 +2844,9 @@ static __latent_entropy void rcu_core(vo
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
-		local_irq_save(flags);
+		guard(irqsave)();
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		local_irq_restore(flags);
 	}
 
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -729,8 +729,7 @@ static void rcu_exp_need_qs(void)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	set_need_resched_current();
 }
 
 #ifdef CONFIG_PREEMPT_RCU
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -753,8 +753,7 @@ static void rcu_read_unlock_special(stru
 			// Also if no expediting and no possible deboosting,
 			// slow is OK.  Plus nohz_full CPUs eventually get
 			// tick enabled.
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
+			set_need_resched_current();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    needs_exp && rdp->defer_qs_iw_pending != DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
@@ -813,10 +812,8 @@ static void rcu_flavor_sched_clock_irq(i
 	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
-		if (rcu_preempt_need_deferred_qs(t)) {
-			set_tsk_need_resched(t);
-			set_preempt_need_resched();
-		}
+		if (rcu_preempt_need_deferred_qs(t))
+			set_need_resched_current();
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -763,8 +763,7 @@ static void print_cpu_stall(unsigned lon
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	set_need_resched_current();
 }
 
 static bool csd_lock_suppress_rcu_stall;


