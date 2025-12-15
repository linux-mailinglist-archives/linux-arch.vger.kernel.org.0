Return-Path: <linux-arch+bounces-15435-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94ECBF6DD
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37838305480A
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D883101DB;
	Mon, 15 Dec 2025 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBl2faMU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfBvfHFp"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346CE1ACEDF;
	Mon, 15 Dec 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823085; cv=none; b=OvzpClRB5ykt9nYj+/LGwQ9cv8Hd3v2QwXuqkrsjP/ab7XgPMf2nhi9QXFnUPxGIdczjOfhmZcJ+dYZCg5tgj1vzM1TzsHdeUsFJsa+NqyzdqygHpqrMEyrHAvTYLmSr1xPobxqTax1rkwy3xYU2clZ1uLWchEOSRpVweHfMDf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823085; c=relaxed/simple;
	bh=sCIUOv3Pc5Bi8qejXKpGiXcetCSWnbvRoMyDZQmLMJY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ithAG2qi3SDNa5YUQpstfQd7/1lgG8ivydgjlA6oxiFZNQv3YUE1/QiaBmadj9CawQlmY/Zs9dYGikxtkoS8tiGQUxKWLufa6cMR8KIgvvjDHHajIjEkaC0orvfykdRMi7OQBwT3BGT7nT1jCsJD9PaniDEEO+7hGcOMSAxhqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBl2faMU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfBvfHFp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251215155708.795202254@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765823082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=iBl2faMUh6T7G3d1bV5jYfO9U2mIPBLFA+oqTecdjG5LbdDktCkmUBxHMOXhfBR42EbZ6L
	Ne/A9P5oYALULJSQTrNNA2qAW6wH2AW7S5uCQoikNFAGiYfDhptRVpV7R8gecsn6N3GSxp
	JOTtgcZIDR3WQC93aWMsK/gNXHhrjgdgH+xhe9nSjWyIh3gglOgup7axW6rNJqgWS5U5cG
	QQljFshcXaVNnpLK6dhkSWUSOylcNoVpA37NHPpLQPC3Twt+mOXFzre6vRSA4m0i+3vAa+
	DBVo9tVL0xsDacMKUg4pzueem6CSJmBxC7CPe/mKdW6vFtHlYn4TrOvfT3fxvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765823082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=WfBvfHFp3wo7sBQPYkxjqW4PIzpVWwAd3xyYv1C5oqLzOB1JdefUTGquCWvBAukIMVA1q7
	en180eOL5fIrnbCQ==
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
Date: Mon, 15 Dec 2025 19:24:41 +0100 (CET)

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
 


