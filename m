Return-Path: <linux-arch+bounces-13431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA019B49D36
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE58316F17B
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284031C566;
	Mon,  8 Sep 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t212k+6B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0UaHn4iZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A231B10C;
	Mon,  8 Sep 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372414; cv=none; b=qf2IogJFPY7NoFiI7Uk1m0aPD6LNH/T4gldXt6nIjeuTNn48WtMmaTLhapk/AYrcKL6ZgsVpb0w3dx84+74A+6KMrgwfpbYlASy8IH4TSai+4wK/aUCViF+ae7nks4u24ZUAa2/6q3ZQk2A73OFpJWDpXoiwvmwOLGvffox88RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372414; c=relaxed/simple;
	bh=4RaYFSfzpQYjNPy+xqWBOA0DfR0lPTjH2Zofu9UBIfo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=h5Cjo3iBp2RZfS7qNs9zYuOuY5X3n0bx9/QJlMBYLPBLPwdu4OXs+KvHuKAI75HcVYmJ5U++s1JSTR6uUM5GQxiLct89Lp4VQnHkWs1KgZsWKWb+lcHCgRzvwJ+CCxkbjmv8qoWg1koMsPqxTGsO9jh1XFp6stU9Bd5z85SJx+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t212k+6B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0UaHn4iZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225753.142571755@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HDN6yarSBUrggJYbJPpwYDv0yRMy1C4SQrJn4Pj85Sc=;
	b=t212k+6BzNQJrCQbXcnYNzePsEP4yKFt5/AQWbBNPIYBnCRT9tUiniBBNN779kf3dZosjY
	gfcjGZWwFin9dYjQfGu9RnjXnaOPozz/Hq++IJOKfBMWuhG1Wr/Q+EAg6SNyXnV7b3XZTv
	DLptFmspp7xtS0kZVfZkBpm7MFjfl5BNSbupAn1tM5Pu3uncRrEweJv0kscOLXt/GDYpU1
	T9Klmo5KYDyQyr8SMndQ1Lydw76warv9ulHBdglRmCJKIyPZeIok381ahyyvOB/ajphwcw
	EFi6jRBY4tXA2xyFuimAry3rCbUUv5ed//p3GlTLaLKs/W8q0rAeil4l1Rg8qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HDN6yarSBUrggJYbJPpwYDv0yRMy1C4SQrJn4Pj85Sc=;
	b=0UaHn4iZ519YS4Q1IVZfZoz5Ekvr35WnsII30rtOG4belD/xYWFfkUcK+Bcl+0NvHH1PDM
	I4gzyrbJYVFck7Dg==
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
Subject: [patch 09/12] rseq: Reset slice extension when scheduled
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 01:00:09 +0200 (CEST)

When a time slice extension was granted in the need_resched() check on exit
to user space, the task can still be scheduled out in one of the other
pending work items. When it gets scheduled back in, and need_resched() is
not set, then the stale grant would be preserved, which is just wrong.

RSEQ already keeps track of that and sets TIF_RSEQ, which invokes the
critical section and ID update mechanisms.

Utilize them and clear the user space slice control member of struct rseq
unconditionally within the existing user access sections. That's just an
unconditional store more in that path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rseq_entry.h |   28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -103,9 +103,17 @@ static __always_inline bool rseq_arm_sli
 	return __rseq_arm_slice_extension_timer();
 }
 
+static __always_inline void rseq_slice_clear_grant(struct task_struct *t)
+{
+	if (IS_ENABLED(CONFIG_RSEQ_STATS) && t->rseq.slice.state.granted)
+		rseq_stat_inc(rseq_stats.s_revoked);
+	t->rseq.slice.state.granted = false;
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
 static inline bool rseq_arm_slice_extension_timer(void) { return false; }
+static inline void rseq_slice_clear_grant(struct task_struct *t) { }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
 
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
@@ -404,6 +412,13 @@ bool rseq_set_ids_get_csaddr(struct task
 	unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
 	if (csaddr)
 		unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+
+	/* Open coded, so it's in the same user access region */
+	if (rseq_slice_extension_enabled()) {
+		/* Unconditionally clear it, no point in conditionals */
+		unsafe_put_user(0U, &rseq->slice_ctrl, efault);
+		rseq_slice_clear_grant(t);
+	}
 	user_access_end();
 
 	/* Cache the new values */
@@ -518,10 +533,19 @@ static __always_inline bool __rseq_exit_
 		 * If IDs have not changed rseq_event::user_irq must be true
 		 * See rseq_sched_switch_event().
 		 */
+		struct rseq __user *rseq = t->rseq.usrptr;
 		u64 csaddr;
 
-		if (unlikely(get_user_masked_u64(&csaddr, &t->rseq.usrptr->rseq_cs)))
+		if (!user_rw_masked_begin(rseq))
 			goto fail;
+		unsafe_get_user(csaddr, &rseq->rseq_cs, fault);
+		/* Open coded, so it's in the same user access region */
+		if (rseq_slice_extension_enabled()) {
+			/* Unconditionally clear it, no point in conditionals */
+			unsafe_put_user(0U, &rseq->slice_ctrl, fault);
+			rseq_slice_clear_grant(t);
+		}
+		user_access_end();
 
 		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
 			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
@@ -545,6 +569,8 @@ static __always_inline bool __rseq_exit_
 	t->rseq.event.events = 0;
 	return false;
 
+fault:
+	user_access_end();
 fail:
 	pagefault_enable();
 	/* Force it into the slow path. Don't clear the state! */


