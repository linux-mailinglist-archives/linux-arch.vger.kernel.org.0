Return-Path: <linux-arch+bounces-14398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D224C1AB4B
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C031AA4A71
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DBD334C02;
	Wed, 29 Oct 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9vYE8dO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ul8wGL1p"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE932D444;
	Wed, 29 Oct 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744141; cv=none; b=jQ+RVLxTsoj926xghflSpktVkRodaNY2n7qWhx3zLbyUnIjtWeKkFL93JP+hDobAt8ygRKoIiRuJdj6kvaz0mXLeCPxh9FHl/GMFSAYUsqtUmMkM5Jz9dCblbjYR/5xWnEw89SJl6uTBX4vGSCTVomNu1IDgN8i0AT9zz2zSdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744141; c=relaxed/simple;
	bh=wdyLpLkZ1R+88WP1oaQr8py7uWZHrb7YKJMO3fmCpCE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=X3gXg1ZK8t4tqwwJ/FiqxsDbmTX0XHlewyjB14KE0M9os8BKAmRw3CzAw/W2VX9OgKM3C4h4QChbCS4U8dqyWOZIpQfJGNTR4P3HKqqNugnFu5K+fxU+CoBp137bf7RLYDeOWI4AK7TSh5CwS7RRG+TLkaRF8TooNdKJIwvlSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9vYE8dO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ul8wGL1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.606732100@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=r6tKDMBnUTjwKx37R8miPI3/kZq9j0kRQyMB+piTah8=;
	b=c9vYE8dOzpbTxW4Swg7Gp6KOQcvltdgzzRuFpWn8VJC+oixuPUksn5PfWHxzL33vofSdAG
	0fTnRt9XbYrigXl5XNnD/geWdsOSbNxxs6LFrbi9XOtnK5YnZDa4r4xTgfWE1mbjw43H7i
	A8cZBeBZxglNPMQHzMqYNyKtvQvLu19xfKdcEkPlDDNhFPUeTi8wstJz323T0aCD/Rcnev
	5aBqdBcF4e8YtISYMuRjo4ErOA4s05mwuF0NjrYoGJ4Fnw55mgL1/Y0xG/AOi5TfB2R618
	QjyyhBEIXAES7adyYA060/EWZUrjZQQgptRc3Ymd2fZMQj28UgKWMbmM2vh9xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=r6tKDMBnUTjwKx37R8miPI3/kZq9j0kRQyMB+piTah8=;
	b=Ul8wGL1pdX78nNGkXddxIMHGjFCKSipkhyN77fs+c2DE4TRUpXHOjG5BDPI699noq0TvIX
	tA2DR4Ius63ASDAQ==
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
Subject: [patch V3 03/12] rseq: Provide static branch for time slice
 extensions
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:16 +0100 (CET)

Guard the time slice extension functionality with a static key, which can
be disabled on the kernel command line.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
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


