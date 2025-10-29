Return-Path: <linux-arch+bounces-14404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22145C1AB87
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F86E1AA499C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64841346A0D;
	Wed, 29 Oct 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1qQ/YomI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zK+zrjLq"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909693469F8;
	Wed, 29 Oct 2025 13:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744152; cv=none; b=EEgXOymArKeMkixr1P2fWQlpZ460g2a6pBzlaV52zOKZkdO07G9UUdrAFXNOB+BhbWwhHuQD3fgXx9+NWVver4wgCBr1ECbswROCze78Wo++qyFGbQTG3FPC37c9Wr0hv6668VgCPHd1OIFeb8hmryZ/0aavMo0B9vN4/ZPPfvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744152; c=relaxed/simple;
	bh=6QRLM7xMqkRArKnD9pXHNONjyOAcJgMQpDE+bXtSwE8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=W7YyGqBuCyIauh2w7UpeoyY/aBD1uSPPcp9cocIASUPY7DMA3r5rYVTWq+UvmMga6i2g3S4JLbdpcnW7KbSu1QCkl/iJKP4nM1WZsHDw2mrpjo3sXHnMOmaiEWSgbDMvYMg7cvPoOEbO1s+tROK/b5j6lo/3PrtSoJOowVoClng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1qQ/YomI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zK+zrjLq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.988550967@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AMdecMI/rcpTkJB16o8t8M64tkc3x3WveHYK82QqmDs=;
	b=1qQ/YomIPXbQLEdIXsrOtxIdM/vMbaUO/VXv0t8o1YyabFzkHbsn2iBiGwAMmW+lprfipk
	I/IDSDt6EM0lo7GGVp6/bHahIdOHfHbqRPA/KJUwwwk2Y+aLYut7WQXb8DNsTF+pElNZAo
	E/0NWLA8Be0Gyzw7s42mnucwSrEVCOF28udLyu9wp29Sna8WjM9/eWCPx5UPkbcBqtz6YL
	jdyOxqUPc7nfk/9kiKuJbAsYYMUQ8yVyQOWiuN+y5OavOqUqqIcoOmswbtLemYaDFDEcbK
	O5IialdjIoVwnykhv/xy0hhu4Xa7L27TW/Sebnnt9lT9cBSifoiCpyGTXDl4cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=AMdecMI/rcpTkJB16o8t8M64tkc3x3WveHYK82QqmDs=;
	b=zK+zrjLqlYbrDs5VYhPTwx3rTz1SMFw0m9zYtkmDy242bXctWBkaF+XvsxbbILB47Wu47N
	D4G/PN3+dODQsTDQ==
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
Subject: [patch V3 09/12] rseq: Reset slice extension when scheduled
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:28 +0100 (CET)

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
 include/linux/rseq_entry.h |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

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
@@ -390,8 +398,15 @@ bool rseq_set_ids_get_csaddr(struct task
 		unsafe_put_user(ids->mm_cid, &rseq->mm_cid, efault);
 		if (csaddr)
 			unsafe_get_user(*csaddr, &rseq->rseq_cs, efault);
+
+		/* Open coded, so it's in the same user access region */
+		if (rseq_slice_extension_enabled()) {
+			/* Unconditionally clear it, no point in conditionals */
+			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+		}
 	}
 
+	rseq_slice_clear_grant(t);
 	/* Cache the new values */
 	t->rseq.ids.cpu_cid = ids->cpu_cid;
 	rseq_stat_inc(rseq_stats.ids);
@@ -487,8 +502,17 @@ static __always_inline bool rseq_exit_us
 		 */
 		u64 csaddr;
 
-		if (unlikely(!get_user_inline(csaddr, &rseq->rseq_cs)))
-			return false;
+		scoped_user_rw_access(rseq, efault) {
+			unsafe_get_user(csaddr, &rseq->rseq_cs, efault);
+
+			/* Open coded, so it's in the same user access region */
+			if (rseq_slice_extension_enabled()) {
+				/* Unconditionally clear it, no point in conditionals */
+				unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+			}
+		}
+
+		rseq_slice_clear_grant(t);
 
 		if (static_branch_unlikely(&rseq_debug_enabled) || unlikely(csaddr)) {
 			if (unlikely(!rseq_update_user_cs(t, regs, csaddr)))
@@ -504,6 +528,8 @@ static __always_inline bool rseq_exit_us
 	u32 node_id = cpu_to_node(ids.cpu_id);
 
 	return rseq_update_usr(t, regs, &ids, node_id);
+efault:
+	return false;
 }
 
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)


