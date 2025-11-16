Return-Path: <linux-arch+bounces-14821-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F141C61D2B
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 395DA34F848
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B05A30F94A;
	Sun, 16 Nov 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="loAQ1Llh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VO8af5Vq"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4C30EF65;
	Sun, 16 Nov 2025 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326287; cv=none; b=b0KFIAbSvoRDfWpA4Itis9AW0Xiu1ZoOp57JTVpb/HPw6w/8c86eV0frN5+MxTxf3VC5q6Waz1+mTtAgVXb5/TPoAJ2vsFm8XQA8wW1LUCyotgNbhmTwCAEl662yRDf5awfpZ17BgUjhLpfrVk/2LyLOJ5QZXarW18OhuZy5tUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326287; c=relaxed/simple;
	bh=SbQyqqLRFf6GHk5fAMKwfr9t/TLxDB5u0aLyaqqa1ug=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=BLcfiHsqyob7VuiLIcW20PzW+zXvfbf7PlK/+T+ajhceANQd1hSdyDtIGU1o+KAnebH1zV/rO42VXf7sUGlz30Udze9gv14+BEeOHb5XXIa5xzcTEeWqP7rpMkECHOLWENEOnzHdDweB0s7SynWF1cNZkp3wfGY48w6+1S7Quf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=loAQ1Llh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VO8af5Vq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116174751.178158397@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bhxpKgtvpe/l4eZLDsLr4+6yQiDep2wvrpm6cRByMmM=;
	b=loAQ1Llhe4WJUjy639D73xrSjsY/0qrCG/f1fDCW3iC+Fz4HEuVc8MefqsIAGXha7gDdgm
	3Wct4QmPJFL2gKyLuj4HroG3KWRu5rfO+c9UCV7oCzpd1avxCjnilZyPEMmcTThVp3nqof
	r7iG7XT8bLKxjVNya7muw3JLE6ngiZ89J0jFRwyNv50gSDuf4IEZ/yPGwY2u+HIfg9YMoI
	K75K8OJsJS6POcgyR2Q9kpA/Q66xfSEuQY5ETO8acjH7qhYea6UV2n6mtdZLjjoxIPiGii
	+tuIJNx0/DRhTpZN8D7rv9hc1LNWgwerX3/WtoUEUCS64t+A8zJcd6szZoh8XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bhxpKgtvpe/l4eZLDsLr4+6yQiDep2wvrpm6cRByMmM=;
	b=VO8af5VqEqPssMHSkleYRV0lHVmpcDIpx8ksjwgAv6zDIa77ry5C6sqwPMv1484PKbNPXY
	seZqB5qXRFnz0VBA==
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
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V4 09/12] rseq: Reset slice extension when scheduled
References: <20251116173423.031443519@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 21:51:23 +0100 (CET)

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
@@ -504,6 +528,8 @@ static __always_inline bool rseq_exit_us
 	u32 node_id = cpu_to_node(ids.cpu_id);
 
 	return rseq_update_usr(t, regs, &ids, node_id);
+efault:
+	return false;
 }
 
 static __always_inline bool __rseq_exit_to_user_mode_restart(struct pt_regs *regs)


