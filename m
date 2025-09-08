Return-Path: <linux-arch+bounces-13427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92588B49D30
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D656E1BC74E5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9BE31283F;
	Mon,  8 Sep 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MB4gZqJ7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tws6YMGy"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5031197B;
	Mon,  8 Sep 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372405; cv=none; b=nBH62RByUQx/C9h5wMh5dcn9i9Ywodvbp19vnWWmbvw82poSG7Sd7r5zAJ52hiV3933pBtXtiG+92cFsy2/USBO3s1IhGi7R17Oz8SqOGMWTR2IKCjPtbzH2hxKa5TDI3ooXBfQrThCDlCBbOAFzdM1iacYzkiNrX4OvhJpcFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372405; c=relaxed/simple;
	bh=s5+0dXKO96Z6TE/svvTpMCqloqjUT8B7tIiQkcRJzUI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=SJ0IFq2BYcao6y6z5DJq0IdA6PkDB0D6iSvlHt6ytOd1HGUPH+5flN9LNBUUhBTHpP4BAARSc7PXTvduW5Dd31Q7xpShCbg5NXMP9qZxoIuWeB6CX6hJqrE3Hmf/igFHgpRf4qx82B6R9xuLA4GMUaEo3fc/BqHzVgvbzCl6Wg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MB4gZqJ7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tws6YMGy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225752.872081859@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=q2HI1rZu/rTLqfMxXCHeJvZRAnjrUkclL/FW2QBEeDw=;
	b=MB4gZqJ7AYPIhpNWNvF3rJ1hQzQ1HN7DUUUqB3junfMwk4xbOflZ47ReyCmlvCBXM9IMXj
	bMCD+ZQyMXQTIU0jtlui0omMJB7W7tdtbZRvsf/pI3Rg71C23hY7K6+wFsM4TAz6TfDzMS
	JNVwMqBHADA3B6E5LNoybmLrm/AaCVLEde218YrBDBvwhZVpnMY1oDruX1COlE2rwqkxX4
	4j8AeKwuFmtpdzspdavrJ1ScSZggEOcDtv8cdVmNY08QcKaAQ3PqQQb0TnsxE/mSSi4IZW
	yMKooEnaYqOwDSuYzy7X6qKvTvexBqNdvLTQJdnOVvOzMHxzPIGu/Z8nu37lnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=q2HI1rZu/rTLqfMxXCHeJvZRAnjrUkclL/FW2QBEeDw=;
	b=Tws6YMGycBqrhvXHfDKm8QmAY1c7fASt6l/C2FD1efOFQOdRaFO2ddBN9Bulvj2KKKrTRV
	3NsPgxgGnaE7acCQ==
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
Subject: [patch 05/12] rseq: Add prctl() to enable time slice extensions
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 00:59:59 +0200 (CEST)

Implement a prctl() so that tasks can enable the time slice extension
mechanism. This fails, when time slice extensions are disabled at compile
time or on the kernel command line and when no rseq pointer is registered
in the kernel.

That allows to implement a single trivial check in the exit to user mode
hotpath, to decide whether the whole mechanism needs to be invoked.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rseq.h       |    9 +++++++
 include/uapi/linux/prctl.h |   10 ++++++++
 kernel/rseq.c              |   52 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys.c               |    6 +++++
 4 files changed, 77 insertions(+)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -190,4 +190,13 @@ void rseq_syscall(struct pt_regs *regs);
 static inline void rseq_syscall(struct pt_regs *regs) { }
 #endif /* !CONFIG_DEBUG_RSEQ */
 
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
+{
+	return -EINVAL;
+}
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
+
 #endif /* _LINUX_RSEQ_H */
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -376,4 +376,14 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_SET_SLOTS	1
 # define PR_FUTEX_HASH_GET_SLOTS	2
 
+/* RSEQ time slice extensions */
+#define PR_RSEQ_SLICE_EXTENSION			79
+# define PR_RSEQ_SLICE_EXTENSION_GET		1
+# define PR_RSEQ_SLICE_EXTENSION_SET		2
+/*
+ * Bits for RSEQ_SLICE_EXTENSION_GET/SET
+ * PR_RSEQ_SLICE_EXT_ENABLE:	Enable
+ */
+# define PR_RSEQ_SLICE_EXT_ENABLE		0x01
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -71,6 +71,7 @@
 #define RSEQ_BUILD_SLOW_PATH
 
 #include <linux/debugfs.h>
+#include <linux/prctl.h>
 #include <linux/ratelimit.h>
 #include <linux/rseq_entry.h>
 #include <linux/sched.h>
@@ -490,6 +491,57 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 #ifdef CONFIG_RSEQ_SLICE_EXTENSION
 DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
 
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
+{
+	switch (arg2) {
+	case PR_RSEQ_SLICE_EXTENSION_GET:
+		if (arg3)
+			return -EINVAL;
+		return current->rseq.slice.state.enabled ? PR_RSEQ_SLICE_EXT_ENABLE : 0;
+
+	case PR_RSEQ_SLICE_EXTENSION_SET: {
+		u32 rflags, valid = RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		bool enable = !!(arg3 & PR_RSEQ_SLICE_EXT_ENABLE);
+
+		if (arg3 & ~PR_RSEQ_SLICE_EXT_ENABLE)
+			return -EINVAL;
+		if (!rseq_slice_extension_enabled())
+			return -ENOTSUPP;
+		if (!current->rseq.usrptr)
+			return -ENXIO;
+
+		/* No change? */
+		if (enable == !!current->rseq.slice.state.enabled)
+			return 0;
+
+		if (get_user(rflags, &current->rseq.usrptr->flags))
+			goto die;
+
+		if (current->rseq.slice.state.enabled)
+			valid |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+
+		if ((rflags & valid) != valid)
+			goto die;
+
+		rflags &= ~RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+		rflags |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		if (enable)
+			rflags |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+
+		if (put_user(rflags, &current->rseq.usrptr->flags))
+			goto die;
+
+		current->rseq.slice.state.enabled = enable;
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+die:
+	force_sig(SIGSEGV);
+	return -EFAULT;
+}
+
 static int __init rseq_slice_cmdline(char *str)
 {
 	bool on;
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,7 @@
 #include <linux/time_namespace.h>
 #include <linux/binfmts.h>
 #include <linux/futex.h>
+#include <linux/rseq.h>
 
 #include <linux/sched.h>
 #include <linux/sched/autogroup.h>
@@ -2805,6 +2806,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_RSEQ_SLICE_EXTENSION:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = rseq_slice_extension_prctl(arg2, arg3);
+		break;
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;


