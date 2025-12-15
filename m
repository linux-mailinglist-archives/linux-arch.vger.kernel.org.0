Return-Path: <linux-arch+bounces-15442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D511CBF6EF
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 739E5308E48A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A10D32695E;
	Mon, 15 Dec 2025 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="efUUNgXG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0Dk3KK2"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F4E32693C;
	Mon, 15 Dec 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823101; cv=none; b=aA41wgcikOxXT0tWwbDiqbt6rzbVxcwnGGza+qcASC3S5E0i8Oqr8zdtvvI4Vbvynh0w3r4lJjnIwTEaFwlwTtr+krlJpJqAQ4Y2N3xsj6En1ZwWt7gJPYvuYlmb7zynKUb8FcgHeHEpCmXVAW6z+vsZEmS/+lYrQt65YtQl7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823101; c=relaxed/simple;
	bh=RhXdOrpmvWhEXZAJBOlVp00/Ibtc92pO9VfibfnzKL4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DPPE1c84Le/CdXLv43nD3bmXEBDGuU/cdqdYEZ3CPWeDkXtpRoIQmKyeJHIy5uuOzl8Mz0kXkALTt/vK5qxNupMIgxzX6OmnuWPwOXu7ZKnQZfPg7xhesn8B7b+ltnimKfFUIKvO2K+yI/rja3+Xw3p5jfTNnPQL7X1dJA5U9og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=efUUNgXG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0Dk3KK2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155709.258157362@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=efUUNgXGGRTo9baBK002GNUTLe3Y+RRtyruCsPOFfNOlIofzFV8TPiV+V3xLMOZxPNBGkE
	wXU3mbGHVZCX7rDFktpRjQsaXAby8EPO7P5B+9NSmAEpZUZKVNLhXJOPOE0gVyWgO96eX6
	jCLN92RMBe5gmwgdfY0VzJgDmpl+Kkuq0QibcKedtStXNTPeNUD0gYqXQ+cX5kTiqocIVh
	+vieIxM7EKM8g9/pfg9bmoai9b/WVWS9CxUIdDtjpcEJN7Vw8AHZlx8HubAep95s1wcxYo
	j2gjfw7DDpykXr6ufrzDQzsarHDvIVKhSb621hcl1B2GLF69YWWGPKVD+xth4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=J0Dk3KK2gZKWdckRjo6V68IAWh+kIlOwF/eaYC1mK4FIus8DedS9Y+x04GewZ0Wey/fk1E
	ZNNeNClRJcxr0zBQ==
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
Subject: [patch V6 10/11] entry: Hook up rseq time slice extension
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 19:24:56 +0100 (CET)

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


