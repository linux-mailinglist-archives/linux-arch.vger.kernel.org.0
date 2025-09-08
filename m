Return-Path: <linux-arch+bounces-13433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA22B49D3D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5C71BC78D1
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03FD31DDAC;
	Mon,  8 Sep 2025 23:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4VHy6Q4Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K5DH7yM5"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFB31D750;
	Mon,  8 Sep 2025 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372419; cv=none; b=FNo/QlJ6KiNB+g+m87PCiCxHikN4be/YsvEWcjpmQ8Wyd+offpcgv6wN8b+vw2BJVAaU+h4KUFrlW0PGlKNMkiPQ0uBsngQyv+HC+JqIpvyGNh9rFAbipzA3ZQRIwwuwe1bhO17dtCXf9FKafGxzapoQDyzytidFg+jz3DQ5GDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372419; c=relaxed/simple;
	bh=RhXdOrpmvWhEXZAJBOlVp00/Ibtc92pO9VfibfnzKL4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KUugInjhnz43cy3go5JNMSP5SvKf5gat3t05eo2CLdwBnalJNuKA+bUrG1yxeLpXSEmR1pvUcCA4hv/Tx6MyQWi+y1CYjLWdjIYwMAl63O+YMFNR6Wz/AamSOHXLQ26NMloH5wNMbT/0qtFbljwWhBgRRU6ftwhwjYoF0eh3Z+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4VHy6Q4Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K5DH7yM5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225753.269052052@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=4VHy6Q4Z+X7wotuWb5XH/oWzf2xQ8Gd0gQPu9ssvBPHM4VT7QrOyzhbx/QFgz8+y1QHeEw
	mSVVzXvAy/FjkHbMaik6gBQGNW5pPxF9+/gUJhWjPU5nF1BHHiUCoFFQsFISIfiqQCqTmG
	rHS0xtst6Lvm/5H6SOWcFSp1R2yJUgOM4Is+pMwMESCCvBD1/6EA8XYPV9uuSlGhObgW1c
	NAPjqtd62loFd4ip+aTKUsvCIupJbv9ghvFNCoXmfU8YRIjWt1NSF8BBgpPHLy284UJ2kl
	NkLBzghgN5rvqfZvuP38Ja/1PaRWtas2T9O9vvHoHFLvYAVHI7GrU/7ykFf/DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gQFvLoA+8aqRp49/IJYirlydqYT+cxE6z9BZ2w2sdfQ=;
	b=K5DH7yM5WVkWYaguBKpIUFa6o5NWJVq4gdxsJ+b5yQadggpnnNZGAnPlkUFbkqokkTKa6G
	75xOkj58B796zzBQ==
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
Subject: [patch 11/12] entry: Hook up rseq time slice extension
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 01:00:14 +0200 (CEST)

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


