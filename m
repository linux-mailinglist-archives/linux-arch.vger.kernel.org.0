Return-Path: <linux-arch+bounces-15421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6501CCBF189
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 394063001BCC
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777D1343D75;
	Mon, 15 Dec 2025 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t4plgjF7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpeejv03"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA983343206;
	Mon, 15 Dec 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817534; cv=none; b=XwtrpbrRaM/a8U5N9Mxce+Q5ARFAZvb5I8I+6167Cor2TC24knBoHG1sqqwJ9frArpTJvAFMjxq7M1tU0KE8ictHS9jgEtzy8LJ+nCxLGl0z6WyHGeDC33BEDQUTtdExOveAKJYUxhnlmO34FQzclOBz8dXe5v4iwTTQtWZaZp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817534; c=relaxed/simple;
	bh=sCIUOv3Pc5Bi8qejXKpGiXcetCSWnbvRoMyDZQmLMJY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=HYZnSiIpR4AmgBd1eLkqx4yO975X7VdS43bUVyxr5eny0NRaWi7eW2IbhjlW+MiiFd0x5i15WyRoI4T92v0MWyj+7G6FDSu68v3CK6K6/4JXXwxDx4x30drGFd2s4eKznMT2hiSvcbgQDRiSPWEQ6+9d0PINFIOh6Lh2ioYpL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t4plgjF7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpeejv03; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155708.795202254@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765817531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=t4plgjF7KtaaadgIfsbQLpkSv8oW4JRF0mLPp0LpI3JxjUsJ2cb9gW1LhyimQPTZd4EhQ1
	J1pKIXOqRB0flM68bJKOXQmprM+TuPo1ZJKFVMGnWgfjlvxB+fUnIMIVJcMmu7dIdOY9Ji
	wK705q9zbWJpmqGDyIAK29ZWKFHNkcADiHgMIvD5MII778MEdrV5cab3ES8kelCGE+bYbI
	QWMZ6k+8oiTkgg0DDOnFmqlQZiWqcpS2PklUNLxdHtx0nrd4MLyOhsfWnx/27PeGkbpDjR
	axMl+8UIleQMQqE9PiwNXkzO7/3QWM5t+2j1mAjrRj37jSgqsol65PcdH4wijA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765817531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=hpeejv03GUZlfwVPFlKhJ0w1LKoSHFUVddHkFFqzJaUP3j566FLUV6ErABS9h0l+wjgWW2
	Qrg5Z0+dEdgvnKAA==
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
Subject: [patch V6 03/11] rseq: Add statistics for time slice extensions
References: <20251215155615.870031952@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 17:52:09 +0100 (CET)

Extend the quick statistics with time slice specific fields.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: Add s_aborted to account for arbitrary syscalls
---
 include/linux/rseq_entry.h |    5 +++++
 kernel/rseq.c              |   14 ++++++++++++++
 2 files changed, 19 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -15,6 +15,11 @@ struct rseq_stats {
 	unsigned long	cs;
 	unsigned long	clear;
 	unsigned long	fixup;
+	unsigned long	s_granted;
+	unsigned long	s_expired;
+	unsigned long	s_revoked;
+	unsigned long	s_yielded;
+	unsigned long	s_aborted;
 };
 
 DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -138,6 +138,13 @@ static int rseq_stats_show(struct seq_fi
 		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
 		stats.fixup	+= data_race(per_cpu(rseq_stats.fixup, cpu));
+		if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+			stats.s_granted	+= data_race(per_cpu(rseq_stats.s_granted, cpu));
+			stats.s_expired	+= data_race(per_cpu(rseq_stats.s_expired, cpu));
+			stats.s_revoked	+= data_race(per_cpu(rseq_stats.s_revoked, cpu));
+			stats.s_yielded	+= data_race(per_cpu(rseq_stats.s_yielded, cpu));
+			stats.s_aborted	+= data_race(per_cpu(rseq_stats.s_aborted, cpu));
+		}
 	}
 
 	seq_printf(m, "exit:   %16lu\n", stats.exit);
@@ -148,6 +155,13 @@ static int rseq_stats_show(struct seq_fi
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);
 	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+		seq_printf(m, "sgrant: %16lu\n", stats.s_granted);
+		seq_printf(m, "sexpir: %16lu\n", stats.s_expired);
+		seq_printf(m, "srevok: %16lu\n", stats.s_revoked);
+		seq_printf(m, "syield: %16lu\n", stats.s_yielded);
+		seq_printf(m, "sabort: %16lu\n", stats.s_aborted);
+	}
 	return 0;
 }
 


