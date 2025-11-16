Return-Path: <linux-arch+bounces-14823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC81C61D04
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id B60C2242FF
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CB3101CD;
	Sun, 16 Nov 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bECoMVjx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TKp5+L56"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C178E3101DD;
	Sun, 16 Nov 2025 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326291; cv=none; b=ixJHDESgYRdy7xk7rPSGeHe/X/2FzrUo1n4z0xuCjg1vD3qRQzgbtFgbllYF9nafDLnfERul7ItiXnxb6jcri5GLtp9en2r4oGCqyPfaL3OuQLHoNpQSdJVVRe7Xd/n9F8BxgfXQUkwbN7zLrGOjthH1mSC6SUrbIVhjbNYVnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326291; c=relaxed/simple;
	bh=RhXdOrpmvWhEXZAJBOlVp00/Ibtc92pO9VfibfnzKL4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZBaTOdk708oTY+M+9cxc0/h9UlO+suXdEbOUq70iFtu42Ajpvufu5yOP0dY4jgoJ0XZmeWPVZZquM+gioITbmQDGnDx8+sV3jWYVAFg0tsg9Wi9KYEhg642Pu9l8ABnUcBs6QB6vCs+mnApyKJjCGkrZQ66n6WBvjIgzyOP5ApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bECoMVjx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TKp5+L56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116174751.305877031@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=bECoMVjxGM3IsRd2YS9/Tz0tA7sZQfbnEndYAeIjhqWb5+wrs74HiYxHUKlmX3Gwqvm3+F
	wR7GKE87ryeJmTwydubjdLfFx5371FiYT8aZeE45qQFb4U7YdykI1ufWwdk9pmy/WKi72h
	VdYCpYZemNOTuz1x5EWXtbfGqQwz5hFdO1/HHiqkGOJl9aDii9JQw9GQly5zklZ8P2WMEl
	T4/3uxIGNSWfDg6MqwXaItkrpgZHf36PMhJu+nhgcV0Aj5xBvD01u+NQ6KH0rBoIGhPXbu
	2XTD49jC0CqJhyT7H+BehpTyhHN2lUN4KRKP/xUy2S9aA2SJNGTa++YYT/Qg0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=TKp5+L56kx5jdzUYd7TeiTvuY072Vqp1VflU8Iv5BTD6gVjCXQLkSO2WE1R7GQsMY84ygH
	3bIshv5Te7jsP4Bg==
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
Subject: [patch V4 11/12] entry: Hook up rseq time slice extension
References: <20251116173423.031443519@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 21:51:27 +0100 (CET)

Wire the grant decision function up in exit_to_user_mode_loop()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/entry/common.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -17,6 +17,14 @@ void __weak arch_do_signal_or_restart(st
 #define EXIT_TO_USER_MODE_WORK_LOOP	(EXIT_TO_USER_MODE_WORK)
 #endif
 
+/* TIF bits, which prevent a time slice extension. */
+#ifdef CONFIG_PREEMPT_RT
+# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED_LAZY)
+#else
+# define TIF_SLICE_EXT_SCHED	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)
+#endif
+#define TIF_SLICE_EXT_DENY	(EXIT_TO_USER_MODE_WORK & ~TIF_SLICE_EXT_SCHED)
+
 static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs *regs,
 							      unsigned long ti_work)
 {
@@ -28,8 +36,10 @@ static __always_inline unsigned long __e
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
-			schedule();
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
+			if (!rseq_grant_slice_extension(ti_work & TIF_SLICE_EXT_DENY))
+				schedule();
+		}
 
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);


