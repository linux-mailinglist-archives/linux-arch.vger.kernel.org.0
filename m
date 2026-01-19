Return-Path: <linux-arch+bounces-15858-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9173CD3A4CA
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 11:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F47B30161C2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9401F2D838A;
	Mon, 19 Jan 2026 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GUWyUpPD"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F902D060D;
	Mon, 19 Jan 2026 10:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818123; cv=none; b=b+YHE4LodgDh36bCY5/DfP0t8ZNiwL/MzaW7w80p5g7fpNUPRtqppE0qoS5P6sGQyJ5UqLRPXrCwvrTf+fU1Qt+h8IjNzNB9slbIzACN4RJbVbL2hRnpUquzjIpJZKG44zcL4pJ5C7pQwvC7o532I20Xr2hgtUG2QUUdCTIjmDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818123; c=relaxed/simple;
	bh=aIRaYDFvO3hduE8VDF/Bf+0TyakNHkrR9XVO8k20raU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys9q9KyyNRt9lnZ07EC23WGlHKzX5NnA/LF+a0kHpTwehFV48tJgHdiIxvyH3eNarRaBok13Ud9GCC5l1sR4DY/d2Q2iH8z0GnrsG8sylQgRC7iMaw2fx/Fcay2oeiBtxMWEanFC4/omrXshqGREsBEsdUu8p/RDC7WQFgoHYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GUWyUpPD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/Fa3xrwKPlJpQL5I4p+2r2Tur2gXqGwIWqYyrUGSQDo=; b=GUWyUpPDx9k8kj4/Xj0/6TVEhw
	wOknieC4dHRezWFJD8vBtkyxvfZuKMn7KuNitHI+C11PuWo+HOZwv+F/QCa3+VTKJZMwhsWy+0QsY
	zjZD8K3v/Oo3lachgHY6sCfP2OTGagMME/eBxKxA24k8ngMLMD9hvrJ6tsJYxNL4Lncd5zwhIHU2Z
	UQzaYcJIfjmiigp1jtgQmZzEKT67YvZZeSw+xHyqLbZOiz5J1fYHL5ccfZUEH4LiNyWbw5oCNxp29
	wkDI1+EnwiCUNkrbge5MGHX4/JQaEmqQmGb8S11Q4dS8sZVPhe4DsPcbhYXOuCJI6AdZpm+Yq13DF
	NV8J5m/Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhmOB-0000000D9Vp-1ibT;
	Mon, 19 Jan 2026 10:21:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AD062302FA1; Mon, 19 Jan 2026 11:21:38 +0100 (CET)
Date: Mon, 19 Jan 2026 11:21:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>,
	"carlos@redhat.com" <carlos@redhat.com>,
	Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [patch V6 01/11] rseq: Add fields and constants for time slice
 extension
Message-ID: <20260119102138.GQ830755@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155708.669472597@linutronix.de>
 <d97944e3-e5f3-4d7e-83ac-89ddd6a4cb64@efficios.com>
 <87jyyjbclh.ffs@tglx>
 <225b9868-4ab7-4a90-8acb-8d965626f6a7@efficios.com>
 <87ldi4gjm3.ffs@tglx>
 <lhua4yhcc0d.fsf@oldenburg.str.redhat.com>
 <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45fd706a-86be-42b8-879e-11bbe262e159@efficios.com>

On Sat, Jan 17, 2026 at 05:16:16PM +0100, Mathieu Desnoyers wrote:

> My main concern is about the overhead of added system calls at thread
> creation. I recall that doing an additional rseq system call at thread
> creation was analyzed thoroughly for performance regressions at the
> libc level. I would not want to start requiring libc to issue a
> handful of additional prctl system calls per thread creation for no good
> reason.

A wee something like so?

That would allow registering rseq with RSEQ_FLAG_SLICE_EXT_DEFAULT_ON
set and if all the stars align, it will then have it on at the end.

---

--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -424,7 +424,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		return 0;
 	}
 
-	if (unlikely(flags))
+	if (unlikely(flags & ~(RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)))
 		return -EINVAL;
 
 	if (current->rseq.usrptr) {
@@ -459,8 +459,12 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
 
-	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION))
+	if (IS_ENABLED(CONFIG_RSEQ_SLICE_EXTENSION)) {
 		rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_AVAILABLE;
+		if (rseq_slice_extension_enabled() &&
+		    flags & RSEQ_FLAG_SLICE_EXT_DEFAULT_ON)
+			rseqfl |= RSEQ_CS_FLAG_SLICE_EXT_ENABLED;
+	}
 
 	scoped_user_write_access(rseq, efault) {
 		/*
@@ -488,6 +492,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	current->rseq.len = rseq_len;
 	current->rseq.sig = sig;
 
+#ifdef CONFIG_RSEQ_SLICE_EXTENSION
+	current->rseq.slice.state.enabled = !!(rseqfl & RSEQ_CS_FLAG_SLICE_EXT_ENABLED);
+#endif
+
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -19,7 +19,8 @@ enum rseq_cpu_id_state {
 };
 
 enum rseq_flags {
-	RSEQ_FLAG_UNREGISTER = (1 << 0),
+	RSEQ_FLAG_UNREGISTER			= (1 << 0),
+	RSEQ_FLAG_SLICE_EXT_DEFAULT_ON		= (1 << 1),
 };
 
 enum rseq_cs_flags_bit {

