Return-Path: <linux-arch+bounces-15113-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FD6C95F2A
	for <lists+linux-arch@lfdr.de>; Mon, 01 Dec 2025 08:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33CC94E148D
	for <lists+linux-arch@lfdr.de>; Mon,  1 Dec 2025 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3976728A3FA;
	Mon,  1 Dec 2025 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhrDDeu4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMk4aXqb"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F76628CF6F;
	Mon,  1 Dec 2025 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764572764; cv=none; b=FHM1RLhW1P24HKYuGcsr+lu0QCSjzmiquBOB4ol/VmWBJ45pY75eaFxvwHYNQd9kSxkXtUk8OjCMjyn6kBg2mSzE9R3kOmv4F9Te9ev2Ft53jqkrzXajmIJ2lfe/noojGcYZCKADY44sNkRxtSzgFEDuKqHoGvdp5mwPRW2kprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764572764; c=relaxed/simple;
	bh=sCIUOv3Pc5Bi8qejXKpGiXcetCSWnbvRoMyDZQmLMJY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=R49jJ4+rL6c0g/XcjBvqrAxou7h7JJy/9qBvRwRBudVpkBSl4FX4aU2h2EG7j5ZxV/6Vgb31My0EuQ1xnPsmTYE1zVfFOWMHCQzJ/ANRv6oBMqwrwdMwLv9V9GymbJpa/2ixx315fmlPVXzLV2gSEcBlXUz7nqxUrx4JDPENR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhrDDeu4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMk4aXqb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251128230240.840699861@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764572760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=nhrDDeu4L3bx2uNPZxPSRDA/ezkglufUN1xv3xLB8J2YhPV/uXnnbOqBTCNi4UKQ6kWlNQ
	R/SxqpZtHeRbbKjgBprfQq9L4ZioKdwqgMCa+VOLcpx4PQloihn5LWlv3TBm9jtzmK4vtm
	bL8FSwOR+nMO4YC8dVTtwiLalCfq10jnicT7CC3FppFDCre4vEeQQGxbJdgKdXZUbTpMmc
	rQTppJL/SsIQFeyixa8zoztpceNlBeJ/KVmUecLcn12oqUJfw+LPtpEc+CFRtscO+G9oZ7
	vCmYQMMf97XkGHBG2jDfhL2YQZvmi8wzEX6iYZYqPnVEfEam3mvYk/VU8y48rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764572760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kGoBtb87LQvvEeMEt7z1mXVJHPOZKvaBorLUBvllkfA=;
	b=YMk4aXqbI90rVTKr8jTNQC4jHvtB86bQhOrWBUITqSGzsBI2ulirWPf4AAufoa2qznFVEP
	zcWI2nIgoPx+EIDQ==
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
Subject: [patch V5 03/11] rseq: Add statistics for time slice extensions
References: <20251128225931.959481199@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  1 Dec 2025 08:05:54 +0100 (CET)

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
 


