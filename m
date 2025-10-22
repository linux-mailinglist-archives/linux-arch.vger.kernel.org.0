Return-Path: <linux-arch+bounces-14265-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA583BFC12F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F045E6822
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D20A34CFAC;
	Wed, 22 Oct 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q5ba/EVq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YQsdnlLq"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BD34C9B8;
	Wed, 22 Oct 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137863; cv=none; b=J69mBd8JvyaeBJq+VPzpmYhNSDbiuN/5or0kDoTLSsN9KM3aQf8BXrhckuRGH7b1w/x4WQm/2Wr8gg9X5ZZRHhGyNuMO5RYME5O/s90A4xj+PTde0SFOGPzZSzUICMYwt5LgfXzc4/OrzU1C6MHeZemSc0IyYuPBt3Q03uZ77uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137863; c=relaxed/simple;
	bh=tAdTs9fFi64S4DilsUhH4aCNl0FFH81K0WEp0ySDyOo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=P0BUHOSpwi7F3QxiAPEQXzfSpOLhumdNVKpzAwkCwMRsSRZmbw/+KQUn11EkcdV2jj2bSNLKNlHFNKkCKQhWPvOYpRiYI0hW1lhrfFSjkvThcPU7zrNiqmK3b/mU7uBt7s0mJxwKQG+ei6mCAkOZm9eO4DP1X6gowNMukG1Az3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q5ba/EVq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YQsdnlLq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.470907320@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=b/ZCkPUz4ROPM7V0xoyrdKbEyj+hha2VH5RyH5QZqPY=;
	b=q5ba/EVqk0mESmYhqob8Q5vfyFPnGMC/UUQNPQp7RZUS0Z9hHZoIhcsSQLqOYSkn1FzTpt
	hITdL/8YAGtAq9ebm5JGU5K4xefZFfPE07ULIW3nYyGwM+yHwOBS4aZuFQdUtyph4Urjqb
	ZE9WqsDbODeH+rEGOR/cJv6oxpxA6LvkG5JBvCzcRz3Fn9LKOgNL0hJr9kGI2RVrz6gUW+
	m+qyMii45CG/7WgBVmgtO4IRf5rGQ0JQO1cHeXIjmKAYDMgcQWk6tVC+au1xGFWmSPRHXO
	6d44nDLvR29MvZiKc0vHNOCsDVARb6ZUgxXpLuPIJJtyHb+ByjB67S7pEW7elA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=b/ZCkPUz4ROPM7V0xoyrdKbEyj+hha2VH5RyH5QZqPY=;
	b=YQsdnlLqXQV+kpDjie/lyndadhFtadkqBuUumeI6k3QWZUDk1TUBJlHdmlgoN6xwAre3lv
	/Ysx6AGEnEUPJuBQ==
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
Subject: [patch V2 09/12] rseq: Reset slice extension when scheduled
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:39 +0200 (CEST)

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
 include/linux/rseq_entry.h |   29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -101,9 +101,17 @@ static __always_inline bool rseq_arm_sli
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
@@ -390,6 +398,13 @@ bool rseq_set_ids_get_csaddr(struct task
 		unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+
+		/* Open coded, so it's in the same user access region */
+		if (rseq_slice_extension_enabled()) {
+			/* Unconditionally clear it, no point in conditionals */
+			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+			rseq_slice_clear_grant(t);
+		}
 	}
 
 	/* Cache the new values */
@@ -487,8 +502,16 @@ static __always_inline bool rseq_exit_us
 		 */
 		u64 csaddr;
 
-		if (unlikely(!get_user_scoped(csaddr, &rseq->rseq_cs)))
-			return false;
+		scoped_user_rw_access(rseq, efault) {
+			unsafe_get_user(csaddr, &rseq->rseq_cs, efault);
+
+			/* Open coded, so it's in the same user access region */
+			if (rseq_slice_extension_enabled()) {
+				/* Unconditionally clear it, no point in conditionals */
+				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+				rseq_slice_clear_grant(t);
+			}
+		}
 
 		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
 			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
@@ -504,6 +527,8 @@ static __always_inline bool rseq_exit_us
 	u32 node_id = cpu_to_node(ids.cpu_id);
 
 	return rseq_update_usr(t, regs, &ids, node_id);
+efault:
+	return false;
 }
 
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)


