Return-Path: <linux-arch+bounces-14406-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E2DC1ABDE
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E0995642A0
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E6B34A3A7;
	Wed, 29 Oct 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="szXgbHEk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bPc4qLHY"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464734886B;
	Wed, 29 Oct 2025 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744156; cv=none; b=YAciOerhdrEJAtg8fO2Qu5jMPfm+r8HdaDZpXTC+gPeU7/4n23wHis3dE7SbEhNYhZsv+F+4cvyDm7wA87p04Q+8eMBf9SHeunTLujyyHVEJCG1iWQo5G32Js0CgnJmEE4LeavlRYLASD4ifXs4dLbW/E1+8HsiPUC6RnhfsYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744156; c=relaxed/simple;
	bh=RhXdOrpmvWhEXZAJBOlVp00/Ibtc92pO9VfibfnzKL4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tQDn2L1xs0rkWrZMSgNkETeinMU0p6Eist+Ev9pAIPnyzrMPZyJisyxQBAsr2bT5Vq49ZqXk18PTWwAbeU9Aob8RneVz16H8C0Mn7OBshqaWTeMGyyUiGqyDCQsO6pK7LLMy4HEQNBtc1GJNAWtEbGbzpcludFnJUykDvwrQXnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=szXgbHEk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bPc4qLHY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130404.114866930@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=szXgbHEkUmIBC1zpuSrC/4a8Ja9ySshfhGUnDqYcwS6Mru6edUFZ1/NZl9IOzWdqgM/WNi
	kTHgsNxXDmuI8bYhncPQH7ujg2PUfb2Xztd0lm2NuvQHHdlIuF90o0so/S/EfFflWjYzxe
	sH9iHRBILhH3PHomMLdQPC1l26U1gC+9fft6eFj2TZhhKq0TcfIeBwcr8LEoHeNkkV98by
	5KiIECxIxUyY5acxK7/XsTMbjca5ywLuUzqJFyAV+fx2zyXI65d1Bm1H1rMaXRdZ+1U5d+
	F92h6Ey5NH68RrfrghOJJ9QJEvJzqsggxY42SALFnKIgNmFVaQAsNQgIh8C97Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=bPc4qLHYHhl868M0VyK/WeKzocTKY9yqEI001tIHIyXMrocQLrZSl3CifHtO8ELBE5xwD8
	9ZJ5mHqTj2vSWcDQ==
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
Subject: [patch V3 11/12] entry: Hook up rseq time slice extension
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:32 +0100 (CET)

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


