Return-Path: <linux-arch+bounces-15120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE2DC95F58
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82EB13433A7
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC1293B5F;
	Mon,  1 Dec 2025 07:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g2H+9FLJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DDj5aq0N"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4C528A3FA;
	Mon,  1 Dec 2025 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572803; cv=none; b=P3Y8UWiheMcXw6PktyFIVF864XvUtIKCzpAn0aAFELnIoQfHndeiE3ToNdrOSabunGE2ZD7rvYw1+KXB7+zTlgHvPooq0j8oKlyz9zdCGn95X1kZrlJzcuP63e1EdmX8HuHTEu9FR2rCXl7d5qqUOvfiW+37eGc08wKrMInLBTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572803; c=relaxed/simple;
	bh=RhXdOrpmvWhEXZAJBOlVp00/Ibtc92pO9VfibfnzKL4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ULlOUcJjLjKBOgC/oPBIa7S7sAuuc7ApX8rZrmIbPYnUeFZVA0V8huK2Y3Dgi1NWu83MPRPoL3T16JY3vO5d9H/QG6/CNcsjUfZwlKEzEX//btcrFkwOtkC5t12NacdRMtoP1tO380q2NPcVgzmBHZ/TTlAJSMzOa5movkzUw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g2H+9FLJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DDj5aq0N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128230241.286446179@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=g2H+9FLJ3AAr6TEx4aZfUVSaTpTVBfsKjuSbJlQv86I7HS6524njxNg6yfv+5hvwcAKDG+
	bJmUyCYFPWvp77IqZ6PBVH+/AqI3Ps0zwgDkAniRx3krJ1S0IEbNgDILdyv1tfdGzwHcFs
	SAGbqO4FHK5BQcWTSKpNQFa0s2jkbJcyonFI7b6XMV0gaE5PMZ8di2oLKvPQTAdYtDOPfC
	rZiShMZX6LoNODqOCTWRSXs5CI/lJCea+D/Q7kgdnFuFCsK0Z6/0rCAlatZXfls+MmIgSV
	Rq5XJOb4zniuvgNFRFS8/cWY0Me7F8QK/tfe6tFeu+WkG4HO88ir5CXfPaWt6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=DDj5aq0N+lEuEWEEUTTW8X37QPJtm4RsenK1IZCcDuCxDe1G2SvuUgHLAh9RbOLlJvM7rt
	c1iMRVWzA3vG5FAQ==
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
Subject: [patch V5 10/11] entry: Hook up rseq time slice extension
References: <20251128225931.959481199@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  1 Dec 2025 08:06:35 +0100 (CET)

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


