Return-Path: <linux-arch+bounces-15118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C551C95F54
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15C104E201F
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09E728E579;
	Mon,  1 Dec 2025 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ORrtf/Xy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I8FHQN1D"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F6C29BDBC;
	Mon,  1 Dec 2025 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572791; cv=none; b=uMtcjgNUTm47nPRLUI+thlQyDJePw0urQ9A2dXep1RZdi6ih8WFm/5wCR4RK2+Pta3tuiWreaBFv6upcdqKDuHoSIfrLMZ7FOpAXFiTBLRXaxmii24XVXUtt8TaO69edF57tVVvyMZPaj0PX2XOuU9CTHjUWDwoCBnsRYiRAN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572791; c=relaxed/simple;
	bh=bweILKBAG+NAHAwOybYlRiEttgCdytAp9C0CZOF0J1E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=atj6TQolzDUUi7Gv23N6i2+f3zE/OnWq5kL8HEI4ma/yKjIkm9osW9CHjG0fkejQ7wrfWA6ZoXmh1exFT6xrAZSu3Qs21WEiYhdFKu4oLsop/6lg3Rk3Tt9trtxR6RoFTUMeYWpNyPvi9YRkrVT++hReiho7FhrcWiDw9X6XITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ORrtf/Xy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I8FHQN1D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128230241.155787168@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tI2ArUugH9bBd2PsGVrarj2XWauowKWXGr0SZO/aAow=;
	b=ORrtf/XyI0m6yoTX2BzlShdhD/UUy13mKREigQiRH38Ie9q+wXXoRKFgDqYm91CWp5tm6F
	70uvhEUtHN58l5ufclYEFzJy0bxOVG9KUWW+CO/wVUJhHIzzSANeyWo3ue6V5YMdWzvHM9
	Ejf9MRuMJFMaJJuWW7W5MkJh+3MfMnmQxYRqoKtzMe+lNeRhqPfLBtF/2UdHT2VooLj72j
	NYeyQWGUwulj5a878MvOtAPfJQmLPM49vJ4JCXGi5gHlhnyigEWF8+Id7173DLgT4OhuJh
	kSlY7DJ72BqbGvPCWvqYrGmNYhPGUUV40IKhkYNjrDnHX/a2XrYMBSHDfapbgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=tI2ArUugH9bBd2PsGVrarj2XWauowKWXGr0SZO/aAow=;
	b=I8FHQN1DWUqI17mc6+j9K+9uPlKc2XYM3FnwCcyXo9K8rDpKuTUVXQ5EQhHU/um1ifdJ46
	RuvIVgUSFeIBc5BA==
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
Subject: [patch V5 08/11] rseq: Reset slice extension when scheduled
References: <20251128225931.959481199@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  1 Dec 2025 08:06:23 +0100 (CET)

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


