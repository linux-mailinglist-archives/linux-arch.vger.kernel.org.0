Return-Path: <linux-arch+bounces-14399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42CC1AE57
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47E114EC030
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315823358D1;
	Wed, 29 Oct 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3o9KWlMa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tPPufxy"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0713358A0;
	Wed, 29 Oct 2025 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744143; cv=none; b=lED8w5wx74DdLZ+3qvLhoPbUYgnCiJvFh5ZPGbyY+CSD6X+L9rvyOYsXky23O8UeEmc1UGP38oeik3HtSg2xLAPI/Wm+RjK2FKl9w94EAuEB//Stv+Wz7S9KQ5ln7aqDBa/pOhlfkRBuw1gB1b0tPFcud1cCGKuAvKAr9Q2YPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744143; c=relaxed/simple;
	bh=NqQjpQ6wmtHhaimTEy5dZdITuRSnH9EVOsOJjL3t7HI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nMQQov1DHt7nXbOC7PgvHYjf8tlt96RWbVCgBAkXBanbSC2tBCXos/fQ3DtW8a71AnHzjWdRqerCCZQfuWJWPzyaHg+sZpmsZWUDZzH9JrdWecIk6l6w61sa0wnOWkFkTatDYF/WoBJ+B9pGgB19JTDpgwIhEyJSfz8TSaUISCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3o9KWlMa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tPPufxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251029130403.670613644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761744139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=3o9KWlMacyWGdE6xcjYeRmWr4iCgJrT9Nfst+K1x3hQauuPiq7p+PO44QRsbsfxIgKSIsz
	aiuNkT+lDJwnR3rwrkgCm+J3UGf8pxG8u5guiTS41oVvAybLlbzuvwidBVcn7Q3DFcwK3p
	SDmvJuWm+frk7yuFjrNj5xHsNjuTJ3+rSBFxVUcoFbxuqwB3QArc0TAGWL1F3UIZ8Jdle+
	Fsz1B0MNCg+3uOKY5CIM60SWvhWxgqGDaqBJ6GvMKthNlRkjv+PWrco7sSMUstii+5tDVI
	6CaYaWymeTILy7vPsXUj1zZDM+eeBue1SGO1V/Z0hKnZCqZ6M9Fn8I2XwrwUbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761744139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=puOLVz/xusJgMHcGpgny0+0j3GVseKRPTpDHpqHQHdc=;
	b=1tPPufxy9X3/lvoMH+XM08CDT5zopDkI3DWO9mQGbYHwcZTHPRjRhpl6pR3PU9W9lW7sv1
	zFVDDUb2CB3j25Bw==
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
Subject: [patch V3 04/12] rseq: Add statistics for time slice extensions
References: <20251029125514.496134233@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Oct 2025 14:22:18 +0100 (CET)

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
 


