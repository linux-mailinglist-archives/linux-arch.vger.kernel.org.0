Return-Path: <linux-arch+bounces-14267-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA60BFC0A1
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6931B1892399
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993933570C8;
	Wed, 22 Oct 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3d1r0Dku";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpPQ9KAk"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A034C134;
	Wed, 22 Oct 2025 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137865; cv=none; b=J2/X8UD8AEbYUnjfwSGepEcywgEh3NQns8VQLy0JxUDUiuUAa/JV7+qSGj8MUcPMpY+VftuiIYmWKQ1d0s/yo0sFHL7ZeaT4bY84Cotn2p5QF2uzbu7N0yR2J/n3FmKBQ6x0bbBiF0QHPs43FCpanhKBammENcgUbhqc+dfIYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137865; c=relaxed/simple;
	bh=XsJAxyBd0vAevc/VUPJOEdS76VEM3jS4ZS0p3kXwpkw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=IuY8IrmVIzKxSLB7cPr7VAgfnpT/kgan1uUppWBukVorBUiky9g4M1vy/erU1aZi3SVpUe8byr1VUPrUNQnd1uXe5mW41DhMRkYnv5M43bAFKwZ69yTi0tvgLymGeWRlAHiSdEM1ANKncTHvrjeWIuQlwR2eRYp+7wCFydwCgHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3d1r0Dku; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpPQ9KAk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.534334174@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IFEKxcddsJ/kociOmF83yTc16XAhB5Tooe9rTfVm04g=;
	b=3d1r0Dku15nQqZFUYgVDzyO2NF72e9vRiByvXqLc65Pm60JdVdhxuE0WaxifLtmydSOlKS
	kSUU4BXKZgGBDdyn3bS0aEhdgZ8InJMj36v4PRBp/CosTwpsoIMVp2PUZq7Xz9q+TeksE9
	P8rp+k2ienuoFg90cKRExAOqzHAktqqqTOK5FLPv/haAWFiJ3IFqS6kNGcKK1om58oQpMj
	qPc6wIcWte8pGUGBicExqhZsehGXwzNUxJ4tagphMdcOBaEjB3saEzRHtvUamwjg141A5o
	yOv9X41xCkj2WmgnD8Lyl1ZgOngei1td85PKENgxTyxpd7yiKbZ7SJciElQtsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=IFEKxcddsJ/kociOmF83yTc16XAhB5Tooe9rTfVm04g=;
	b=kpPQ9KAkBy7g4PgsElbWXFUE7uE4aP9+IliSEDBVEvY1AhL5SOcCAdsUQ3OSVBuwqVe7xk
	bfgL8my8eZRj16BA==
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
Subject: [patch V2 10/12] rseq: Implement rseq_grant_slice_extension()
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:41 +0200 (CEST)

Provide the actual decision function, which decides whether a time slice
extension is granted in the exit to user mode path when NEED_RESCHED is
evaluated.

The decision is made in two stages. First an inline quick check to avoid
going into the actual decision function. This checks whether:

 #1 the functionality is enabled

 #2 the exit is a return from interrupt to user mode

 #3 any TIF bit, which causes extra work is set. That includes TIF_RSEQ,
    which means the task was already scheduled out.
 
The slow path, which implements the actual user space ABI, is invoked
when:

  A) #1 is true, #2 is true and #3 is false

     It checks whether user space requested a slice extension by setting
     the request bit in the rseq slice_ctrl field. If so, it grants the
     extension and stores the slice expiry time, so that the actual exit
     code can double check whether the slice is already exhausted before
     going back.

  B) #1 - #3 are true _and_ a slice extension was granted in a previous
     loop iteration

     In this case the grant is revoked.

In case that the user space access faults or invalid state is detected, the
task is terminated with SIGSEGV.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
V2: Provide an extra stub for the !RSEQ case - Prateek
---
 include/linux/rseq_entry.h |  108 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -41,6 +41,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_
 #ifdef CONFIG_RSEQ
 #include <linux/jump_label.h>
 #include <linux/rseq.h>
+#include <linux/sched/signal.h>
 #include <linux/uaccess.h>
 
 #include <linux/tracepoint-defs.h>
