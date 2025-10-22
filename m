Return-Path: <linux-arch+bounces-14261-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AFBFC192
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 15:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26805623D90
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4434C146;
	Wed, 22 Oct 2025 12:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RGH1FT4g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rNt3GGSb"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3834BA35;
	Wed, 22 Oct 2025 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137857; cv=none; b=QaSX9m/AJg3vHR6b0nv5DCqZJ0bAr6npkEfO0ot0eDWa5QuT43yI9S6HFe0A28WM/n+73/HZLtRoNxpz6bSVc9exuYGiqTeX1HduuDMZjq8YvUJQ2ujDHXoDFO454n0N8d8Tt9Cy2WiG8FOdfkDo5dnC8fkYN4JVIux8LWN/l6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137857; c=relaxed/simple;
	bh=NqQjpQ6wmtHhaimTEy5dZdITuRSnH9EVOsOJjL3t7HI=;
	h=Message-ID:From:To:Subject:References:MIME-Version:Content-Type:
	 cc:Date; b=HZlkgeIQavnMKHzmDkpOHTMbKqrpzN5Bbysn/dU9s6MPAHv8qhwAjZuRqBQdqNMh2hIdoiq/4r4QAWsGaCanQjVeKqVdqjSWyPMsRksbaxN21J/mUAlRYNDffg+Y8ONEeyLguDvuegJ34cO2xGd7v05WyO/lEMEs3j652FIUOBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RGH1FT4g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rNt3GGSb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121427.154468974@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=RGH1FT4gMeYfcV+qgskWSrAx0ekg8en92o5+thKaMsHWFEHUUYg2uau7GiFbu5fdYW2Q2D
	jHd+9F/akKTUdRRQgK4rmlUBrlin9bSToDHB5jmFpSDzZE0/oVdlKw/DhoCQ0BOT9NFk5K
	IaajdBwgUH0GwrtA32mnhxa/rdYamZxTYWvIwDf/1lTowO2iHHSeSazNg7WNcbMqv4B7kH
	sk8ZjF7drGMWWK8uhUx4kwM1bf7Tan6FjrFPw7q8qXkSp3wvXWTkW3vAzmVMtb2dJtRiZN
	hGhvLQSbbbGGOf7MrkLltlCL0G6OpmiE9kCAwcSLkxEcmfQzquTasQxo1soUfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=rNt3GGSbnKp11eWPfxghzbPdfC55gtgzrUBLCkAAxqsZAD7urOHAifdptXz8PMOv+0UE5F
	PgLoVo8yl+qsH3Ag==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch V2 04/12] rseq: Add statistics for time slice extensions
References: <20251022110646.839870156@linutronix.de>
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
Date: Wed, 22 Oct 2025 14:57:33 +0200 (CEST)

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
 


