Return-Path: <linux-arch+bounces-13426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB06B49D31
	for <lists+linux-arch@lfdr.de>; Tue,  9 Sep 2025 01:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F6A443D95
	for <lists+linux-arch@lfdr.de>; Mon,  8 Sep 2025 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801D42F0661;
	Mon,  8 Sep 2025 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwFj8V9x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBKj4myO"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887B3112A0;
	Mon,  8 Sep 2025 23:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757372403; cv=none; b=Y3riYJBWmY+CtwMFjhblfurEbwK9KvFEzICCwEPKTlNu1vuNttcxsJK6BkaA4l5Qi8zO6GE+BJMS5SYXtWzVN2TGIMQB5d3jQOGtRFi+uHZnTDOr7BFLVCkPrDyCxEef43+nvABrRsUVYtBHAVhv3ejJOHhB5jryisBRrGQsQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757372403; c=relaxed/simple;
	bh=NqQjpQ6wmtHhaimTEy5dZdITuRSnH9EVOsOJjL3t7HI=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=mEbf+5Q0uLIxMpsn+1y5EcBFwtSd/rUHn6Q+UbxKHafcrhsnJKBBk/OdrElscpA53wkaQNxmVmQ6nIAO/eakGkr4IfPu1XOAmVT58Q4TU1Cx+y7OWQcEeOE1whqjcCLKpO9jr97FFyeWJJSyWv/MBwl8sSNzIPzG9tFiqCJfK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwFj8V9x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBKj4myO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908225752.808973324@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757372398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=nwFj8V9xpjJS2xjnYghzTPAyD6gCEZrg2AxvRsBLeDoR2nk/L3vYXTUbc3X+5RthrkvsSm
	/wAZpJ2nKKTcnTlv9jL3JKKReXvmtzXvNcDOA0OWcm/SxD5JsZi+07Jzt2UoSTIji/380D
	cjQU6oEn6G9vF/ry0V6bnw4lDL8vHmKKqesivT0DBaaOQLt8R/w7CIm73g0BBg9PdGAkSi
	m0ZuthDRAX6m1UExAzW3tNLb3nAjkCHwOxzw5YquANpyJwG5JAj2dXsmLnpSaag37i389u
	xkLz8s4uP9YfNV5dXf4xahqSVFBdqUS+3PTEwIWBALk5krUGQ32KyG2xwxEOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757372398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=VBKj4myOJex1TJY340JUP5vfkx/G0eGJvpaP0Z9+PakZRIpGqhqepbTMZTrS9OSLcnudrw
	CHmJqgfaz6ZnKdCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 04/12] rseq: Add statistics for time slice extensions
References: <20250908225709.144709889@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: Peter Zilstra <peterz@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>,
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
Date: Tue,  9 Sep 2025 00:59:56 +0200 (CEST)

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
 