@@ -108,10 +109,116 @@ static __always_inline void rseq_slice_c
 	t->rseq.slice.state.granted = false;
 }
 
+static __always_inline bool rseq_grant_slice_extension(bool work_pending)
+{
+	struct task_struct *curr = current;
+	struct rseq_slice_ctrl usr_ctrl;
+	union rseq_slice_state state;
+	struct rseq __user *rseq;
+
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	/* If not enabled or not a return from interrupt, nothing to do. */
+	state = curr->rseq.slice.state;
+	state.enabled &= curr->rseq.event.user_irq;
+	if (likely(!state.state))
+		return false;
+
+	rseq = curr->rseq.usrptr;
+	scoped_user_rw_access(rseq, efault) {
+
+		/*
+		 * Quick check conditions where a grant is not possible or
+		 * needs to be revoked.
+		 *
+		 *  1) Any TIF bit which needs to do extra work aside of
+		 *     rescheduling prevents a grant.
+		 *
+		 *  2) A previous rescheduling request resulted in a slice
+		 *     extension grant.
+		 */
+		if (unlikely(work_pending || state.granted)) {
+			/* Clear user control unconditionally. No point for checking */
+			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+			rseq_slice_clear_grant(curr);
+			return false;
+		}
+
+		unsafe_get_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
+		if (likely(!(usr_ctrl.request)))
+			return false;
+
+		/* Grant the slice extention */
+		usr_ctrl.request = 0;
+		usr_ctrl.granted = 1;
+		unsafe_put_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
+	}
+
+	rseq_stat_inc(rseq_stats.s_granted);
+
+	curr->rseq.slice.state.granted = true;
+	/* Store expiry time for arming the timer on the way out */
+	curr->rseq.slice.expires = data_race(rseq_slice_ext_nsecs) + ktime_get_mono_fast_ns();
+	/*
+	 * This is racy against a remote CPU setting TIF_NEED_RESCHED in
+	 * several ways:
+	 *
+	 * 1)
+	 *	CPU0			CPU1
+	 *	clear_tsk()
+	 *				set_tsk()
+	 *	clear_preempt()
+	 *				Raise scheduler IPI on CPU0
+	 *	--> IPI
+	 *	    fold_need_resched() -> Folds correctly
+	 * 2)
+	 *	CPU0			CPU1
+	 *				set_tsk()
+	 *	clear_tsk()
+	 *	clear_preempt()
+	 *				Raise scheduler IPI on CPU0
+	 *	--> IPI
+	 *	    fold_need_resched() <- NOOP as TIF_NEED_RESCHED is false
+	 *
+	 * #1 is not any different from a regular remote reschedule as it
+	 *    sets the previously not set bit and then raises the IPI which
+	 *    folds it into the preempt counter
+	 *
+	 * #2 is obviously incorrect from a scheduler POV, but it's not
+	 *    differently incorrect than the code below clearing the
+	 *    reschedule request with the safety net of the timer.
+	 *
+	 * The important part is that the clearing is protected against the
+	 * scheduler IPI and also against any other interrupt which might
+	 * end up waking up a task and setting the bits in the middle of
+	 * the operation:
+	 *
+	 *	clear_tsk()
+	 *	---> Interrupt
+	 *		wakeup_on_this_cpu()
+	 *		set_tsk()
+	 *		set_preempt()
+	 *	clear_preempt()
+	 *
+	 * which would be inconsistent state.
+	 */
+	scoped_guard(irq) {
+		clear_tsk_need_resched(curr);
+		clear_preempt_need_resched();
+	}
+	return true;
+
+efault:
+	force_sig(SIGSEGV);
+	return false;
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
 static inline bool rseq_arm_slice_extension_timer(void) { return false; }
 static inline void rseq_slice_clear_grant(struct task_struct *t) { }
+static inline bool rseq_grant_slice_extension(bool work_pending) { return false; }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
@@ -645,6 +752,7 @@ static inline bool rseq_exit_to_user_mod
 static inline void rseq_syscall_exit_to_user_mode(void) { }
 static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
+static inline bool rseq_grant_slice_extension(bool work_pending) { return false; }
 #endif /* !CONFIG_RSEQ */
 
 #endif /* _LINUX_RSEQ_ENTRY_H */


