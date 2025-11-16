Return-Path: <linux-arch+bounces-14816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C4C61D19
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 21:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0D60362300
	for <lists+linux-arch@lfdr.de>; Sun, 16 Nov 2025 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDFE2737E3;
	Sun, 16 Nov 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XCDCSIEe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Op6U/YGk"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C1272E6A;
	Sun, 16 Nov 2025 20:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763326277; cv=none; b=fWhs+mg9NHG8EglEDuVb4oxD4PJiOpp6Vvdnz353Ou084mXLR/0Uw1cvohztpQdWfF2z+Z1TmU/mTKhQBeuu+4oCvbP61uUJAnudAnWQzyWGb2SPkQQlfYWXHbzZjY3SunhX1cKIIGtHLQ5hJp1St7xfbhic7360ZkLh+49exEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763326277; c=relaxed/simple;
	bh=NqQjpQ6wmtHhaimTEy5dZdITuRSnH9EVOsOJjL3t7HI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lHhRTDWTpOBYzOhybL5/sEVklMzcL5Rt/TRCuVjDEQpAYgabMLw2u+HWBEDNjX8lWSO3B73IzxK3obzAxDh0xrL6S6SnovN05NwWolAeV63bJOon3SACzHbCf6n2/qlSgTZJI3Ja1Rfqzdhh9K127rdrpZMSrRsiO6yiEbrqFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XCDCSIEe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Op6U/YGk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251116174750.857118379@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763326274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=XCDCSIEeaaXi25CNH6XVM/r+7lm4QHJAPOeeX9cn5jKSoZVxrJiPfftuIu0kKDCsaWtzKh
	dsVSAEf4y1efgC56rrTJPrlu18b6aXc3+suhDVXl6UT1eI7H6EcTNY0C5HajI6J9aP49pG
	2KN1KpQxHCPY2f1hgEa9FbJDuMnSoZqmozRT9lyFmzzVBdr6RVOnM0Wf8Xpw1wJfbJjQLu
	yXn8vnfdM+725qSQPpnWCdXAK4gH5Fb4nWCEOqEkPVp2zF1G47PF2SAJ2nTvXfKuUhJmsN
	Tjw7etYPUTFx6ql/ki4+3IQzYHSyFLlKqMQIS7o/51C07eARF+HfHpUwSIudOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763326274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=Op6U/YGkjDcDjKzf+rXUqtm7rte3/IhT+aY6T8Dwra6GY4Jmuah7nCHVnh9Go/tMkdotCn
	KRvvcaIXJbO/ClCA==
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
Subject: [patch V4 04/12] rseq: Add statistics for time slice extensions
References: <20251116173423.031443519@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 21:51:13 +0100 (CET)

Extend the quick statistics with time slice specific fields.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq_entry.h |    4 ++++
 kernel/rseq.c              |   12 ++++++++++++
 2 files changed, 16 insertions(+)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -15,6 +15,10 @@ struct rseq_stats {
 	unsigned long	cs;
 	unsigned long	clear;
 	unsigned long	fixup;
+	unsigned long	s_granted;
+	unsigned long	s_expired;
+	unsigned long	s_revoked;
+	unsigned long	s_yielded;
 };
 
 DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -138,6 +138,12 @@ static int rseq_stats_show(struct seq_fi
 		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
 		stats.fixup	+= data_race(per_cpu(rseq_stats.fixup, cpu));
+		if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+			stats.s_granted	+= data_race(per_cpu(rseq_stats.s_granted, cpu));
+			stats.s_expired	+= data_race(per_cpu(rseq_stats.s_expired, cpu));
+			stats.s_revoked	+= data_race(per_cpu(rseq_stats.s_revoked, cpu));
+			stats.s_yielded	+= data_race(per_cpu(rseq_stats.s_yielded, cpu));
+		}
 	}
 
 	seq_printf(m, "exit:   %16lu\n", stats.exit);
@@ -148,6 +154,12 @@ static int rseq_stats_show(struct seq_fi
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);
 	seq_printf(m, "fixup:  %16lu\n", stats.fixup);
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
+		seq_printf(m, "sgrant: %16lu\n", stats.s_granted);
+		seq_printf(m, "sexpir: %16lu\n", stats.s_expired);
+		seq_printf(m, "srevok: %16lu\n", stats.s_revoked);
+		seq_printf(m, "syield: %16lu\n", stats.s_yielded);
+	}
 	return 0;
 }
 


