Return-Path: <linux-arch+bounces-14815-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA0C61D0D
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 481AC360A90
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C87272E63;
	Sun, 16 Nov 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sJ7u+FG9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v17CpnP1"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EFD26FDA9;
	Sun, 16 Nov 2025 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326275; cv=none; b=PxtK3GgCwo4pDNnodb81MzQmxPUBqKuPgTEjaldwb40BsWC4csaDSGyR0iaxhiRTb7sCLLGwcX0EzCuXq4yTycq/mhtl2RsJAc/kJ55INnovTSvVlVrDg4Cu3VFraitJZ1jBhwg5fwZzMlDBGuLNxkaVDC1qw3BwdpDAeJT27S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326275; c=relaxed/simple;
	bh=TA7lrT53WU79dKJyoMSPjS4BGsGO5jf1PbfErdOpEYA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DG4+974iR3zhrFHlcUUywjX0UaiWKQAbNeY7Yf9ichwhtk9RzHZoTUCeJjh/14i1rZOicwsdU5SUJW1lWZNA2a32Ac/MoTdMU9YY+p402krb+NsWf9QA20KwDdFBjhUiYgG0fYhLlFbQoeU3BRp4LwjbktrZKi8jABCGmkhuIEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sJ7u+FG9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v17CpnP1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116174750.793522799@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=sJ7u+FG9C3eT3L1EA7EeULmwOJGbWAwZ6PNeojSY8H/ON4ybvt44Ztrd9h6VspvzrNl5Db
	CN7c1zUaZigag3pedz381fkZJz3Sj7uTHkLXJh3/jNzREPSRbXGuqaQyOwlrNPnGEFFHKL
	xUiuwRIZNqu7KWgKp0HEiHL5VZYhQAep9vHge8mF6PGhlLKrYGz6hLdrcOpE+gG8AwvmrR
	wkfMfGXS7siO5QNsUA4WvTDBd7F6QagWIurU1HCo2PfWU/m7dtxH/qXSMDM8IOcvsuiPiU
	hHbCZ0BfehYqlxiUXWcYy8hGitsQnt/KdgFW8HhseE0YzgNCzmqe3LLs7hkGdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=v17CpnP17zkhxUoHML4dgnvwyQuv30EwFP45lu6/j1k8A1gFNIZFSMjFho1Bcg8sQ2jdWj
	fH0A5sGOsxamLSBw==
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
Subject: [patch V4 03/12] rseq: Provide static branch for time slice
 extensions
References: <20251116173423.031443519@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 21:51:11 +0100 (CET)

Guard the time slice extension functionality with a static key, which can
be disabled on the kernel command line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
V4: Return 0 on error in __setup() - Randy
V3: Document command line parameter - Sebastian
V2: Return 1 from __setup() - Prateek
---
 Documentation/admin-guide/kernel-parameters.txt |    5 +++++
 include/linux/rseq_entry.h                      |   11 +++++++++++
 kernel/rseq.c                                   |   17 +++++++++++++++++
 3 files changed, 33 insertions(+)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6482,6 +6482,11 @@
 
 	rootflags=	[KNL] Set root filesystem mount option string
 
+	rseq_slice_ext= [KNL] RSEQ based time slice extension
+			Format: boolean
+			Control enablement of RSEQ based time slice extension.
+			Default is 'on'.
+
 	initramfs_options= [KNL]
                         Specify mount options for for the initramfs mount.
 
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
@@ -483,3 +483,20 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
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
+		return 0;
+
+	if (!on)
+		static_branch_disable(&rseq_slice_extension_key);
+	return 1;
+}
+__setup("rseq_slice_ext=", rseq_slice_cmdline);
+#endif /* CONFIG_RSEQ_SLICE_EXTENSION */


