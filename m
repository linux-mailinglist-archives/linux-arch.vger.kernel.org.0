Return-Path: <linux-arch+bounces-14400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F40C1AB69
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63DA41AA4E7A
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF576343D70;
	Wed, 29 Oct 2025 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiuD1HB8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWPZ4cji"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359493385B8;
	Wed, 29 Oct 2025 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744145; cv=none; b=fik0fRnIIsO8WsRza3KYkd9OjKNcpBmDhc9TkoBQQ40uDsWV7vQZmvsXyFZfH2F7c4pfwQcG7rp639l4L0cI4d2HuLgBMiptpej0LXiYCSLbu6xH1GoXvjPpd9jpG9RcD90GaO+autNRD3P7QKQP41iqCYRrKPtmf+j0HkdSwKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744145; c=relaxed/simple;
	bh=gOP5BANFd3VpHuJ2BZmP5TNHjlKbJsxngF4HViEgVoQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O0+2/mKaCuGVD8Mq+QdvIb8t5f74QSvdWRkSTHexzhaNW9tOuNbmKoKU+Juxp1DPQDCKdjVqttVgHhAE6h1iZQq5T5nYdeqNPg7I8E/UZFaADoKR+nuii+ma2EYuAhsJTruw2mUQ/raSgTbAIHgkzEzQM6bP5PvsFmDvvXoVwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiuD1HB8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWPZ4cji; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.733465222@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjEMKljcpOIHWP0e5qtd2vFNbhxhiAfQeDZfSIblhQI=;
	b=YiuD1HB8sfhtc24u1Lgjpj70Kx3338g6fq5JJ5tlUPniq3wPNndk86iCIBItFOh0dDu9eY
	pJm5C4tpCBKH/v5L1+MOYIiO+0atSFqvLu86LJeYFChyEsxyQEbQBJvwNmCSIRFbalhV+5
	hYWTfA7Wd/ckoFKjZUBbxJUlIUwVGyGQjZDv8312guz7MfOq6A8muDKSTWeruIU/jSUCN9
	oTA1KCgN9VPAa46VVoaAklkYcLiKMSvui5svjf5zQQrIB9MyEUrkml5/hQlF1ci1KUP5z+
	BqxkBR3OZTx0HsbmJ3KlGIzmb42Ns+B9KzNHQ5icP/WO62nHNR6ktAvS2xxCrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=rjEMKljcpOIHWP0e5qtd2vFNbhxhiAfQeDZfSIblhQI=;
	b=eWPZ4cjieUs1YoRoTJdV1m6evYF9OcQUoc6spY6K6H4yPU1Y3P3qBRvJtlrqbKvEDLTPlj
	iL6sCWO5bCgKxkAw==
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
Subject: [patch V3 05/12] rseq: Add prctl() to enable time slice extensions
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:20 +0100 (CET)

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


