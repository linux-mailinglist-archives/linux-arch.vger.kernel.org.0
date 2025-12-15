Return-Path: <linux-arch+bounces-15440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB0CBF6A7
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E77D3301C8E0
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45069326936;
	Mon, 15 Dec 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBLhEg9l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GE1JY19P"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF245268690;
	Mon, 15 Dec 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823099; cv=none; b=uWc2tF7kL76mx6gmDMGNqJdythys+Gaa4CCWSeUfqINcr0cSk6cUxo/u27cz/pxnuOlB9NxWAevsIualKcke1EkM/PrUv3yBr304cOFd2dgE4ZkIrdNoZofMyHMYIhyd6438655jZKT1DMNcm65SQWqwaggQ/fwRoyvaHrhAUj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823099; c=relaxed/simple;
	bh=bweILKBAG+NAHAwOybYlRiEttgCdytAp9C0CZOF0J1E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=g9MhRsGzzRDCLIKcObu0T8OsAhDEXD9OUjiFJ/oFXLi/YfRwOkLdrsWJX+a6diASV4M7mfUWRdcDO+MVIAmThEFWoXnanHZe1pdPlRnWumsrCM2Zj8HtW4WbgGyM3NlGy0hj/7ArwXjepXShdwKTiTbZHoGgqsP+HnXbKW6cwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBLhEg9l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GE1JY19P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155709.131081527@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tI2ArUugH9bBd2PsGVrarj2XWauowKWXGr0SZO/aAow=;
	b=nBLhEg9lRjdAcRHwTDp1HcKxQ9NWR429UFtmnci+iHSELhSD+l7wh74vfRm3xKQY5ejxFS
	QamO+hg3eHrK48EWr2Am2KxluubrortpnVF6P2gJh400wDOjSlyry4JijVlzMN3a/yuf8P
	UK0h8TdBnMNCp2fSu+mo9+D6vSJDNzw43hezPIEyCijLMVUWoyWnjH99p+4YZsLsa1coKa
	nBuDnSxUvf+31w3TyDOM6O38Baq3ItBJWOuEHxTamnbMyrX9e7+OikDAp2ShkPXiND+naK
	UbFykNTy4Wea5l4TZEckLHDpLuXyiiFtu9b90UKluUKHzwf4Ayjf9Z+oZCfrNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tI2ArUugH9bBd2PsGVrarj2XWauowKWXGr0SZO/aAow=;
	b=GE1JY19PXj12JuVXGrnDXYSIlyP9c/J6f8JJItyjziBV8w/Tf6riUVzZRlkxVVJ3W6f9gG
	/DMwsI3WAykWA/Dw==
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
Subject: [patch V6 08/11] rseq: Reset slice extension when scheduled
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 19:24:52 +0100 (CET)

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
@@ -102,9 +102,17 @@ static __always_inline bool rseq_arm_sli
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
@@ -391,8 +399,15 @@ bool rseq_set_ids_get_csaddr(struct task
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
@@ -488,8 +503,17 @@ static __always_inline bool rseq_exit_us
 		 */
 		u64 csaddr;
 
-		if (unlikely(get_user_inline(csaddr, &rseq->rseq_cs)))
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
@@ -505,6 +529,8 @@ static __always_inline bool rseq_exit_us
 	u32 node_id = cpu_to_node(ids.cpu_id);
 
 	return rseq_update_usr(t, regs, &ids, node_id);
+efault:
+	return false;
 }
 
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)


