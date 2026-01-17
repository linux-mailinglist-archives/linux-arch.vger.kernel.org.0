Return-Path: <linux-arch+bounces-15837-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52709D38D7B
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79681301E58B
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF8A271450;
	Sat, 17 Jan 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MfJ82Tez"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D592B7260D;
	Sat, 17 Jan 2026 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643487; cv=none; b=qq1xclPbHQbpPSOLcFjm4VjDdUtUAUZgwh4+s3bBuVNyfpz2VhiIQm+gz7oCtIpfYENUNBm0M7igqVPzX2dlnK6cARqcE7M0ZLX5Rmc8GMN07b4tqKs4BP6RfPTa7PwNqcU9HCifCLpH+ihyhRVsknTP49V62aM6QA8mvrWhgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643487; c=relaxed/simple;
	bh=R1XmyFauC74oVIhZJc9Zu9JS58wxAeIuopOtHdGVAWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2jc+vp2iLuPERrA4BEJXgVaIgtGI/LiCXZ/j4798oGNMiDMPtM+WfyyIS2BQdke+cNoaeqDZ2GgqvNa06QsTGKG2JKQ85I3ZLEhc/lPJssKruo+MLV9tUYxDGQBzLAVe4QhPnFMr5T3J0dEWt10ONSTJ5dseJV4T3N0U2W3v1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MfJ82Tez; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RU63Iuo6p/fLRsns9WnspVB4JLkE7c7I/E/AL6I3Z+M=; b=MfJ82TezDxPYtas9ep4m4K/oKN
	+YYS7L0fC7AZtGdOOD5rRWyrmB8qRTPWhcYgmQtm8VscQchfAybuk9Rnbxb2bThF//AtzRbjDwFnA
	X0mtDvZ2o5KsTsdgAT33hOWvzlA29hHKFSRRLWTRB7SPxxQ6/AhHcQC0uGVrdGPyJMdppYnYz9RpZ
	ODx3dDvDhj3KNFlPeR8PENJiLJrlSMja3YCvghyqGhThUN+cHoMQoRi5oZPeSzY7b39osQ+CyzJOA
	lsQ/QvVcOHHeUv7tiNHLjciSDO5gaZ6G8TZqCyEwHsqsdIPgNu4cmnZ6FUNdETLeXt7EJzWtxjstG
	kgMlmeow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vh2xf-00000009zAt-2t8V;
	Sat, 17 Jan 2026 09:51:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ED58B30065D; Sat, 17 Jan 2026 10:51:14 +0100 (CET)
Date: Sat, 17 Jan 2026 10:51:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
	Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [patch V6 10/11] entry: Hook up rseq time slice extension
Message-ID: <20260117095114.GF1890602@noisy.programming.kicks-ass.net>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.258157362@linutronix.de>
 <d8215f9a-3088-483c-bd96-4058767b886d@efficios.com>
 <20251219110711.GE1132199@noisy.programming.kicks-ass.net>
 <878qe4ifas.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qe4ifas.ffs@tglx>

On Sun, Jan 11, 2026 at 12:01:31PM +0100, Thomas Gleixner wrote:

> I know you argued about this many times, but I still maintain my point
> of view that TIF_PREEMPT and TIF_PREEMPT_LAZY are fundmentally different:
> 
>      TIF_PREEMPT_LAZY grants a non-RT task to complete until it reaches
>      return to user
> 
>      TIF_PREEMPT enforces preemption at the next possible preemption
>      point

This is only true for lazy preemption; and that is not the only possible
model.

> My main concern is this scenario:
> 
>    sched_other_task()
>         request_slice_extension()
> 
>    ---> interrupt
>         RT task is woken up
> 
>         return_to_user()
>            grant_extension()
>            ...
> 
> which means the RT task is delayed until the OTHER task relinquishes the
> CPU voluntarily or via timeout.

Which is exactly the same as if there were a kernel preempt_disable()
region.

> So I prefer to keep the current semantics for RT. This can be revisited
> of course when a proper evaluation has been done, but IMO there are too
> many moving parts in a RT system to make this actually work correctly
> under all circumstances.
> 
> I'll add proper comments to that effect.

I've added:

+/*
+ * Since rseq slice ext has a direct correlation to the worst case
+ * scheduling latency (schedule is delayed after all), only have it affect
+ * LAZY reschedules on PREEMPT_RT for now.
+ *
+ * However, since this delay is only applicable to userspace, a value
+ * for rseq_slice_extension_nsec that is strictly less than the worst case
+ * kernel space preempt_disable() region, should mean the scheduling latency
+ * is not affected, even for !LAZY.
+ *
+ * However, since this value depends on the hardware at hand, it cannot be
+ * pre-determined in any sensible way. Hence punt on this problem for now.
+ */


