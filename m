Return-Path: <linux-arch+bounces-14260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4505EBFC074
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D931A6093E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3EA34BA32;
	Wed, 22 Oct 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtDBb22N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="faCLpytf"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E2334B681;
	Wed, 22 Oct 2025 12:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137855; cv=none; b=qbr8om6dbwrifCEuG5KXfpvwnDqaq3SZqWklwp6poqtyWXAOnpWn62hAz169m/og6mp3ek4J0GswCt5xxwpuk4ExsE0i4DB8g0pZLczCeyad7eh25c/x+mWlkurmyAeNO76cnynq8zuq5XEIpXEvGb0p+q3KIyCRfWM/SlCv7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137855; c=relaxed/simple;
	bh=IjvXmE2JrkMsosPYQMRvXF2fFTF071l0g+ACV8CdgG8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Iih9f0GpnNV77XE1ddvFNOmUfsDoz5lhvQA9BXJDTKNuEhWKVkq4gP8hc30sVvgS/heEs+NPoNelhUUgc4Z66MwuXfoM3CWomNTYe3VfF0XirFwI1lLPkyHTVUxXNlqe1UgoTgyw+bq24xpJyvz4M4ZKxvA1V0WuaH5IY5uA87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtDBb22N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=faCLpytf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.091502763@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SeRUCqhF9aNn5em8N+vlujAff6oNLhgT31VXqodq41c=;
	b=XtDBb22NouYfeJ4GwhWP+eBNtzIlFP1Q1JoOVARQtMTEoPlsVlrN8xfg0uh3Cs5MP5a0QV
	b43XDIM8ZgETTUBTQkc9e1U+ZVHsK5isqalJXixTTbUZpLbGmAi4+Afw+6DO5zUq9tsR3r
	APNBixZR6szBwj83gMZWyzbaH9ymNQplFi6k2in8vkKCeONork8XAWmDsExKo420j97snj
	b5ElRPhFJ53aPdEKyFvcDMd7pdLi0dSGTT+qgW4BqkDmFDm11gEu82fMUoQdWLvUJNy2YK
	uFNE0BTVqFbg0QKggQgk+pIUS1vA1GJzCDSCousLOGBDev2uaWYETyLekPOK9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=SeRUCqhF9aNn5em8N+vlujAff6oNLhgT31VXqodq41c=;
	b=faCLpytf2arQsVp/LYthtwtjlr/D8Wf4oo0aTFZTwYaCCRiOSiuo4jppVEGdBfJuolg4eN
	7SgLJKyd7KDFYODQ==
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
Subject: [patch V2 03/12] rseq: Provide static branch for time slice
 extensions
References: <20251022110646.839870156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:57:32 +0200 (CEST)

Guard the time slice extension functionality with a static key, which can
be disabled on the kernel command line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
V2: Return 1 from __setup() - Prateek
---
 include/linux/rseq_entry.h |   11 +++++++++++
 kernel/rseq.c              |   17 +++++++++++++++++
 2 files changed, 28 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -75,6 +75,17 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEB
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
@@ -484,3 +484,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 efault:
 	return -EFAULT;
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
+	return 1;
+}
+__setup("rseq_slice_ext=", rseq_slice_cmdline);
+#endif /* CONFIG_RSEQ_SLICE_EXTENSION */


