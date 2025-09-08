Return-Path: <linux-arch+bounces-13425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3175AB49D2C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC55B4E7DC5
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0698930DD01;
	Mon,  8 Sep 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QUaSMlFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dfCtUSc9"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E930ACF9;
	Mon,  8 Sep 2025 22:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372399; cv=none; b=oen3iYbUI1mVM/H8OhxytwRkPF9NRUFE3A5reBUkTChUbhgsyzhBkgYPUttLCZBiM4fDBwzkOOvsIbnfV0AnL9SI0j7M7cW0SVvxqjxzD9hufOLjS5yT2TdqYeo1yB8XHBXzTdwduR/YbrHfMMebNTOAxP9NFqkrRDNCGvTBOQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372399; c=relaxed/simple;
	bh=Zk+7GUelBL5L11XtNETdSZvQBonABXAXwyKF4YXotDo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=H48eZTIenrtWgC/6JEfR8b196oE2heH6mHvIpm8QzV2KSTGsB0IRvfedPCq8o2ZCb89hdHHeoJxVZPpuxEN6bFUy5oLX/9mKNNPAB57gF5a9P6/1++0tnV+P6JkK1ZXmpdZkxG+7hyXqtgOLQ3lU5SGLH+2ciWUhcQDwgiuLCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QUaSMlFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dfCtUSc9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225752.744169647@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yifYKxxoOjDGJ+Kw/k9A+Jz2j8TKRsJ1YOBwxZLrTTg=;
	b=QUaSMlFE78bzzptgx7Y9ooL+93PMl8tc6JNMaeouChLbv6FPw+8gkncudRhcpZNKgc4+yx
	VTWljVh1fS9fLQrY/+PKfsFGiU2UUdqw8Ak7+troDV6KY82D89Xbik3Lexd0Q6Oy58oroW
	6O5tM4KOjrczjFOAULM+eO8cOBc495ISKgw5P9z2zCPJI9BAMEqbfmIbCpD3KT46ml9Y+L
	M8as2/R1T9498DXcd76jgoXhYBkqC6YzR1LwfEWlljz8FHP/9f9gLYNp+X9oCS3Jgqcu1f
	WCnZ93g6LC482x+DymY6utevgstgS5LSEOroOJwJVmVQ8hnpPTcq4gADIiQHUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=yifYKxxoOjDGJ+Kw/k9A+Jz2j8TKRsJ1YOBwxZLrTTg=;
	b=dfCtUSc9KqTE6gC6+gPpZlhd7SqTmYztxjDOQyOtSu8MuEuzq16a+5tb7lENP+W256//+z
	tE/1aPI15YdsOrAg==
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
Subject: [patch 03/12] rseq: Provide static branch for time slice extensions
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue,  9 Sep 2025 00:59:53 +0200 (CEST)

Guard the time slice extension functionality with a static key, which can
be disabled on the kernel command line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rseq_entry.h |   11 +++++++++++
 kernel/rseq.c              |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -77,6 +77,17 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
 #define rseq_inline __always_inline
 #endif
 
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+DECLARE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static __always_inline bool rseq_slice_extension_enabled(void)
+{
+	return static_branch_likely(&rseq_slice_extension_key);
+}
+#else /* CONFIG_RSEQ_SLICE_EXTENSION */
+static inline bool rseq_slice_extension_enabled(void) { return false; }
+#endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
+
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, unsigned long csaddr);
 bool rseq_debug_validate_ids(struct task_struct *t);
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -474,3 +474,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 
 	return 0;
 }
+
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+DEFINE_STATIC_KEY_TRUE(rseq_slice_extension_key);
+
+static int __init rseq_slice_cmdline(char *str)
+{
+	bool on;
+
+	if (kstrtobool(str, &on))
+		return -EINVAL;
+
+	if (!on)
+		static_branch_disable(&rseq_slice_extension_key);
+	return 0;
+}
+__setup("rseq_slice_ext=", rseq_slice_cmdline);
+#endif /* CONFIG_RSEQ_SLICE_EXTENSION */


