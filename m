Return-Path: <linux-arch+bounces-14817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE9C61CEC
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 8D3D2242DE
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C027E074;
	Sun, 16 Nov 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="srGrD5D7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MxPgv+I"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526F276049;
	Sun, 16 Nov 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326279; cv=none; b=VidF9j69zmegmZAkKt7B1cqep3FJHvtFsXAmSd+7juJw/Tmzvu1iNbIY+4OzFZQoGhk8FzdmsT0YtxlFn7kjPfP8HBsQGmCuI48EyB0QMxpaMUmBIZXx9WP85/IiJlRNIE/qVgrcBmYiAVGPAiOD0J2BBzi5HdigdV/itg5NWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326279; c=relaxed/simple;
	bh=gOP5BANFd3VpHuJ2BZmP5TNHjlKbJsxngF4HViEgVoQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=s/twkKIq0ZBIi/ZAPqNjYKYUouK340Vkhms3CHu5Y6uhwg65hIyquNFpf1iRLJRbJYA1gc9TCBioIUZcqL26hHSIBJqyA3NxsAL/iOJgCXKuCRHVcgPAMkX35p6g+EKfz3+leyDTXirqSQU4DfRib6MP1qEp6KaFLZvEEdozzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=srGrD5D7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4MxPgv+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116174750.920653724@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjEMKljcpOIHWP0e5qtd2vFNbhxhiAfQeDZfSIblhQI=;
	b=srGrD5D74I/OiQ2WzOv+ptn1kKzxIR7+4T0YgqRsOunjyZbsQtAjlEeLfLyMLWQ3R4o0XM
	ijxrqEQjB+rclRUmQ6oPZU1xc2dNDH+Eum5Q8ZXteYW8jFli7ewp2omn4LLcYkmbZBGrKu
	jm01lXOiDTJkn2N6IregH9sDW5CfSYUy3hNNwCoB2nUVVfOwE9fqrGOU2F+koKYttdcnFy
	zzbiETfgoO1NQTpCc/DyknVLJzQfAAvEjS9uT8c8lEy+Uw+F8FzEUBL/EWTYBtUYbNJaPJ
	5VAoaNyVBipQwbIu109GZiVDwiL2RGu0PajS0cSXLFfRgZRRe73coO0S2xNZtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjEMKljcpOIHWP0e5qtd2vFNbhxhiAfQeDZfSIblhQI=;
	b=4MxPgv+IjcEsrJqZvrkROmicAR1AyhbRMbYGBX1KPmS+lThUgVDgXs9sOMcJN0la+PwsJS
	3wvEt4iSWXS3l8Dg==
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
Subject: [patch V4 05/12] rseq: Add prctl() to enable time slice extensions
References: <20251116173423.031443519@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 21:51:15 +0100 (CET)

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
V3: Use -ENOTSUPP for the stub inline - Sebastian
---
 include/linux/rseq.h       |    9 +++++++
 include/uapi/linux/prctl.h |   10 ++++++++
 kernel/rseq.c              |   52 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/sys.c               |    6 +++++
 4 files changed, 77 insertions(+)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -164,4 +164,13 @@ void rseq_syscall(struct pt_regs *regs);
 static inline void rseq_syscall(struct pt_regs *regs) { }
 #endif /* !CONFIG_DEBUG_RSEQ */
 
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3);
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline int rseq_slice_extension_prctl(unsigned long arg2, unsigned long arg3)
+{
+	return -ENOTSUPP;
+}
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
+
 #endif /* _LINUX_RSEQ_H */
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -386,4 +386,14 @@ struct prctl_mm_map {
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
@@ -500,6 +501,57 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
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
@@ -2868,6 +2869,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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


