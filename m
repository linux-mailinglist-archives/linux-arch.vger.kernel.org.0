Return-Path: <linux-arch+bounces-15112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D3CC95F27
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E62CA4E13D9
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AB528980A;
	Mon,  1 Dec 2025 07:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="STeeg5uX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyzYzsy3"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50CF849C;
	Mon,  1 Dec 2025 07:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572761; cv=none; b=Lh6F2nvca+Lrno9PgMfVE1Eoupfj1eDzLtCxp0M5bTx1qCOmBUsKfJp7rT4W8xCPoZv3uOJy5RDZCu6Z7/eGHN2ql+S2t+OJPPSGAaIDbtsZcJ6fdzcIQcivPMm7o8/PxIDSn2hjuQB8pbiV55eBVSVO9TkJa1OLkHl/x5x+1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572761; c=relaxed/simple;
	bh=TA7lrT53WU79dKJyoMSPjS4BGsGO5jf1PbfErdOpEYA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=urA+kp3WKLA8UEphCCi12cOy2uNQOn+GH2Y98TyymtjT/wJO0EJon4uiShzudV2k/+sVvz3IXmg5w3VOuhmtgJOtR/gUWcZhvF+p7SiPaMD4887y1R/q27UCfZUB0+GA5CKGTqCwL534kjwoJ5NzZnoHKWxNC1CDq187YvOZrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=STeeg5uX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyzYzsy3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128230240.776997010@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=STeeg5uXb4ylORbjQUVgj2w1npkJBMl1hbHjwaOBhxuDE7bVzA8kcBU/1oTYbbBsE6RFly
	b4JL5i9HojX53PlqpJDkZG0n/6Bx2uDsXYmZek0jPz7urHrzCBAhuqDFgJ7YwcBG+aorY9
	OZTE1NPn2uUEoErcZpZxttljQHBO9XeW6F2wX8wm4yeR0++c6GAgX0NJGDG98QBu1CVUY1
	o1Z3gB/n3taLVvJ/xiL8to1DuRU4Vcj7Ri8i/4joC1m8UUXspJMTRDEQ5UIBM7oklx9MaH
	pI4+RGAmBOKwyJnwW8Ym5r5eERAxifHKf7kQg7IIj5T/xvuAG0s+f39zzk4xVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=AyzYzsy3HwqwF5m8zNxbPfrjF3R/TAnuqWqctSwN9wXJBkJqi451Ykc8COq2IFwGEg8+uq
	D9UUnX0AoxqujyAQ==
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
Subject: [patch V5 02/11] rseq: Provide static branch for time slice
 extensions
References: <20251128225931.959481199@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  1 Dec 2025 08:05:48 +0100 (CET)

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


