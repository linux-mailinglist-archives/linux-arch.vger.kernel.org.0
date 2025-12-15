Return-Path: <linux-arch+bounces-15420-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0ACBF282
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11312306C2DA
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E93342CB8;
	Mon, 15 Dec 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1tdsHmC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJfYTPbQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF97342C93;
	Mon, 15 Dec 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817531; cv=none; b=LvA9dYVSlOO+kkIFf4eJ01kXhf88suoDF6G9lkOttHPYzkTA/lrUtT2t567/K++pBH3KMQ1Ast2tfJVYqiAtmBCbIS69RaL8A1r+SSOFfn7EyqR4C5tI7LKE3ICO9pAxuP7xamtqqB3xnoBFDCCxM4s9wxs+0iCeOqCCv/xGxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817531; c=relaxed/simple;
	bh=TA7lrT53WU79dKJyoMSPjS4BGsGO5jf1PbfErdOpEYA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=O+UnsFlGEs3DI2ei7gGl/pFJlYLFjKacMZBVjKCITuCB/tENTETrRwnNUnkhzmoUKDln/hgSRgNcNXQs1LyAoomt90bYVfpo/duq+Rs6gnqbeVyBuHvInLra3drKcIOiAT+cMj3vwRyfyePz7MoD2snGNuU0rj9hANE8MX04QIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y1tdsHmC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJfYTPbQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155708.733429292@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765817528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=y1tdsHmC3qbBjH9KNBGyhJzQstW8DacWV/1BwNOUF36XaQVCQj4S717e+UCfRde2ShO7lR
	hG/WzYlcJPtdqOWViReT02aDKZ2KmN91QKzmAtCjRFzNDLVlhMNZxKYZDeXWodbY/h24FI
	eSDD87F7ShTZhr69oLuObeYh23XUYmB+GHPI5oqQn4IwOnJzg8GVdOw+B81SdXVb0qV7zu
	juCeo31PayQWBd//ay/3TpUZ7eJgoTKpzBP8aDiXhurra2bQd15i1vm4e6aI6THHz2tck2
	QHHt32lSapeuj1TUfRUBJLCG8PUUJj8uNmMfhU+LyvDhdxxvSmMpJafBmDps3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765817528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=30E4+htDTDGTIapY14XtOT+E3N9EWJok6h6ZJqVhSd4=;
	b=QJfYTPbQpQXJVd3sYHkb3C/0QdI/4kfg/pFk2wu/bBfK/s/WKbns5D7DFArTx7Q4SjIGY9
	74jCv192mytxi3BA==
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
Subject: [patch V6 02/11] rseq: Provide static branch for time slice
 extensions
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 17:52:06 +0100 (CET)

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


